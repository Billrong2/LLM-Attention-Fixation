from __future__ import annotations

import argparse
import copy
import os
import re
import shutil
import sys
import time
from pathlib import Path
from typing import Dict, List, Optional, Sequence, Tuple

import torch

# Local eyetracking runtime imports.
PROJECT_ROOT = Path(__file__).resolve().parents[1]
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

from models import ModelRunner
from paths import model_dir_name, resolve_artifact_path, resolve_obf_result_root
from steering import SteeringConfig
from util import utity


def _canonicalize_model_output(text: str) -> tuple[str, bool]:
    if not text:
        return "", False
    stripped = text.strip()
    fence_pattern = re.compile(r"```(\w+)?\s*\n?(.*?)\n?```", re.DOTALL)
    matches = list(fence_pattern.finditer(stripped))
    for m in reversed(matches):
        candidate = (m.group(2) or "").strip()
        if not candidate:
            continue
        lowered = candidate.lower()
        if "<your answer>" in lowered:
            continue
        if lowered.startswith("class ") or lowered.startswith("import "):
            continue
        return candidate, True
    if matches:
        tail = stripped[matches[-1].end():].strip()
        if tail:
            return tail, True
    return stripped, bool(stripped)


def _parse_gpu_ids(raw: Optional[str]) -> Optional[List[int]]:
    if not raw:
        return None
    parts = re.split(r"[+,]", raw.strip())
    out: List[int] = []
    for p in parts:
        p = p.strip()
        if not p:
            continue
        if not p.isdigit():
            raise ValueError(f"Invalid GPU id '{p}' in --gpu-ids={raw!r}.")
        out.append(int(p))
    return out or None


def _parse_techniques(raw: Optional[str]) -> Optional[set[str]]:
    if not raw:
        return None
    vals = {x.strip() for x in raw.split(",") if x.strip()}
    return vals or None


def _resolve_obf_variant_root(base_dir: Path, dataset: str) -> Path:
    ds = dataset.strip().lower()
    if ds == "eyetracking":
        candidates = [
            base_dir / "obfuscation" / "source" / "eyetracking" / "java",
            base_dir / "obfuscation" / "source" / "java",  # legacy layout
        ]
    elif ds == "humaneval":
        candidates = [
            base_dir / "obfuscation" / "source" / "humaneval" / "java",
            base_dir / "obfuscation" / "source" / "humaneval-x" / "java",
        ]
    else:
        raise ValueError(f"Unsupported dataset '{dataset}'. Use 'eyetracking' or 'humaneval'.")

    for c in candidates:
        if c.is_dir():
            return c
    return candidates[0]


def _assign_config_fields(target: SteeringConfig, source: SteeringConfig) -> None:
    for key, value in vars(source).items():
        setattr(target, key, copy.deepcopy(value))


def _build_steering_config(args: argparse.Namespace) -> Optional[SteeringConfig]:
    enabled = [
        idx
        for idx, flag in enumerate(
            [args.level1, args.level2, args.level3, args.level4, args.level5], start=1
        )
        if flag
    ]
    if not enabled:
        return None

    head_mask_path = (
        resolve_artifact_path(PROJECT_ROOT, args.head_mask_path)
        if args.head_mask_path
        else None
    )
    return SteeringConfig(
        enabled_levels=enabled,
        prior=args.prior,
        n_bins=max(1, int(args.n_bins)),
        binning=args.binning,
        beta_bias=float(args.beta_bias),
        beta_post=float(args.beta_post),
        lambda_attn=float(args.lambda_attn),
        lambda_mlp=float(args.lambda_mlp),
        head_subset_mode=args.head_subset_mode,
        head_mask_path=head_mask_path,
        head_mask_apply_to=args.head_mask_apply_to,
        head_subset_topk_per_layer=max(1, int(args.head_subset_topk_per_layer)),
        head_subset_calib_runs=max(1, int(args.head_subset_calib_runs)),
        head_subset_calib_max_new_tokens=max(1, int(args.head_subset_calib_max_new_tokens)),
        head_subset_calib_first_decode_only=(args.head_subset_calib_first_decode_only == "on"),
    )


def _collect_variants(
    source_root: Path,
    *,
    snippet_filter: Optional[str],
    difficulty_filter: Optional[str],
    techniques_filter: Optional[set[str]],
) -> List[Tuple[str, str, str, Path]]:
    variants: List[Tuple[str, str, str, Path]] = []
    if not source_root.is_dir():
        raise FileNotFoundError(f"Obfuscation source root missing: {source_root}")
    for snippet_dir in sorted(p for p in source_root.iterdir() if p.is_dir()):
        snippet = snippet_dir.name
        if snippet_filter and snippet != snippet_filter:
            continue
        for technique_dir in sorted(p for p in snippet_dir.iterdir() if p.is_dir()):
            technique = technique_dir.name
            if techniques_filter and technique not in techniques_filter:
                continue
            for difficulty_dir in sorted(p for p in technique_dir.iterdir() if p.is_dir()):
                difficulty = difficulty_dir.name
                if difficulty_filter and difficulty != difficulty_filter:
                    continue
                java_files = sorted(
                    p for p in difficulty_dir.glob("*.java")
                    if p.is_file() and not p.name.endswith(".meta.json")
                )
                for variant in java_files:
                    variants.append((snippet, technique, difficulty, variant))
    return variants


def parse_args() -> argparse.Namespace:
    ap = argparse.ArgumentParser(description="Output prediction runner on obfuscated Java variants.")
    ap.add_argument(
        "--dataset",
        choices=["eyetracking", "humaneval"],
        default="eyetracking",
        help="Dataset selector: eyetracking -> obfuscation/source/(eyetracking/)java, humaneval -> obfuscation/source/humaneval(-x)/java.",
    )
    ap.add_argument("--code-snippet", type=str, default=None, help="Single snippet folder name to run.")
    ap.add_argument("--difficulty", choices=["easy", "med", "hard"], default=None)
    ap.add_argument("--techniques", type=str, default=None, help="Comma-separated technique folder names.")
    ap.add_argument("--runs-per-snippet", type=int, default=20)
    ap.add_argument(
        "--max-new-tokens",
        type=int,
        default=1024,
        help="Maximum number of generated tokens per run (default: 1024).",
    )
    ap.add_argument("--gpu-ids", type=str, default=None, help="GPU IDs like 0,1 or 0+1+2+3")
    ap.add_argument("--model-name", type=str, default=None, help="HF model name override.")
    ap.add_argument("--cache-dir", type=str, default=None, help="HF cache directory override.")
    ap.add_argument("--record-layers", choices=["on", "off"], default="on")
    ap.add_argument("--record-bdv", choices=["on", "off"], default=None, help=argparse.SUPPRESS)
    ap.add_argument("--record-bdv-buckets", type=str, default=None, help=argparse.SUPPRESS)
    ap.add_argument("--run-tag", type=str, default=None)
    ap.add_argument("--auto-run-tag", action="store_true")
    ap.add_argument("--gpus", type=int, default=None, help="Max number of visible GPUs to use.")
    ap.add_argument("--level1", action="store_true")
    ap.add_argument("--level2", action="store_true")
    ap.add_argument("--level3", action="store_true")
    ap.add_argument("--level4", action="store_true")
    ap.add_argument("--level5", action="store_true")
    ap.add_argument(
        "--prior",
        choices=["human", "ast", "lex", "rand", "uniform", "cfg", "slice"],
        default="human",
    )
    ap.add_argument("--n-bins", type=int, default=12)
    ap.add_argument("--binning", choices=["equal_count"], default="equal_count")
    ap.add_argument("--beta-bias", type=float, default=0.0)
    ap.add_argument("--beta-post", type=float, default=0.0)
    ap.add_argument("--lambda-attn", type=float, default=1.0)
    ap.add_argument("--lambda-mlp", type=float, default=1.0)
    ap.add_argument(
        "--head-subset-mode",
        choices=["none", "file", "auto"],
        default="none",
    )
    ap.add_argument("--head-mask-path", type=str, default=None)
    ap.add_argument(
        "--head-mask-apply-to",
        choices=["l1", "l2", "both"],
        default="both",
    )
    ap.add_argument("--head-subset-topk-per-layer", type=int, default=4)
    ap.add_argument("--head-subset-calib-runs", type=int, default=12)
    ap.add_argument("--head-subset-calib-max-new-tokens", type=int, default=64)
    ap.add_argument(
        "--head-subset-calib-first-decode-only",
        choices=["on", "off"],
        default="on",
    )
    ap.add_argument(
        "--steer-last-n-layers",
        type=int,
        default=None,
        help="Override L1/L2 steering layer band to the last N transformer layers.",
    )
    return ap.parse_args()


def main() -> None:
    args = parse_args()
    if args.record_bdv is not None:
        print("[WARN] --record-bdv is deprecated and ignored. Use --record-layers on/off only.")
    if args.record_bdv_buckets is not None:
        print("[WARN] --record-bdv-buckets is deprecated and ignored. Buckets b1+b3 are emitted automatically when --record-layers=on.")

    gpu_ids = _parse_gpu_ids(args.gpu_ids)
    if gpu_ids is not None:
        os.environ["CUDA_VISIBLE_DEVICES"] = ",".join(str(i) for i in gpu_ids)
    visible_gpus = torch.cuda.device_count() if torch.cuda.is_available() else 0
    max_devices = None
    if gpu_ids is not None and visible_gpus > 0:
        max_devices = min(len(gpu_ids), visible_gpus)
    elif args.gpus is not None and visible_gpus > 0:
        max_devices = min(max(1, int(args.gpus)), visible_gpus)

    base_dir = Path(__file__).resolve().parents[1]
    source_root = _resolve_obf_variant_root(base_dir, args.dataset)
    techniques_filter = _parse_techniques(args.techniques)
    variants = _collect_variants(
        source_root,
        snippet_filter=args.code_snippet.strip() if args.code_snippet else None,
        difficulty_filter=args.difficulty,
        techniques_filter=techniques_filter,
    )
    if not variants:
        raise RuntimeError(
            f"No obfuscated variants matched the requested filters under dataset='{args.dataset}' root: {source_root}"
        )

    run_tag = args.run_tag.strip() if args.run_tag else None
    if not run_tag and args.auto_run_tag:
        run_tag = f"{time.strftime('%Y%m%d-%H%M%S')}-{args.dataset}-pid{os.getpid()}"
    if run_tag:
        run_tag = re.sub(r"[^A-Za-z0-9_.-]+", "_", run_tag)
    else:
        run_tag = "default"

    instruction = (
        "You will analyze the Java program provided below. "
        "First, explain how you will predict the output for the code snippet. "
        "Then, simulate it as a compiler would and print the exact console output. \n"
    )

    llama = ModelRunner()
    base_steering_config = _build_steering_config(args)
    active_steering_config: Optional[SteeringConfig] = None
    if base_steering_config is not None:
        active_steering_config = copy.deepcopy(base_steering_config)
        llama.set_steering_config(active_steering_config)
    llama.login_hf()
    llama.config(
        key_scope="prompt",
        max_devices=max_devices,
        model_name=args.model_name,
        cache_dir=args.cache_dir,
    )
    llama.build()
    if base_steering_config and args.steer_last_n_layers is not None:
        n = max(1, int(args.steer_last_n_layers))
        num_layers = getattr(getattr(llama.model, "config", None), "num_hidden_layers", None)
        if not isinstance(num_layers, int) or num_layers <= 0:
            layers_obj = getattr(getattr(llama.model, "model", None), "layers", None)
            num_layers = len(layers_obj) if layers_obj is not None else None
        if isinstance(num_layers, int) and num_layers > 0:
            start = max(0, num_layers - min(n, num_layers))
            end = max(0, num_layers - 1)
            base_steering_config.steer_layer_start = start
            base_steering_config.steer_layer_end = end
            if active_steering_config is not None:
                _assign_config_fields(active_steering_config, base_steering_config)
            print(
                f"[Steering] last-{n} layer override active: start={start}, end={end} (num_layers={num_layers})"
            )
        else:
            print(
                "[WARN] --steer-last-n-layers provided but failed to infer model layer count; "
                "using backend defaults."
            )

    model_label = model_dir_name(args.model_name or llama.model_name)
    output_root = resolve_obf_result_root(base_dir, model_label)
    output_root.mkdir(parents=True, exist_ok=True)

    runs_per_variant = max(1, int(args.runs_per_snippet))
    record_layers = args.record_layers == "on"

    try:
        for snippet, technique, difficulty, variant_path in variants:
            code = variant_path.read_text(encoding="utf-8")
            java_class_name = variant_path.stem
            if base_steering_config:
                current_cfg = copy.deepcopy(base_steering_config)
                if active_steering_config is None:
                    active_steering_config = current_cfg
                    llama.set_steering_config(active_steering_config)
                else:
                    _assign_config_fields(active_steering_config, current_cfg)
                if current_cfg.head_subset_mode == "auto":
                    calib_info = llama.calibrate_head_subset(
                        code_snippet=code,
                        instruction=instruction,
                        language="java",
                        vocab_tokens=[],
                        snippet_name=snippet,
                    )
                    print(
                        f"[{snippet}/{technique}/{difficulty}] Auto head subset ready: "
                        f"active_heads={int(calib_info.get('active_total', 0))}, "
                        f"layers_with_heads={int(calib_info.get('layers_with_heads', 0))}"
                    )
                    if calib_info.get("auto_save_path"):
                        print(
                            f"[{snippet}/{technique}/{difficulty}] Auto head subset mask: "
                            f"{calib_info['auto_save_path']}"
                        )
            try:
                actual_output = utity.run_java_program(code, java_class_name)
            except Exception as exc:
                raise RuntimeError(f"Failed to execute obfuscated variant {variant_path}: {exc}") from exc

            actual_output_str = actual_output if actual_output is not None else ""
            actual_output_clean = actual_output_str.strip()

            variant_root = output_root / snippet / technique / difficulty / run_tag
            variant_root.mkdir(parents=True, exist_ok=True)
            for outcome in ("EM", "Mismatch"):
                out_dir = variant_root / outcome
                if out_dir.exists():
                    for child in out_dir.iterdir():
                        if child.is_dir():
                            shutil.rmtree(child)
                        else:
                            child.unlink()
                out_dir.mkdir(exist_ok=True)

            run_idx = 1
            completed = 0
            while completed < runs_per_variant:
                result = llama.run_llama(
                    code,
                    instruction=instruction,
                    language="java",
                    max_new_tokens=max(1, int(args.max_new_tokens)),
                    record_layers=record_layers,
                    record_attention=record_layers,
                    vocab_tokens=[],
                )
                predicted_output_raw = result.get("generated_text", "")
                predicted_output, format_ok = _canonicalize_model_output(predicted_output_raw)
                if not format_ok and not (actual_output_clean == "" and predicted_output == ""):
                    print(f"[{snippet}/{technique}/{difficulty}] Missing answer section; retrying run {run_idx:03d}.")
                    continue

                is_exact_match = predicted_output == actual_output_clean
                run_dir = variant_root / ("EM" if is_exact_match else "Mismatch") / f"{run_idx}"
                run_dir.mkdir(parents=True, exist_ok=True)

                result["actual_output"] = actual_output_str
                result["predicted_output"] = predicted_output
                result["predicted_output_raw"] = predicted_output_raw
                result["exact_match"] = is_exact_match
                result["task"] = "output_prediction"
                result["obfuscation"] = {
                    "dataset": args.dataset,
                    "snippet": snippet,
                    "technique": technique,
                    "difficulty": difficulty,
                    "variant_file": variant_path.name,
                }

                if record_layers:
                    pair_id = f"{snippet}:{technique}:{difficulty}:{run_idx:03d}"
                    artifact_paths = llama.write_recording_superset(
                        result=result,
                        run_dir=run_dir,
                        schema_dir=variant_root,
                        code_snippet=code,
                        instruction=instruction,
                        target_text=actual_output_clean,
                        language="java",
                        pair_id=pair_id,
                        variant_type="obf",
                        is_correct=is_exact_match,
                    )
                    result.update(artifact_paths)
                    result["recording_complete"] = True
                    result.pop("full_decode_head_tensors", None)
                    required = [
                        artifact_paths.get("record_layers_full_path"),
                        artifact_paths.get("bdv_features_b1_path"),
                        artifact_paths.get("bdv_features_b3_path"),
                        artifact_paths.get("bdv_schema_path"),
                    ]
                    if any(not p or not Path(p).is_file() for p in required):
                        raise RuntimeError(
                            f"Recorder failure for {snippet}/{technique}/{difficulty} run {run_idx:03d}: missing required superset artifacts."
                        )
                else:
                    result["recording_complete"] = False
                    result.pop("full_decode_head_tensors", None)

                llama.save_dump(result, str(run_dir / "model_output.json"))
                if record_layers:
                    (run_dir / "actual_output.txt").write_text(actual_output_str + "\n", encoding="utf-8")
                    (run_dir / "predicted_output.txt").write_text(predicted_output + "\n", encoding="utf-8")
                    (run_dir / "predicted_output_raw.txt").write_text(predicted_output_raw + "\n", encoding="utf-8")
                status = "EM" if is_exact_match else "Mismatch"
                print(f"[{snippet}/{technique}/{difficulty}] {status} run {run_idx:03d} -> {run_dir}")
                run_idx += 1
                completed += 1
    finally:
        llama.free()


if __name__ == "__main__":
    main()
