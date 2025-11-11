from __future__ import annotations

from typing import Callable, Optional, TYPE_CHECKING

import torch
from transformers.models.llama.modeling_llama import LlamaDecoderLayer

if TYPE_CHECKING:
    from .runtime import SteeringRuntime
    from .config import SteeringConfig


def patch_decoder_layer(
    layer: LlamaDecoderLayer,
    runtime_getter: Callable[[], Optional["SteeringRuntime"]],
    config: "SteeringConfig",
    layer_idx: int,
) -> None:
    original_forward = layer.forward

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
        if runtime and 3 in config.enabled_levels and 40 <= layer_idx <= 63:
            hidden_states = hidden_states * coeffs.lambda_attn
        hidden_states = residual + hidden_states

        residual = hidden_states
        hidden_states = layer.post_attention_layernorm(hidden_states)
        hidden_states = layer.mlp(hidden_states)
        if runtime and 3 in config.enabled_levels and 40 <= layer_idx <= 63:
            hidden_states = hidden_states * coeffs.lambda_mlp
        hidden_states = residual + hidden_states

        outputs = (hidden_states,)
        if output_attentions:
            outputs += (self_attn_weights,)
        if use_cache:
            outputs += (present_key_value,)
        return outputs

    layer.forward = steered_forward
