"""iter_p2w4a6_in4: pow2 4-bit weights, 6-bit activations, 4-bit gray input, iterative quantize + prune."""
from .config import DEFAULT_ARCH, NAME, parse_arch
from .model import QNet

__all__ = ["DEFAULT_ARCH", "NAME", "QNet", "parse_arch"]
