"""First-order LUT / memory / FPS estimate of a time-multiplexed pow2 core on EP4CE6 (+-30-100 %).
Compare variants with it; calibrate with one Quartus synthesis of a single PE.
Does not include a camera frame buffer."""
import math

from .config import ABITS, IMG, IN_BITS, USE_BN

EP4CE6 = dict(le=6272, mem_bits=276480, m9k=30, mult18=15)


def layers_of(arch, kept=None):
    ch = list(kept) if kept else [c for c, _ in arch]
    out, cin, hw = [], 1, IMG
    for (_, pool), c in zip(arch, ch):
        out.append(dict(cin=cin, cout=c, hw=hw, pool=pool))
        cin = c
        if pool:
            hw //= 2
    return out


def estimate(arch, kept=None, P=1, fclk=50e6, abits=ABITS, in_bits=IN_BITS, bn=USE_BN):
    L = layers_of(arch, kept)
    a = max(abits, in_bits)                      # PE input width
    max_cin = max(l["cin"] for l in L)
    w = a + 7
    dot, dot_w = 9 * 3 * w + 8 * w + 15, w + 4   # 9 barrel shifters (3 stages) + adder tree
    acc_w = dot_w + math.ceil(math.log2(max(2, max_cin)))
    post = acc_w + 3 * acc_w + a                 # bias add + pow2 re-quant shifter + clamp
    mults = P if bn else 0                       # BN scale: one multiplier per PE
    pe = dot + acc_w + post
    luts = (P * pe + P * 2 * abits + 250 + 60 * len(L) + 18 * a + P * (abits + 7) + 3 * acc_w
            + max(0, mults - EP4CE6["mult18"]) * 16 * a)

    cycles = sum(math.ceil(l["cout"] / P) * l["cin"] * l["hw"] ** 2 for l in L) + IMG * IMG + 200
    tensors = [IMG * IMG * in_bits]
    for l in L:
        h = l["hw"] // 2 if l["pool"] else l["hw"]
        tensors.append(h * h * l["cout"] * abits)
    ram0, ram1 = max(tensors[0::2]), max(tensors[1::2])
    params = sum(l["cin"] * l["cout"] * 9 for l in L) + L[-1]["cout"] * 2
    wbits = params * 4
    pbits = sum(l["cout"] for l in L) * (40 if bn else 24) + 2 * 24
    mem = ram0 + ram1 + wbits + pbits
    blocks = sum(math.ceil(b / 9216) for b in (ram0, ram1, wbits, pbits))
    return dict(P=P, luts=int(luts), mults=mults, params=params, mem_kbit=mem / 1024, m9k=blocks,
                cycles=cycles, fps=fclk / cycles, fit_le=luts / EP4CE6["le"], fit_m9k=blocks / EP4CE6["m9k"])


def format_estimate(e):
    ok = "yes" if (e["fit_le"] < 0.8 and e["fit_m9k"] <= 1.0) else "NO"
    return (f"  P={e['P']:<2d} LUT~{e['luts']:5d} ({100 * e['fit_le']:3.0f}% of 6272)  mem~{e['mem_kbit']:6.1f} kbit "
            f"(M9K~{e['m9k']:2d}/30)  mult={e['mults']:<2d} params={e['params']:<6d} {e['fps']:6.1f} FPS  fits? {ok}")
