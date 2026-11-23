"""Iterative quantize + prune (paper Algorithm 1), run on a float-trained QNet.

For each conv layer i, in order:
    1. quantize its weights (pow2) and activations (6-bit), calibrate the activation clip
    2. freeze its weights, retrain the later layers for `iter_epochs`
    3. re-estimate BN, then try removing each filter (smallest |w| first); keep the removal if AUC on the
       calibration split stays within `prune_tol` of the AUC before pruning this layer
    4. freeze BN + clip of layer i
Finally quantize the FC and tune only logit scale + bias for 1 epoch.
"""
import torch
import torch.nn as nn

from .data import prep
from .engine import fit, predict, recalibrate_bn
from .metrics import metrics


def quantize_and_prune(model, data, device, lr=2e-3, iter_epochs=3, prune_tol=0.005, prune_eval_n=4000,
                       batch=128, aug=True, balance=True, seed=0):
    g = torch.Generator().manual_seed(seed)
    eidx = torch.randperm(data.Xcal.shape[0], generator=g)[:prune_eval_n]
    Xe, ye = data.Xcal[eidx], data.ycal[eidx.numpy()]

    def auc_now():
        return metrics(predict(model, Xe, device), ye)["auc"]

    model.set_quant(False)
    n = len(model.convs)
    for i in range(n):
        conv, act = model.convs[i], model.acts[i]
        conv.qw = True
        act.enabled = True
        idx = torch.randperm(data.Xtr.shape[0])[:64]
        model.calibrate_layer(i, prep(data.Xtr[idx].to(device), model.in_bits), use_batch_stats=True)
        conv.weight.requires_grad_(False)
        if conv.bias is not None:
            conv.bias.requires_grad_(False)
        print(f"  stage {i + 1}/{n}: layer {i} quantized + weights frozen, retraining later layers", flush=True)
        fit(model, data, device, iter_epochs, lr * 0.3, f"L{i}", batch, aug, balance)

        recalibrate_bn(model, data.Xtr, device, n_batches=20)
        base = auc_now()
        order = torch.argsort(conv.qweight().detach().abs().sum((1, 2, 3))).tolist()
        mk = model.mask(i)
        removed = 0
        for f in order:
            if int(mk.sum().item()) <= 2:
                break
            mk[f] = 0.0
            if auc_now() >= base - prune_tol:
                removed += 1
            else:
                mk[f] = 1.0
        print(f"    layer {i}: kept {int(mk.sum().item())}/{mk.numel()} filters (removed {removed}), "
              f"cal-split AUC {base:.4f} -> {auc_now():.4f}", flush=True)

        if isinstance(model.bns[i], nn.BatchNorm2d):
            for p in model.bns[i].parameters():
                p.requires_grad_(False)
        act.clip.requires_grad_(False)
        model.frozen.add(i)

    print("  final: quantize FC, tune only logit scale + bias for 1 epoch", flush=True)
    model.fc.qw = True
    model.fc.weight.requires_grad_(False)
    fit(model, data, device, 1, lr * 0.1, "FC", batch, aug, balance)
    return model.kept()
