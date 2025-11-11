from __future__ import annotations

from collections import defaultdict
from typing import Dict, Sequence, TYPE_CHECKING

import torch
from transformers.generation.logits_process import LogitsProcessor

if TYPE_CHECKING:
    from .runtime import SteeringRuntime


class PointerBiasProcessor(LogitsProcessor):
    def __init__(self, runtime: "SteeringRuntime"):
        self.runtime = runtime

    def __call__(self, input_ids: torch.LongTensor, scores: torch.FloatTensor) -> torch.FloatTensor:
        runtime = self.runtime
        coeffs = runtime.coeffs()
        beta = coeffs.beta_ptr
        if beta == 0.0 or runtime.latest_attention is None:
            runtime.advance()
            return scores

        attention_vector = runtime.latest_attention  # [batch, k_len]
        bias = torch.zeros_like(scores)
        for vocab_id, positions in runtime.pointer_mapping.items():
            mass = attention_vector[:, positions].sum(dim=1)
            bias[:, vocab_id] += beta * mass
        scores = scores + bias
        runtime.advance()
        return scores


class StepAdvanceProcessor(LogitsProcessor):
    def __init__(self, runtime: "SteeringRuntime"):
        self.runtime = runtime

    def __call__(self, input_ids: torch.LongTensor, scores: torch.FloatTensor) -> torch.FloatTensor:
        self.runtime.advance()
        return scores


def build_pointer_mapping(prompt_tokens: Sequence[int]) -> Dict[int, Sequence[int]]:
    mapping = defaultdict(list)
    for idx, token_id in enumerate(prompt_tokens):
        mapping[token_id].append(idx)
    return mapping
