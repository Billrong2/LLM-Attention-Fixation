from __future__ import annotations

import math
from typing import Callable, Optional, TYPE_CHECKING

import torch
import torch.nn.functional as F
from torch import nn
from transformers.models.llama.modeling_llama import (
    LlamaAttention,
    LlamaDecoderLayer,
    apply_rotary_pos_emb,
    repeat_kv,
)

from ..levels import level1_bias, level2_post, level4_scale
from .common import LayerCutoffs, compute_default_cutoffs, get_decoder_layers

if TYPE_CHECKING:
    from ..config import SteeringConfig
    from ..runtime import SteeringRuntime


class SteeringAttention(nn.Module):  ## Llama Steering Attention.
    """
    LLaMA/CodeLlama-specific attention wrapper that applies steering levels.
    """

    def __init__(
        self,
        base_attn: LlamaAttention,
        runtime_getter: Callable[[], Optional["SteeringRuntime"]],
        layer_index: int,
        config: "SteeringConfig",
        cutoffs: LayerCutoffs | None = None,
    ) -> None:
        super().__init__()
        self.base = base_attn
        self.runtime_getter = runtime_getter
        self.layer_index = layer_index
        self.config = config
        if cutoffs is None:
            num_layers = int(getattr(getattr(base_attn, "config", None), "num_hidden_layers", 80))
            cutoffs = compute_default_cutoffs(num_layers)
        self.cutoffs = cutoffs

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

        target_device = hidden_states.device
        if position_ids is not None and position_ids.device != target_device:
            position_ids = position_ids.to(target_device)
        if attention_mask is not None and attention_mask.device != target_device:
            attention_mask = attention_mask.to(target_device)
        if cache_position is not None and cache_position.device != target_device:
            cache_position = cache_position.to(target_device)

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

        if runtime and 4 in self.config.enabled_levels and self.layer_index >= self.cutoffs.l4_start:
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

        if runtime and 1 in self.config.enabled_levels and runtime.should_apply_l12(
            layer_idx=self.layer_index,
            q_len=q_len,
            kv_len=attn_weights.shape[-1],
            default_layer_start=self.cutoffs.l12_start,
            default_layer_end=self.cutoffs.l12_end,
        ):
            base_attn_weights = attn_weights
            bias = runtime.prior_tensor(attn_weights.device, attn_weights.shape[-1])
            steered_attn_weights = level1_bias(attn_weights, bias, runtime.coeffs().beta_bias, cap=self.config.bias_cap)
            head_mask = runtime.get_head_mask_tensor(
                layer_idx=self.layer_index,
                num_layers=int(getattr(self.config_hf, "num_hidden_layers", self.layer_index + 1)),
                num_heads=self.num_heads,
                device=attn_weights.device,
                level="l1",
            )
            if head_mask is not None:
                attn_weights = base_attn_weights + (steered_attn_weights - base_attn_weights) * head_mask.to(attn_weights.dtype)
            else:
                attn_weights = steered_attn_weights
            runtime.steer_calls += 1

        effective_mask = None
        if attention_mask is not None:
            if cache_position is not None:
                causal_mask = attention_mask[:, :, cache_position, : key_states.shape[-2]]
                attn_weights = attn_weights + causal_mask
                effective_mask = causal_mask
            else:
                attn_weights = attn_weights + attention_mask
                effective_mask = attention_mask

        if runtime and runtime.debug_assert_mask and effective_mask is not None:
            mask_blocked = effective_mask <= -1e4
            if mask_blocked.any():
                if mask_blocked.shape != attn_weights.shape:
                    mask_blocked = mask_blocked.expand_as(attn_weights)
                masked_logits = attn_weights.masked_select(mask_blocked)
                if masked_logits.numel() > 0:
                    assert torch.all(masked_logits < -1e4), "Masked logits became finite after steering bias."

        attn_probs = nn.functional.softmax(attn_weights, dim=-1, dtype=torch.float32)
        attn_probs = nn.functional.dropout(attn_probs, p=self.attention_dropout, training=self.training)

        if runtime:
            mean_heads = attn_probs.mean(dim=1)
            runtime.latest_attention = mean_heads[:, -1, :].detach()
            runtime.maybe_collect_head_stats(
                layer_idx=self.layer_index,
                num_layers=int(getattr(self.config_hf, "num_hidden_layers", self.layer_index + 1)),
                num_heads=self.num_heads,
                q_len=q_len,
                kv_len=attn_probs.shape[-1],
                default_layer_start=self.cutoffs.l12_start,
                default_layer_end=self.cutoffs.l12_end,
                attn_probs=attn_probs,
            )

        if runtime and 2 in self.config.enabled_levels and runtime.should_apply_l12(
            layer_idx=self.layer_index,
            q_len=q_len,
            kv_len=attn_probs.shape[-1],
            default_layer_start=self.cutoffs.l12_start,
            default_layer_end=self.cutoffs.l12_end,
        ):
            base_attn_probs = attn_probs
            scale = runtime.prior_tensor(attn_probs.device, attn_probs.shape[-1])
            steered_attn_probs = level2_post(attn_probs, scale, runtime.coeffs().beta_post)
            head_mask = runtime.get_head_mask_tensor(
                layer_idx=self.layer_index,
                num_layers=int(getattr(self.config_hf, "num_hidden_layers", self.layer_index + 1)),
                num_heads=self.num_heads,
                device=attn_probs.device,
                level="l2",
            )
            if head_mask is not None:
                attn_probs = base_attn_probs + (steered_attn_probs - base_attn_probs) * head_mask.to(attn_probs.dtype)
            else:
                attn_probs = steered_attn_probs
            runtime.steer_calls += 1
        attn_probs = attn_probs.to(value_states.dtype)

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


def patch_decoder_layer(
    layer: LlamaDecoderLayer,
    runtime_getter: Callable[[], Optional["SteeringRuntime"]],
    config: "SteeringConfig",
    layer_idx: int,
    cutoffs: LayerCutoffs | None = None,
) -> None:
    if cutoffs is None:
        attn = getattr(layer, "self_attn", None)
        cfg = getattr(attn, "config", None) or getattr(attn, "config_hf", None)
        num_layers = int(getattr(cfg, "num_hidden_layers", 80))
        cutoffs = compute_default_cutoffs(num_layers)

    def steered_forward(
        hidden_states: torch.Tensor,
        attention_mask: Optional[torch.Tensor] = None,
        position_ids: Optional[torch.LongTensor] = None,
        past_key_value: Optional[tuple[torch.Tensor]] = None,
        output_attentions: bool = False,
        use_cache: bool = False,
        cache_position: Optional[torch.LongTensor] = None,
        **kwargs,
    ):
        runtime = runtime_getter()
        coeffs = runtime.coeffs() if runtime else None

        residual = hidden_states
        hidden_states = layer.input_layernorm(hidden_states)
        hidden_states, self_attn_weights, present_key_value = layer.self_attn(
            hidden_states=hidden_states,
            attention_mask=attention_mask,
            position_ids=position_ids,
            past_key_value=past_key_value,
            output_attentions=output_attentions,
            use_cache=use_cache,
            cache_position=cache_position,
            **kwargs,
        )

        hidden_states = hidden_states.to(dtype=residual.dtype, device=residual.device, non_blocking=True)
        if runtime and 3 in config.enabled_levels and cutoffs.l3_start <= layer_idx <= cutoffs.l3_end:
            hidden_states = hidden_states * coeffs.lambda_attn
        residual = residual.to(hidden_states.device, dtype=hidden_states.dtype, non_blocking=True)
        hidden_states = residual + hidden_states

        residual = hidden_states
        hidden_states = layer.post_attention_layernorm(hidden_states)
        hidden_states = layer.mlp(hidden_states)
        hidden_states = hidden_states.to(dtype=residual.dtype, device=residual.device, non_blocking=True)
        if runtime and 3 in config.enabled_levels and cutoffs.l3_start <= layer_idx <= cutoffs.l3_end:
            hidden_states = hidden_states * coeffs.lambda_mlp
        residual = residual.to(hidden_states.device, dtype=hidden_states.dtype, non_blocking=True)
        hidden_states = residual + hidden_states

        outputs = (hidden_states,)
        if output_attentions:
            outputs += (self_attn_weights,)
        if use_cache:
            outputs += (present_key_value,)
        return outputs

    layer.forward = steered_forward  # type: ignore[method-assign]


def install_llama_steering(
    model,
    runtime_getter: Callable[[], Optional["SteeringRuntime"]],
    config: "SteeringConfig",
) -> None:
    layers = get_decoder_layers(model)
    cutoffs = compute_default_cutoffs(len(layers))
    for idx, layer in enumerate(layers):
        layer.self_attn = SteeringAttention(
            layer.self_attn,
            runtime_getter=runtime_getter,
            layer_index=idx,
            config=config,
            cutoffs=cutoffs,
        )
        patch_decoder_layer(layer, runtime_getter, config, idx, cutoffs=cutoffs)
