#!/usr/bin/env python3
"""Deterministically audit and select long-code case-study candidates.

The auditor never runs a model and never mutates result roots.  It independently
checks every saved run, joins split result roots, requires a matched four-condition
paired design, and applies the preregistered strict case-study eligibility rule.
"""

from __future__ import annotations

import argparse
import csv
import io
import json
import re
import sys
from collections import defaultdict
from pathlib import Path
from typing import Any, Dict, List, Mapping, Optional, Sequence, Tuple


sys.dont_write_bytecode = True

HERE = Path(__file__).resolve().parent
if str(HERE) not in sys.path:
    sys.path.insert(0, str(HERE))

import run_long_code_experiment as protocol


AUDIT_SCHEMA_VERSION = "long-code-audit-v1"
RUNNER_DEPENDENCY_KEY = (
    "PromptSteering/long-code-sample-work/run_long_code_experiment.py"
)
PUBLISHED_DATASET_PROFILE = {
    "dataset_id": "deepmind/code_contests",
    "dataset_revision": "802411c3010cb00d1b05bad57ca77365a3c699d6",
    "dataset_file_sha256": "02e8c1ccedae716f1e43cc813fcb7823c3db666ea92638820aba80e8cef451ab",
    "split": "valid",
    "language": "Java",
    "language_code": 4,
    "solution_container": "solutions",
    "solution_label": "correct human solution",
    "source_code": 2,
}
BASELINE_CONDITIONS = (
    "original_plain",
    "obfuscated_plain",
    "obfuscated_prompt_slice",
)
CODESTEER_CONDITION = "obfuscated_codesteer"
ALL_CONDITIONS = protocol.CONDITIONS

TRACE_TERMS = {
    "assign",
    "branch",
    "call",
    "condition",
    "execute",
    "iteration",
    "loop",
    "print",
    "return",
    "state",
    "update",
    "value",
}
UNCERTAINTY_TERMS = {
    "apparently",
    "cannot determine",
    "guess",
    "likely",
    "maybe",
    "perhaps",
    "probably",
    "unclear",
    "unsure",
}
DRIFT_TERMS = {
    "compile this",
    "here is the code",
    "implementation below",
    "java code",
    "rewrite the program",
}
JAVA_STOPWORDS = {
    "abstract",
    "boolean",
    "break",
    "byte",
    "case",
    "catch",
    "char",
    "class",
    "continue",
    "default",
    "double",
    "else",
    "enum",
    "extends",
    "false",
    "final",
    "finally",
    "float",
    "for",
    "if",
    "implements",
    "import",
    "instanceof",
    "int",
    "interface",
    "long",
    "native",
    "new",
    "null",
    "package",
    "private",
    "protected",
    "public",
    "return",
    "short",
    "static",
    "strictfp",
    "super",
    "switch",
    "synchronized",
    "this",
    "throw",
    "throws",
    "transient",
    "true",
    "try",
    "void",
    "volatile",
    "while",
}


def _read_json(path: Path) -> Dict[str, Any]:
    payload = json.loads(path.read_text(encoding="utf-8"))
    if not isinstance(payload, dict):
        raise TypeError(f"Expected JSON object: {path}")
    return payload


def _sha256_text(text: str) -> str:
    return protocol._sha256_bytes(text.encode("utf-8"))


def _fingerprint_payload(run_config: Mapping[str, Any]) -> Dict[str, Any]:
    keys = (
        "protocol_version",
        "manifest_sha256",
        "sample_id",
        "original_sha256",
        "obfuscated_sha256",
        "condition",
        "trial",
        "paired_seed",
        "model_name",
        "model_snapshot_commit",
        "generation",
        "prompt_sha256",
        "steering",
    )
    return {key: run_config.get(key) for key in keys}


def _validate_static_prior_cache_profile(
    recorded: Any,
    *,
    location: Path,
    runtime: bool,
) -> List[str]:
    """Require the exact registered no-op cache profile and runtime installation."""
    label = "environment" if runtime else "experiment config"
    if not isinstance(recorded, dict):
        return [f"missing static prior cache profile in {label} {location}"]

    errors: List[str] = []
    expected = protocol.STATIC_PRIOR_CACHE_PROFILE
    if recorded.get("enabled") is not True:
        errors.append(f"static prior cache is not enabled in {label} {location}")
    for key, expected_value in expected.items():
        if key == "enabled":
            continue
        if key not in recorded:
            errors.append(
                f"static prior cache profile missing key {key!r} in {label} {location}"
            )
        elif recorded[key] != expected_value:
            errors.append(
                f"static prior cache profile mismatch for {key!r} in {label} {location}: "
                f"recorded={recorded[key]!r}, expected={expected_value!r}"
            )

    allowed_keys = set(expected)
    if runtime:
        allowed_keys.update({"installed", "already_installed"})
        if recorded.get("installed") is not True:
            errors.append(f"static prior cache was not installed in environment {location}")
        if not isinstance(recorded.get("already_installed"), bool):
            errors.append(
                f"static prior cache already_installed flag is missing or not boolean "
                f"in environment {location}"
            )
    unexpected_keys = sorted(set(recorded) - allowed_keys)
    if unexpected_keys:
        errors.append(
            f"static prior cache profile has unexpected keys in {label} {location}: "
            f"{unexpected_keys}"
        )
    return errors


def _published_problem_identity(
    candidate_metadata: Any,
    *,
    location: Path,
) -> Tuple[Optional[str], Optional[Dict[str, Any]], Optional[str], List[str]]:
    """Validate immutable CodeContests provenance and derive a problem identity.

    The dataset row, not a mutable display key or a particular solution/test,
    is the canonical problem unit. Codeforces contest metadata is retained as
    an independent human-readable cross-check.
    """
    if not isinstance(candidate_metadata, dict):
        return None, None, None, [f"missing candidate metadata in {location}"]
    provenance = candidate_metadata.get("provenance")
    if not isinstance(provenance, dict):
        return None, None, None, [f"missing published-dataset provenance in {location}"]

    errors: List[str] = []
    for key, expected in PUBLISHED_DATASET_PROFILE.items():
        observed = provenance.get(key)
        if observed != expected:
            errors.append(
                f"published-dataset provenance mismatch for {key!r} in {location}: "
                f"observed={observed!r}, expected={expected!r}"
            )

    integer_fields = ("row_index", "solution_index", "cf_contest_id")
    for key in integer_fields:
        value = provenance.get(key)
        if isinstance(value, bool) or not isinstance(value, int) or value < 0:
            errors.append(f"invalid published-dataset {key!r} in {location}: {value!r}")
    cf_index = provenance.get("cf_index")
    if not isinstance(cf_index, str) or not cf_index.strip():
        errors.append(f"invalid Codeforces problem index in {location}: {cf_index!r}")

    row_index = provenance.get("row_index")
    contest_id = provenance.get("cf_contest_id")
    if (
        isinstance(row_index, bool)
        or not isinstance(row_index, int)
        or isinstance(contest_id, bool)
        or not isinstance(contest_id, int)
        or not isinstance(cf_index, str)
        or not cf_index.strip()
    ):
        return None, None, None, errors

    display_problem_key = candidate_metadata.get("problem_key")
    expected_problem_key = f"codeforces-{contest_id}-{cf_index.strip()}"
    if display_problem_key != expected_problem_key:
        errors.append(
            f"problem key/provenance mismatch in {location}: "
            f"observed={display_problem_key!r}, expected={expected_problem_key!r}"
        )
    canonical = (
        f"{PUBLISHED_DATASET_PROFILE['dataset_id']}@"
        f"{PUBLISHED_DATASET_PROFILE['dataset_revision']}:"
        f"{PUBLISHED_DATASET_PROFILE['split']}:row-{row_index:06d}"
    )
    fields = {
        "dataset_id": provenance.get("dataset_id"),
        "dataset_revision": provenance.get("dataset_revision"),
        "dataset_file_sha256": provenance.get("dataset_file_sha256"),
        "split": provenance.get("split"),
        "row_index": row_index,
        "cf_contest_id": contest_id,
        "cf_index": cf_index.strip(),
    }
    return canonical, fields, expected_problem_key, errors


def _trace_quality(
    reasoning: str, source: str, target_method: str, submitted_prompt: str = ""
) -> Dict[str, Any]:
    """Transparent source-grounded trace score that never reads the oracle.

    The score is used only to rank already-successful CodeSteer trials.  It rewards
    a concise-but-substantive explanation, source identifier grounding, execution
    vocabulary, explicit target/input/state/output grounding, and lack of
    uncertainty or code-generation drift.  It deliberately excludes predicted
    output, oracle output, and exact-match data.
    """
    reasoning_lower = reasoning.lower()
    words = re.findall(r"[A-Za-z_][A-Za-z_0-9]*|\d+(?:\.\d+)?", reasoning)
    word_count = len(words)
    source_ids = {
        token
        for token in re.findall(r"\b[A-Za-z_][A-Za-z_0-9]*\b", source)
        if token.lower() not in JAVA_STOPWORDS and len(token) >= 2
    }
    reasoning_ids = set(re.findall(r"\b[A-Za-z_][A-Za-z_0-9]*\b", reasoning))
    grounded_ids = sorted(source_ids & reasoning_ids)

    # Full credit between 50 and 260 words; gentle linear ramps outside it.
    if word_count < 50:
        length_component = min(1.0, word_count / 50.0)
    elif word_count <= 260:
        length_component = 1.0
    else:
        length_component = max(0.0, 1.0 - ((word_count - 260) / 520.0))
    identifier_denominator = max(1, min(12, len(source_ids)))
    identifier_component = min(1.0, len(grounded_ids) / float(identifier_denominator))
    present_trace_terms = sorted(term for term in TRACE_TERMS if term in reasoning_lower)
    execution_component = min(1.0, len(present_trace_terms) / 6.0)
    target_component = 1.0 if target_method and target_method.lower() in reasoning_lower else 0.0
    case_match = re.search(
        r"### CASES_BEGIN(.*?)### CASES_END", submitted_prompt, flags=re.DOTALL
    )
    case_block = case_match.group(1) if case_match else ""
    input_literals = sorted(
        {
            literal
            for literal in re.findall(r"(?<![A-Za-z_])-?\d+(?:\.\d+)?", case_block)
            if literal not in {"001"}
        }
    )
    mentioned_input_literals = [literal for literal in input_literals if literal in reasoning]
    input_component = (
        min(1.0, len(mentioned_input_literals) / float(min(4, len(input_literals))))
        if input_literals
        else 0.5
    )
    state_evidence_patterns = {
        "assignment": r"\b[A-Za-z_]\w*\s*=\s*-?\d+",
        "transition_arrow": r"(?:->|→)",
        "state_transition_word": r"\b(?:becomes?|changes?|increments?|decrements?|updates?|remains?)\b",
        "ordered_step": r"\b(?:then|next|after|before|finally)\b",
    }
    state_evidence = sorted(
        name
        for name, pattern in state_evidence_patterns.items()
        if re.search(pattern, reasoning, flags=re.IGNORECASE)
    )
    intermediate_state_component = min(1.0, len(state_evidence) / 2.0)
    output_terms = sorted(
        term for term in ("console", "output", "print", "stdout") if term in reasoning_lower
    )
    output_component = min(1.0, len(output_terms) / 2.0)
    uncertainty_hits = sorted(term for term in UNCERTAINTY_TERMS if term in reasoning_lower)
    drift_hits = sorted(term for term in DRIFT_TERMS if term in reasoning_lower)
    if "```" in reasoning or re.search(r"\bpublic\s+class\b", reasoning):
        drift_hits.append("generated_code_block")
    drift_hits = sorted(set(drift_hits))
    certainty_component = max(
        0.0, 1.0 - (len(uncertainty_hits) / 3.0) - (len(drift_hits) / 2.0)
    )
    sentence_count = len([part for part in re.split(r"[.!?]+(?:\s+|$)", reasoning.strip()) if part])

    weights = {
        "length": 0.15,
        "source_identifier_grounding": 0.20,
        "execution_vocabulary": 0.15,
        "target_method_grounding": 0.10,
        "input_literal_grounding": 0.10,
        "intermediate_state_evidence": 0.15,
        "output_discussion": 0.05,
        "certainty": 0.10,
    }
    components = {
        "length": length_component,
        "source_identifier_grounding": identifier_component,
        "execution_vocabulary": execution_component,
        "target_method_grounding": target_component,
        "input_literal_grounding": input_component,
        "intermediate_state_evidence": intermediate_state_component,
        "output_discussion": output_component,
        "certainty": certainty_component,
    }
    score = sum(weights[name] * components[name] for name in weights)
    return {
        "score": round(float(score), 8),
        "weights": weights,
        "components": {key: round(float(value), 8) for key, value in components.items()},
        "word_count": word_count,
        "sentence_count": sentence_count,
        "source_identifier_count": len(source_ids),
        "grounded_identifier_count": len(grounded_ids),
        "grounded_identifiers": grounded_ids,
        "execution_terms": present_trace_terms,
        "input_literals": input_literals,
        "mentioned_input_literals": mentioned_input_literals,
        "intermediate_state_evidence": state_evidence,
        "output_terms": output_terms,
        "uncertainty_terms": uncertainty_hits,
        "code_generation_drift_terms": drift_hits,
        "heuristic_only_manual_audit_required": True,
        "uses_outcome_or_oracle": False,
    }


def _validate_registered_codesteer(steering: Any) -> List[str]:
    errors: List[str] = []
    if not isinstance(steering, dict):
        return ["missing CodeSteer configuration"]
    checks = {
        "enabled_levels": steering.get("enabled_levels") == [2],
        "prior": steering.get("prior") == "slice_hybrid",
        "n_bins": steering.get("n_bins") == 12,
        "beta_post": abs(float(steering.get("beta_post", -1.0)) - 0.8) < 1e-9,
        "recency_mix": steering.get("recency_mix") is True,
        "recency_rho": abs(float(steering.get("recency_rho", -1.0)) - 0.2) < 1e-9,
        "recency_window": steering.get("recency_window") == 64,
        "only_first_decode_step": steering.get("only_first_decode_step") is False,
        "head_subset_mode": steering.get("head_subset_mode") == "none",
    }
    start = steering.get("steer_layer_start")
    end = steering.get("steer_layer_end")
    checks["qwen14_last_eight_layers_40_47"] = start == 40 and end == 47
    errors.extend(f"CodeSteer config mismatch: {name}" for name, ok in checks.items() if not ok)
    return errors


def audit_run(record_path: Path, result_root: Path) -> Dict[str, Any]:
    run_dir = record_path.parent
    errors: List[str] = []
    try:
        rel = record_path.relative_to(result_root)
    except ValueError:
        rel = record_path
    required = {
        "record": run_dir / "record.json",
        "run_config": run_dir / "run_config.json",
        "submitted_prompt": run_dir / "submitted_prompt.txt",
        "raw_completion": run_dir / "raw_completion.txt",
        "reasoning": run_dir / "reasoning.txt",
        "source": run_dir / "source.java",
        "oracle_stdout": run_dir / "oracle_stdout.txt",
        "score": run_dir / "score.json",
        "steering_debug": run_dir / "steering_debug.json",
        "model_output": run_dir / "model_output.json",
    }
    for label, path in required.items():
        if not path.is_file():
            errors.append(f"missing artifact: {label}")
    if errors:
        return {
            "valid": False,
            "errors": errors,
            "record_path": str(record_path),
            "relative_record_path": str(rel),
            "result_root": str(result_root),
        }

    try:
        record = _read_json(required["record"])
        run_config = _read_json(required["run_config"])
        score_saved = _read_json(required["score"])
        debug = _read_json(required["steering_debug"])
    except Exception as exc:
        return {
            "valid": False,
            "errors": [f"JSON read failure: {type(exc).__name__}: {exc}"],
            "record_path": str(record_path),
            "relative_record_path": str(rel),
            "result_root": str(result_root),
        }

    path_condition = run_dir.name
    path_trial_match = re.fullmatch(r"trial_(\d+)", run_dir.parent.name)
    path_trial = int(path_trial_match.group(1)) if path_trial_match else None
    path_sample = run_dir.parent.parent.name
    sample_id = str(run_config.get("sample_id", record.get("sample_id", "")))
    condition = str(run_config.get("condition", record.get("condition", "")))
    try:
        trial = int(run_config.get("trial", record.get("trial", -1)))
    except Exception:
        trial = -1
    try:
        paired_seed = int(run_config.get("paired_seed", record.get("paired_seed", -1)))
    except Exception:
        paired_seed = -1

    if record.get("status") != "complete":
        errors.append("record status is not complete")
    if sample_id != path_sample:
        errors.append(f"sample id/path mismatch: {sample_id!r} != {path_sample!r}")
    if condition != path_condition or condition not in ALL_CONDITIONS:
        errors.append(f"condition/path mismatch or unknown condition: {condition!r}/{path_condition!r}")
    if path_trial is None or trial != path_trial:
        errors.append(f"trial/path mismatch: {trial!r}/{path_trial!r}")
    if bool(run_config.get("activation_steering")) != (condition == CODESTEER_CONDITION):
        errors.append("condition/activation_steering flag mismatch")

    fingerprint = str(run_config.get("fingerprint", ""))
    recomputed_fingerprint = protocol._run_fingerprint(_fingerprint_payload(run_config))
    if not fingerprint or fingerprint != recomputed_fingerprint:
        errors.append("run_config fingerprint does not recompute")
    if str(record.get("fingerprint", "")) != fingerprint:
        errors.append("record/run_config fingerprint mismatch")

    prompt = required["submitted_prompt"].read_text(encoding="utf-8")
    completion = required["raw_completion"].read_text(encoding="utf-8")
    reasoning = required["reasoning"].read_text(encoding="utf-8")
    source = required["source"].read_text(encoding="utf-8")
    oracle_stdout = required["oracle_stdout"].read_text(encoding="utf-8")
    if _sha256_text(prompt) != run_config.get("prompt_sha256"):
        errors.append("submitted prompt hash mismatch")
    source_hash = _sha256_text(source)
    expected_source_kind = "original" if condition == "original_plain" else "obfuscated"
    if run_config.get("source_kind") != expected_source_kind:
        errors.append(
            f"condition/source_kind mismatch: {condition} requires {expected_source_kind}"
        )
    expected_source_hash = (
        run_config.get("original_sha256")
        if run_config.get("source_kind") == "original"
        else run_config.get("obfuscated_sha256")
    )
    if source_hash != expected_source_hash:
        errors.append("saved source hash mismatch")

    predicted_stdout, parse_meta = protocol.parse_final_output(completion)
    predicted_normalized = (
        protocol.normalize_stdout(predicted_stdout) if predicted_stdout is not None else None
    )
    oracle_normalized = protocol.normalize_stdout(oracle_stdout)
    exact = predicted_stdout is not None and predicted_normalized == oracle_normalized
    saved_exact = score_saved.get(
        "trimmed_exact_match", score_saved.get("exact_match_whitespace_normalized")
    )
    if bool(saved_exact) != exact:
        errors.append("saved/recomputed exact-match disagreement")
    if score_saved.get("parse_status") != parse_meta.get("parse_status"):
        errors.append("saved/recomputed parse-status disagreement")
    record_exact = record.get("score", {}).get(
        "trimmed_exact_match",
        record.get("score", {}).get("exact_match_whitespace_normalized"),
    )
    if record_exact != exact:
        errors.append("record/recomputed exact-match disagreement")

    generation = run_config.get("generation")
    if generation != protocol.GENERATION_DEFAULTS:
        errors.append("generation config differs from registered protocol")
    if run_config.get("model_name") != protocol.DEFAULT_MODEL_NAME:
        errors.append("model name differs from registered Qwen/Qwen2.5-14B protocol")
    if run_config.get("model_snapshot_commit") != protocol.MODEL_SNAPSHOT_COMMIT:
        errors.append("model snapshot commit differs from registered protocol")
    try:
        protocol.validate_steering_debug(
            protocol.ConditionInput(
                name=condition,
                source_kind=str(run_config.get("source_kind", "")),
                source_path=required["source"],
                source_code=source,
                target_method=str(run_config.get("target_method", "")),
                instruction="",
                prompt_metadata=dict(run_config.get("prompt_metadata") or {}),
                activation_steering=condition == CODESTEER_CONDITION,
            ),
            debug,
        )
    except Exception as exc:
        errors.append(f"steering debug invalid: {exc}")

    steering = run_config.get("steering")
    if condition == CODESTEER_CONDITION:
        errors.extend(_validate_registered_codesteer(steering))
        prior = run_config.get("codesteer_prior_preflight")
        if not isinstance(prior, dict):
            errors.append("missing CodeSteer prior preflight")
        else:
            if prior.get("algorithm_fallback_detected") is not False:
                errors.append("CodeSteer algorithm prior used fallback")
            if prior.get("case_signal_active") is not True:
                errors.append("CodeSteer CASES signal inactive")
    elif steering is not None:
        errors.append("baseline condition contains activation-steering config")

    prompt_meta = run_config.get("prompt_metadata") or {}
    if condition == "obfuscated_prompt_slice":
        if prompt_meta.get("enabled") is not True or prompt_meta.get("mode") != "slice":
            errors.append("prompt-slice metadata missing or wrong mode")
        if prompt_meta.get("max_elements") != 24:
            errors.append("prompt-slice max_elements is not 24")
        if int(prompt_meta.get("emitted_element_count", 0) or 0) > 24:
            errors.append("prompt-slice emitted more than 24 elements")
        if prompt_meta.get("target_method") != run_config.get("target_method"):
            errors.append("prompt-slice/recorded target-method mismatch")
        guidance_text = str(prompt_meta.get("guidance_text", ""))
        if not guidance_text or not prompt.startswith(guidance_text + "\n\n"):
            errors.append("prompt-slice submitted prompt does not contain its exact recorded guidance prefix")

    expected_reasoning = (
        completion.rsplit("FINAL_OUTPUT_JSON:", 1)[0].strip()
        if "FINAL_OUTPUT_JSON:" in completion
        else completion.strip()
    )
    if reasoning != expected_reasoning:
        errors.append("reasoning artifact is not the raw pre-final-JSON trace")
    trace_quality = _trace_quality(
        reasoning, source, str(run_config.get("target_method", "")), prompt
    )
    return {
        "valid": not errors,
        "errors": errors,
        "sample_id": sample_id,
        "trial": trial,
        "paired_seed": paired_seed,
        "condition": condition,
        "fingerprint": fingerprint,
        "model_name": run_config.get("model_name"),
        "generation": generation,
        "original_sha256": run_config.get("original_sha256"),
        "obfuscated_sha256": run_config.get("obfuscated_sha256"),
        "saved_source_sha256": source_hash,
        "source_kind": run_config.get("source_kind"),
        "target_method": run_config.get("target_method"),
        "prompt_sha256": run_config.get("prompt_sha256"),
        "task_base_prompt_sha256": (
            _sha256_text(
                prompt[len(str(prompt_meta.get("guidance_text", ""))) + 2 :]
            )
            if condition == "obfuscated_prompt_slice"
            and str(prompt_meta.get("guidance_text", ""))
            and prompt.startswith(str(prompt_meta.get("guidance_text", "")) + "\n\n")
            else _sha256_text(prompt)
        ),
        "oracle_stdout_normalized_sha256": _sha256_text(oracle_normalized),
        "parse_status": parse_meta.get("parse_status"),
        "trimmed_exact_match": exact,
        "exact_match_whitespace_normalized": exact,
        "trace_quality": trace_quality,
        "record_path": str(record_path),
        "relative_record_path": str(rel),
        "result_root": str(result_root),
    }


def _discover_roots(roots: Sequence[Path]) -> Tuple[List[Path], List[str]]:
    resolved: List[Path] = []
    errors: List[str] = []
    seen: set[Path] = set()
    for raw in roots:
        root = raw.expanduser().resolve()
        if root in seen:
            continue
        seen.add(root)
        if not root.is_dir():
            errors.append(f"result root is not a directory: {root}")
            continue
        resolved.append(root)
    return sorted(resolved), errors


def audit_result_roots(result_roots: Sequence[Path]) -> Dict[str, Any]:
    roots, global_errors = _discover_roots(result_roots)
    expected_trials_by_sample: Dict[str, int] = {}
    base_seed_by_sample: Dict[str, int] = {}
    problem_keys_by_sample: Dict[str, set[str]] = defaultdict(set)
    canonical_identities_by_sample: Dict[str, set[str]] = defaultdict(set)
    identity_fields_by_sample: Dict[str, Dict[str, Dict[str, Any]]] = defaultdict(dict)
    declared_samples: set[str] = set()
    preflight_rejections: Dict[str, List[str]] = defaultdict(list)
    experiment_configs: List[Dict[str, Any]] = []
    for root in roots:
        config_path = root / "experiment_config.json"
        if not config_path.is_file():
            global_errors.append(f"missing experiment_config.json: {root}")
            continue
        try:
            config = _read_json(config_path)
        except Exception as exc:
            global_errors.append(f"invalid experiment config {config_path}: {exc}")
            continue
        global_errors.extend(
            _validate_static_prior_cache_profile(
                config.get("static_prior_cache"),
                location=config_path,
                runtime=False,
            )
        )
        experiment_configs.append({"result_root": str(root), "config": config})
        rejection_path = root / "preflight_rejections.json"
        if rejection_path.is_file():
            try:
                rejection_payload = _read_json(rejection_path)
                for rejection in rejection_payload.get("rejections", []) or []:
                    if not isinstance(rejection, dict) or not rejection.get("sample_id"):
                        global_errors.append(f"malformed preflight rejection in {rejection_path}")
                        continue
                    preflight_rejections[str(rejection["sample_id"])].extend(
                        str(reason) for reason in (rejection.get("reasons", []) or [])
                    )
            except Exception as exc:
                global_errors.append(f"invalid preflight rejection file {rejection_path}: {exc}")
        environment_path = root / "environment.json"
        if not environment_path.is_file():
            global_errors.append(f"missing environment.json: {root}")
        else:
            try:
                environment = _read_json(environment_path)
                if environment.get("experiment_config_sha256") != protocol.sha256_file(config_path):
                    global_errors.append(
                        f"experiment config SHA256 mismatch in {environment_path}"
                    )
                if environment.get("model_snapshot_commit_registered") != protocol.MODEL_SNAPSHOT_COMMIT:
                    global_errors.append(f"registered model snapshot mismatch in {environment_path}")
                if environment.get("model_snapshot_commit_verified") is not True:
                    global_errors.append(f"model snapshot was not verified in {environment_path}")
                global_errors.extend(
                    _validate_static_prior_cache_profile(
                        environment.get("static_prior_cache"),
                        location=environment_path,
                        runtime=True,
                    )
                )
                provenance = environment.get("runtime_code_provenance")
                required_dependencies = {
                    "models.py",
                    "PromptSteering/element_prompting.py",
                    "PromptSteering/prompt.py",
                    "steering/config.py",
                    "steering/runtime.py",
                    "steering/priors.py",
                    "steering/levels.py",
                    "steering/backends/qwen2_backend.py",
                    RUNNER_DEPENDENCY_KEY,
                }
                if not isinstance(provenance, dict):
                    global_errors.append(f"missing runtime code provenance in {environment_path}")
                else:
                    dependency_hashes = provenance.get("dependency_sha256") or {}
                    if not isinstance(dependency_hashes, dict):
                        global_errors.append(
                            f"runtime dependency hashes are not a JSON object in {environment_path}"
                        )
                        dependency_hashes = {}
                    missing_dependencies = sorted(required_dependencies - set(dependency_hashes))
                    if missing_dependencies:
                        global_errors.append(
                            f"missing runtime dependency hashes in {environment_path}: "
                            f"{missing_dependencies}"
                        )
                    runner_sha256 = environment.get("runner_sha256")
                    if not isinstance(runner_sha256, str) or not runner_sha256:
                        global_errors.append(f"missing runner SHA256 in {environment_path}")
                    elif RUNNER_DEPENDENCY_KEY in dependency_hashes and (
                        runner_sha256 != dependency_hashes[RUNNER_DEPENDENCY_KEY]
                    ):
                        global_errors.append(
                            f"runner SHA256 disagrees with runtime dependency hash in "
                            f"{environment_path}: runner_sha256={runner_sha256!r}, "
                            f"dependency_sha256[{RUNNER_DEPENDENCY_KEY!r}]="
                            f"{dependency_hashes[RUNNER_DEPENDENCY_KEY]!r}"
                        )
                    if not provenance.get("git_revision"):
                        global_errors.append(f"missing git revision in {environment_path}")
                    if not isinstance(provenance.get("git_dirty"), bool):
                        global_errors.append(f"missing git dirty flag in {environment_path}")
            except Exception as exc:
                global_errors.append(f"invalid environment provenance {environment_path}: {exc}")
        try:
            trial_count = int(config.get("trials", 0))
        except Exception:
            trial_count = 0
        try:
            base_seed = int(config.get("base_seed"))
        except Exception:
            base_seed = -1
        if base_seed < 0:
            global_errors.append(f"invalid base_seed in {config_path}")
        if trial_count <= 0:
            global_errors.append(f"invalid trial count in {config_path}")
        for sample_id_any in config.get("sample_ids", []) or []:
            sample_id = str(sample_id_any)
            declared_samples.add(sample_id)
            sample_snapshot_path = root / "samples" / sample_id / "sample.json"
            if sample_snapshot_path.is_file():
                try:
                    sample_snapshot = _read_json(sample_snapshot_path)
                    metadata = sample_snapshot.get("metadata") or {}
                    candidate_metadata = (
                        metadata.get("candidate_metadata")
                        if isinstance(metadata, dict)
                        and isinstance(metadata.get("candidate_metadata"), dict)
                        else {}
                    )
                    canonical_identity, identity_fields, problem_key, provenance_errors = (
                        _published_problem_identity(
                            candidate_metadata,
                            location=sample_snapshot_path,
                        )
                    )
                    global_errors.extend(provenance_errors)
                    if problem_key:
                        problem_keys_by_sample[sample_id].add(str(problem_key))
                    if canonical_identity and identity_fields:
                        canonical_identities_by_sample[sample_id].add(canonical_identity)
                        identity_fields_by_sample[sample_id][canonical_identity] = identity_fields
                except Exception as exc:
                    global_errors.append(
                        f"invalid sample provenance {sample_snapshot_path}: {exc}"
                    )
            else:
                global_errors.append(f"missing sample provenance snapshot: {sample_snapshot_path}")
            prior = expected_trials_by_sample.get(sample_id)
            if prior is not None and prior != trial_count:
                global_errors.append(
                    f"conflicting expected trials for {sample_id}: {prior} versus {trial_count}"
                )
            elif trial_count > 0:
                expected_trials_by_sample[sample_id] = trial_count
            prior_seed = base_seed_by_sample.get(sample_id)
            if prior_seed is not None and prior_seed != base_seed:
                global_errors.append(
                    f"conflicting base_seed for {sample_id}: {prior_seed} versus {base_seed}"
                )
            elif base_seed >= 0:
                base_seed_by_sample[sample_id] = base_seed

    keyed: Dict[Tuple[str, int, str], Dict[str, Any]] = {}
    duplicate_sources: Dict[Tuple[str, int, str], List[str]] = defaultdict(list)
    conflict_keys: set[Tuple[str, int, str]] = set()
    invalid_unkeyed: List[Dict[str, Any]] = []
    for root in roots:
        for record_path in sorted((root / "runs").glob("*/trial_*/*/record.json")):
            run = audit_run(record_path, root)
            if not all(key in run for key in ("sample_id", "trial", "condition")):
                invalid_unkeyed.append(run)
                continue
            key = (str(run["sample_id"]), int(run["trial"]), str(run["condition"]))
            declared_samples.add(key[0])
            duplicate_sources[key].append(str(record_path))
            if key not in keyed:
                keyed[key] = run
            elif keyed[key].get("fingerprint") != run.get("fingerprint"):
                conflict_keys.add(key)
                global_errors.append(f"conflicting duplicate run for {key}: {duplicate_sources[key]}")
            else:
                # Identical duplicates are harmless; combine validity conservatively.
                if not run.get("valid"):
                    keyed[key]["valid"] = False
                    keyed[key].setdefault("errors", []).extend(
                        f"duplicate invalid: {message}" for message in run.get("errors", [])
                    )
    for key in conflict_keys:
        keyed[key]["valid"] = False
        keyed[key].setdefault("errors", []).append("conflicting duplicate fingerprints")
    for key, paths in duplicate_sources.items():
        keyed[key]["duplicate_record_paths"] = sorted(paths)

    candidates: List[Dict[str, Any]] = []
    for sample_id in sorted(declared_samples):
        known_problem_keys = sorted(problem_keys_by_sample.get(sample_id, set()))
        if len(known_problem_keys) > 1:
            global_errors.append(
                f"conflicting problem keys for {sample_id}: {known_problem_keys}"
            )
        if not known_problem_keys:
            global_errors.append(f"missing published-dataset problem key for {sample_id}")
        problem_key = known_problem_keys[0] if known_problem_keys else f"unresolved:{sample_id}"
        known_canonical_identities = sorted(canonical_identities_by_sample.get(sample_id, set()))
        if len(known_canonical_identities) > 1:
            global_errors.append(
                f"conflicting canonical problem identities for {sample_id}: "
                f"{known_canonical_identities}"
            )
        if not known_canonical_identities:
            global_errors.append(f"missing canonical published-dataset identity for {sample_id}")
        canonical_problem_identity = (
            known_canonical_identities[0]
            if known_canonical_identities
            else f"unresolved:{sample_id}"
        )
        canonical_problem_identity_fields = identity_fields_by_sample.get(sample_id, {}).get(
            canonical_problem_identity, {}
        )
        sample_runs = [run for key, run in keyed.items() if key[0] == sample_id]
        rejection_reasons = sorted(set(preflight_rejections.get(sample_id, [])))
        was_preflight_rejected = bool(rejection_reasons)
        observed_trials = sorted({int(run["trial"]) for run in sample_runs if int(run["trial"]) > 0})
        expected_count = expected_trials_by_sample.get(sample_id)
        if expected_count is None:
            expected_count = max(observed_trials) if observed_trials else 0
        expected_trials = list(range(1, expected_count + 1))
        sample_errors: List[str] = []
        if was_preflight_rejected and sample_runs:
            sample_errors.append("preflight-rejected sample unexpectedly contains inference runs")
        if not was_preflight_rejected and observed_trials != expected_trials:
            sample_errors.append(
                f"trial set mismatch: observed={observed_trials}, expected={expected_trials}"
            )
        for trial in ([] if was_preflight_rejected else expected_trials):
            present = sorted(
                condition
                for (sid, trial_id, condition) in keyed
                if sid == sample_id and trial_id == trial
            )
            if present != sorted(ALL_CONDITIONS):
                missing = sorted(set(ALL_CONDITIONS) - set(present))
                extra = sorted(set(present) - set(ALL_CONDITIONS))
                sample_errors.append(
                    f"trial {trial} condition mismatch: missing={missing}, extra={extra}"
                )

        valid_runs = [run for run in sample_runs if run.get("valid")]
        invalid_runs = [run for run in sample_runs if not run.get("valid")]
        for run in invalid_runs:
            sample_errors.extend(
                f"trial {run.get('trial')}/{run.get('condition')}: {message}"
                for message in run.get("errors", [])
            )

        # Matched-pair invariants for each complete trial.
        for trial in ([] if was_preflight_rejected else expected_trials):
            trial_runs = {
                condition: keyed.get((sample_id, trial, condition)) for condition in ALL_CONDITIONS
            }
            if any(run is None for run in trial_runs.values()):
                continue
            seeds = {run.get("paired_seed") for run in trial_runs.values() if run is not None}
            generations = {
                protocol._stable_json(run.get("generation"))
                for run in trial_runs.values()
                if run is not None
            }
            oracles = {
                run.get("oracle_stdout_normalized_sha256")
                for run in trial_runs.values()
                if run is not None
            }
            obf_hashes = {
                run.get("obfuscated_sha256") for run in trial_runs.values() if run is not None
            }
            if len(seeds) != 1:
                sample_errors.append(f"trial {trial} does not share one paired seed")
            if len(generations) != 1:
                sample_errors.append(f"trial {trial} generation configs differ")
            if len(oracles) != 1:
                sample_errors.append(f"trial {trial} oracle outputs differ")
            if len(obf_hashes) != 1:
                sample_errors.append(f"trial {trial} obfuscated source hashes differ")
            plain = trial_runs.get("obfuscated_plain")
            codesteer = trial_runs.get(CODESTEER_CONDITION)
            if plain and codesteer and plain.get("prompt_sha256") != codesteer.get("prompt_sha256"):
                sample_errors.append(
                    f"trial {trial} obfuscated plain and CodeSteer prompts differ"
                )
            task_bases = {
                trial_runs[condition].get("task_base_prompt_sha256")
                for condition in (
                    "obfuscated_plain",
                    "obfuscated_prompt_slice",
                    CODESTEER_CONDITION,
                )
                if trial_runs.get(condition)
            }
            if len(task_bases) != 1:
                sample_errors.append(
                    f"trial {trial} obfuscated conditions do not share the same base task prompt"
                )

        if sample_runs:
            original_hashes = {
                run.get("saved_source_sha256")
                for run in sample_runs
                if run.get("condition") == "original_plain"
            }
            obfuscated_hashes = {
                run.get("saved_source_sha256")
                for run in sample_runs
                if run.get("condition") in ALL_CONDITIONS[1:]
            }
            obfuscated_targets = {
                run.get("target_method")
                for run in sample_runs
                if run.get("condition") in ALL_CONDITIONS[1:]
            }
            if len(original_hashes) != 1:
                sample_errors.append("original_plain source differs across trials")
            if len(obfuscated_hashes) != 1:
                sample_errors.append("the three obfuscated conditions do not use one identical source")
            if len(obfuscated_targets) != 1:
                sample_errors.append("the three obfuscated conditions do not use one identical target method")
            base_seed = base_seed_by_sample.get(sample_id)
            if base_seed is None:
                sample_errors.append("missing experiment base_seed for paired-seed recomputation")
            else:
                for run in sample_runs:
                    expected_seed = protocol.paired_seed(base_seed, sample_id, int(run["trial"]))
                    if run.get("paired_seed") != expected_seed:
                        sample_errors.append(
                            f"trial {run.get('trial')}/{run.get('condition')} paired seed does not recompute"
                        )

        exact_trials: Dict[str, List[int]] = {}
        exact_counts: Dict[str, int] = {}
        for condition in ALL_CONDITIONS:
            successes = sorted(
                int(run["trial"])
                for run in sample_runs
                if run.get("condition") == condition
                and run.get("valid")
                and run.get("trimmed_exact_match") is True
            )
            exact_trials[condition] = successes
            exact_counts[condition] = len(successes)

        complete_and_valid = bool(
            not was_preflight_rejected
            and not sample_errors
            and len(valid_runs) == expected_count * len(ALL_CONDITIONS)
        )
        marker_exact_codesteer_trials = sorted(
            int(run["trial"])
            for run in valid_runs
            if run.get("condition") == CODESTEER_CONDITION
            and run.get("trimmed_exact_match") is True
            and run.get("parse_status") == "marker_json"
        )
        strict_eligible = bool(
            complete_and_valid
            and marker_exact_codesteer_trials
            and all(exact_counts[condition] == 0 for condition in BASELINE_CONDITIONS)
        )
        successful_codesteer = [
            run
            for run in valid_runs
            if run.get("condition") == CODESTEER_CONDITION
            and run.get("trimmed_exact_match") is True
            and run.get("parse_status") == "marker_json"
        ]
        successful_codesteer.sort(
            key=lambda run: (
                -float(run.get("trace_quality", {}).get("score", 0.0)),
                int(run.get("trial", 10**9)),
                str(run.get("fingerprint", "")),
            )
        )
        ranked = [
            {
                "rank": rank,
                "trial": int(run["trial"]),
                "paired_seed": int(run["paired_seed"]),
                "ranking_prefilter": {
                    "valid_run": True,
                    "exact_match_required": True,
                    "valid_final_marker_json_required": True,
                },
                "trace_quality": run["trace_quality"],
                "record_path": run["record_path"],
                "fingerprint": run["fingerprint"],
            }
            for rank, run in enumerate(successful_codesteer, start=1)
        ]
        best = ranked[0] if ranked else None
        candidates.append(
            {
                "sample_id": sample_id,
                "problem_key": problem_key,
                "canonical_problem_identity": canonical_problem_identity,
                "canonical_problem_identity_fields": canonical_problem_identity_fields,
                "preflight_rejected": was_preflight_rejected,
                "preflight_rejection_reasons": rejection_reasons,
                "complete_and_valid": complete_and_valid,
                "validation_errors": sorted(set(sample_errors)),
                "expected_trials": expected_trials,
                "observed_trials": observed_trials,
                "run_count": len(sample_runs),
                "valid_run_count": len(valid_runs),
                "exact_counts": exact_counts,
                "exact_trials": exact_trials,
                "marker_json_exact_codesteer_trials": marker_exact_codesteer_trials,
                "strict_eligible": strict_eligible,
                "eligibility_rule": (
                    "complete matched four-condition trials; >=1 exact CodeSteer trial with "
                    "FINAL_OUTPUT_JSON marker; "
                    "zero exact trials for original_plain, obfuscated_plain, and "
                    "obfuscated_prompt_slice"
                ),
                "best_successful_codesteer_trial": best,
                "successful_codesteer_trace_ranking": ranked,
                "runs": sorted(
                    sample_runs,
                    key=lambda run: (int(run.get("trial", -1)), str(run.get("condition", ""))),
                ),
            }
        )

    eligible_candidates = [candidate for candidate in candidates if candidate["strict_eligible"]]
    eligible = [candidate["sample_id"] for candidate in eligible_candidates]
    problem_keys_to_identities: Dict[str, set[str]] = defaultdict(set)
    identities_to_problem_keys: Dict[str, set[str]] = defaultdict(set)
    for candidate in candidates:
        problem_keys_to_identities[str(candidate["problem_key"])].add(
            str(candidate["canonical_problem_identity"])
        )
        identities_to_problem_keys[str(candidate["canonical_problem_identity"])].add(
            str(candidate["problem_key"])
        )
    for problem_key, identities in sorted(problem_keys_to_identities.items()):
        if len(identities) != 1:
            global_errors.append(
                f"problem key maps to multiple canonical dataset rows: "
                f"{problem_key} -> {sorted(identities)}"
            )
    for identity, problem_keys in sorted(identities_to_problem_keys.items()):
        if len(problem_keys) != 1:
            global_errors.append(
                f"canonical dataset row maps to multiple problem keys: "
                f"{identity} -> {sorted(problem_keys)}"
            )
    eligible_by_problem: Dict[str, List[Dict[str, Any]]] = defaultdict(list)
    for candidate in eligible_candidates:
        eligible_by_problem[str(candidate["canonical_problem_identity"])].append(candidate)
    unique_problem_selection: List[Dict[str, Any]] = []
    for canonical_identity in sorted(eligible_by_problem):
        variants = eligible_by_problem[canonical_identity]
        variants.sort(
            key=lambda candidate: (
                -float(
                    ((candidate.get("best_successful_codesteer_trial") or {}).get("trace_quality") or {}).get(
                        "score", 0.0
                    )
                ),
                str(candidate["sample_id"]),
            )
        )
        chosen = variants[0]
        chosen["unique_problem_selected"] = True
        alternatives = [candidate["sample_id"] for candidate in variants[1:]]
        for alternative in variants[1:]:
            alternative["unique_problem_selected"] = False
        unique_problem_selection.append(
            {
                "canonical_problem_identity": canonical_identity,
                "canonical_problem_identity_fields": chosen[
                    "canonical_problem_identity_fields"
                ],
                "problem_key": chosen["problem_key"],
                "selected_sample_id": chosen["sample_id"],
                "duplicate_eligible_alternatives": alternatives,
                "selection_rule": "highest best-trace heuristic score, then lexicographic sample_id",
            }
        )
    for candidate in candidates:
        candidate.setdefault("unique_problem_selected", False)

    invalid_candidate_count = sum(
        (not candidate["complete_and_valid"])
        and not (
            candidate.get("preflight_rejected")
            and not candidate.get("validation_errors")
        )
        for candidate in candidates
    )
    preflight_rejected_count = sum(candidate.get("preflight_rejected") for candidate in candidates)
    validation_ok = not global_errors and not invalid_unkeyed and invalid_candidate_count == 0
    return {
        "schema_version": AUDIT_SCHEMA_VERSION,
        "protocol_version": protocol.PROTOCOL_VERSION,
        "deterministic": True,
        "result_roots": [str(root) for root in roots],
        "experiment_configs": experiment_configs,
        "validation": {
            "ok": validation_ok,
            "global_errors": sorted(set(global_errors)),
            "invalid_unkeyed_runs": invalid_unkeyed,
            "candidate_count": len(candidates),
            "complete_valid_candidate_count": sum(
                candidate["complete_and_valid"] for candidate in candidates
            ),
            "invalid_candidate_count": invalid_candidate_count,
            "preflight_rejected_candidate_count": preflight_rejected_count,
        },
        "selection": {
            "strict_eligible_count": len(eligible),
            "strict_eligible_sample_ids": eligible,
            "unique_problem_eligible_count": len(unique_problem_selection),
            "unique_problem_selection": unique_problem_selection,
            "trace_quality_score_uses_outcome_or_oracle": False,
            "trace_ranking_prefilter_requires_valid_exact_final_json": True,
            "trace_ranking_is_heuristic_not_llm_judgment": True,
            "manual_trace_audit_required_before_publication": True,
            "trace_quality_heuristic": (
                "15% concise/substantive length, 20% source-identifier grounding, "
                "15% execution vocabulary, 10% target-method grounding, 10% input-literal "
                "grounding, 15% intermediate-state evidence, 5% output discussion, and "
                "10% certainty/no code-generation drift; applied only after valid-run, exact, "
                "and FINAL_OUTPUT_JSON gates"
            ),
        },
        "candidates": candidates,
    }


def _csv_text(rows: Sequence[Mapping[str, Any]], fieldnames: Sequence[str]) -> str:
    stream = io.StringIO(newline="")
    writer = csv.DictWriter(stream, fieldnames=list(fieldnames), lineterminator="\n")
    writer.writeheader()
    for row in rows:
        writer.writerow({name: row.get(name, "") for name in fieldnames})
    return stream.getvalue()


def write_reports(report: Mapping[str, Any], output_dir: Path) -> Dict[str, str]:
    output_dir = protocol._experiment_output_root(output_dir)
    output_dir.mkdir(parents=True, exist_ok=True)
    json_path = output_dir / "long_code_audit.json"
    candidates_path = output_dir / "long_code_candidates.csv"
    runs_path = output_dir / "long_code_runs.csv"
    protocol.atomic_write_json(json_path, report)

    candidate_rows: List[Dict[str, Any]] = []
    run_rows: List[Dict[str, Any]] = []
    for candidate in report.get("candidates", []) or []:
        exact_counts = candidate.get("exact_counts", {}) or {}
        best = candidate.get("best_successful_codesteer_trial") or {}
        candidate_rows.append(
            {
                "sample_id": candidate.get("sample_id"),
                "problem_key": candidate.get("problem_key"),
                "canonical_problem_identity": candidate.get(
                    "canonical_problem_identity"
                ),
                "preflight_rejected": candidate.get("preflight_rejected"),
                "complete_and_valid": candidate.get("complete_and_valid"),
                "strict_eligible": candidate.get("strict_eligible"),
                "unique_problem_selected": candidate.get("unique_problem_selected"),
                "expected_trial_count": len(candidate.get("expected_trials", []) or []),
                "valid_run_count": candidate.get("valid_run_count"),
                "original_plain_exact_count": exact_counts.get("original_plain", 0),
                "obfuscated_plain_exact_count": exact_counts.get("obfuscated_plain", 0),
                "obfuscated_prompt_slice_exact_count": exact_counts.get(
                    "obfuscated_prompt_slice", 0
                ),
                "obfuscated_codesteer_exact_count": exact_counts.get(
                    "obfuscated_codesteer", 0
                ),
                "best_codesteer_trial": best.get("trial", ""),
                "best_trace_quality_score": (best.get("trace_quality") or {}).get("score", ""),
                "validation_errors": " | ".join(candidate.get("validation_errors", []) or []),
                "preflight_rejection_reasons": " | ".join(
                    candidate.get("preflight_rejection_reasons", []) or []
                ),
            }
        )
        for run in candidate.get("runs", []) or []:
            trace = run.get("trace_quality", {}) or {}
            run_rows.append(
                {
                    "sample_id": run.get("sample_id"),
                    "trial": run.get("trial"),
                    "paired_seed": run.get("paired_seed"),
                    "condition": run.get("condition"),
                    "valid": run.get("valid"),
                    "trimmed_exact_match": run.get("trimmed_exact_match"),
                    "exact_match_whitespace_normalized": run.get(
                        "exact_match_whitespace_normalized"
                    ),
                    "parse_status": run.get("parse_status"),
                    "trace_quality_score": trace.get("score", ""),
                    "trace_word_count": trace.get("word_count", ""),
                    "fingerprint": run.get("fingerprint"),
                    "record_path": run.get("record_path"),
                    "errors": " | ".join(run.get("errors", []) or []),
                }
            )
    candidate_fields = (
        "sample_id",
        "problem_key",
        "canonical_problem_identity",
        "preflight_rejected",
        "complete_and_valid",
        "strict_eligible",
        "unique_problem_selected",
        "expected_trial_count",
        "valid_run_count",
        "original_plain_exact_count",
        "obfuscated_plain_exact_count",
        "obfuscated_prompt_slice_exact_count",
        "obfuscated_codesteer_exact_count",
        "best_codesteer_trial",
        "best_trace_quality_score",
        "validation_errors",
        "preflight_rejection_reasons",
    )
    run_fields = (
        "sample_id",
        "trial",
        "paired_seed",
        "condition",
        "valid",
        "trimmed_exact_match",
        "exact_match_whitespace_normalized",
        "parse_status",
        "trace_quality_score",
        "trace_word_count",
        "fingerprint",
        "record_path",
        "errors",
    )
    protocol.atomic_write_text(candidates_path, _csv_text(candidate_rows, candidate_fields))
    protocol.atomic_write_text(runs_path, _csv_text(run_rows, run_fields))
    return {
        "json": str(json_path),
        "candidates_csv": str(candidates_path),
        "runs_csv": str(runs_path),
    }


def parse_args(argv: Optional[Sequence[str]] = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("result_roots", nargs="+", type=Path)
    parser.add_argument("--output-dir", type=Path, default=HERE / "audit")
    parser.add_argument(
        "--allow-incomplete",
        action="store_true",
        help="Write the audit but return success when completeness/integrity validation fails.",
    )
    return parser.parse_args(argv)


def main(argv: Optional[Sequence[str]] = None) -> int:
    args = parse_args(argv)
    report = audit_result_roots(args.result_roots)
    paths = write_reports(report, args.output_dir)
    print(json.dumps({"validation": report["validation"], "selection": report["selection"], "outputs": paths}, indent=2, sort_keys=True))
    return 0 if report["validation"]["ok"] or args.allow_incomplete else 2


if __name__ == "__main__":
    raise SystemExit(main())
