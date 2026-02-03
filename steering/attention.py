"""
Legacy import shim.

The steering implementation is model-family specific. The original code in this
module was LLaMA/CodeLlama-specific. It has been moved to
`steering.backends.llama_backend` so we can add additional backends (e.g.,
Qwen2.5) without mixing architectures in one file.
"""

from .backends.llama_backend import SteeringAttention

__all__ = ["SteeringAttention"]
