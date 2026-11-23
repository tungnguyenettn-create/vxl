"""Quantizers (straight-through estimators) and quantized layers."""
import torch
import torch.nn as nn
import torch.nn.functional as F

from .config import W_EMAX, W_EMIN


def ste(x, q):
    return x + (q - x).detach()


def pow2_weight(w, emin=W_EMIN, emax=W_EMAX):
    """w_q = sign(w) * 2^round(log2|w|), |w| < 2^emin -> 0, range capped at 2^emax (4-bit code)."""
    a = w.abs()
    e = torch.round(torch.log2(a.clamp(min=2.0 ** emin / 2))).clamp(emin, emax)
    q = torch.sign(w) * torch.pow(2.0, e)
    q = torch.where(a < 2.0 ** emin, torch.zeros_like(q), q)
    return ste(w, q)


def pow2_ste(x):
    return ste(x, torch.pow(2.0, torch.round(torch.log2(x.clamp(min=1e-6)))))


class QConv2d(nn.Conv2d):
    """3x3 conv, stride 1, pad 1. qw=False -> float weights (stage 0 of iterative training)."""

    def __init__(self, cin, cout, bias):
        super().__init__(cin, cout, 3, padding=1, bias=bias)
        self.qw = True

    def qweight(self):
        return pow2_weight(self.weight) if self.qw else self.weight

    def forward(self, x):
        return F.conv2d(x, self.qweight(), self.bias, 1, 1)


class QLinear(nn.Linear):
    def __init__(self, i, o):
        super().__init__(i, o)
        self.qw = True

    def qweight(self):
        return pow2_weight(self.weight) if self.qw else self.weight

    def forward(self, x):
        return F.linear(x, self.qweight(), self.bias)


class ActQ(nn.Module):
    """Clipped ReLU with 2^bits-1 levels, clip forced to a power of 2. enabled=False -> plain ReLU."""

    def __init__(self, bits):
        super().__init__()
        self.bits = bits
        self.enabled = True
        self.clip = nn.Parameter(torch.tensor(4.0))

    def forward(self, x):
        if not self.enabled:
            return F.relu(x)
        c = pow2_ste(self.clip.abs())
        y = torch.minimum(F.relu(x), c)
        lv = float(2 ** self.bits - 1)
        return ste(y, torch.round(y / c * lv) / lv * c)
