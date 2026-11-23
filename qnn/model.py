"""QNet: VGG-style 3x3 convs + max-pool + global average pool + 2-way FC.

Parameter names match qnn_presence.py, so its model.pt files load here directly."""
import torch
import torch.nn as nn
import torch.nn.functional as F

from .config import ABITS, IN_BITS, USE_BN
from .quant import ActQ, QConv2d, QLinear


class QNet(nn.Module):
    def __init__(self, arch, abits=ABITS, in_bits=IN_BITS, use_bn=USE_BN):
        super().__init__()
        self.in_bits = in_bits
        self.frozen = set()
        self.pools = [p for _, p in arch]
        self.convs = nn.ModuleList()
        self.bns = nn.ModuleList()
        self.acts = nn.ModuleList()
        cin = 1
        for i, (c, _) in enumerate(arch):
            self.convs.append(QConv2d(cin, c, bias=not use_bn))
            self.bns.append(nn.BatchNorm2d(c) if use_bn else nn.Identity())
            self.acts.append(ActQ(abits))
            self.register_buffer(f"mask{i}", torch.ones(c))   # 0 = pruned filter
            cin = c
        self.fc = QLinear(cin, 2)
        self.fc_scale = nn.Parameter(torch.tensor(1.0))       # positive scalar: does not change argmax

    def mask(self, i):
        return getattr(self, f"mask{i}")

    def kept(self):
        return [int(self.mask(i).sum().item()) for i in range(len(self.convs))]

    def forward(self, x):
        for i in range(len(self.convs)):
            x = self.acts[i](self.bns[i](self.convs[i](x)))
            x = x * self.mask(i).view(1, -1, 1, 1)
            if self.pools[i]:
                x = F.max_pool2d(x, 2)
        return self.fc_scale * self.fc(x.mean((2, 3)))

    def train(self, mode=True):
        super().train(mode)
        if mode:                                   # frozen layers keep their BN running stats
            for i in self.frozen:
                if isinstance(self.bns[i], nn.BatchNorm2d):
                    self.bns[i].eval()
        return self

    def set_quant(self, on):
        for c in self.convs:
            c.qw = on
        self.fc.qw = on
        for a in self.acts:
            a.enabled = on

    @torch.no_grad()
    def clip_weights(self):
        for m in list(self.convs) + [self.fc]:
            m.weight.clamp_(-0.5, 0.5)

    @torch.no_grad()
    def calibrate_layer(self, i, x, use_batch_stats=True):
        """Set activation clip of layer i to the 99.9th percentile of its positive pre-activation."""
        was = self.training
        self.train(use_batch_stats)
        h = x
        for j in range(i + 1):
            z = self.bns[j](self.convs[j](h))
            if j == i:
                v = z.flatten()
                v = v[v > 0]
                v = v[:: max(1, v.numel() // 500000)]
                if v.numel() > 0:
                    self.acts[i].clip.fill_(max(torch.quantile(v, 0.999).item(), 1e-2))
                break
            h = self.acts[j](z) * self.mask(j).view(1, -1, 1, 1)
            if self.pools[j]:
                h = F.max_pool2d(h, 2)
        self.train(was)
