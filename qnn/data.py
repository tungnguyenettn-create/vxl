"""Image loading (with .npz cache), calibration split, input quantization, augmentation."""
import os

import numpy as np
import torch
import torch.nn.functional as F

from .config import CLASSES, IMG, IMG_EXT


def list_images(folder):
    files = []
    for label, cname in enumerate(CLASSES):
        sub = os.path.join(folder, cname)
        if not os.path.isdir(sub):
            raise FileNotFoundError(f"missing folder {sub}")
        for dp, _, fns in os.walk(sub):
            for fn in sorted(fns):
                if os.path.splitext(fn)[1].lower() in IMG_EXT:
                    files.append((os.path.join(dp, fn), label))
    return files


def load_folder(folder, cache_path=None, size=IMG):
    """folder/{no_person,person}/*  ->  (uint8 N,H,W, int64 N). Cached to cache_path if given."""
    from PIL import Image
    files = list_images(folder)
    if cache_path and os.path.exists(cache_path):
        d = np.load(cache_path)
        if len(d["y"]) == len(files):
            return d["x"], d["y"]
    xs, ys = [], []
    for k, (path, label) in enumerate(files):
        im = Image.open(path).convert("L")
        if im.size != (size, size):
            im = im.resize((size, size), Image.BILINEAR)
        xs.append(np.asarray(im, dtype=np.uint8))
        ys.append(label)
        if (k + 1) % 5000 == 0:
            print(f"  loaded {k + 1}/{len(files)} images from {folder}", flush=True)
    x, y = np.stack(xs), np.array(ys, dtype=np.int64)
    if cache_path:
        os.makedirs(os.path.dirname(cache_path), exist_ok=True)
        np.savez_compressed(cache_path, x=x, y=y)
    return x, y


def load_split(root, split, cache_dir):
    return load_folder(os.path.join(root, split), os.path.join(cache_dir, f"cache_{split}_{IMG}.npz"))


class Data:
    """Tensors for train / calib / val.  The calib split (held out from train, never trained on) drives
    pruning decisions and the decision threshold.  Deterministic in (seed, calib_frac, max_train), so the
    `train` and `prune` commands see the same split."""

    def __init__(self, root, cache_dir, seed=0, calib_frac=0.05, max_train=0, need_train=True):
        rng = np.random.RandomState(seed)
        xva, yva = load_split(root, "val", cache_dir)
        self.Xva = torch.from_numpy(xva).unsqueeze(1)
        self.yva = yva
        if not need_train:
            return
        xtr, ytr = load_split(root, "train", cache_dir)
        if max_train and len(ytr) > max_train:
            sel = rng.permutation(len(ytr))[:max_train]
            xtr, ytr = xtr[sel], ytr[sel]
        perm = rng.permutation(len(ytr))
        n_cal = max(50, int(len(ytr) * calib_frac))
        cal, tr = perm[:n_cal], perm[n_cal:]
        self.Xcal = torch.from_numpy(xtr[cal]).unsqueeze(1)
        self.ycal = ytr[cal]
        self.Xtr = torch.from_numpy(xtr[tr]).unsqueeze(1)
        self.ytr_np = ytr[tr]
        self.ytr = torch.from_numpy(self.ytr_np)

    def describe(self):
        s = ""
        if hasattr(self, "Xtr"):
            s += (f"train {tuple(self.Xtr.shape)} (person={int((self.ytr_np == 1).sum())}, "
                  f"none={int((self.ytr_np == 0).sum())})  calib {tuple(self.Xcal.shape)}  ")
        return s + (f"val {tuple(self.Xva.shape)} (person={int((self.yva == 1).sum())}, "
                    f"none={int((self.yva == 0).sum())})")


def prep(x_u8, bits):
    """uint8 B,1,H,W -> keep top `bits` bits -> float in [0, 1]."""
    q = x_u8.long() >> (8 - bits)
    return q.float() / float(2 ** bits - 1)


def augment(xb):
    """Flip, brightness/contrast jitter, +-4 px shift. uint8 B,1,H,W in and out."""
    B, _, H, W = xb.shape
    x = xb.float()
    dev = x.device
    flip = torch.rand(B, device=dev) < 0.5
    x = torch.where(flip.view(B, 1, 1, 1), x.flip(3), x)
    c = 0.7 + 0.6 * torch.rand(B, 1, 1, 1, device=dev)
    b = (torch.rand(B, 1, 1, 1, device=dev) - 0.5) * 60
    m = x.mean((1, 2, 3), keepdim=True)
    x = ((x - m) * c + m + b).clamp(0, 255)
    pad = 4
    xp = F.pad(x, (pad, pad, pad, pad), mode="replicate")
    ox = torch.randint(0, 2 * pad + 1, (B,)).tolist()
    oy = torch.randint(0, 2 * pad + 1, (B,)).tolist()
    out = torch.empty_like(x)
    for k in range(B):
        out[k] = xp[k, :, oy[k]:oy[k] + H, ox[k]:ox[k] + W]
    return out.round().to(torch.uint8)
