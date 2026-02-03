from __future__ import annotations

from typing import Callable, Optional, TYPE_CHECKING, Any

if TYPE_CHECKING:
    from ..config import SteeringConfig
    from ..runtime import SteeringRuntime


def _model_type(model: Any) -> str:
    cfg = getattr(model, "config", None)
    return str(getattr(cfg, "model_type", "") or "").lower()


def install_steering_hooks(
    model: Any,
    runtime_getter: Callable[[], Optional["SteeringRuntime"]],
    config: "SteeringConfig",
) -> str:
    """
    Install steering hooks for the given HF model.

    Returns the backend name ("llama" or "qwen2").
    """

    model_type = _model_type(model)
    if model_type == "qwen2":
        from .qwen2_backend import install_qwen2_steering

        install_qwen2_steering(model, runtime_getter, config)
        return "qwen2"

    if model_type == "llama":
        from .llama_backend import install_llama_steering

        install_llama_steering(model, runtime_getter, config)
        return "llama"

    raise ValueError(
        f"Unsupported model_type={model_type!r} for steering. Supported: 'llama' (CodeLlama/LLaMA), 'qwen2' (Qwen2.5)."
    )

