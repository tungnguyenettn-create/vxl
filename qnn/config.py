"""Fixed configuration of iter_p2w4a6_in4.

    weights     : power-of-2, 4-bit code (0, +-2^-1 .. +-2^-7)
    activations : 6-bit clipped ReLU, clip forced to a power of 2
    input       : 4-bit grayscale (top 4 bits of the uint8 pixel)
    training    : float -> per layer quantize / freeze / retrain / prune (paper Algorithm 1)
"""
NAME = "iter_p2w4a6_in4"
IMG = 64                      # input size (64x64 grayscale)
IN_BITS = 4                   # input pixel bits
ABITS = 6                     # activation bits
W_EMIN, W_EMAX = -7, -1       # pow2 weight exponent range (|w| < 2^-7 -> 0, |w| <= 0.5)
USE_BN = True                 # BatchNorm (folds into per-channel scale + bias in hardware)
DEFAULT_ARCH = "8p-16p-24-32p-32"
CLASSES = ("no_person", "person")   # folder names -> label 0 / 1
IMG_EXT = {".png", ".jpg", ".jpeg", ".bmp", ".webp", ".tif", ".tiff"}


def parse_arch(spec):
    """'8p-16p-24-32p-32' -> [(8, True), (16, True), (24, False), (32, True), (32, False)]
    number = conv output channels, 'p' = 2x2 max-pool after that conv."""
    out = []
    for tok in spec.split("-"):
        out.append((int(tok.rstrip("p")), tok.endswith("p")))
    if sum(p for _, p in out) > 5:
        raise SystemExit(f"arch '{spec}': more than 5 pools on a {IMG}x{IMG} input")
    return out
