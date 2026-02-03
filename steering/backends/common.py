from __future__ import annotations

from dataclasses import dataclass
from typing import Any


@dataclass(frozen=True)
class LayerCutoffs:
    """
    Default layer ranges for steering levels.

    The original implementation was tuned for an 80-layer model (CodeLlama-70B):
    - Level 1/2: layers >= 52
    - Level 4:   layers >= 60
    - Level 3:   layers 40..63

    To keep the *same strategy* across model sizes, we scale these cutoffs as a
    fraction of total decoder layers. For 80 layers, the fractions reproduce
    the original constants exactly.
    """

    l12_start: int
    l4_start: int
    l3_start: int
    l3_end: int


def compute_default_cutoffs(num_layers: int) -> LayerCutoffs:
    if num_layers <= 0:
        return LayerCutoffs(l12_start=0, l4_start=0, l3_start=0, l3_end=0)

    def clamp_idx(idx: int) -> int:
        return max(0, min(num_layers - 1, idx))

    # Keep the same relative "late layer" behavior.
    l12_start = clamp_idx(int(num_layers * 0.65))
    l4_start = clamp_idx(int(num_layers * 0.75))

    l3_start = clamp_idx(int(num_layers * 0.50))
    l3_end = clamp_idx(int(num_layers * 0.7875))
    if l3_end < l3_start:
        l3_end = l3_start

    return LayerCutoffs(l12_start=l12_start, l4_start=l4_start, l3_start=l3_start, l3_end=l3_end)


def get_decoder_layers(model: Any):
    """
    Return decoder layers for common HF causal LMs (LLaMA/CodeLlama, Qwen2.*).
    """

    # LlamaForCausalLM / Qwen2ForCausalLM expose: model.model.layers
    inner = getattr(model, "model", None)
    layers = getattr(inner, "layers", None) if inner is not None else None
    if layers is None:
        raise AttributeError(
            "Unsupported model structure: expected `model.model.layers` to exist for steering backends."
        )
    return layers

