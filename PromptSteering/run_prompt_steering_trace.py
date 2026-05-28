#!/usr/bin/env python3
from __future__ import annotations

import argparse
import importlib.util
import json
import os
import shutil
import sys
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import torch

from prompt_steering_common import (
    DEFAULT_MODEL_NAME,
    DEFAULT_OUTPUT_ROOT,
    DEFAULT_PROJECT_ROOT,
    PROMPT_STEERING_CHOICES,
    add_project_root,
    clean_run_tag,
    collect_obfuscated_sources,
    collect_original_sources,
    configure_java_classpath,
    configure_java_home,
    parse_csv_list,
    parse_gpu_ids,
    resolve_path,
    steer_instruction,
    write_json,
)


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Prompt-only steering baseline for Java execution-trace prediction."
    )
    parser.add_argument("--project-root", type=Path, default=DEFAULT_PROJECT_ROOT)
    parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT_ROOT)
    parser.add_argument("--dataset", choices=["humaneval", "cruxeval"], required=True)
    parser.add_argument("--source-kind", choices=["original", "obfuscated"], default="original")
    parser.add_argument("--source-root", type=Path, default=None)
    parser.add_argument("--prompt-steering", choices=PROMPT_STEERING_CHOICES, required=True)
    parser.add_argument("--snippet", default=None)
    parser.add_argument("--snippets", default=None)
    parser.add_argument("--techniques", default=None)
    parser.add_argument("--tiers", default=None)
    parser.add_argument("--case-ids", default="first", help="'first', 'all', or comma-separated case ids.")
    parser.add_argument("--runs-per-case", type=int, default=1)
    parser.add_argument("--prompt-style", default="json_array_loop_semantics")
    parser.add_argument("--max-new-tokens", type=int, default=256)
    parser.add_argument("--model-name", default=DEFAULT_MODEL_NAME)
    parser.add_argument("--cache-dir", default=None)
    parser.add_argument("--java-home", default=None)
    parser.add_argument("--offline", choices=["on", "off"], default="on")
    parser.add_argument("--hf-login", choices=["on", "off"], default="off")
    parser.add_argument("--gpu-ids", default=None)
    parser.add_argument("--gpus", type=int, default=None)
    parser.add_argument("--record-layers", choices=["on", "off"], default="off")
    parser.add_argument("--cf-min-cases", type=int, default=8)
    parser.add_argument("--cf-target-cases", type=int, default=16)
    parser.add_argument("--cf-cache-dir", type=Path, default=None)
    parser.add_argument("--cf-rebuild", choices=["on", "off"], default="off")
    parser.add_argument("--run-tag", default=None)
    parser.add_argument(
        "--resume",
        choices=["on", "off"],
        default="off",
        help="When on, keep completed run_* directories and only add missing runs.",
    )
    parser.add_argument("--dry-run", action="store_true")
    return parser.parse_args()


def _configure_cuda(args: argparse.Namespace) -> Optional[int]:
    gpu_ids = parse_gpu_ids(args.gpu_ids)
    if gpu_ids is not None:
        os.environ["CUDA_VISIBLE_DEVICES"] = ",".join(str(x) for x in gpu_ids)
    visible = torch.cuda.device_count() if torch.cuda.is_available() else 0
    if gpu_ids is not None and visible > 0:
        return min(len(gpu_ids), visible)
    if args.gpus is not None and visible > 0:
        return min(max(1, int(args.gpus)), visible)
    return None


def _load_project_module(project_root: Path, rel_path: str, module_name: str) -> Any:
    path = project_root / rel_path
    spec = importlib.util.spec_from_file_location(module_name, path)
    if spec is None or spec.loader is None:
        raise ImportError(f"Failed to load {rel_path} from {project_root}")
    mod = importlib.util.module_from_spec(spec)
    sys.modules[module_name] = mod
    spec.loader.exec_module(mod)
    return mod


def _source_items(args: argparse.Namespace) -> List[Tuple[str, str, str, Path]]:
    snippets = parse_csv_list(args.snippets)
    if args.snippet:
        snippets.append(args.snippet.strip())
    snippets = sorted(set(snippets))
    if args.source_kind == "original":
        return [
            (snippet, "original", "original", path)
            for snippet, path in collect_original_sources(
                project_root=args.project_root,
                dataset=args.dataset,
                snippets=snippets,
            )
        ]
    if args.source_root is None:
        raise ValueError("--source-root is required for obfuscated trace runs.")
    source_root = resolve_path(args.source_root, project_root=args.project_root, must_exist=True)
    return collect_obfuscated_sources(
        source_root,
        snippets=snippets,
        techniques=parse_csv_list(args.techniques),
        tiers=parse_csv_list(args.tiers),
        allow_empty=bool(snippets),
    )


def _number_source(java_code: str) -> str:
    return "\n".join(f"L{i:03d} {line}" for i, line in enumerate(java_code.splitlines(), start=1))


def _trace_with_prompt_lines(trace: Dict[str, Any]) -> Dict[str, Any]:
    out = dict(trace)
    events = []
    for event in trace.get("events", []) or []:
        e = dict(event)
        if "prompt_line" not in e and isinstance(e.get("line"), int) and int(e["line"]) > 0:
            e["prompt_line"] = int(e["line"])
        events.append(e)
    out["events"] = events
    return out


def _select_case_ids(case_pack: Dict[str, Any], raw: str) -> List[str]:
    cases = [str(c["case_id"]) for c in case_pack.get("cases", [])]
    if raw == "all":
        return cases
    if raw == "first":
        return cases[:1]
    wanted = parse_csv_list(raw)
    missing = sorted(set(wanted) - set(cases))
    if missing:
        raise ValueError(f"Requested case ids not in pack: {missing}")
    return wanted


def _target_paths(
    *,
    args: argparse.Namespace,
    model_label: str,
    snippet: str,
    technique: str,
    tier: str,
    case_id: str,
    run_tag: str,
    variant_name: str,
) -> Path:
    base = args.output_root.resolve() / "trace_prediction" / model_label / args.dataset
    mode = args.prompt_steering
    if args.source_kind == "original":
        return base / "original" / snippet / "prompt-steering" / mode / run_tag / case_id
    return base / "obfuscated" / snippet / technique / tier / "prompt-steering" / mode / run_tag / variant_name / case_id


def _completed_run_dirs(root: Path) -> List[Path]:
    if not root.exists():
        return []
    return sorted(
        [
            child
            for child in root.glob("run_*")
            if child.is_dir() and (child / "model_output.json").is_file()
        ],
        key=lambda p: p.name,
    )


def _next_run_index(root: Path) -> int:
    used = set()
    if root.exists():
        for child in root.glob("run_*"):
            if child.is_dir():
                try:
                    used.add(int(child.name.split("_", 1)[1]))
                except Exception:
                    continue
    idx = 1
    while idx in used:
        idx += 1
    return idx


def _build_target(
    *,
    args: argparse.Namespace,
    target_dir: Path,
    trace_result: Dict[str, Any],
    numbered_source: str,
    load_trace_prediction_target_from_entry,
) -> Any:
    prompt_source_path = target_dir / "prompt_source_numbered.txt"
    trace_path = target_dir / "oracle_trace.json"
    prompt_source_path.parent.mkdir(parents=True, exist_ok=True)
    prompt_source_path.write_text(numbered_source, encoding="utf-8")
    write_json(trace_path, _trace_with_prompt_lines(trace_result))
    entry = {
        "dataset": args.dataset,
        "snippet": trace_result.get("snippet", ""),
        "case_id": trace_result.get("case_id", ""),
        "case_expression": trace_result.get("case_expression", ""),
        "prompt_source_path": str(prompt_source_path),
        "trace_path": str(trace_path),
    }
    return load_trace_prediction_target_from_entry(entry)


def _original_gold_lines_for_case(
    *,
    args: argparse.Namespace,
    snippet: str,
    case_id: str,
    cf_cache_dir: Path,
    trace_java_case,
) -> Tuple[Optional[List[int]], str]:
    try:
        originals = collect_original_sources(
            project_root=args.project_root,
            dataset=args.dataset,
            snippets=[snippet],
        )
        _, source_path = originals[0]
        source = source_path.read_text(encoding="utf-8")
        trace_result = trace_java_case(
            project_root=args.project_root,
            dataset=args.dataset,
            snippet=snippet,
            java_code=source,
            class_name=source_path.stem,
            case_id=case_id,
            cache_dir=cf_cache_dir,
            rebuild_case_pack=args.cf_rebuild == "on",
            min_cases=args.cf_min_cases,
            target_cases=args.cf_target_cases,
            variant="original",
            variant_path=None,
        )
        if trace_result.get("trace_status") != "ok":
            return None, f"original_trace_status:{trace_result.get('trace_status')}"
        return [int(x) for x in trace_result.get("executed_line_sequence", [])], ""
    except Exception as exc:
        return None, f"{type(exc).__name__}:{exc}"


def main() -> None:
    args = parse_args()
    args.project_root = args.project_root.resolve()
    args.output_root = args.output_root.resolve()
    java_home = configure_java_home(args.java_home)
    java_compat_jar = configure_java_classpath(java_home)
    add_project_root(args.project_root)
    if args.offline == "on":
        os.environ["HF_HUB_OFFLINE"] = "1"
        os.environ["TRANSFORMERS_OFFLINE"] = "1"

    from counterfactual_eval import build_case_pack
    from models import ModelRunner
    from paths import model_dir_name

    java_trace_mod = _load_project_module(
        args.project_root,
        "evaluation/java_execution_trace.py",
        "_prompt_steering_java_execution_trace",
    )
    trace_pred_mod = _load_project_module(
        args.project_root,
        "evaluation/trace_prediction.py",
        "_prompt_steering_trace_prediction",
    )
    trace_java_case = java_trace_mod.trace_java_case
    build_trace_prediction_instruction = trace_pred_mod.build_trace_prediction_instruction
    evaluate_trace_prediction = trace_pred_mod.evaluate_trace_prediction
    load_trace_prediction_target_from_entry = trace_pred_mod.load_trace_prediction_target_from_entry
    parse_predicted_line_sequence_with_meta = trace_pred_mod.parse_predicted_line_sequence_with_meta

    cf_cache_dir = (
        args.cf_cache_dir.resolve()
        if args.cf_cache_dir is not None and args.cf_cache_dir.is_absolute()
        else (args.output_root / "casepacks" if args.cf_cache_dir is None else args.output_root / args.cf_cache_dir)
    )
    items = _source_items(args)
    run_tag = clean_run_tag(
        args.run_tag,
        dataset=args.dataset,
        source_kind=args.source_kind,
        mode=args.prompt_steering,
    )
    model_label = model_dir_name(args.model_name)

    planned = []
    for snippet, technique, tier, path in items:
        code = path.read_text(encoding="utf-8")
        case_pack = build_case_pack(
            java_code=code,
            class_name=path.stem,
            dataset=args.dataset,
            snippet=snippet,
            min_cases=args.cf_min_cases,
            target_cases=args.cf_target_cases,
            cache_dir=cf_cache_dir,
            rebuild=args.cf_rebuild == "on",
        )
        for case_id in _select_case_ids(case_pack, args.case_ids):
            planned.append((snippet, technique, tier, path, case_id))

    print(f"[dry-run={args.dry_run}] dataset={args.dataset} source_kind={args.source_kind} mode={args.prompt_steering}")
    print(f"[trace targets] {len(planned)} case targets")
    print(f"[output] {args.output_root}")
    if java_home is not None:
        print(f"[java] JAVA_HOME={java_home}")
    print(f"[java] OBF_JAVA_CLASSPATH includes {java_compat_jar}")
    if args.dry_run:
        for item in planned[:20]:
            print("  ", item)
        if len(planned) > 20:
            print(f"  ... {len(planned) - 20} more")
        return

    if args.resume == "on":
        target_runs = max(1, args.runs_per_case)
        pending = []
        for snippet, technique, tier, path, case_id in planned:
            target_dir = _target_paths(
                args=args,
                model_label=model_label,
                snippet=snippet,
                technique=technique,
                tier=tier,
                case_id=case_id,
                run_tag=run_tag,
                variant_name=path.stem,
            )
            existing_runs = _completed_run_dirs(target_dir)
            if len(existing_runs) >= target_runs:
                print(f"[skip] {snippet}/{case_id} already has {len(existing_runs)}/{target_runs} runs")
                continue
            pending.append((snippet, technique, tier, path, case_id))
        planned = pending
        if not planned:
            print("[done] all requested trace targets already complete")
            return

    max_devices = _configure_cuda(args)
    llama = ModelRunner()
    if args.hf_login == "on":
        llama.login_hf()
    llama.config(
        key_scope="prompt",
        max_devices=max_devices,
        model_name=args.model_name,
        cache_dir=args.cache_dir,
    )
    llama.build()
    record_layers = args.record_layers == "on"
    try:
        for snippet, technique, tier, path, case_id in planned:
            code = path.read_text(encoding="utf-8")
            target_dir = _target_paths(
                args=args,
                model_label=model_label,
                snippet=snippet,
                technique=technique,
                tier=tier,
                case_id=case_id,
                run_tag=run_tag,
                variant_name=path.stem,
            )
            try:
                trace_result = trace_java_case(
                    project_root=args.project_root,
                    dataset=args.dataset,
                    snippet=snippet,
                    java_code=code,
                    class_name=path.stem,
                    case_id=case_id,
                    cache_dir=cf_cache_dir,
                    rebuild_case_pack=args.cf_rebuild == "on",
                    min_cases=args.cf_min_cases,
                    target_cases=args.cf_target_cases,
                    variant=("original" if args.source_kind == "original" else "obfuscated"),
                    variant_path=(None if args.source_kind == "original" else path),
                )
            except Exception as exc:
                target_dir.mkdir(parents=True, exist_ok=True)
                write_json(
                    target_dir / "trace_build_error.json",
                    {
                        "dataset": args.dataset,
                        "source_kind": args.source_kind,
                        "snippet": snippet,
                        "case_id": case_id,
                        "prompt_steering": args.prompt_steering,
                        "error_type": type(exc).__name__,
                        "error": str(exc),
                    },
                )
                print(
                    f"[skip] {snippet}/{case_id} trace_status=trace_build_error "
                    f"error={type(exc).__name__}:{exc}"
                )
                continue
            if trace_result.get("trace_status") != "ok":
                print(f"[skip] {snippet}/{case_id} trace_status={trace_result.get('trace_status')}")
                continue
            target_runs = max(1, args.runs_per_case)
            existing_runs = _completed_run_dirs(target_dir) if args.resume == "on" else []
            if existing_runs and len(existing_runs) >= target_runs:
                print(f"[skip] {snippet}/{case_id} already has {len(existing_runs)}/{target_runs} runs")
                continue
            if target_dir.exists():
                if args.resume == "off":
                    for child in target_dir.glob("run_*"):
                        if child.is_dir():
                            shutil.rmtree(child)
            try:
                target = _build_target(
                    args=args,
                    target_dir=target_dir,
                    trace_result=trace_result,
                    numbered_source=_number_source(code),
                    load_trace_prediction_target_from_entry=load_trace_prediction_target_from_entry,
                )
            except Exception as exc:
                target_dir.mkdir(parents=True, exist_ok=True)
                write_json(
                    target_dir / "trace_target_error.json",
                    {
                        "dataset": args.dataset,
                        "source_kind": args.source_kind,
                        "snippet": snippet,
                        "case_id": case_id,
                        "prompt_steering": args.prompt_steering,
                        "error_type": type(exc).__name__,
                        "error": str(exc),
                    },
                )
                print(
                    f"[skip] {snippet}/{case_id} trace_target_status=unsupported "
                    f"error={type(exc).__name__}:{exc}"
                )
                continue
            original_gold_lines: Optional[List[int]] = None
            original_gold_error = ""
            if args.source_kind == "obfuscated":
                original_gold_lines, original_gold_error = _original_gold_lines_for_case(
                    args=args,
                    snippet=snippet,
                    case_id=case_id,
                    cf_cache_dir=cf_cache_dir,
                    trace_java_case=trace_java_case,
                )
            instruction = build_trace_prediction_instruction(target, prompt_style=args.prompt_style)
            instruction = steer_instruction(instruction, args.prompt_steering, task="trace_prediction")
            completed = len(existing_runs)
            while completed < target_runs:
                run_idx = _next_run_index(target_dir) if args.resume == "on" else completed + 1
                result = llama.run_llama(
                    target.prompt_source,
                    instruction=instruction,
                    language="java",
                    max_new_tokens=max(1, args.max_new_tokens),
                    record_layers=record_layers,
                    record_attention=record_layers,
                    vocab_tokens=[],
                )
                raw = str(result.get("generated_completion") or result.get("generated_text", ""))
                parsed = parse_predicted_line_sequence_with_meta(raw)
                metrics = evaluate_trace_prediction(
                    predicted=parsed.parsed_lines,
                    gold=target.gold_prompt_lines,
                )
                exact_match_to_original_gold = (
                    parsed.parsed_lines == original_gold_lines
                    if original_gold_lines is not None
                    else None
                )
                run_dir = target_dir / f"run_{run_idx:04d}"
                run_dir.mkdir(parents=True, exist_ok=True)
                result["task"] = "trace_prediction"
                result["dataset"] = args.dataset
                result["source_kind"] = args.source_kind
                result["mode"] = "prompt-steering"
                result["prompt_steering"] = {
                    "enabled": args.prompt_steering != "none",
                    "mode": args.prompt_steering,
                    "mechanism": "natural_language_instruction_only",
                }
                result["trace_prediction"] = {
                    "snippet": snippet,
                    "case_id": case_id,
                    "prompt_style": args.prompt_style,
                    "gold_lines": target.gold_prompt_lines,
                    "predicted_lines": parsed.parsed_lines,
                    "parse_mode": parsed.parse_mode,
                    "parse_valid": parsed.parse_valid,
                    "failure_reason": parsed.failure_reason,
                    "metrics": metrics,
                    "original_gold_lines": original_gold_lines,
                    "original_gold_error": original_gold_error,
                    "exact_match_to_original_gold": exact_match_to_original_gold,
                }
                if args.source_kind == "obfuscated":
                    result["obfuscation"] = {
                        "snippet": snippet,
                        "technique": technique,
                        "tier": tier,
                        "variant_file": path.name,
                        "variant_path": str(path),
                    }
                if record_layers:
                    artifact_paths = llama.write_recording_superset(
                        result=result,
                        run_dir=run_dir,
                        schema_dir=target_dir,
                        code_snippet=target.prompt_source,
                        instruction=instruction,
                        target_text=" ".join(str(x) for x in target.gold_prompt_lines),
                        language="java",
                        pair_id=f"{snippet}:{case_id}:{run_idx:03d}",
                        variant_type=f"trace-prompt-{args.prompt_steering}",
                        is_correct=bool(metrics.get("exact_match", False)),
                    )
                    result.update(artifact_paths)
                    result["recording_complete"] = True
                    result.pop("full_decode_head_tensors", None)
                else:
                    result["recording_complete"] = False
                    result.pop("full_decode_head_tensors", None)
                llama.save_dump(result, str(run_dir / "model_output.json"))
                write_json(
                    run_dir / "score.json",
                    {
                        "dataset": args.dataset,
                        "source_kind": args.source_kind,
                        "snippet": snippet,
                        "case_id": case_id,
                        "prompt_steering": args.prompt_steering,
                        "prompt_style": args.prompt_style,
                        "parse_mode": parsed.parse_mode,
                        "parse_valid": parsed.parse_valid,
                        "failure_reason": parsed.failure_reason,
                        "gold_lines": target.gold_prompt_lines,
                        "predicted_lines": parsed.parsed_lines,
                        "ordered_f1": float(metrics["ordered_f1"]),
                        "ordered_precision": float(metrics["ordered_precision"]),
                        "ordered_recall": float(metrics["ordered_recall"]),
                        "exact_match": bool(metrics["exact_match"]),
                        "exact_match_to_original_gold": exact_match_to_original_gold,
                        "original_gold_available": original_gold_lines is not None,
                        "original_gold_error": original_gold_error,
                        "gold_length": int(metrics["gold_length"]),
                        "predicted_length": int(metrics["predicted_length"]),
                    },
                )
                (run_dir / "predicted_trace.txt").write_text(
                    " ".join(str(x) for x in parsed.parsed_lines) + "\n",
                    encoding="utf-8",
                )
                completed += 1
                print(f"[done] {snippet}/{case_id} run {completed}/{target_runs}")
    finally:
        llama.free()


if __name__ == "__main__":
    main()
