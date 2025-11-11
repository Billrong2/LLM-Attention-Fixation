from __future__ import annotations

import math
from typing import Callable, Optional, TYPE_CHECKING

import torch
import torch.nn.functional as F
from torch import nn
from transformers.models.llama.modeling_llama import (
    LlamaAttention,
    apply_rotary_pos_emb,
    repeat_kv,
)

from .levels import level1_bias, level2_post, level4_scale

if TYPE_CHECKING:
    from .runtime import SteeringRuntime


class SteeringAttention(nn.Module):
    def __init__(
        self,
        base_attn: LlamaAttention,
        runtime_getter: Callable[[], Optional["SteeringRuntime"]],
        layer_index: int,
        config,
    ) -> None:
        super().__init__()
        self.base = base_attn
        self.runtime_getter = runtime_getter
        self.layer_index = layer_index
        self.config = config

        # Mirror base attributes to preserve HF APIs.
        self.config_hf = base_attn.config
        self.q_proj = base_attn.q_proj
        self.k_proj = base_attn.k_proj
        self.v_proj = base_attn.v_proj
        self.o_proj = base_attn.o_proj
        self.rotary_emb = base_attn.rotary_emb
        self.num_heads = base_attn.num_heads
        self.num_key_value_heads = base_attn.num_key_value_heads
        self.num_key_value_groups = base_attn.num_key_value_groups
        self.head_dim = base_attn.head_dim
        self.hidden_size = base_attn.hidden_size
        self.attention_dropout = base_attn.attention_dropout
        self.layer_idx = getattr(base_attn, "layer_idx", layer_index)

    def forward(
        self,
        hidden_states: torch.Tensor,
        attention_mask: Optional[torch.Tensor] = None,
        position_ids: Optional[torch.LongTensor] = None,
        past_key_value: Optional[torch.Tensor] = None,
        output_attentions: bool = False,
        use_cache: bool = False,
        cache_position: Optional[torch.LongTensor] = None,
        **kwargs,
    ):
        runtime = self.runtime_getter()
        bsz, q_len, _ = hidden_states.size()

        if self.config_hf.pretraining_tp > 1:
            key_value_slicing = (self.num_key_value_heads * self.head_dim) // self.config_hf.pretraining_tp
            query_slices = self.q_proj.weight.split(
                (self.num_heads * self.head_dim) // self.config_hf.pretraining_tp, dim=0
            )
            key_slices = self.k_proj.weight.split(key_value_slicing, dim=0)
            value_slices = self.v_proj.weight.split(key_value_slicing, dim=0)

            query_states = [F.linear(hidden_states, query_slices[i]) for i in range(self.config_hf.pretraining_tp)]
            query_states = torch.cat(query_states, dim=-1)

            key_states = [F.linear(hidden_states, key_slices[i]) for i in range(self.config_hf.pretraining_tp)]
            key_states = torch.cat(key_states, dim=-1)

            value_states = [F.linear(hidden_states, value_slices[i]) for i in range(self.config_hf.pretraining_tp)]
            value_states = torch.cat(value_states, dim=-1)
        else:
            query_states = self.q_proj(hidden_states)
            key_states = self.k_proj(hidden_states)
            value_states = self.v_proj(hidden_states)

        query_states = query_states.view(bsz, q_len, self.num_heads, self.head_dim).transpose(1, 2)
        key_states = key_states.view(bsz, q_len, self.num_key_value_heads, self.head_dim).transpose(1, 2)
        value_states = value_states.view(bsz, q_len, self.num_key_value_heads, self.head_dim).transpose(1, 2)

        past_key_value = getattr(self, "past_key_value", past_key_value)
        cos, sin = self.rotary_emb(value_states, position_ids)
        query_states, key_states = apply_rotary_pos_emb(query_states, key_states, cos, sin)

        if past_key_value is not None:
            cache_kwargs = {"sin": sin, "cos": cos, "cache_position": cache_position}
            key_states, value_states = past_key_value.update(key_states, value_states, self.layer_idx, cache_kwargs)

        key_states = repeat_kv(key_states, self.num_key_value_groups)
        value_states = repeat_kv(value_states, self.num_key_value_groups)

        if runtime and 4 in self.config.enabled_levels and self.layer_index >= 60:
            prior_vec = runtime.prior_tensor(key_states.device, key_states.shape[-2]).view(-1)
            key_states, value_states = level4_scale(
                key_states,
                value_states,
                prior_vec,
                self.config.alpha_k,
                self.config.alpha_v,
                self.config.gamma_min,
                self.config.gamma_max,
                self.config.eta_min,
                self.config.eta_max,
            )

        attn_weights = torch.matmul(query_states, key_states.transpose(2, 3)) / math.sqrt(self.head_dim)

        if runtime and 1 in self.config.enabled_levels and self.layer_index >= 52:
            bias = runtime.prior_tensor(attn_weights.device, attn_weights.shape[-1])
            attn_weights = level1_bias(attn_weights, bias, runtime.coeffs().beta_bias, cap=self.config.bias_cap)

        if attention_mask is not None:
            if cache_position is not None:
                causal_mask = attention_mask[:, :, cache_position, : key_states.shape[-2]]
                attn_weights = attn_weights + causal_mask
            else:
                attn_weights = attn_weights + attention_mask

        attn_probs = nn.functional.softmax(attn_weights, dim=-1, dtype=torch.float32).to(query_states.dtype)
        attn_probs = nn.functional.dropout(attn_probs, p=self.attention_dropout, training=self.training)

        if runtime:
            mean_heads = attn_probs.mean(dim=1)
            runtime.latest_attention = mean_heads[:, -1, :].detach()

        if runtime and 2 in self.config.enabled_levels and self.layer_index >= 52:
            scale = runtime.prior_tensor(attn_probs.device, attn_probs.shape[-1])
            attn_probs = level2_post(attn_probs, scale, runtime.coeffs().beta_post)

        attn_output = torch.matmul(attn_probs, value_states)

        if attn_output.size() != (bsz, self.num_heads, q_len, self.head_dim):
            raise ValueError("Unexpected attention output size")

        attn_output = attn_output.transpose(1, 2).contiguous().reshape(bsz, q_len, self.hidden_size)

        if self.config_hf.pretraining_tp > 1:
            attn_output = attn_output.split(self.hidden_size // self.config_hf.pretraining_tp, dim=2)
            o_proj_slices = self.o_proj.weight.split(self.hidden_size // self.config_hf.pretraining_tp, dim=1)
            attn_output = sum([F.linear(attn_output[i], o_proj_slices[i]) for i in range(self.config_hf.pretraining_tp)])
        else:
            attn_output = self.o_proj(attn_output)

        if not output_attentions:
            attn_probs = None

        present_key_value = past_key_value if use_cache else None
        return attn_output, attn_probs, present_key_value
