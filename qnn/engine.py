"""Training loop, inference, BatchNorm re-estimation, checkpoint I/O."""
import math
import time

import torch
import torch.nn as nn
import torch.nn.functional as F

from .config import ABITS, IN_BITS, NAME, USE_BN, parse_arch
from .data import augment, prep
from .metrics import metrics
from .model import QNet


@torch.no_grad()
def predict(model, X, device, bs=512):
    """Score = logit(person) - logit(no_person)."""
    model.eval()
    out = []
    for i in range(0, X.shape[0], bs):
        out.append(model(prep(X[i:i + bs].to(device), model.in_bits)).cpu())
    lg = torch.cat(out)
    return (lg[:, 1] - lg[:, 0]).numpy()


@torch.no_grad()
def recalibrate_bn(model, Xtr, device, n_batches=60, bs=256):
    """Re-estimate BN running statistics on clean training images (cumulative average)."""
    bns = [m for m in model.bns if isinstance(m, nn.BatchNorm2d)]
    if not bns:
        return
    for bn in bns:
        bn.reset_running_stats()
        bn.momentum = None
    model.train()
    for bn in bns:
        bn.train()                      # also the ones frozen during iterative training
    idx = torch.randperm(Xtr.shape[0])[:n_batches * bs]
    for i in range(0, idx.numel(), bs):
        model(prep(Xtr[idx[i:i + bs]].to(device), model.in_bits))
    for bn in bns:
        bn.momentum = 0.1
    model.eval()


def fit(model, data, device, epochs, lr, tag, batch=128, aug=True, balance=True):
    params = [p for p in model.parameters() if p.requires_grad]
    if epochs <= 0 or not params:
        return None
    Xtr, ytr = data.Xtr, data.ytr
    opt = torch.optim.Adam(params, lr=lr)
    N = Xtr.shape[0]
    spe = math.ceil(N / batch)
    sched = torch.optim.lr_scheduler.CosineAnnealingLR(opt, T_max=max(1, epochs * spe), eta_min=lr * 0.02)
    cw = None
    if balance:
        cnt = torch.bincount(ytr, minlength=2).float().clamp(min=1)
        cw = (cnt.sum() / (2 * cnt)).to(device)
    last = None
    for ep in range(epochs):
        model.train()
        t0 = time.time()
        perm = torch.randperm(N)
        tl, nb = 0.0, 0
        for s in range(0, N, batch):
            idx = perm[s:s + batch]
            xb, yb = Xtr[idx].to(device), ytr[idx].to(device)
            if aug:
                xb = augment(xb)
            loss = F.cross_entropy(model(prep(xb, model.in_bits)), yb, weight=cw)
            opt.zero_grad(set_to_none=True)
            loss.backward()
            opt.step()
            sched.step()
            model.clip_weights()
            tl += loss.item()
            nb += 1
        m = metrics(predict(model, data.Xva, device), data.yva)
        print(f"  [{tag}] ep {ep + 1}/{epochs} loss {tl / max(1, nb):.4f} val_acc {m['acc']:.4f} "
              f"auc {m['auc']:.4f} rec@5%FPR {m['rec_fpr5']:.3f} ({time.time() - t0:.0f}s)", flush=True)
        last = m
    return last


# ---------------------------------------------------------------- checkpoints
def save_ckpt(path, model, arch, stage, **extra):
    torch.save(dict(name=NAME, stage=stage, arch=arch, state_dict=model.state_dict(),
                    frozen=sorted(model.frozen), kept=model.kept(), **extra), path)


def load_ckpt(path, device, arch=None):
    """Loads a checkpoint written by save_ckpt, or a raw state_dict from qnn_presence.py
    (then `arch` must be given)."""
    obj = torch.load(path, map_location=device, weights_only=False)
    if isinstance(obj, dict) and "state_dict" in obj:
        meta = {k: v for k, v in obj.items() if k != "state_dict"}
        sd = obj["state_dict"]
    else:
        if arch is None:
            raise SystemExit(f"{path} is a raw state_dict; pass --arch")
        meta, sd = dict(arch=arch, stage="quant"), obj
    model = QNet(parse_arch(meta["arch"]), ABITS, IN_BITS, USE_BN).to(device)
    model.load_state_dict(sd)
    model.frozen = set(meta.get("frozen", []))
    model.set_quant(meta.get("stage") != "float")
    return model, meta
