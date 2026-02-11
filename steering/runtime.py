from __future__ import annotations

from dataclasses import dataclass, field
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
    prompt_attention_mask: Optional[Sequence[int]] = None
    enabled: bool = True
    decode_only: bool = True
    only_first_decode_step: bool = True
    layer_start: Optional[int] = None
    layer_end: Optional[int] = None
    gating_debug: bool = False
    debug_assert_mask: bool = False
    total_steps: int = 0
    step_index: int = 0
    latest_attention: Optional[torch.Tensor] = None
    steer_calls: int = 0
    blocked_prefill_calls: int = 0
    blocked_q_len: int = 0
    blocked_kv_len: int = 0
    blocked_layer: int = 0
    blocked_disabled: int = 0
    _gate_logged_once: bool = False
    temporal_debug: list[dict] = field(default_factory=list)
    _temporal_logged_keys: set[tuple[int, int]] = field(default_factory=set)

    def start(self, total_steps: int) -> None:
        self.total_steps = total_steps
        self.step_index = 0
        self.steer_calls = 0
        self.blocked_prefill_calls = 0
        self.blocked_q_len = 0
        self.blocked_kv_len = 0
        self.blocked_layer = 0
        self.blocked_disabled = 0
        self._gate_logged_once = False
        self.temporal_debug = []
        self._temporal_logged_keys = set()
        self.manager.init_bins(total_steps)
        self.manager.step(self.step_index)

    def advance(self) -> None:
        self.step_index = min(self.step_index + 1, self.total_steps - 1)
        self.manager.step(self.step_index)

    def _prompt_mask_tensor(self, device: torch.device, key_len: int) -> torch.Tensor:
        """
        Valid-key mask for [0:key_len), using prompt pad-mask for prompt positions and
        ones for generated positions.
        """
        mask = torch.ones(key_len, device=device, dtype=torch.float32)
        if self.prompt_attention_mask is not None:
            prompt_len = min(self.prompt_len, key_len, len(self.prompt_attention_mask))
            if prompt_len > 0:
                prompt_mask = torch.as_tensor(
                    self.prompt_attention_mask[:prompt_len],
                    device=device,
                    dtype=torch.float32,
                )
                mask[:prompt_len] = prompt_mask
        return mask

    def _uniform_over_valid_keys(self, device: torch.device, key_len: int) -> torch.Tensor:
        key_valid = self._prompt_mask_tensor(device, key_len)
        total = key_valid.sum()
        if total <= 0:
            return torch.full((key_len,), 1.0 / max(key_len, 1), device=device, dtype=torch.float32)
        return key_valid / total

    def _record_temporal_debug(self, key_len: int, prior_vec: torch.Tensor, rho_used: float) -> None:
        if len(self.temporal_debug) >= 3:
            return
        key = (self.step_index, int(key_len))
        if key in self._temporal_logged_keys:
            return
        self._temporal_logged_keys.add(key)

        prompt_len = min(self.prompt_len, key_len)
        recent_start = max(0, key_len - max(int(self.config.recency_window), 1))
        prompt_mass = float(prior_vec[:prompt_len].sum().item()) if prompt_len > 0 else 0.0
        recent_mass = float(prior_vec[recent_start:key_len].sum().item()) if key_len > recent_start else 0.0
        generated_mass = float(prior_vec[prompt_len:key_len].sum().item()) if key_len > prompt_len else 0.0
        self.temporal_debug.append(
            {
                "step_index": int(self.step_index),
                "kv_len": int(key_len),
                "rho_used": float(rho_used),
                "prompt_mass": prompt_mass,
                "recent_mass": recent_mass,
                "generated_mass": generated_mass,
            }
        )

    def build_key_prior(self, device: torch.device, key_len: int) -> torch.Tensor:
        """
        Step-2 temporal prior:
        - First decode step: prompt prior only.
        - Later decode steps: (1-rho)*prompt_prior_padded + rho*recency_prior.
        - Uniform prior stays a no-op over valid keys.
        """
        eps = 1e-12
        key_len = int(key_len)
        if key_len <= 0:
            return torch.zeros(0, device=device, dtype=torch.float32)

        # Keep uniform prior as a guaranteed no-op for softmax.
        if self.config.prior == "uniform":
            prior = self._uniform_over_valid_keys(device, key_len)
            self._record_temporal_debug(key_len, prior, rho_used=0.0)
            return prior

        prompt_len = min(self.prompt_len, key_len)
        prompt_prior = torch.zeros(key_len, device=device, dtype=torch.float32)
        prior_vec = self.manager.prior_vector()
        if prompt_len > 0:
            prompt_prior[:prompt_len] = torch.from_numpy(prior_vec[:prompt_len]).to(device=device, dtype=torch.float32)

        key_valid = self._prompt_mask_tensor(device, key_len)
        prompt_prior = prompt_prior * key_valid
        prompt_mass = prompt_prior.sum()
        if prompt_mass > 0:
            prompt_prior = prompt_prior / prompt_mass
        else:
            prompt_prior = self._uniform_over_valid_keys(device, key_len)

        rho = float(np.clip(self.config.recency_rho, 0.0, 1.0))
        use_mix = bool(self.config.recency_mix)
        apply_after_prompt = bool(self.config.recency_apply_after_prompt)
        if (not use_mix) or (apply_after_prompt and key_len == prompt_len):
            prior = prompt_prior
            self._record_temporal_debug(key_len, prior, rho_used=0.0)
            return prior

        # Recency prior: prefer generated keys first, fallback to last-W overall.
        window = max(1, int(self.config.recency_window))
        if str(self.config.recency_scope).lower() == "prefer_generated":
            start = max(prompt_len, key_len - window)
            if start >= key_len:
                start = max(0, key_len - window)
        else:
            start = max(0, key_len - window)

        recent = torch.zeros(key_len, device=device, dtype=torch.float32)
        recent[start:key_len] = 1.0
        recent = recent * key_valid
        recent_mass = recent.sum()
        if recent_mass > 0:
            recent = recent / recent_mass
        else:
            recent = self._uniform_over_valid_keys(device, key_len)

        prior = (1.0 - rho) * prompt_prior + rho * recent
        prior = prior * key_valid
        norm = prior.sum()
        if norm > eps:
            prior = prior / norm
        else:
            prior = self._uniform_over_valid_keys(device, key_len)
        self._record_temporal_debug(key_len, prior, rho_used=rho)
        return prior

    def prior_tensor(self, device: torch.device, key_len: int) -> torch.Tensor:
        prior_vec = self.build_key_prior(device=device, key_len=key_len)
        return prior_vec.view(1, 1, 1, -1)

    def coeffs(self):
        return self.manager.coeffs()

    def should_apply_l12(
        self,
        *,
        layer_idx: int,
        q_len: int,
        kv_len: int,
        default_layer_start: int,
        default_layer_end: int,
    ) -> bool:
        reason = "apply"
        if not self.enabled:
            self.blocked_disabled += 1
            reason = "disabled"
            self._maybe_log_gate_decision(layer_idx, q_len, kv_len, reason)
            return False
        layer_start = default_layer_start if self.layer_start is None else self.layer_start
        layer_end = default_layer_end if self.layer_end is None else self.layer_end
        if layer_idx < layer_start or layer_idx > layer_end:
            self.blocked_layer += 1
            reason = "layer"
            self._maybe_log_gate_decision(layer_idx, q_len, kv_len, reason)
            return False
        if self.decode_only and q_len != 1:
            self.blocked_prefill_calls += 1
            self.blocked_q_len += 1
            reason = "q_len"
            self._maybe_log_gate_decision(layer_idx, q_len, kv_len, reason)
            return False
        if self.only_first_decode_step and kv_len != self.prompt_len:
            self.blocked_kv_len += 1
            reason = "kv_len"
            self._maybe_log_gate_decision(layer_idx, q_len, kv_len, reason)
            return False
        self._maybe_log_gate_decision(layer_idx, q_len, kv_len, reason)
        return True

    def _maybe_log_gate_decision(self, layer_idx: int, q_len: int, kv_len: int, reason: str) -> None:
        if not self.gating_debug or self._gate_logged_once:
            return
        print(
            f"[SteeringGate] layer={layer_idx} q_len={q_len} kv_len={kv_len} "
            f"prompt_len={self.prompt_len} decision={reason}"
        )
        self._gate_logged_once = True


def create_runtime(
    config: SteeringConfig,
    prompt_token_ids: Sequence[int],
    prompt_tokens: Sequence[str],
    code_text: str,
    vocab_tokens: Sequence[dict],
    prompt_attention_mask: Optional[Sequence[int]] = None,
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
        prompt_attention_mask=prompt_attention_mask,
        enabled=config.steering_enabled,
        decode_only=config.decode_only,
        only_first_decode_step=config.only_first_decode_step,
        layer_start=config.steer_layer_start,
        layer_end=config.steer_layer_end,
        gating_debug=config.gating_debug,
        debug_assert_mask=config.debug_assert_mask,
    )
