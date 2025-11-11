from __future__ import annotations

from dataclasses import dataclass
from typing import Optional, Sequence

import numpy as np
import torch

from .config import SteeringConfig
from .manager import SteeringManager
from .pointer import build_pointer_mapping


@dataclass
class SteeringRuntime:
    config: SteeringConfig
    manager: SteeringManager
    prompt_token_ids: Sequence[int]
    prompt_tokens: Sequence[str]
    pointer_mapping: dict
    prompt_len: int
    total_steps: int = 0
    step_index: int = 0
    latest_attention: Optional[torch.Tensor] = None

    def start(self, total_steps: int) -> None:
        self.total_steps = total_steps
        self.step_index = 0
        self.manager.init_bins(total_steps)
        self.manager.step(self.step_index)

    def advance(self) -> None:
        self.step_index = min(self.step_index + 1, self.total_steps - 1)
        self.manager.step(self.step_index)

    def prior_tensor(self, device: torch.device, key_len: int) -> torch.Tensor:
        prior_vec = self.manager.prior_vector()
        tensor = torch.zeros(key_len, device=device, dtype=torch.float32)
        prompt_len = min(self.prompt_len, key_len)
        tensor[:prompt_len] = torch.from_numpy(prior_vec[:prompt_len]).to(device)
        norm = tensor.sum()
        if norm > 0:
            tensor = tensor / norm
        return tensor.view(1, 1, 1, -1)

    def coeffs(self):
        return self.manager.coeffs()


def create_runtime(
    config: SteeringConfig,
    prompt_token_ids: Sequence[int],
    prompt_tokens: Sequence[str],
    code_text: str,
    vocab_tokens: Sequence[dict],
) -> SteeringRuntime:
    manager = SteeringManager(
        config=config,
        prompt_tokens=prompt_tokens,
        code_text=code_text,
        vocab_tokens=vocab_tokens,
    )
    pointer_mapping = build_pointer_mapping(prompt_token_ids)
    return SteeringRuntime(
        config=config,
        manager=manager,
        prompt_token_ids=prompt_token_ids,
        prompt_tokens=prompt_tokens,
        pointer_mapping=pointer_mapping,
        prompt_len=len(prompt_token_ids),
    )
