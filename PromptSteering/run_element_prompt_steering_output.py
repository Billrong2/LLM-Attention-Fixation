#!/usr/bin/env python3
from __future__ import annotations

import argparse
import hashlib
import json
import os
import random
import shutil
from pathlib import Path
from typing import Any, Dict, List, Optional, Tuple

import torch

THIS_DIR = Path(__file__).resolve().parent

from element_prompting import build_artifact_conditioned_instruction
from prompt_steering_common import (
    DEFAULT_MODEL_NAME,
    DEFAULT_PROJECT_ROOT,
    PROMPT_STEERING_CHOICES,
    add_project_root,
    canonicalize_model_output,
    clean_run_tag,
    collect_obfuscated_sources,
    collect_original_sources,
    configure_java_classpath,
    configure_java_home,
    parse_csv_list,
    parse_gpu_ids,
    resolve_path,
    stdout_instruction,
    write_json,
)


DEFAULT_OUTPUT_ROOT = THIS_DIR / "artifacts"


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Artifact-conditioned prompt-only steering baseline for Java output prediction."
    )
    parser.add_argument("--project-root", type=Path, default=DEFAULT_PROJECT_ROOT)
    parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT_ROOT)
    parser.add_argument("--dataset", choices=["eyetracking", "humaneval", "cruxeval"], required=True)
    parser.add_argument("--source-kind", choices=["original", "obfuscated"], default="original")
    parser.add_argument(
        "--source-root",
        type=Path,
        default=None,
        help="Prepared obfuscated corpus root for --source-kind obfuscated.",
    )
    parser.add_argument("--prompt-steering", choices=PROMPT_STEERING_CHOICES, required=True)
    parser.add_argument("--snippet", default=None, help="Single snippet name without .java.")
    parser.add_argument("--snippets", default=None, help="Comma-separated snippet names without .java.")
    parser.add_argument("--techniques", default=None, help="Comma-separated obfuscation technique folders.")
    parser.add_argument("--tiers", default=None, help="Comma-separated obfuscation tiers, such as easy,med,hard.")
    parser.add_argument("--runs-per-snippet", type=int, default=3)
    parser.add_argument("--max-new-tokens", type=int, default=512)
    parser.add_argument("--temperature", type=float, default=0.9)
    parser.add_argument("--top-p", type=float, default=0.95)
    parser.add_argument("--base-seed", type=int, default=20260527)
    parser.add_argument("--max-structural-elements", type=int, default=24)
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
    parser.add_argument("--cf-strict-json", choices=["on", "off"], default="on")
    parser.add_argument("--retry-incomplete-json", choices=["on", "off"], default="on")
    parser.add_argument("--max-attempt-multiplier", type=int, default=10)
    parser.add_argument("--run-tag", default=None)
    parser.add_argument(
        "--resume",
        choices=["on", "off"],
        default="off",
        help="When on, keep completed run_* directories and only add missing runs.",
    )
    parser.add_argument("--dry-run", action="store_true")
    return parser.parse_args()


def _set_generation_seed(seed: int) -> None:
    random.seed(seed)
    try:
        import numpy as np  # type: ignore

        np.random.seed(seed % (2**32 - 1))
    except Exception:
        pass
    torch.manual_seed(seed)
    if torch.cuda.is_available():
        torch.cuda.manual_seed_all(seed)


def _trial_seed(base_seed: int, *parts: Any) -> int:
    digest = hashlib.sha256()
    digest.update(str(base_seed).encode("utf-8"))
    for part in parts:
        digest.update(b"\x00")
        digest.update(str(part).encode("utf-8", errors="ignore"))
    return int(digest.hexdigest()[:8], 16)


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


def _source_items(args: argparse.Namespace) -> Tuple[str, List[Tuple[str, str, str, Path]]]:
    project_root = args.project_root.resolve()
    snippets = parse_csv_list(args.snippets)
    if args.snippet:
        snippets.append(args.snippet.strip())
    snippets = sorted(set(snippets))

    if args.source_kind == "original":
        items = [
            (snippet, "original", "original", path)
            for snippet, path in collect_original_sources(
                project_root=project_root,
                dataset=args.dataset,
                snippets=snippets,
            )
        ]
        return "original", items

    if args.source_root is None:
        raise ValueError("--source-root is required for --source-kind obfuscated.")
    source_root = resolve_path(args.source_root, project_root=project_root, must_exist=True)
    items = collect_obfuscated_sources(
        source_root,
        snippets=snippets,
        techniques=parse_csv_list(args.techniques),
        tiers=parse_csv_list(args.tiers),
        allow_empty=bool(snippets),
    )
    return "obfuscated", items


def _build_output_root(
    *,
    args: argparse.Namespace,
    model_label: str,
    snippet: str,
    technique: str,
    tier: str,
    run_tag: str,
) -> Path:
    base = args.output_root.resolve()
    mode = args.prompt_steering
    if args.source_kind == "original":
        return base / "attn_viz" / model_label / args.dataset / snippet / "prompt-steering" / mode / run_tag
    return (
        base
        / "obfuscation"
        / "result"
        / model_label
        / args.dataset
        / snippet
        / technique
        / tier
        / "prompt-steering"
        / mode
        / run_tag
    )


def _legacy_output_root(
    *,
    args: argparse.Namespace,
    model_label: str,
    snippet: str,
    technique: str,
    tier: str,
    run_tag: str,
) -> Path:
    base = args.output_root.resolve()
    mode = args.prompt_steering
    if args.source_kind == "original":
        return base / "attn_viz" / model_label / snippet / "prompt-steering" / mode / run_tag
    return (
        base
        / "obfuscation"
        / "result"
        / model_label
        / snippet
        / technique
        / tier
        / "prompt-steering"
        / mode
        / run_tag
    )


def _candidate_output_roots(
    *,
    args: argparse.Namespace,
    model_label: str,
    snippet: str,
    technique: str,
    tier: str,
    run_tag: str,
) -> List[Path]:
    canonical = _build_output_root(
        args=args,
        model_label=model_label,
        snippet=snippet,
        technique=technique,
        tier=tier,
        run_tag=run_tag,
    )
    legacy = _legacy_output_root(
        args=args,
        model_label=model_label,
        snippet=snippet,
        technique=technique,
        tier=tier,
        run_tag=run_tag,
    )
    return [canonical] if canonical == legacy else [canonical, legacy]


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


def _run_dir_index(path: Path) -> Optional[int]:
    if not path.name.startswith("run_"):
        return None
    try:
        return int(path.name.split("_", 1)[1])
    except Exception:
        return None


def _unique_run_dirs(run_dirs: List[Path]) -> List[Path]:
    unique: Dict[int, Path] = {}
    for run_dir in sorted(run_dirs, key=lambda p: (str(p.parent), p.name)):
        idx = _run_dir_index(run_dir)
        if idx is None:
            continue
        unique.setdefault(idx, run_dir)
    return [unique[idx] for idx in sorted(unique)]


def _completed_run_dirs_many(roots: List[Path]) -> List[Path]:
    out: List[Path] = []
    for root in roots:
        out.extend(_completed_run_dirs(root))
    return _unique_run_dirs(out)


def _same_resolved_path(left: str, right: Path) -> bool:
    if not left:
        return False
    try:
        return Path(left).resolve() == right.resolve()
    except Exception:
        return False


def _run_payload_matches_item(
    run_dir: Path,
    *,
    dataset: str,
    source_kind: str,
    prompt_mode: str,
    snippet: str,
    source_path: Path,
    technique: str,
    tier: str,
) -> bool:
    try:
        payload = json.loads((run_dir / "model_output.json").read_text(encoding="utf-8"))
    except Exception:
        return False

    payload_mode = str((payload.get("prompt_steering") or {}).get("mode", "none"))
    if payload_mode != prompt_mode:
        return False
    if str(payload.get("dataset", "")).lower() != dataset.lower():
        return False
    if str(payload.get("source_kind", "original")) != source_kind:
        return False
    if str(payload.get("snippet", "")) != snippet:
        return False

    if source_kind == "original":
        payload_source = str(payload.get("source_path", ""))
        return not payload_source or _same_resolved_path(payload_source, source_path)

    obf = payload.get("obfuscation", {}) or {}
    if _same_resolved_path(str(obf.get("variant_path", "")), source_path):
        return True
    if _same_resolved_path(str(payload.get("source_path", "")), source_path):
        return True
    return (
        str(obf.get("dataset", "")).lower() == dataset.lower()
        and str(obf.get("snippet", "")) == snippet
        and str(obf.get("technique", "")) == technique
        and str(obf.get("tier", "")) == tier
    )


def _completed_run_dirs_for_item(
    roots: List[Path],
    *,
    dataset: str,
    source_kind: str,
    prompt_mode: str,
    snippet: str,
    source_path: Path,
    technique: str,
    tier: str,
) -> List[Path]:
    out: List[Path] = []
    for root in roots:
        for run_dir in _completed_run_dirs(root):
            if _run_payload_matches_item(
                run_dir,
                dataset=dataset,
                source_kind=source_kind,
                prompt_mode=prompt_mode,
                snippet=snippet,
                source_path=source_path,
                technique=technique,
                tier=tier,
            ):
                out.append(run_dir)
    return _unique_run_dirs(out)


def _next_run_index(root: Path, extra_roots: List[Path] = ()) -> int:
    used = set()
    for scan_root in [root, *extra_roots]:
        if scan_root.exists():
            for child in scan_root.glob("run_*"):
                if not child.is_dir():
                    continue
                idx = _run_dir_index(child)
                if idx is not None:
                    used.add(idx)
    idx = 1
    while idx in used:
        idx += 1
    return idx


def _next_run_index_for_item(root: Path, existing_runs: List[Path]) -> int:
    used = {_run_dir_index(path) for path in existing_runs}
    used.discard(None)
    idx = 1
    while idx in used or (root / f"run_{idx:04d}").exists():
        idx += 1
    return idx


def _counterfactual_eval(
    *,
    result: Dict[str, Any],
    predicted_output_raw: str,
    case_pack: Dict[str, Any],
    case_ids: List[str],
    strict_json: bool,
    parse_predicted_labels,
    score_case_predictions,
) -> Tuple[bool, str, Dict[str, Any], bool]:
    predicted_map, parse_meta = parse_predicted_labels(
        predicted_output_raw,
        case_ids,
        strict_json=strict_json,
    )
    parse_mode = str(parse_meta.get("parse_mode", "none"))
    provided = int(parse_meta.get("provided_case_count", 0))
    requested = int(parse_meta.get("requested_case_count", len(case_ids)))
    complete = requested <= 0 or provided >= requested
    score = score_case_predictions(case_pack, predicted_map)
    parse_coverage = float(provided) / float(requested) if requested else 0.0
    strict_pass = bool(score["all_cases_pass"])
    if provided == 0:
        match_label = "parse_fail"
    elif strict_pass:
        match_label = "all_pass"
    else:
        match_label = "partial"

    result["counterfactual"] = {
        "profile": "counterfactual_tf",
        "case_total": int(score["case_total"]),
        "case_correct": int(score["case_correct"]),
        "case_accuracy": float(score["case_accuracy"]),
        "all_cases_pass": strict_pass,
        "strict_pass": strict_pass,
        "match_label": match_label,
        "parse_mode": parse_mode,
        "provided_case_count": provided,
        "requested_case_count": requested,
        "parse_coverage": parse_coverage,
        "parse_meta": parse_meta,
    }
    result["oracle_labels"] = score["oracle_labels"]
    result["predicted_labels"] = score["predicted_labels"]
    result["per_case_scores"] = score["per_case"]
    result["case_total"] = int(score["case_total"])
    result["case_correct"] = int(score["case_correct"])
    result["case_accuracy"] = float(score["case_accuracy"])
    result["all_cases_pass"] = strict_pass
    result["strict_pass"] = strict_pass
    result["match_label"] = match_label
    result["parse_mode"] = parse_mode
    result["provided_case_count"] = provided
    result["requested_case_count"] = requested
    result["parse_coverage"] = parse_coverage
    result["exact_match"] = strict_pass
    return strict_pass, json.dumps(score["predicted_labels"], sort_keys=True), score, complete


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

    from counterfactual_eval import (
        build_case_pack,
        build_counterfactual_instruction,
        parse_predicted_labels,
        resolve_task_profile,
        score_case_predictions,
    )
    from models import ModelRunner
    from paths import model_dir_name
    from util import utity

    source_kind, items = _source_items(args)
    run_tag = clean_run_tag(
        args.run_tag,
        dataset=args.dataset,
        source_kind=source_kind,
        mode=args.prompt_steering,
    )
    task_profile = resolve_task_profile(args.dataset, "auto")
    record_layers = args.record_layers == "on"
    cf_cache_dir = (
        args.cf_cache_dir.resolve()
        if args.cf_cache_dir is not None and args.cf_cache_dir.is_absolute()
        else (args.output_root / "casepacks" if args.cf_cache_dir is None else args.output_root / args.cf_cache_dir)
    )
    model_label = model_dir_name(args.model_name)

    print(f"[dry-run={args.dry_run}] dataset={args.dataset} source_kind={source_kind} mode={args.prompt_steering}")
    print(f"[items] {len(items)} source files")
    print(f"[output] {args.output_root}")
    if java_home is not None:
        print(f"[java] JAVA_HOME={java_home}")
    print(f"[java] OBF_JAVA_CLASSPATH includes {java_compat_jar}")
    if args.dry_run:
        for item in items[:20]:
            print("  ", item)
        if len(items) > 20:
            print(f"  ... {len(items) - 20} more")
        return

    if args.resume == "on":
        target_runs = max(1, args.runs_per_snippet)
        pending = []
        for snippet, technique, tier, path in items:
            item_roots = _candidate_output_roots(
                args=args,
                model_label=model_label,
                snippet=snippet,
                technique=technique,
                tier=tier,
                run_tag=run_tag,
            )
            existing_runs = _completed_run_dirs_for_item(
                item_roots,
                dataset=args.dataset,
                source_kind=source_kind,
                prompt_mode=args.prompt_steering,
                snippet=snippet,
                source_path=path,
                technique=technique,
                tier=tier,
            )
            if len(existing_runs) >= target_runs:
                print(f"[skip] {snippet}/{technique}/{tier} already has {len(existing_runs)}/{target_runs} runs")
                continue
            pending.append((snippet, technique, tier, path))
        items = pending
        if not items:
            print("[done] all requested output targets already complete")
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
    try:
        for snippet, technique, tier, path in items:
            code = path.read_text(encoding="utf-8")
            class_name = path.stem
            instruction = stdout_instruction()
            answer_prefix = ""
            case_pack: Optional[Dict[str, Any]] = None
            case_ids: List[str] = []
            if task_profile == "counterfactual_tf":
                case_pack = build_case_pack(
                    java_code=code,
                    class_name=class_name,
                    dataset=args.dataset,
                    snippet=snippet,
                    min_cases=args.cf_min_cases,
                    target_cases=args.cf_target_cases,
                    cache_dir=cf_cache_dir,
                    rebuild=args.cf_rebuild == "on",
                )
                instruction = build_counterfactual_instruction(case_pack)
                answer_prefix = "\n\nJSON answer:\n"
                case_ids = [str(c["case_id"]) for c in case_pack.get("cases", [])]
            instruction, structural_prompt = build_artifact_conditioned_instruction(
                instruction,
                args.prompt_steering,
                java_code=code,
                task=task_profile,
                target_method_name=None,
                max_elements=max(1, args.max_structural_elements),
            )

            exec_result = utity.run_java_program_with_result(code, class_name, enable_assertions=True)
            if not exec_result.get("compiled", False):
                raise RuntimeError(f"Compile failed for {path}: {exec_result.get('compile_error', '')}")
            if task_profile == "counterfactual_tf":
                oracle_labels = {
                    str(c["case_id"]): ("T" if bool(c["expected_bool"]) else "F")
                    for c in (case_pack or {}).get("cases", [])
                }
                actual_output_str = json.dumps(oracle_labels, sort_keys=True)
                actual_output_clean = actual_output_str
            else:
                if not exec_result.get("success", False):
                    raise RuntimeError(f"Run failed for {path}: {exec_result.get('runtime_error', '')}")
                actual_output_str = str(exec_result.get("stdout", ""))
                actual_output_clean = actual_output_str.strip()

            item_root = _build_output_root(
                args=args,
                model_label=model_label,
                snippet=snippet,
                technique=technique,
                tier=tier,
                run_tag=run_tag,
            )
            item_roots = _candidate_output_roots(
                args=args,
                model_label=model_label,
                snippet=snippet,
                technique=technique,
                tier=tier,
                run_tag=run_tag,
            )
            target_runs = max(1, args.runs_per_snippet)
            existing_runs = (
                _completed_run_dirs_for_item(
                    item_roots,
                    dataset=args.dataset,
                    source_kind=source_kind,
                    prompt_mode=args.prompt_steering,
                    snippet=snippet,
                    source_path=path,
                    technique=technique,
                    tier=tier,
                )
                if args.resume == "on"
                else []
            )
            if existing_runs and len(existing_runs) >= target_runs:
                print(f"[skip] {snippet}/{technique}/{tier} already has {len(existing_runs)}/{target_runs} runs")
                continue
            if item_root.exists():
                if args.resume == "off":
                    for child in item_root.glob("run_*"):
                        if child.is_dir():
                            shutil.rmtree(child)
            item_root.mkdir(parents=True, exist_ok=True)

            completed = len(existing_runs)
            attempts = 0
            max_attempts = max(target_runs, target_runs * max(1, args.max_attempt_multiplier))
            while completed < target_runs:
                attempts += 1
                if attempts > max_attempts:
                    raise RuntimeError(f"Exceeded {max_attempts} attempts for {snippet}/{technique}/{tier}.")
                planned_run_idx = (
                    _next_run_index_for_item(item_root, existing_runs)
                    if args.resume == "on"
                    else completed + 1
                )
                generation_seed = _trial_seed(
                    args.base_seed,
                    args.dataset,
                    source_kind,
                    args.prompt_steering,
                    snippet,
                    technique,
                    tier,
                    planned_run_idx,
                    attempts,
                )
                _set_generation_seed(generation_seed)
                result = llama.run_llama(
                    code,
                    instruction=instruction,
                    language="java",
                    answer_prefix=answer_prefix,
                    max_new_tokens=max(1, args.max_new_tokens),
                    temperature=float(args.temperature),
                    top_p=float(args.top_p),
                    do_sample=True,
                    record_layers=record_layers,
                    record_attention=record_layers,
                    vocab_tokens=[],
                )
                predicted_output_raw = str(
                    result.get("generated_completion") or result.get("generated_text", "")
                )
                score: Dict[str, Any] = {}
                if task_profile == "counterfactual_tf":
                    assert case_pack is not None
                    is_exact_match, predicted_output, score, complete = _counterfactual_eval(
                        result=result,
                        predicted_output_raw=predicted_output_raw,
                        case_pack=case_pack,
                        case_ids=case_ids,
                        strict_json=args.cf_strict_json == "on",
                        parse_predicted_labels=parse_predicted_labels,
                        score_case_predictions=score_case_predictions,
                    )
                    if args.retry_incomplete_json == "on" and not complete:
                        print(f"[{snippet}] incomplete JSON parse, retrying attempt {attempts}/{max_attempts}")
                        continue
                else:
                    predicted_output, format_ok = canonicalize_model_output(predicted_output_raw)
                    if not format_ok and not (actual_output_clean == "" and predicted_output == ""):
                        print(f"[{snippet}] unparseable output, retrying attempt {attempts}/{max_attempts}")
                        continue
                    is_exact_match = predicted_output == actual_output_clean

                run_idx = planned_run_idx
                run_dir = item_root / f"run_{run_idx:04d}"
                run_dir.mkdir(parents=True, exist_ok=True)

                result["actual_output"] = actual_output_str
                result["predicted_output"] = predicted_output
                result["predicted_output_raw"] = predicted_output_raw
                result["exact_match"] = bool(is_exact_match)
                result["task"] = "output_prediction"
                result["task_profile"] = task_profile
                result["eval_profile"] = task_profile
                result["dataset"] = args.dataset
                result["snippet"] = snippet
                result["source_path"] = str(path)
                result["mode"] = "prompt-steering"
                result["prompt_steering"] = {
                    "enabled": args.prompt_steering != "none",
                    "mode": args.prompt_steering,
                    "mechanism": "artifact_conditioned_natural_language_instruction_only",
                }
                result["structural_prompt"] = structural_prompt
                result["generation_params"] = {
                    "temperature": float(args.temperature),
                    "top_p": float(args.top_p),
                    "max_new_tokens": int(max(1, args.max_new_tokens)),
                    "do_sample": True,
                    "seed": int(generation_seed),
                    "base_seed": int(args.base_seed),
                }
                result["trial_id"] = run_idx
                result["run_index"] = run_idx
                result["source_kind"] = source_kind
                result["actual_execution"] = exec_result
                if source_kind == "obfuscated":
                    result["obfuscation"] = {
                        "dataset": args.dataset,
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
                        schema_dir=item_root,
                        code_snippet=code,
                        instruction=instruction,
                        target_text=actual_output_clean,
                        language="java",
                        pair_id=f"{snippet}:{technique}:{tier}:{run_idx:03d}",
                        variant_type=f"prompt-{args.prompt_steering}",
                        is_correct=bool(is_exact_match),
                    )
                    result.update(artifact_paths)
                    result["recording_complete"] = True
                    result.pop("full_decode_head_tensors", None)
                else:
                    result["recording_complete"] = False
                    result.pop("full_decode_head_tensors", None)

                if task_profile == "counterfactual_tf":
                    assert case_pack is not None
                    write_json(run_dir / "case_pack.json", case_pack)
                    write_json(run_dir / "oracle_labels.json", result.get("oracle_labels", {}))
                    write_json(run_dir / "predicted_labels.json", result.get("predicted_labels", {}))
                    write_json(
                        run_dir / "score.json",
                        {
                            "eval_profile": "counterfactual_tf",
                            "case_total": int(result.get("case_total", 0)),
                            "case_correct": int(result.get("case_correct", 0)),
                            "case_accuracy": float(result.get("case_accuracy", 0.0)),
                            "all_cases_pass": bool(result.get("all_cases_pass", False)),
                            "strict_pass": bool(result.get("strict_pass", False)),
                            "match_label": str(result.get("match_label", "partial")),
                            "parse_mode": str(result.get("parse_mode", "none")),
                            "provided_case_count": int(result.get("provided_case_count", 0)),
                            "requested_case_count": int(result.get("requested_case_count", 0)),
                            "parse_coverage": float(result.get("parse_coverage", 0.0)),
                        },
                    )
                llama.save_dump(result, str(run_dir / "model_output.json"))
                (run_dir / "actual_output.txt").write_text(actual_output_str + "\n", encoding="utf-8")
                (run_dir / "predicted_output.txt").write_text(predicted_output + "\n", encoding="utf-8")
                (run_dir / "predicted_output_raw.txt").write_text(predicted_output_raw + "\n", encoding="utf-8")
                existing_runs.append(run_dir)
                completed += 1
                print(f"[done] {snippet}/{technique}/{tier} run {completed}/{target_runs}")
    finally:
        llama.free()


if __name__ == "__main__":
    main()
