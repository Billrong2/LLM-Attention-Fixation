#!/usr/bin/env python3
from __future__ import annotations

import argparse
import sys
from pathlib import Path

sys.path.append(str(Path(__file__).resolve().parents[2]))

from models import ModelRunner  # noqa: E402
from steering import SteeringConfig  # noqa: E402


DEFAULT_INSTRUCTION = (
    "Simulate the execution of the Java program provided below and reproduce exactly what would appear on "
    "standard output. Return only the raw console output characters, preserving line breaks and spacing. "
    "Do not add explanations, commentary, or formatting such as code fences or quotes. If the program prints "
    "nothing, respond with an empty string."
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Step-1 decode-only steering no-op invariants.")
    parser.add_argument("--snippet", type=Path, default=Path("Source/Ackerman.java"))
    parser.add_argument("--model-name", type=str, default="Qwen/Qwen2.5-Coder-7B-Instruct")
    parser.add_argument("--cache-dir", type=str, default=None)
    parser.add_argument("--gpu-ids", type=str, default=None, help="CUDA_VISIBLE_DEVICES override, e.g. '0' or '0,1'")
    parser.add_argument("--max-new-tokens", type=int, default=64)
    parser.add_argument("--gating-debug", action="store_true", help="Enable one-time gating decision print.")
    parser.add_argument("--mask-assert-debug", action="store_true", help="Enable masked-logits dominance asserts in hooks.")
    return parser.parse_args()


def _run_once(
    *,
    code: str,
    model_name: str,
    cache_dir: str | None,
    steering: SteeringConfig | None,
    max_new_tokens: int,
) -> dict:
    lm = ModelRunner()
    if steering is not None:
        lm.set_steering_config(steering)
    lm.config(
        model_name=model_name,
        cache_dir=cache_dir,
        max_new_tokens=max_new_tokens,
        temperature=0.0,
        top_p=1.0,
        top_k=0,
        key_scope="prompt",
    )
    lm.build()
    try:
        return lm.run_llama(
            code,
            instruction=DEFAULT_INSTRUCTION,
            language="java",
            do_sample=False,
            temperature=0.0,
            top_p=1.0,
            top_k=0,
            max_new_tokens=max_new_tokens,
            record_attention=False,
        )
    finally:
        lm.free()


def _assert_same(label: str, a: dict, b: dict) -> None:
    if a["token_ids_all"] != b["token_ids_all"]:
        raise AssertionError(f"{label} failed: token_ids_all differ.")


def main() -> None:
    args = parse_args()
    if args.gpu_ids:
        import os

        os.environ["CUDA_VISIBLE_DEVICES"] = args.gpu_ids

    code = args.snippet.read_text(encoding="utf-8")

    print("[1/5] Baseline run (legacy path: no steering config)...")
    baseline = _run_once(
        code=code,
        model_name=args.model_name,
        cache_dir=args.cache_dir,
        steering=None,
        max_new_tokens=args.max_new_tokens,
    )

    print("[2/5] Invariant A: split_prefill=OFF, enabled=OFF must equal baseline...")
    cfg_disabled_legacy = SteeringConfig(
        enabled_levels=[1],
        prior="ast",
        beta_bias=0.8,
        steering_enabled=False,
        decode_only=True,
        only_first_decode_step=True,
        split_prefill=False,
        gating_debug=args.gating_debug,
        debug_assert_mask=args.mask_assert_debug,
    )
    disabled_legacy = _run_once(
        code=code,
        model_name=args.model_name,
        cache_dir=args.cache_dir,
        steering=cfg_disabled_legacy,
        max_new_tokens=args.max_new_tokens,
    )
    _assert_same("Invariant A (legacy-disabled==baseline)", baseline, disabled_legacy)

    print("[3/5] Invariant D: split_prefill=ON, enabled=OFF must equal legacy baseline...")
    cfg_disabled_split = SteeringConfig(
        enabled_levels=[1],
        prior="ast",
        beta_bias=0.8,
        steering_enabled=False,
        decode_only=True,
        only_first_decode_step=True,
        split_prefill=True,
        gating_debug=args.gating_debug,
        debug_assert_mask=args.mask_assert_debug,
    )
    disabled_split = _run_once(
        code=code,
        model_name=args.model_name,
        cache_dir=args.cache_dir,
        steering=cfg_disabled_split,
        max_new_tokens=args.max_new_tokens,
    )
    _assert_same("Invariant D (split-prefill-disabled==legacy-baseline)", baseline, disabled_split)

    print("[4/5] Invariant B: beta=0 must equal baseline...")
    cfg_beta0 = SteeringConfig(
        enabled_levels=[1, 2],
        prior="ast",
        beta_bias=0.0,
        beta_post=0.0,
        steering_enabled=True,
        decode_only=True,
        only_first_decode_step=True,
        split_prefill=True,
        gating_debug=args.gating_debug,
        debug_assert_mask=args.mask_assert_debug,
    )
    beta0 = _run_once(
        code=code,
        model_name=args.model_name,
        cache_dir=args.cache_dir,
        steering=cfg_beta0,
        max_new_tokens=args.max_new_tokens,
    )
    _assert_same("Invariant B (beta=0==baseline)", baseline, beta0)

    print("[5/5] Invariant C: uniform prior must equal baseline...")
    cfg_uniform = SteeringConfig(
        enabled_levels=[1],
        prior="uniform",
        beta_bias=0.8,
        steering_enabled=True,
        decode_only=True,
        only_first_decode_step=True,
        split_prefill=True,
        gating_debug=args.gating_debug,
        debug_assert_mask=args.mask_assert_debug,
    )
    uniform = _run_once(
        code=code,
        model_name=args.model_name,
        cache_dir=args.cache_dir,
        steering=cfg_uniform,
        max_new_tokens=args.max_new_tokens,
    )
    _assert_same("Invariant C (uniform==baseline)", baseline, uniform)

    print("All invariants passed.")
    for label, result in [
        ("disabled_legacy", disabled_legacy),
        ("disabled_split", disabled_split),
        ("beta0", beta0),
        ("uniform", uniform),
    ]:
        dbg = result.get("steering_debug", {})
        print(
            f"  {label:8s} split_prefill={dbg.get('split_prefill_used')} "
            f"steer_calls={dbg.get('steer_calls')} blocked_prefill={dbg.get('blocked_prefill_calls')} "
            f"blocked_q={dbg.get('blocked_q_len')} blocked_kv={dbg.get('blocked_kv_len')} "
            f"blocked_layer={dbg.get('blocked_layer')} blocked_disabled={dbg.get('blocked_disabled')}"
        )


if __name__ == "__main__":
    main()
