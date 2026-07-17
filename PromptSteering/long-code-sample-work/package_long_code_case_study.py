#!/usr/bin/env python3
"""Build a deterministic, self-contained staging artifact for ten case studies.

This script is intentionally a *packager*, not a model runner or a selector that
can relax the registered gate.  It independently re-runs the saved-results audit,
requires the supplied JSON and CSV reports to be current, and writes only below
this work directory.  Legacy strict reviews select at most one sample per
published-dataset problem.  Explicit paired-trial reviews instead select ten
distinct concrete sample IDs, may repeat canonical problems, and disclose the
actual problem counts and repeats.
"""

from __future__ import annotations

import argparse
import csv
import dataclasses
import hashlib
import importlib.util
import json
import os
import re
import shlex
import shutil
import sys
import tempfile
from collections import defaultdict
from pathlib import Path
from typing import Any, Dict, Iterable, List, Mapping, Optional, Sequence, Tuple


sys.dont_write_bytecode = True

HERE = Path(__file__).resolve().parent
PROJECT_ROOT = HERE.parents[1]
if str(HERE) not in sys.path:
    sys.path.insert(0, str(HERE))
if str(PROJECT_ROOT) not in sys.path:
    sys.path.insert(0, str(PROJECT_ROOT))

import audit_long_code_results as auditor
import preflight_long_code_tokenizer as tokenizer_preflight
import run_long_code_experiment as protocol


PACKAGE_SCHEMA_VERSION = "long-code-case-study-package-v1"
MANUAL_REVIEW_SCHEMA_VERSION = "long-code-manual-trace-review-v1"
PAIRED_MANUAL_REVIEW_SCHEMA_VERSION = (
    "long-code-paired-trial-manual-trace-review-v1"
)
CASE_COUNT = 10
EXPECTED_TRIALS = (1, 2, 3)
BASELINE_CONDITIONS = tuple(auditor.BASELINE_CONDITIONS)
CODESTEER_CONDITION = auditor.CODESTEER_CONDITION
ALL_CONDITIONS = tuple(protocol.CONDITIONS)
MANUAL_REASONING_QUALITY = {
    "coherent",
    "mostly_coherent",
    "output_correct_reasoning_limited",
}
MANUAL_GROUNDING_DIMENSIONS = {"source", "input", "state"}

REQUIRED_RUN_ARTIFACTS = (
    "record.json",
    "status.json",
    "run_config.json",
    "submitted_prompt.txt",
    "model_prompt_decoded.txt",
    "raw_completion.txt",
    "reasoning.txt",
    "predicted_stdout.txt",
    "source.java",
    "oracle_stdout.txt",
    "score.json",
    "steering_debug.json",
    "model_output.json",
)

REQUIRED_SAMPLE_ARTIFACTS = (
    "sample.json",
    "stdin.txt",
    "oracle.json",
    "oracle_stdout.txt",
    "original.java",
    "obfuscated.java",
    "static_preflight.json",
    "preflight.json",
)

CODECONTESTS_DATASET_ID = "deepmind/code_contests"
CODECONTESTS_REVISION = "802411c3010cb00d1b05bad57ca77365a3c699d6"
CODECONTESTS_FILE_SHA256 = "02e8c1ccedae716f1e43cc813fcb7823c3db666ea92638820aba80e8cef451ab"
CODECONTESTS_SPLIT = "valid"
CODECONTESTS_LANGUAGE = "Java"
CODECONTESTS_LANGUAGE_CODE = 4
CODECONTESTS_SOLUTION_LABEL = "correct human solution"
CODECONTESTS_SOLUTION_CONTAINER = "solutions"
CODECONTESTS_SOURCE_CODE = 2
CODECONTESTS_PARQUET = HERE / "codecontests-valid-802411c3.parquet"

TOKENIZER_REQUIRED_FILES = {
    "config.json",
    "merges.txt",
    "tokenizer.json",
    "tokenizer_config.json",
    "vocab.json",
}
SUPPLEMENTAL_PIPELINE_FILES = (
    "SUPPLEMENTAL_CASE_PROTOCOL.md",
    "prepare_supplemental_cases.py",
    "test_prepare_supplemental_cases.py",
    "supplemental_launch_plan.json",
    "test_supplemental_launch_plan.py",
)

INITIAL_SOURCE_SCHEMA = "long-code-obfuscated-variants-v1"
SUPPLEMENTAL_SOURCE_SCHEMA = "long-code-supplemental-cases-v2"
BALANCED_SOURCE_SCHEMA = "long-code-balanced-contingency-v1"
BALANCED_LAUNCH_SCHEMA = "long-code-balanced-launch-plan-v1"
BALANCED_FREEZE_SCHEMA = "long-code-balanced-freeze-v1"
BALANCED_CONTINGENCY_ROOT = HERE / "balanced_contingency"
BALANCED_FREEZE_MANIFEST_SHA256 = (
    "818f9d6b3926ed41e34d4fcf905aaad4e60cef80da652d49a6f431236393ee02"
)
BALANCED_PRE_CORRECTION_FREEZE_SHA256 = (
    "eb0acd8cdf021109bb8dce0420731a3bf638d31c04bc49f285f10e7daa3ceb00"
)
BALANCED_PROTOCOL_JSON = "balanced_contingency_protocol.json"
BALANCED_EXECUTION_DISCLOSURE = "balanced_execution_disclosure.json"
BALANCED_EXECUTION_DISCLOSURE_SCHEMA = (
    "long-code-balanced-execution-disclosure-v1"
)
BALANCED_RUNNER_DEPENDENCY = (
    "PromptSteering/long-code-sample-work/run_long_code_experiment.py"
)
BALANCED_REQUIRED_CONTROL_FILES = {
    "BALANCED_CONTINGENCY_PROTOCOL.md",
    BALANCED_PROTOCOL_JSON,
    "prepare_balanced_contingency.py",
    "finalize_balanced_contingency.py",
    "test_prepare_balanced_contingency.py",
    "prepare_long_code_variants.py",
    "prepare_supplemental_cases.py",
    "run_long_code_experiment.py",
    "preflight_long_code_tokenizer.py",
    "test_preflight_long_code_tokenizer.py",
}
BALANCED_CASES_PER_WAVE = 38
BALANCED_PROBLEMS_PER_WAVE = 19
BALANCED_SHARD_SIZES = (10, 10, 9, 9)
BALANCED_SHARD_RECORDS = (120, 120, 108, 108)
BALANCED_RECORDS_PER_WAVE = 456

BALANCED_EXTENSION_SOURCE_SCHEMA = "long-code-balanced-extension-contingency-v1"
BALANCED_EXTENSION_LAUNCH_SCHEMA = "long-code-balanced-extension-launch-plan-v1"
BALANCED_EXTENSION_FREEZE_SCHEMA = "long-code-balanced-extension-freeze-v1"
BALANCED_EXTENSION_ROOT = HERE / "balanced_extension_contingency"
BALANCED_EXTENSION_EXTERNAL_ANCHOR = (
    HERE / "balanced_extension_contingency.FREEZE.sha256"
)
BALANCED_EXTENSION_FREEZE_MANIFEST_SHA256 = (
    "44b2fad37ccbf8051c1f17ddc08c76ac6e3cbb0a05364a4f4f552663f6eccec8"
)
BALANCED_EXTENSION_FILTERED_MANIFEST_SHA256 = (
    "7fd17e066435e279196ddf243bbe6ae04a2ba30d48f86e1974eddee1d577dbf0"
)
BALANCED_EXTENSION_PRE_MANIFEST_SHA256 = (
    "cf592fbdf835bb9b173e489eb64031f9be00be9f1d645a7a63c6149e820abfd5"
)
BALANCED_EXTENSION_TOKENIZER_REPORT_SHA256 = (
    "d2acd2f96fa3521b4e22c14d51ef74c5d455068ea49a85e5e36f5fb7154590b5"
)
BALANCED_EXTENSION_LAUNCH_PLAN_SHA256 = (
    "080c641dc5b7a3ed343c29689795fb2865abe8564baa64cb2927e2828f3b3b81"
)
BALANCED_EXTENSION_PROTOCOL_JSON = "balanced_extension_contingency_protocol.json"
BALANCED_EXTENSION_PROTOCOL_SHA256 = (
    "a475e16a125f5fe617f75884cda1371fd83f72a840d398fa8c9448487aeea071"
)
BALANCED_ADAPTIVE_DISCLOSURE_SHA256 = (
    "fb9461aedfe8e005b93778f20ea020a96c0da8d48b168a37a36f19033b3e553f"
)
BALANCED_EXTENSION_REQUIRED_CONTROL_FILES = {
    "BALANCED_EXTENSION_CONTINGENCY_PROTOCOL.md",
    BALANCED_EXTENSION_PROTOCOL_JSON,
    "prepare_balanced_extension_contingency.py",
    "finalize_balanced_extension_contingency.py",
    "test_prepare_balanced_extension_contingency.py",
    "prepare_balanced_contingency.py",
    "test_prepare_balanced_contingency.py",
    "prepare_long_code_variants.py",
    "prepare_supplemental_cases.py",
    "run_long_code_experiment.py",
    "preflight_long_code_tokenizer.py",
    "test_preflight_long_code_tokenizer.py",
}
BALANCED_EXTENSION_CASES = 114
BALANCED_EXTENSION_PROBLEMS = 19
BALANCED_EXTENSION_CASES_PER_PROBLEM = 6
BALANCED_EXTENSION_ACCEPTED_RANKS = (5, 6, 7, 8, 9, 10)
BALANCED_EXTENSION_SHARD_SIZES = (29, 29, 28, 28)
BALANCED_EXTENSION_SHARD_RECORDS = (348, 348, 336, 336)
BALANCED_EXTENSION_RECORDS = 1368

BALANCED_EXTENSION2_SOURCE_SCHEMA = "long-code-balanced-extension2-contingency-v1"
BALANCED_EXTENSION2_LAUNCH_SCHEMA = "long-code-balanced-extension2-launch-plan-v1"
BALANCED_EXTENSION2_FREEZE_SCHEMA = "long-code-balanced-extension2-freeze-v1"
BALANCED_EXTENSION2_ROOT = HERE / "balanced_extension2_contingency"
BALANCED_EXTENSION2_EXTERNAL_ANCHOR = (
    HERE / "balanced_extension2_contingency.FREEZE.sha256"
)
BALANCED_EXTENSION2_FREEZE_MANIFEST_SHA256 = (
    "956236852fc93bd5e9a714de85ccfe16cb45c3cefc6e6a9aa2a4447e3b571182"
)
BALANCED_EXTENSION2_PROTOCOL_JSON = "balanced_extension2_contingency_protocol.json"
BALANCED_EXTENSION2_PROTOCOL_SHA256 = (
    "ed666d7a709080b01f8357a2cf6d0cd95ecc62feecfe29d8927e5eeb14c09ebe"
)
BALANCED_EXTENSION2_PACKAGING_DISCLOSURE = (
    "balanced_extension2_packaging_execution_disclosure.json"
)
BALANCED_EXTENSION2_PACKAGING_DISCLOSURE_SCHEMA = (
    "long-code-balanced-extension2-packaging-execution-disclosure-v1"
)
BALANCED_EXTENSION2_PACKAGING_DISCLOSURE_SHA256 = (
    "5fc73202fc7bedec288f394cd7d25a66061f8da656645a0f7bb2a72b6909ec41"
)
BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE = (
    "balanced_extension2_paired_trial_protocol_refinement_disclosure.json"
)
BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE_SCHEMA = (
    "long-code-balanced-extension2-paired-trial-protocol-refinement-disclosure-v1"
)
BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE_SHA256 = (
    "58402b64684f4b150b4a0adb8f1bdd4dd32973476a80fbee02c03cb279f519e0"
)
BALANCED_EXTENSION2_REQUIRED_CONTROL_FILES = {
    "BALANCED_EXTENSION2_CONTINGENCY_PROTOCOL.md",
    BALANCED_EXTENSION2_PROTOCOL_JSON,
    "prepare_balanced_extension2_contingency.py",
    "finalize_balanced_extension2_contingency.py",
    "test_prepare_balanced_extension2_contingency.py",
    "BALANCED_EXTENSION_CONTINGENCY_PROTOCOL.md",
    BALANCED_EXTENSION_PROTOCOL_JSON,
    "prepare_balanced_extension_contingency.py",
    "finalize_balanced_extension_contingency.py",
    "test_prepare_balanced_extension_contingency.py",
    "BALANCED_CONTINGENCY_PROTOCOL.md",
    BALANCED_PROTOCOL_JSON,
    "prepare_balanced_contingency.py",
    "finalize_balanced_contingency.py",
    "test_prepare_balanced_contingency.py",
    "prepare_long_code_variants.py",
    "prepare_supplemental_cases.py",
    "run_long_code_experiment.py",
    "preflight_long_code_tokenizer.py",
    "test_preflight_long_code_tokenizer.py",
}
BALANCED_EXTENSION2_GENERATED_FILE_COUNT = 3362
BALANCED_EXTENSION2_CONTROL_FILE_COUNT = 20
BALANCED_EXTENSION2_PROBLEMS = 19
BALANCED_EXTENSION2_WAVE_SPECS = {
    4: {
        "accepted_ranks": (11, 12, 13, 14, 15),
        "cases_per_problem": 5,
        "cases": 95,
        "shard_cases": (24, 24, 24, 23),
        "shard_records": (288, 288, 288, 276),
        "records": 1140,
        "pre_manifest_sha256": (
            "b295a5ea5b00f9741299af0ff9cd914897df3780a6794a5a60eb165954835de2"
        ),
        "filtered_manifest_sha256": (
            "bdb56bd094e30d46d541daca1c620132c75219376f188b11a5dbe20877c3c253"
        ),
        "tokenizer_report_sha256": (
            "2192171d85977e7ed87511a083f0a308e3b01d41c92938cd79a25c0793f0c1fb"
        ),
        "launch_plan_sha256": (
            "4b2b2d1af7d27e7dac391daac6b324c309e3e4906fa4e8fe9226e7e6629aa882"
        ),
    },
    5: {
        "accepted_ranks": (16, 17, 18, 19),
        "cases_per_problem": 4,
        "cases": 76,
        "shard_cases": (19, 19, 19, 19),
        "shard_records": (228, 228, 228, 228),
        "records": 912,
        "pre_manifest_sha256": (
            "d0a69c48dad2440a7ad72214d2918f3afc995b13fb62a5b4861c9bdfdbab8453"
        ),
        "filtered_manifest_sha256": (
            "31beaba762c8d4e6a22af1d006eb93d3506bdf23a4d1dd124dca168b31aab056"
        ),
        "tokenizer_report_sha256": (
            "cbabc10fed6f5e7b8e890b432356cdec39efaa9bd0b20de98453a1b2ba0c82b1"
        ),
        "launch_plan_sha256": (
            "88068e7aea8495fc5e08ddf3fc92a7d30d540a4df3e6f1b4d64e9dd22408dea7"
        ),
    },
}
BALANCED_EXTENSION2_FAILURE_AUDIT_SHA256 = {
    25: "d9e0ec51950455035569ec778d61017aaf6c45b9f26eb0c7ae10d27d6e48e24f",
    20: "e4dd3956e19e4e7e6d9c83b7e12d547dd40e69f690d5e98d8476b4d87273dd09",
}
BALANCED_EXTENSION2_FAILURE_INVENTORY_SHA256 = {
    25: "ac1a6e8e8a4f987b36af3b2a2a35b89e18e0c6f5a846edb1a81b414aedd78e1b",
    20: "bd48c11297ad3350411612501716ba315af3abb5e8e020c0f101c74085d0527a",
}

PREPARED_EVIDENCE_FILES = (
    "all_variant_attempts.json",
    "eligible_variants.json",
    "rejections.jsonl",
    "summary.json",
)


class PackageError(RuntimeError):
    """Raised when packaging would make an unsupported or unauditable claim."""


def _stable_json(value: Any) -> str:
    return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":"))


def _sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def _sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as stream:
        for block in iter(lambda: stream.read(1024 * 1024), b""):
            digest.update(block)
    return digest.hexdigest()


def _read_json_object(path: Path, label: str) -> Dict[str, Any]:
    try:
        payload = json.loads(path.read_text(encoding="utf-8"))
    except Exception as exc:
        raise PackageError(f"Cannot read {label} JSON {path}: {exc}") from exc
    if not isinstance(payload, dict):
        raise PackageError(f"{label} must be a JSON object: {path}")
    return payload


def _safe_component(value: Any, label: str) -> str:
    text = str(value)
    if not text or text in {".", ".."} or not re.fullmatch(r"[A-Za-z0-9_.-]+", text):
        raise PackageError(f"Unsafe {label}: {text!r}")
    return text


def _resolve_existing_under(
    value: Path, root: Path, label: str, *, require_file: Optional[bool] = None
) -> Path:
    try:
        resolved_root = root.expanduser().resolve(strict=True)
    except Exception as exc:
        raise PackageError(f"Missing {label} root {root}: {exc}") from exc
    raw = value.expanduser()
    candidate = raw if raw.is_absolute() else resolved_root / raw
    try:
        resolved = candidate.resolve(strict=True)
        resolved.relative_to(resolved_root)
    except Exception as exc:
        raise PackageError(f"{label} escapes or is missing under {resolved_root}: {value}") from exc
    if require_file is True and not resolved.is_file():
        raise PackageError(f"{label} is not a regular file: {resolved}")
    if require_file is False and not resolved.is_dir():
        raise PackageError(f"{label} is not a directory: {resolved}")
    return resolved


def _resolve_output_dir(value: Path) -> Path:
    raw = value.expanduser()
    candidate = raw if raw.is_absolute() else HERE / raw
    resolved = candidate.resolve(strict=False)
    try:
        resolved.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise PackageError(f"Staging output must stay below {HERE}: {resolved}") from exc
    if resolved == HERE:
        raise PackageError("The work root itself cannot be used as the staging output")
    return resolved


def _write_text(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(text, encoding="utf-8")


def _write_json(path: Path, payload: Any) -> None:
    _write_text(
        path,
        json.dumps(payload, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
    )


def _copy_file(src: Path, dst: Path, allowed_root: Path) -> None:
    source = _resolve_existing_under(src, allowed_root, "copy source", require_file=True)
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(source, dst)


def _copy_tree_files(src_root: Path, dst_root: Path, allowed_root: Path) -> None:
    source_root = _resolve_existing_under(
        src_root, allowed_root, "copy-tree source", require_file=False
    )
    for source in sorted(source_root.rglob("*"), key=lambda path: path.as_posix()):
        if source.is_symlink():
            raise PackageError(f"Symlinks are not accepted in copied evidence: {source}")
        if source.is_dir():
            continue
        if not source.is_file():
            raise PackageError(f"Non-regular evidence entry: {source}")
        relative = source.relative_to(source_root)
        _copy_file(source, dst_root / relative, allowed_root)


def _parse_bool_csv(value: str, label: str) -> bool:
    if value == "True":
        return True
    if value == "False":
        return False
    raise PackageError(f"Invalid Boolean in audit CSV ({label}): {value!r}")


def _validate_audit_csvs(
    report: Mapping[str, Any], candidates_csv: Path, runs_csv: Path, scratch_dir: Path
) -> None:
    """Require byte-identical canonical CSV reports for the supplied audit JSON."""
    # ``auditor.write_reports`` is the one canonical CSV renderer.  Its temporary
    # files live inside the not-yet-published atomic build directory, never in
    # the work root or a system temporary directory.
    scratch_dir.mkdir(parents=True, exist_ok=False)
    generated = auditor.write_reports(report, scratch_dir)
    expected_candidates = Path(generated["candidates_csv"]).read_bytes()
    expected_runs = Path(generated["runs_csv"]).read_bytes()
    if candidates_csv.read_bytes() != expected_candidates:
        raise PackageError("Candidate CSV is not the canonical companion of the audit JSON")
    if runs_csv.read_bytes() != expected_runs:
        raise PackageError("Run CSV is not the canonical companion of the audit JSON")

    # Parse once as a second, explicit guard against duplicate or malformed keys.
    with candidates_csv.open("r", encoding="utf-8", newline="") as stream:
        candidate_rows = list(csv.DictReader(stream))
    candidate_ids = [str(row.get("sample_id", "")) for row in candidate_rows]
    expected_ids = [str(row.get("sample_id", "")) for row in report.get("candidates", [])]
    if candidate_ids != expected_ids or len(candidate_ids) != len(set(candidate_ids)):
        raise PackageError("Candidate CSV row identities do not match the audit JSON")
    for row in candidate_rows:
        _parse_bool_csv(row.get("strict_eligible", ""), "strict_eligible")


def _validate_and_refresh_audit(
    audit_json: Path,
    audit_candidates_csv: Path,
    audit_runs_csv: Path,
    result_roots: Sequence[Path],
    scratch_dir: Path,
) -> Tuple[Dict[str, Any], List[Path]]:
    report = _read_json_object(audit_json, "audit")
    if report.get("schema_version") != auditor.AUDIT_SCHEMA_VERSION:
        raise PackageError(f"Unsupported audit schema: {report.get('schema_version')!r}")
    if report.get("protocol_version") != protocol.PROTOCOL_VERSION:
        raise PackageError("Audit protocol version does not match the experiment runner")
    if report.get("deterministic") is not True:
        raise PackageError("Audit does not declare deterministic evaluation")
    validation = report.get("validation") or {}
    if validation.get("ok") is not True:
        raise PackageError("Audit validation is not OK; refusing to package")

    roots: List[Path] = []
    for raw_root in result_roots:
        roots.append(
            _resolve_existing_under(raw_root, HERE, "result root", require_file=False)
        )
    roots = sorted(set(roots))
    if not roots:
        raise PackageError("At least one result root is required")
    registered_roots = sorted(Path(value).resolve() for value in report.get("result_roots", []))
    if roots != registered_roots:
        raise PackageError("Supplied result roots do not exactly match the audited result roots")

    refreshed = auditor.audit_result_roots(roots)
    if _stable_json(refreshed) != _stable_json(report):
        raise PackageError(
            "Saved artifacts no longer reproduce the supplied audit report; rerun the auditor"
        )
    _validate_audit_csvs(report, audit_candidates_csv, audit_runs_csv, scratch_dir)
    return report, roots


def _expanded_manifest_ids(payload: Mapping[str, Any]) -> set[str]:
    variants = payload.get("variants") or payload.get("samples") or payload.get("cases")
    if not isinstance(variants, list):
        raise PackageError("Manifest lacks a variants/samples/cases list")
    expanded: set[str] = set()
    for variant_any in variants:
        if not isinstance(variant_any, dict):
            raise PackageError("Malformed variant in manifest")
        parent_id = str(
            variant_any.get("id")
            or variant_any.get("sample_id")
            or variant_any.get("candidate_id")
            or ""
        )
        if not parent_id:
            raise PackageError("Manifest variant lacks an identity")
        cases = variant_any.get("cases")
        if isinstance(cases, list) and cases:
            for case_index, case_any in enumerate(cases, 1):
                if not isinstance(case_any, dict):
                    raise PackageError(f"Malformed concrete case under manifest variant {parent_id}")
                case_id = str(
                    case_any.get("case_id")
                    or case_any.get("id")
                    or case_any.get("name")
                    or f"c{case_index:03d}"
                )
                sample_id = protocol._safe_sample_id(f"{parent_id}__{case_id}")
                if sample_id in expanded:
                    raise PackageError(f"Duplicate exploded manifest sample id: {sample_id}")
                expanded.add(sample_id)
        else:
            sample_id = protocol._safe_sample_id(parent_id)
            if sample_id in expanded:
                raise PackageError(f"Duplicate manifest sample id: {sample_id}")
            expanded.add(sample_id)
    return expanded


def _require_sha256(value: Any, label: str) -> str:
    digest = str(value)
    if not re.fullmatch(r"[0-9a-f]{64}", digest):
        raise PackageError(f"Invalid SHA256 for {label}: {value!r}")
    return digest


def _validate_vector_summary(
    value: Any, *, label: str, expected_length: int
) -> Dict[str, Any]:
    if not isinstance(value, dict):
        raise PackageError(f"Tokenizer report lacks vector summary {label}")
    if value.get("dtype_for_sha256") != "little-endian-float64":
        raise PackageError(f"Unexpected vector encoding for {label}")
    length = int(value.get("length", -1))
    nonzero = int(value.get("nonzero_count", -1))
    if length != expected_length or not 0 < nonzero <= length:
        raise PackageError(f"Invalid vector shape/nonzero count for {label}")
    total = float(value.get("sum", float("nan")))
    minimum = float(value.get("min", float("nan")))
    maximum = float(value.get("max", float("nan")))
    if not (
        abs(total - 1.0) <= 1e-9
        and minimum >= 0.0
        and maximum >= minimum
        and maximum <= 1.0
    ):
        raise PackageError(f"Invalid normalized-vector statistics for {label}")
    _require_sha256(value.get("sha256"), f"{label} vector")
    return value


def _validate_tokenizer_record_structure(record: Mapping[str, Any]) -> None:
    sample_id = str(record.get("sample_id", ""))
    prompt = record.get("prompt") or {}
    token_preflight = prompt.get("token_preflight") or {}
    slicing = record.get("slicing_prior") or {}
    hybrid = record.get("slice_hybrid") or {}
    helper = record.get("inference_helper_result") or {}
    token_count = int(prompt.get("token_count", -1))
    _require_sha256(prompt.get("token_ids_sha256"), f"{sample_id} token IDs")
    _require_sha256(prompt.get("token_strings_sha256"), f"{sample_id} token strings")
    context_limit = int(token_preflight.get("context_limit", -1))
    max_new_tokens = int(token_preflight.get("max_new_tokens", -1))
    margin = int(token_preflight.get("context_margin_tokens", -1))
    if (
        context_limit != 131072
        or max_new_tokens != int(protocol.GENERATION_DEFAULTS["max_new_tokens"])
        or margin != context_limit - token_count - max_new_tokens
        or token_preflight.get("fits_context") is not (margin >= 0)
    ):
        raise PackageError(f"Tokenizer context arithmetic is invalid for {sample_id}")

    actual = _validate_vector_summary(
        slicing.get("actual"), label=f"{sample_id} slicing actual", expected_length=token_count
    )
    fallback = _validate_vector_summary(
        slicing.get("normalized_positional_fallback"),
        label=f"{sample_id} slicing fallback",
        expected_length=token_count,
    )
    comparison = slicing.get("comparison") or {}
    fallback_detected = slicing.get("algorithm_fallback_detected") is True
    if (
        int(slicing.get("bin_index", -1)) != 0
        or int(slicing.get("n_bins", -1)) != 12
        or comparison.get("same_shape") is not True
        or (comparison.get("allclose") is True) != fallback_detected
        or (helper.get("algorithm_fallback_detected") is True) != fallback_detected
        or int(helper.get("algorithm_vector_length", -1)) != token_count
        or int(helper.get("fallback_vector_length", -1)) != token_count
        or int(helper.get("n_bins", -1)) != 12
        or (actual.get("sha256") == fallback.get("sha256")) != fallback_detected
    ):
        raise PackageError(f"Tokenizer SlicingPrior invariants are invalid for {sample_id}")
    if abs(
        float(helper.get("algorithm_vs_fallback_l1", float("nan")))
        - float(comparison.get("l1_distance", float("nan")))
    ) > 1e-12:
        raise PackageError(f"Tokenizer prior-distance fields disagree for {sample_id}")

    case_vectors = hybrid.get("case_vectors")
    if not isinstance(case_vectors, list) or len(case_vectors) != int(
        hybrid.get("case_vector_count", -1)
    ):
        raise PackageError(f"Tokenizer CASES vector count is invalid for {sample_id}")
    for index, summary in enumerate(case_vectors, 1):
        _validate_vector_summary(
            summary,
            label=f"{sample_id} CASES vector {index}",
            expected_length=token_count,
        )
    _validate_vector_summary(
        hybrid.get("hybrid_vector"),
        label=f"{sample_id} hybrid vector",
        expected_length=token_count,
    )
    parsed_ids = hybrid.get("parsed_case_ids")
    if (
        not isinstance(parsed_ids, list)
        or parsed_ids != helper.get("parsed_case_ids")
        or len(parsed_ids) != len(case_vectors)
        or int(helper.get("case_vector_count", -1)) != len(case_vectors)
        or (hybrid.get("case_signal_active") is True) != bool(parsed_ids)
        or (helper.get("case_signal_active") is True) != bool(parsed_ids)
    ):
        raise PackageError(f"Tokenizer CASES invariants are invalid for {sample_id}")


def _validate_tokenizer_evidence(
    report_path: Path,
    exclusions_path: Path,
    manifest_path: Path,
    result_roots: Sequence[Path],
) -> Dict[str, Any]:
    token_report = _read_json_object(report_path, "tokenizer preflight")
    token_manifest = _read_json_object(manifest_path, "tokenizer inference manifest")
    if token_report.get("schema_version") != "long-code-tokenizer-preflight-v1":
        raise PackageError("Unsupported tokenizer-preflight schema")
    records = token_report.get("records")
    if not isinstance(records, list):
        raise PackageError("Tokenizer preflight is missing its full denominator records")
    by_sample: Dict[str, Dict[str, Any]] = {}
    excluded_ids: List[str] = []
    for record_any in records:
        if not isinstance(record_any, dict):
            raise PackageError("Malformed tokenizer-preflight record")
        sample_id = _safe_component(record_any.get("sample_id", ""), "tokenizer sample id")
        if sample_id in by_sample:
            raise PackageError(f"Duplicate tokenizer-preflight sample id: {sample_id}")
        by_sample[sample_id] = record_any
        decision = record_any.get("decision") or {}
        eligible = decision.get("inference_eligible") is True
        helper = record_any.get("inference_helper_result") or {}
        prompt = record_any.get("prompt") or {}
        token_preflight = prompt.get("token_preflight") or {}
        slicing = record_any.get("slicing_prior") or {}
        hybrid = record_any.get("slice_hybrid") or {}
        prompt_text = prompt.get("text")
        if not isinstance(prompt_text, str):
            raise PackageError(f"Tokenizer record lacks exact prompt text: {sample_id}")
        prompt_hash = _sha256_bytes(prompt_text.encode("utf-8"))
        declared_prompt_hashes = {
            prompt.get("sha256"),
            helper.get("prompt_sha256"),
            token_preflight.get("prompt_sha256"),
        }
        if declared_prompt_hashes != {prompt_hash}:
            raise PackageError(f"Tokenizer prompt hashes disagree for {sample_id}")
        token_count = int(prompt.get("token_count", -1))
        if token_count <= 0 or int(token_preflight.get("prompt_token_count", -2)) != token_count:
            raise PackageError(f"Tokenizer prompt token counts disagree for {sample_id}")
        _validate_tokenizer_record_structure(record_any)
        markers = prompt.get("markers") or {}
        substantive_ok = bool(
            helper.get("algorithm_fallback_detected") is False
            and slicing.get("algorithm_fallback_detected") is False
            and (slicing.get("comparison") or {}).get("allclose") is False
            and helper.get("case_signal_active") is True
            and hybrid.get("case_signal_active") is True
            and int(helper.get("case_vector_count", 0)) > 0
            and int(hybrid.get("case_vector_count", 0)) > 0
            and token_preflight.get("fits_context") is True
            and int(token_preflight.get("context_margin_tokens", -1)) >= 0
            and markers.get("cases_begin_present") is True
            and markers.get("cases_end_present") is True
            and markers.get("c001_spec_present") is True
            and prompt.get("codesteer_instruction_equals_obfuscated_plain") is True
        )
        reasons = decision.get("exclusion_reasons") or []
        if eligible and (not substantive_ok or reasons):
            raise PackageError(f"Tokenizer-eligible record fails substantive gates: {sample_id}")
        if not eligible:
            excluded_ids.append(sample_id)
            if not reasons:
                raise PackageError(f"Tokenizer-excluded record lacks reasons: {sample_id}")

    counts = token_report.get("counts") or {}
    denominator_indices = [int(record.get("denominator_index", -1)) for record in records]
    if denominator_indices != list(range(1, len(records) + 1)):
        raise PackageError("Tokenizer denominator indices are not canonical manifest order")
    if int(counts.get("exploded_denominator_records", -1)) != len(records):
        raise PackageError("Tokenizer denominator count does not match its records")
    if int(counts.get("excluded_records", -1)) != len(excluded_ids):
        raise PackageError("Tokenizer exclusion count does not match its records")
    eligible_ids = set(by_sample) - set(excluded_ids)
    if int(counts.get("inference_eligible_records", -1)) != len(eligible_ids):
        raise PackageError("Tokenizer eligible count does not match its records")
    if int(counts.get("preflight_error_records", -1)) != 0:
        raise PackageError("Tokenizer preflight reports errors")

    exclusion_rows: List[Dict[str, Any]] = []
    for line_number, line in enumerate(exclusions_path.read_text(encoding="utf-8").splitlines(), 1):
        if not line.strip():
            continue
        try:
            row = json.loads(line)
        except Exception as exc:
            raise PackageError(f"Invalid tokenizer exclusion JSONL line {line_number}: {exc}") from exc
        if not isinstance(row, dict):
            raise PackageError(f"Tokenizer exclusion line {line_number} is not an object")
        exclusion_rows.append(row)
    exclusion_row_ids = sorted(str(row.get("sample_id", "")) for row in exclusion_rows)
    if exclusion_row_ids != sorted(excluded_ids):
        raise PackageError("Tokenizer exclusions JSONL does not match the full report")
    for row in exclusion_rows:
        sample_id = str(row["sample_id"])
        record = by_sample[sample_id]
        expected_row = {
            "schema_version": "long-code-tokenizer-preflight-v1",
            "denominator_index": record.get("denominator_index"),
            "sample_id": sample_id,
            "parent_variant_id": record.get("parent_variant_id"),
            "case_id": record.get("case_id"),
            "inference_eligible": False,
            "exclusion_reasons": (record.get("decision") or {}).get("exclusion_reasons"),
            "algorithm_fallback_detected": (record.get("slicing_prior") or {}).get(
                "algorithm_fallback_detected"
            ),
            "case_signal_active": (record.get("slice_hybrid") or {}).get(
                "case_signal_active"
            ),
            "error": record.get("error"),
        }
        if row != expected_row:
            raise PackageError(f"Tokenizer exclusion row is not canonical for {sample_id}")

    variants = token_manifest.get("variants")
    if not isinstance(variants, list):
        raise PackageError("Tokenizer inference manifest lacks a variants list")
    manifest_ids = _expanded_manifest_ids(token_manifest)
    if int(token_manifest.get("variant_count", -1)) != len(variants):
        raise PackageError("Tokenizer inference-manifest count does not match its variants")
    if manifest_ids != eligible_ids:
        raise PackageError(
            "Filtered inference manifest IDs do not exactly equal tokenizer-eligible IDs"
        )
    source_meta = token_report.get("source_manifest") or {}
    source_rel = Path(str(source_meta.get("path", "")))
    source_path = _resolve_existing_under(source_rel, HERE, "tokenizer source manifest", require_file=True)
    if _sha256_file(source_path) != source_meta.get("sha256"):
        raise PackageError("Tokenizer source-manifest SHA256 does not recompute")
    source_manifest = _read_json_object(source_path, "tokenizer source manifest")
    if _expanded_manifest_ids(source_manifest) != set(by_sample):
        raise PackageError("Tokenizer denominator IDs do not exactly equal source-manifest IDs")
    source_variants = source_manifest.get("variants") or []
    if int(source_manifest.get("variant_count", -1)) != len(source_variants):
        raise PackageError("Tokenizer source-manifest variant count is inconsistent")
    if int(counts.get("input_top_level_variants", -1)) != len(source_variants):
        raise PackageError("Tokenizer top-level denominator count is inconsistent")
    filtered_preflight = token_manifest.get("tokenizer_preflight") or {}
    if filtered_preflight.get("source_manifest_sha256") != source_meta.get("sha256"):
        raise PackageError("Filtered manifest does not bind the tokenizer source-manifest hash")
    if (
        filtered_preflight.get("schema_version") != "long-code-tokenizer-preflight-v1"
        or int(filtered_preflight.get("input_top_level_count", -1)) != len(source_variants)
        or int(filtered_preflight.get("retained_top_level_count", -1)) != len(variants)
        or int(filtered_preflight.get("retained_exploded_sample_count", -1))
        != len(eligible_ids)
        or filtered_preflight.get("full_report") != report_path.name
        or filtered_preflight.get("exclusions") != exclusions_path.name
    ):
        raise PackageError("Filtered manifest tokenizer-preflight metadata is inconsistent")

    tokenizer = token_report.get("tokenizer") or {}
    if tokenizer.get("model_id") != protocol.DEFAULT_MODEL_NAME:
        raise PackageError("Tokenizer report model identity differs from Qwen/Qwen2.5-14B")
    if tokenizer.get("snapshot_commit") != protocol.MODEL_SNAPSHOT_COMMIT:
        raise PackageError("Tokenizer report model snapshot differs from the registered commit")
    if int(tokenizer.get("model_max_length", 0)) != 131072:
        raise PackageError("Tokenizer context limit differs from the registered tokenizer")
    if (
        tokenizer.get("model_weights_loaded") is not False
        or tokenizer.get("padding_side") != "left"
        or (tokenizer.get("offline_environment") or {}).get("HF_HUB_OFFLINE") != "1"
        or (tokenizer.get("offline_environment") or {}).get("TRANSFORMERS_OFFLINE") != "1"
    ):
        raise PackageError("Tokenizer report does not prove offline tokenizer-only execution")
    snapshot_dir = Path(str(tokenizer.get("snapshot_dir_read_only_input", ""))).expanduser()
    if not snapshot_dir.is_dir() or snapshot_dir.name != protocol.MODEL_SNAPSHOT_COMMIT:
        raise PackageError(f"Registered tokenizer snapshot directory is unavailable: {snapshot_dir}")
    tokenizer_files = tokenizer.get("files") or {}
    if not isinstance(tokenizer_files, dict) or set(tokenizer_files) != TOKENIZER_REQUIRED_FILES:
        raise PackageError("Tokenizer report does not contain the exact five-file inventory")
    for name, info_any in sorted(tokenizer_files.items()):
        safe_name = _safe_component(name, "tokenizer filename")
        info = info_any if isinstance(info_any, dict) else {}
        path = snapshot_dir / safe_name
        if not path.is_file():
            raise PackageError(f"Registered tokenizer file is unavailable: {path}")
        if path.stat().st_size != int(info.get("bytes", -1)) or _sha256_file(path) != info.get("sha256"):
            raise PackageError(f"Registered tokenizer file hash/size mismatch: {safe_name}")

    filtered_hash = _sha256_file(manifest_path)
    bound_roots: List[Path] = []
    root_sample_ids: Dict[Path, set[str]] = {}
    configured_sample_union: set[str] = set()
    for root in result_roots:
        config = _read_json_object(root / "experiment_config.json", "experiment config")
        if config.get("manifest_sha256") != filtered_hash:
            continue
        bound_roots.append(root)
        raw_sample_ids = config.get("sample_ids")
        if not isinstance(raw_sample_ids, list) or not raw_sample_ids:
            raise PackageError(f"Experiment config lacks its exact sample-ID shard: {root}")
        configured_ids = {str(value) for value in raw_sample_ids}
        if len(configured_ids) != len(raw_sample_ids) or not configured_ids <= eligible_ids:
            raise PackageError(f"Experiment config sample IDs are invalid for tokenizer gate: {root}")
        overlap = configured_sample_union & configured_ids
        if overlap:
            raise PackageError(
                f"Tokenizer-gate sample IDs are configured in multiple result roots: {sorted(overlap)}"
            )
        configured_sample_union.update(configured_ids)
        root_sample_ids[root] = configured_ids
        if config.get("model_name") != protocol.DEFAULT_MODEL_NAME:
            raise PackageError(f"Experiment config model identity mismatch: {root}")
        if config.get("model_snapshot_commit") != protocol.MODEL_SNAPSHOT_COMMIT:
            raise PackageError(f"Experiment config model snapshot mismatch: {root}")
        config_token = ((config.get("manifest_metadata") or {}).get("tokenizer_preflight") or {})
        if config_token.get("source_manifest_sha256") != source_meta.get("sha256"):
            raise PackageError(f"Experiment config source-manifest hash mismatch: {root}")
        environment = _read_json_object(root / "environment.json", "experiment environment")
        if environment.get("model_snapshot_commit_registered") != protocol.MODEL_SNAPSHOT_COMMIT:
            raise PackageError(f"Environment registered model snapshot mismatch: {root}")
        if environment.get("model_snapshot_commit_cached_ref") != protocol.MODEL_SNAPSHOT_COMMIT:
            raise PackageError(f"Environment cached model snapshot mismatch: {root}")
        if environment.get("model_snapshot_commit_verified") is not True:
            raise PackageError(f"Environment did not verify model snapshot: {root}")
    if not bound_roots:
        raise PackageError(
            f"No audited experiment config binds filtered manifest hash {filtered_hash}"
        )
    if configured_sample_union != eligible_ids:
        raise PackageError(
            "Experiment-config sample-ID shards do not exactly cover their tokenizer gate"
        )
    return {
        "report": token_report,
        "manifest": token_manifest,
        "report_path": report_path,
        "exclusions_path": exclusions_path,
        "manifest_path": manifest_path,
        "source_manifest": source_manifest,
        "source_manifest_path": source_path,
        "source_manifest_sha256": source_meta.get("sha256"),
        "denominator_ids": set(by_sample),
        "eligible_ids": eligible_ids,
        "excluded_ids": set(excluded_ids),
        "bound_roots": set(bound_roots),
        "root_sample_ids": root_sample_ids,
        "filtered_manifest_sha256": filtered_hash,
        "tokenizer_snapshot_dir": snapshot_dir.resolve(),
    }


def _validate_tokenizer_evidence_union(
    evidence_sets: Sequence[Mapping[str, Any]],
    *,
    audited_sample_ids: Iterable[str],
    strict_sample_ids: Iterable[str],
    result_roots: Sequence[Path],
) -> None:
    if not evidence_sets:
        raise PackageError("At least one tokenizer evidence set is required")
    eligible_union: set[str] = set()
    denominator_union: set[str] = set()
    roots_union: set[Path] = set()
    for evidence in evidence_sets:
        eligible = set(evidence.get("eligible_ids") or set())
        denominator = set(evidence.get("denominator_ids") or set())
        bound_roots = set(evidence.get("bound_roots") or set())
        eligible_overlap = eligible_union & eligible
        denominator_overlap = denominator_union & denominator
        root_overlap = roots_union & bound_roots
        if eligible_overlap:
            raise PackageError(f"Tokenizer evidence eligible-ID sets overlap: {sorted(eligible_overlap)}")
        if denominator_overlap:
            raise PackageError(
                f"Tokenizer evidence denominator-ID sets overlap: {sorted(denominator_overlap)}"
            )
        if root_overlap:
            raise PackageError(f"Experiment roots bind multiple tokenizer evidence sets: {root_overlap}")
        eligible_union.update(eligible)
        denominator_union.update(denominator)
        roots_union.update(bound_roots)
    audited = set(str(value) for value in audited_sample_ids)
    strict = set(str(value) for value in strict_sample_ids)
    if eligible_union != audited:
        missing = sorted(audited - eligible_union)
        extra = sorted(eligible_union - audited)
        raise PackageError(
            f"Tokenizer eligible-ID union does not exactly equal audited IDs: missing={missing}, extra={extra}"
        )
    if not strict <= eligible_union:
        raise PackageError(
            f"Strict candidates missing from tokenizer evidence union: {sorted(strict - eligible_union)}"
        )
    if roots_union != set(result_roots):
        raise PackageError(
            "Tokenizer manifest bindings do not cover every audited result root exactly once"
        )


def _classify_tokenizer_evidence_sets(
    evidence_sets: Sequence[Mapping[str, Any]],
) -> Dict[str, Any]:
    """Accept only the registered contiguous one- through seven-gate layouts."""
    if not 1 <= len(evidence_sets) <= 7:
        raise PackageError(
            "Packaging requires one to seven registered tokenizer evidence sets"
        )
    classified: Dict[str, List[Mapping[str, Any]]] = {
        "initial": [],
        "supplemental": [],
        "balanced": [],
        "extension": [],
        "extension2": [],
    }
    for evidence in evidence_sets:
        source = evidence.get("source_manifest") or {}
        filtered = evidence.get("manifest") or {}
        schema = str(source.get("schema_version", ""))
        if str(filtered.get("schema_version", "")) != schema:
            raise PackageError(
                "Tokenizer source and filtered manifest schemas disagree: "
                f"{schema!r} != {filtered.get('schema_version')!r}"
            )
        if schema in {
            BALANCED_SOURCE_SCHEMA,
            BALANCED_EXTENSION_SOURCE_SCHEMA,
            BALANCED_EXTENSION2_SOURCE_SCHEMA,
        } and (
            filtered.get("wave_id") != source.get("wave_id")
        ):
            raise PackageError("Balanced source and filtered manifest wave IDs disagree")
        if schema == INITIAL_SOURCE_SCHEMA:
            classified["initial"].append(evidence)
        elif schema == SUPPLEMENTAL_SOURCE_SCHEMA:
            classified["supplemental"].append(evidence)
        elif schema == BALANCED_SOURCE_SCHEMA:
            classified["balanced"].append(evidence)
        elif schema == BALANCED_EXTENSION_SOURCE_SCHEMA:
            classified["extension"].append(evidence)
        elif schema == BALANCED_EXTENSION2_SOURCE_SCHEMA:
            classified["extension2"].append(evidence)
        else:
            raise PackageError(f"Unregistered tokenizer source-manifest schema: {schema!r}")

    expected = {
        1: (1, 0, 0, 0, 0),
        2: (1, 1, 0, 0, 0),
        3: (1, 1, 1, 0, 0),
        4: (1, 1, 2, 0, 0),
        5: (1, 1, 2, 1, 0),
        6: (1, 1, 2, 1, 1),
        7: (1, 1, 2, 1, 2),
    }[len(evidence_sets)]
    observed = tuple(
        len(classified[name])
        for name in (
            "initial",
            "supplemental",
            "balanced",
            "extension",
            "extension2",
        )
    )
    if observed != expected:
        raise PackageError(
            "Tokenizer evidence layout must be initial only; initial+supplemental; or "
            "initial+supplemental plus contiguous balanced Waves 1/2 and optional adaptive "
            "Waves 3/4/5 (observed initial/supplemental/balanced/extension/extension2="
            f"{observed})"
        )
    balanced_wave_ids = sorted(
        str((evidence.get("source_manifest") or {}).get("wave_id", ""))
        for evidence in classified["balanced"]
    )
    expected_wave_ids = {
        0: [],
        1: ["balanced_wave_1"],
        2: ["balanced_wave_1", "balanced_wave_2"],
    }[len(classified["balanced"])]
    if balanced_wave_ids != expected_wave_ids:
        raise PackageError(
            "Balanced tokenizer gates must be contiguous Wave 1 then optional Wave 2"
        )
    extension_wave_ids = [
        str((evidence.get("source_manifest") or {}).get("wave_id", ""))
        for evidence in classified["extension"]
    ]
    if extension_wave_ids not in ([], ["balanced_wave_3"]):
        raise PackageError("Adaptive extension tokenizer gate must be exactly balanced_wave_3")
    extension2_by_wave: Dict[str, Mapping[str, Any]] = {}
    for evidence in classified["extension2"]:
        wave_id = str((evidence.get("source_manifest") or {}).get("wave_id", ""))
        if wave_id in extension2_by_wave:
            raise PackageError("Second adaptive extension repeats a tokenizer wave")
        extension2_by_wave[wave_id] = evidence
    extension2_wave_ids = sorted(extension2_by_wave)
    if extension2_wave_ids not in (
        [],
        ["balanced_wave_4"],
        ["balanced_wave_4", "balanced_wave_5"],
    ):
        raise PackageError(
            "Second adaptive extension tokenizer gates must be contiguous Wave 4 then "
            "optional Wave 5"
        )
    return {
        "initial": classified["initial"][0],
        "supplemental": (
            classified["supplemental"][0] if classified["supplemental"] else None
        ),
        "balanced": list(classified["balanced"]),
        "extension": (
            classified["extension"][0] if classified["extension"] else None
        ),
        "extension2": [extension2_by_wave[wave_id] for wave_id in extension2_wave_ids],
    }


def _validate_supplemental_disclosure(
    evidence_sets: Sequence[Mapping[str, Any]],
) -> Optional[Dict[str, Any]]:
    classified = _classify_tokenizer_evidence_sets(evidence_sets)
    supplemental = classified["supplemental"]
    if supplemental is None:
        return None
    disclosure = dict(supplemental.get("source_manifest") or {})
    checks = {
        "frozen_source_denominator": disclosure.get("frozen_source_denominator") == 25,
        "source_denominator_unchanged": disclosure.get(
            "supplemental_cases_change_source_denominator"
        )
        is False,
        "outcome_blind": isinstance(disclosure.get("outcome_blind_disclosure"), str)
        and "without reading or using any model response" in disclosure["outcome_blind_disclosure"],
        "timing_disclosed": isinstance(disclosure.get("timing_disclosure"), str)
        and "before that screen completed" in disclosure["timing_disclosure"],
        "selected_case_count": int(disclosure.get("selected_supplemental_case_count", -1))
        == 60,
    }
    failed = [name for name, ok in checks.items() if not ok]
    if failed:
        raise PackageError(f"Supplemental outcome-blind/timing disclosure invalid: {failed}")
    return {
        "frozen_source_denominator": 25,
        "supplemental_cases_change_source_denominator": False,
        "outcome_blind_disclosure": disclosure["outcome_blind_disclosure"],
        "timing_disclosure": disclosure["timing_disclosure"],
        "selected_supplemental_case_count": 60,
    }


def _frozen_relative_path(value: Any, label: str) -> Path:
    text = str(value)
    relative = Path(text)
    if (
        not text
        or relative.is_absolute()
        or any(part in {"", ".", ".."} for part in relative.parts)
        or relative.as_posix() != text.replace("\\", "/")
    ):
        raise PackageError(f"Unsafe {label} path in balanced freeze: {value!r}")
    return relative


def _validate_balanced_freeze(
    balanced_root: Path,
) -> Tuple[Dict[str, Any], Dict[str, Dict[str, Any]], Dict[str, Any]]:
    """Recompute the external anchor, exact generated inventory, and controls."""
    freeze_path = _resolve_existing_under(
        balanced_root / "freeze_manifest.json",
        balanced_root,
        "balanced freeze manifest",
        require_file=True,
    )
    anchor_path = _resolve_existing_under(
        balanced_root / "FREEZE.sha256",
        balanced_root,
        "balanced freeze anchor",
        require_file=True,
    )
    freeze_hash = _sha256_file(freeze_path)
    if freeze_hash != BALANCED_FREEZE_MANIFEST_SHA256:
        raise PackageError(
            "Balanced freeze manifest differs from the registered immutable SHA256"
        )
    if anchor_path.read_text(encoding="utf-8") != f"{freeze_hash}  freeze_manifest.json\n":
        raise PackageError("Balanced FREEZE.sha256 does not exactly anchor freeze_manifest.json")
    freeze = _read_json_object(freeze_path, "balanced freeze manifest")
    if (
        freeze.get("schema_version") != BALANCED_FREEZE_SCHEMA
        or freeze.get("state") != "frozen_not_launched"
    ):
        raise PackageError("Balanced freeze schema/state is not the registered frozen contract")

    generated_rows = freeze.get("generated_files")
    if not isinstance(generated_rows, list) or not generated_rows:
        raise PackageError("Balanced freeze lacks its generated-file inventory")
    inventory: Dict[str, Dict[str, Any]] = {}
    for row_any in generated_rows:
        row = row_any if isinstance(row_any, dict) else {}
        relative = _frozen_relative_path(row.get("path", ""), "generated artifact")
        key = relative.as_posix()
        if key in inventory or relative.name in {"freeze_manifest.json", "FREEZE.sha256"}:
            raise PackageError(f"Duplicate/reserved balanced generated-file entry: {key}")
        path = _resolve_existing_under(
            balanced_root / relative,
            balanced_root,
            f"balanced generated artifact {key}",
            require_file=True,
        )
        if path.stat().st_size != int(row.get("bytes", -1)) or _sha256_file(path) != row.get(
            "sha256"
        ):
            raise PackageError(f"Balanced generated artifact hash/size mismatch: {key}")
        inventory[key] = dict(row)

    actual_files: set[str] = set()
    for path in sorted(balanced_root.rglob("*"), key=lambda item: item.as_posix()):
        if path.is_symlink():
            raise PackageError(f"Symlinks are not accepted in balanced evidence: {path}")
        if path.is_dir():
            continue
        if not path.is_file():
            raise PackageError(f"Non-regular balanced evidence entry: {path}")
        if path.name not in {"freeze_manifest.json", "FREEZE.sha256"}:
            actual_files.add(path.relative_to(balanced_root).as_posix())
    if set(inventory) != actual_files:
        raise PackageError(
            "Balanced generated-file inventory is not exact: "
            f"missing={sorted(actual_files - set(inventory))}, "
            f"extra={sorted(set(inventory) - actual_files)}"
        )

    control_rows = freeze.get("control_files")
    if not isinstance(control_rows, list):
        raise PackageError("Balanced freeze lacks its control-file inventory")
    controls: Dict[str, Dict[str, Any]] = {}
    work_root = balanced_root.parent
    for row_any in control_rows:
        row = row_any if isinstance(row_any, dict) else {}
        relative = _frozen_relative_path(row.get("path", ""), "control file")
        key = relative.as_posix()
        if key in controls:
            raise PackageError(f"Duplicate balanced control-file entry: {key}")
        path = _resolve_existing_under(
            work_root / relative,
            work_root,
            f"balanced control file {key}",
            require_file=True,
        )
        if path.stat().st_size != int(row.get("bytes", -1)) or _sha256_file(path) != row.get(
            "sha256"
        ):
            raise PackageError(f"Balanced control-file hash/size mismatch: {key}")
        controls[key] = dict(row)
    if set(controls) != BALANCED_REQUIRED_CONTROL_FILES:
        raise PackageError(
            "Balanced control-file inventory is not the registered ten-file set: "
            f"{sorted(controls)}"
        )

    invariants = freeze.get("invariants") or {}
    expected_invariants = {
        "wave_1_cases": BALANCED_CASES_PER_WAVE,
        "wave_2_cases": BALANCED_CASES_PER_WAVE,
        "canonical_problems_per_wave": BALANCED_PROBLEMS_PER_WAVE,
        "cases_per_problem_per_wave": 2,
        "waves_disjoint": True,
        "overlap_with_previous_screens": 0,
        "tokenizer_exclusions": 0,
        "model_weights_loaded": False,
        "model_inference_calls": 0,
        "result_roots_created": False,
    }
    failed = [name for name, value in expected_invariants.items() if invariants.get(name) != value]
    if failed:
        raise PackageError(f"Balanced freeze invariants are invalid: {failed}")

    protocol_path = _resolve_existing_under(
        work_root / BALANCED_PROTOCOL_JSON,
        work_root,
        "balanced protocol JSON",
        require_file=True,
    )
    protocol_payload = _read_json_object(protocol_path, "balanced protocol")
    trigger = protocol_payload.get("trigger") or {}
    population = protocol_payload.get("immutable_population") or {}
    reporting = protocol_payload.get("reporting") or {}
    inference = protocol_payload.get("inference") or {}
    waves = protocol_payload.get("waves")
    expected_waves = [
        {
            "wave_id": "balanced_wave_1",
            "accepted_ranks_per_problem": [1, 2],
            "canonical_problem_count": BALANCED_PROBLEMS_PER_WAVE,
            "case_count": BALANCED_CASES_PER_WAVE,
        },
        {
            "wave_id": "balanced_wave_2",
            "accepted_ranks_per_problem": [3, 4],
            "canonical_problem_count": BALANCED_PROBLEMS_PER_WAVE,
            "case_count": BALANCED_CASES_PER_WAVE,
        },
    ]
    timing = protocol_payload.get("timing_disclosure")
    protocol_checks = {
        "schema": protocol_payload.get("schema_version") == BALANCED_SOURCE_SCHEMA,
        "timing": isinstance(timing, str)
        and "before corrected supplemental model outputs or scores were inspected" in timing,
        "complete_audit_trigger": trigger.get("audit_must_be_complete_and_valid") is True,
        "wave_1_threshold": trigger.get("run_wave_1_when_metric_below") == 10,
        "wave_2_threshold": trigger.get("run_wave_2_when_post_wave_1_metric_below") == 10,
        "no_interim_looks": trigger.get("interim_looks_within_wave_allowed") is False,
        "source_denominator": population.get("frozen_source_denominator") == 25,
        "eligible_sources": population.get("tokenizer_eligible_source_count") == 23,
        "canonical_problems": population.get("canonical_problem_count")
        == BALANCED_PROBLEMS_PER_WAVE,
        "waves": waves == expected_waves,
        "outcome_selected_reporting": reporting.get("case_finding_is_outcome_selected") is True,
        "retain_pool": reporting.get("retain_complete_screened_pool") is True,
        "no_pass_at_k": reporting.get("display_pass_at_k") is False,
        "model": inference.get("model_id") == protocol.DEFAULT_MODEL_NAME,
        "trials": inference.get("trials_per_case") == 3,
        "conditions": inference.get("conditions") == list(ALL_CONDITIONS),
        "base_seed": inference.get("base_seed") == 20260713,
    }
    failed_protocol = [name for name, ok in protocol_checks.items() if not ok]
    if failed_protocol:
        raise PackageError(f"Balanced trigger/timing/reporting protocol is invalid: {failed_protocol}")
    if controls[BALANCED_PROTOCOL_JSON].get("sha256") != _sha256_file(protocol_path):
        raise PackageError("Balanced protocol JSON is not bound by the control inventory")
    return freeze, inventory, protocol_payload


def _validate_balanced_extension_freeze(
    extension_root: Path,
    *,
    external_anchor_path: Optional[Path] = None,
) -> Tuple[Dict[str, Any], Dict[str, Dict[str, Any]], Dict[str, Any]]:
    """Fail closed on both Wave-3 anchors, its exact inventory, and protocol."""
    freeze_path = _resolve_existing_under(
        extension_root / "freeze_manifest.json",
        extension_root,
        "balanced extension freeze manifest",
        require_file=True,
    )
    internal_anchor = _resolve_existing_under(
        extension_root / "FREEZE.sha256",
        extension_root,
        "balanced extension internal freeze anchor",
        require_file=True,
    )
    work_root = extension_root.parent
    external_anchor = _resolve_existing_under(
        external_anchor_path or work_root / BALANCED_EXTENSION_EXTERNAL_ANCHOR.name,
        work_root,
        "balanced extension external freeze anchor",
        require_file=True,
    )
    freeze_hash = _sha256_file(freeze_path)
    if freeze_hash != BALANCED_EXTENSION_FREEZE_MANIFEST_SHA256:
        raise PackageError(
            "Balanced extension freeze manifest differs from the registered immutable SHA256"
        )
    if internal_anchor.read_text(encoding="utf-8") != (
        f"{freeze_hash}  freeze_manifest.json\n"
    ):
        raise PackageError("Balanced extension internal FREEZE.sha256 is invalid")
    if external_anchor.read_text(encoding="utf-8") != (
        f"{freeze_hash}  balanced_extension_contingency/freeze_manifest.json\n"
    ):
        raise PackageError("Balanced extension external freeze anchor is invalid")

    freeze = _read_json_object(freeze_path, "balanced extension freeze manifest")
    if (
        freeze.get("schema_version") != BALANCED_EXTENSION_FREEZE_SCHEMA
        or freeze.get("state") != "frozen_not_launched"
    ):
        raise PackageError("Balanced extension freeze schema/state is invalid")

    generated_rows = freeze.get("generated_files")
    if not isinstance(generated_rows, list) or not generated_rows:
        raise PackageError("Balanced extension freeze lacks generated files")
    inventory: Dict[str, Dict[str, Any]] = {}
    for row_any in generated_rows:
        row = row_any if isinstance(row_any, dict) else {}
        relative = _frozen_relative_path(row.get("path", ""), "extension artifact")
        key = relative.as_posix()
        if key in inventory or relative.name in {"freeze_manifest.json", "FREEZE.sha256"}:
            raise PackageError(f"Duplicate/reserved extension artifact entry: {key}")
        path = _resolve_existing_under(
            extension_root / relative,
            extension_root,
            f"balanced extension artifact {key}",
            require_file=True,
        )
        if path.stat().st_size != int(row.get("bytes", -1)) or _sha256_file(path) != row.get(
            "sha256"
        ):
            raise PackageError(f"Balanced extension artifact hash/size mismatch: {key}")
        inventory[key] = dict(row)

    actual_files: set[str] = set()
    for path in sorted(extension_root.rglob("*"), key=lambda item: item.as_posix()):
        if path.is_symlink():
            raise PackageError(f"Symlinks are not accepted in extension evidence: {path}")
        if path.is_dir():
            continue
        if not path.is_file():
            raise PackageError(f"Non-regular extension evidence entry: {path}")
        if path.name not in {"freeze_manifest.json", "FREEZE.sha256"}:
            actual_files.add(path.relative_to(extension_root).as_posix())
    if set(inventory) != actual_files:
        raise PackageError(
            "Balanced extension generated-file inventory is not exact: "
            f"missing={sorted(actual_files - set(inventory))}, "
            f"extra={sorted(set(inventory) - actual_files)}"
        )

    control_rows = freeze.get("control_files")
    if not isinstance(control_rows, list):
        raise PackageError("Balanced extension freeze lacks control files")
    controls: Dict[str, Dict[str, Any]] = {}
    for row_any in control_rows:
        row = row_any if isinstance(row_any, dict) else {}
        relative = _frozen_relative_path(row.get("path", ""), "extension control file")
        key = relative.as_posix()
        if key in controls:
            raise PackageError(f"Duplicate extension control-file entry: {key}")
        path = _resolve_existing_under(
            work_root / relative,
            work_root,
            f"balanced extension control file {key}",
            require_file=True,
        )
        if path.stat().st_size != int(row.get("bytes", -1)) or _sha256_file(path) != row.get(
            "sha256"
        ):
            raise PackageError(f"Balanced extension control hash/size mismatch: {key}")
        controls[key] = dict(row)
    if set(controls) != BALANCED_EXTENSION_REQUIRED_CONTROL_FILES:
        raise PackageError(
            "Balanced extension control inventory is not the registered twelve-file set"
        )

    invariants = freeze.get("invariants") or {}
    expected_invariants = {
        "adaptive_not_preregistered": True,
        "outcome_blind_in_timing": False,
        "case_ranking_outcome_independent": True,
        "wave_3_cases": BALANCED_EXTENSION_CASES,
        "canonical_problems": BALANCED_EXTENSION_PROBLEMS,
        "cases_per_problem": BALANCED_EXTENSION_CASES_PER_PROBLEM,
        "accepted_ranks_per_problem": list(BALANCED_EXTENSION_ACCEPTED_RANKS),
        "overlap_with_initial_supplemental_wave_1_wave_2": 0,
        "tokenizer_exclusions": 0,
        "model_weights_loaded": False,
        "model_inference_calls": 0,
        "model_result_files_read_by_preparer_or_finalizer": 0,
        "result_roots_created": False,
        "shard_case_counts": list(BALANCED_EXTENSION_SHARD_SIZES),
        "shard_expected_run_records": list(BALANCED_EXTENSION_SHARD_RECORDS),
        "expected_run_records": BALANCED_EXTENSION_RECORDS,
    }
    failed = [name for name, value in expected_invariants.items() if invariants.get(name) != value]
    if failed:
        raise PackageError(f"Balanced extension freeze invariants are invalid: {failed}")

    protocol_path = _resolve_existing_under(
        work_root / BALANCED_EXTENSION_PROTOCOL_JSON,
        work_root,
        "balanced extension protocol JSON",
        require_file=True,
    )
    if _sha256_file(protocol_path) != BALANCED_EXTENSION_PROTOCOL_SHA256:
        raise PackageError("Balanced extension protocol differs from its registered SHA256")
    if controls[BALANCED_EXTENSION_PROTOCOL_JSON].get("sha256") != _sha256_file(protocol_path):
        raise PackageError("Balanced extension protocol is not bound by the control inventory")
    protocol_payload = _read_json_object(protocol_path, "balanced extension protocol")
    trigger = protocol_payload.get("trigger") or {}
    population = protocol_payload.get("immutable_population") or {}
    case_selection = protocol_payload.get("case_selection") or {}
    wave = protocol_payload.get("wave") or {}
    tokenizer_gate = protocol_payload.get("tokenizer_gate") or {}
    inference = protocol_payload.get("inference") or {}
    reporting = protocol_payload.get("reporting") or {}
    status = protocol_payload.get("status") or {}
    timing = str(protocol_payload.get("timing_disclosure", ""))
    adaptive = str(protocol_payload.get("adaptive_status_disclosure", ""))
    preparation = str(protocol_payload.get("preparation_read_disclosure", ""))
    protocol_checks = {
        "schema": protocol_payload.get("schema_version") == BALANCED_EXTENSION_SOURCE_SCHEMA,
        "adaptive": status.get("adaptive") is True,
        "not_preregistered": status.get("preregistered") is False,
        "not_outcome_blind_timing": status.get("outcome_blind_in_timing") is False,
        "outcome_independent_ranking": status.get(
            "case_eligibility_ranking_selection_outcome_independent"
        )
        is True,
        "timing_look": "aggregate interim results-index exact-count look" in timing,
        "timing_codesteer_zero": "zero exact CodeSteer trials" in timing,
        "timing_baseline_ids": "identifiers of samples with baseline exact matches" in timing,
        "adaptive_text": "not preregistered" in adaptive
        and "not outcome-blind in timing" in adaptive,
        "static_preparation": "read no inference result files" in preparation,
        "complete_trigger": trigger.get("audit_must_be_complete_and_valid") is True,
        "threshold": trigger.get("run_wave_3_only_when_complete_post_wave_2_metric_below") == 10,
        "no_wave_interim": trigger.get("interim_looks_within_wave_allowed") is False,
        "freeze_before_trigger": trigger.get("selection_and_tokenizer_freeze_precede_trigger_evaluation")
        is True,
        "source_denominator": population.get("frozen_source_denominator") == 25,
        "eligible_sources": population.get("tokenizer_eligible_source_count") == 23,
        "canonical_problems": population.get("canonical_problem_count")
        == BALANCED_EXTENSION_PROBLEMS,
        "public_absent": case_selection.get("public_tests_policy")
        == "not loaded, inspected, ranked, or selected",
        "continued_ranks": case_selection.get("continuation_rule")
        == (
            "reconstruct the prior deterministic ranking, verify frozen accepted ranks 1-4 "
            "exactly, and retain the next six JDK-valid and tokenizer-eligible cases as "
            "accepted ranks 5-10"
        ),
        "wave_id": wave.get("wave_id") == "balanced_wave_3",
        "wave_ranks": wave.get("accepted_ranks_per_problem")
        == list(BALANCED_EXTENSION_ACCEPTED_RANKS),
        "wave_count": wave.get("case_count") == BALANCED_EXTENSION_CASES,
        "tokenizer_model": tokenizer_gate.get("model_id") == protocol.DEFAULT_MODEL_NAME,
        "tokenizer_snapshot": tokenizer_gate.get("snapshot_commit")
        == protocol.MODEL_SNAPSHOT_COMMIT,
        "weights_absent": tokenizer_gate.get("model_weights_loaded") is False,
        "inference_model": inference.get("model_id") == protocol.DEFAULT_MODEL_NAME,
        "trials": inference.get("trials_per_case") == 3,
        "conditions": inference.get("conditions") == list(ALL_CONDITIONS),
        "shards": inference.get("shard_case_counts")
        == list(BALANCED_EXTENSION_SHARD_SIZES),
        "records": inference.get("expected_run_records") == BALANCED_EXTENSION_RECORDS,
        "outcome_selected_reporting": reporting.get("case_finding_is_outcome_selected") is True,
        "retain_pool": reporting.get("retain_complete_screened_pool") is True,
        "no_pass_at_k": reporting.get("display_pass_at_k") is False,
    }
    failed_protocol = [name for name, ok in protocol_checks.items() if not ok]
    if failed_protocol:
        raise PackageError(
            f"Balanced extension protocol/disclosures are invalid: {failed_protocol}"
        )
    return freeze, inventory, protocol_payload


def _validate_balanced_extension2_packaging_disclosure(
    work_root: Path,
) -> Dict[str, Any]:
    """Bind the post-freeze filename-listing incident without overstating its scope."""
    path = _resolve_existing_under(
        work_root / BALANCED_EXTENSION2_PACKAGING_DISCLOSURE,
        work_root,
        "balanced Extension-2 packaging execution disclosure",
        require_file=True,
    )
    raw = path.read_bytes()
    digest = _sha256_bytes(raw)
    if digest != BALANCED_EXTENSION2_PACKAGING_DISCLOSURE_SHA256:
        raise PackageError(
            "Balanced Extension-2 packaging execution disclosure differs from its "
            "registered SHA256"
        )
    payload = _read_json_object(
        path, "balanced Extension-2 packaging execution disclosure"
    )
    expected_flags = {
        "result_path_names_listed": True,
        "result_file_contents_read": False,
        "result_progress_inspected": False,
        "model_outcomes_inspected_or_used": False,
        "frozen_extension2_package_modified": False,
        "cases_or_settings_modified": False,
        "ongoing_run_modified": False,
        "sequential_triggers_or_launch_decisions_modified": False,
        "filesystem_mutation_by_incident_command": False,
    }
    failed = [
        name for name, expected in expected_flags.items()
        if payload.get(name) is not expected
    ]
    command = (
        "rg --files | rg 'extension2.*disclos|disclos.*extension2|"
        "balanced_extension2' | head -n 80"
    )
    disclosure = str(payload.get("disclosure", ""))
    required_phrases = (
        "filename-only search",
        "listed path names",
        "No inference-result file content",
        "did not alter frozen cases",
        "sequential trigger or launch decision",
    )
    if (
        payload.get("schema_version")
        != BALANCED_EXTENSION2_PACKAGING_DISCLOSURE_SCHEMA
        or failed
        or payload.get("command") != command
        or payload.get("incident_time_is_approximate") is not True
        or not isinstance(payload.get("incident_time_local_approximate"), str)
        or not isinstance(payload.get("recorded_at_local"), str)
        or Path(str(payload.get("working_directory", ""))).resolve()
        != HERE.resolve()
        or any(phrase not in disclosure for phrase in required_phrases)
    ):
        raise PackageError(
            "Balanced Extension-2 packaging execution disclosure is incomplete or "
            f"inaccurate: flags={failed}"
        )
    return {
        **payload,
        "sha256": digest,
        "package_local_path": (
            "screened_pool/balanced_extension2_execution_evidence/"
            f"{BALANCED_EXTENSION2_PACKAGING_DISCLOSURE}"
        ),
        "outside_prelaunch_freeze": True,
    }


def _validate_balanced_extension2_refinement_disclosure(
    work_root: Path,
) -> Dict[str, Any]:
    """Bind the outcome-aware paired-trial interpretation adopted after Wave 3."""
    path = _resolve_existing_under(
        work_root / BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE,
        work_root,
        "balanced Extension-2 paired-trial refinement disclosure",
        require_file=True,
    )
    raw = path.read_bytes()
    digest = _sha256_bytes(raw)
    if digest != BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE_SHA256:
        raise PackageError(
            "Balanced Extension-2 paired-trial refinement disclosure differs from its "
            "registered SHA256"
        )
    payload = _read_json_object(
        path, "balanced Extension-2 paired-trial refinement disclosure"
    )
    observed = payload.get("observed_complete_wave_3_paired_audit") or {}
    eligibility = payload.get("paired_trial_eligibility") or {}
    selection = payload.get("publication_selection") or {}
    trigger = payload.get("sequential_trigger_refinement") or {}
    requested = str(payload.get("requested_interpretation", ""))
    timing = str(payload.get("timing", ""))
    checks = {
        "schema": payload.get("schema_version")
        == BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE_SCHEMA,
        "after_wave3": "after the complete valid Wave-3 audit" in timing,
        "before_wave4_use": "before any packaging use of complete Wave-4 outcomes" in timing,
        "user_requested": "The user requested" in requested,
        "concrete_input": "distinct concrete input (sample_id)" in requested,
        "not_ten_problems": "rather than a distinct canonical problem" in requested,
        "observed_complete": observed.get("complete_and_valid") is True,
        "observed_nine": observed.get("paired_eligible_distinct_sample_id_count") == 9,
        "observed_four_problems": observed.get("distinct_canonical_problem_count") == 4,
        "codesteer_exact": "trimmed-exact" in str(eligibility.get("codesteer", ""))
        and "marker_json" in str(eligibility.get("codesteer", "")),
        "same_trial_baselines": "same trial and paired seed"
        in str(eligibility.get("baselines", ""))
        and "all valid and non-exact" in str(eligibility.get("baselines", "")),
        "other_trials_allowed": "may be exact on other trials"
        in str(eligibility.get("other_trials", "")),
        "ten_samples": selection.get("required_distinct_sample_id_count") == CASE_COUNT,
        "repeats_allowed": selection.get("canonical_problem_repeats_allowed") is True,
        "report_actual": selection.get("report_actual_distinct_canonical_problem_count")
        is True,
        "manual_review": selection.get(
            "manual_reasoning_grounding_and_baseline_failure_notes_required"
        )
        is True,
        "wave4": "count is 9, below 10" in str(trigger.get("wave_4", "")),
        "wave5_complete": "After Wave 4 completes" in str(trigger.get("wave_5", "")),
        "wave5_stop": "at least 10" in str(trigger.get("wave_5", "")),
        "wave5_continue": "only when that complete count remains below 10"
        in str(trigger.get("wave_5", "")),
        "no_interim": trigger.get("interim_wave_4_outcomes_may_determine_wave_5")
        is False,
        "adaptive": payload.get("adaptive") is True,
        "outcome_aware": payload.get("outcome_aware") is True,
        "post_hoc": payload.get("post_hoc") is True,
        "not_preregistered": payload.get("preregistered") is False,
        "not_outcome_blind": payload.get("outcome_blind_in_timing") is False,
        "cases_unchanged": payload.get(
            "frozen_extension2_cases_or_inference_settings_changed"
        )
        is False,
        "run_unchanged": payload.get("ongoing_wave_4_run_changed") is False,
        "no_pass_at_k": payload.get("display_pass_at_k") is False,
        "no_generalization_claim": payload.get(
            "aggregate_performance_or_ten_problem_generalization_claim_supported"
        )
        is False,
    }
    failed = [name for name, ok in checks.items() if not ok]
    if failed:
        raise PackageError(
            f"Balanced Extension-2 paired-trial refinement disclosure is invalid: {failed}"
        )
    return {
        **payload,
        "sha256": digest,
        "package_local_path": (
            "screened_pool/balanced_extension2_execution_evidence/"
            f"{BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE}"
        ),
        "outside_prelaunch_freeze": True,
    }


def _validate_balanced_extension2_failure_archive(
    *,
    extension_root: Path,
    inventory: Mapping[str, Mapping[str, Any]],
    missing_rank: int,
) -> Dict[str, Any]:
    """Validate one preserved failed larger design and its external archive copy."""
    if missing_rank not in {20, 25}:
        raise PackageError(f"Unsupported Extension-2 feasibility rank: {missing_rank}")
    label = f"rank{missing_rank}"
    audit_relative = f"{label}_feasibility_failure_audit.json"
    evidence_relative = f"{label}_feasibility_failure"
    audit_path = _resolve_existing_under(
        extension_root / audit_relative,
        extension_root,
        f"balanced Extension-2 rank-{missing_rank} failure audit",
        require_file=True,
    )
    expected_audit_hash = BALANCED_EXTENSION2_FAILURE_AUDIT_SHA256[missing_rank]
    if (
        _sha256_file(audit_path) != expected_audit_hash
        or inventory.get(audit_relative, {}).get("sha256") != expected_audit_hash
    ):
        raise PackageError(
            f"Balanced Extension-2 rank-{missing_rank} failure audit is not frozen"
        )
    audit = _read_json_object(
        audit_path, f"balanced Extension-2 rank-{missing_rank} failure audit"
    )
    expected_top_level = {
        "schema_version",
        "failure",
        "evidence_root",
        "external_preserved_archive",
        "evidence_file_count",
        "evidence_inventory_sha256",
        "evidence_files",
        "model_result_files_read",
        "wave_3_result_files_read",
        "model_inference_calls",
    }
    if missing_rank == 25:
        expected_top_level.update({"original_proposal", "prospective_revision"})
        expected_schema = (
            "long-code-balanced-extension2-rank25-feasibility-failure-v1"
        )
        expected_failure = {
            "row_index": 27,
            "variant_id": (
                "cc-valid-r027-s0184-1553-d-backspace__t5_easy_seed1"
            ),
            "statically_eligible_candidate_count": 202,
            "jdk_executed_candidate_count": 202,
            "accepted_rank_count": 24,
            "prior_frozen_accepted_rank_count": 10,
            "new_accepted_rank_count": 14,
            "missing_accepted_rank": 25,
            "exact_19_by_5_possible": False,
            "preparer_exit_message": (
                "FAIL CLOSED: row 27 supplied accepted_count=24, new cases=14; "
                "exact ranks 11--25 are required"
            ),
        }
        if audit.get("original_proposal") != {
            "wave_6_accepted_ranks_per_problem": [21, 22, 23, 24, 25],
            "cases_per_problem": 5,
            "case_count": 95,
        } or audit.get("prospective_revision") != {
            "wave_6_accepted_ranks_per_problem": [21, 22, 23, 24],
            "cases_per_problem": 4,
            "case_count": 76,
            "largest_uniform_block_across_same_19_problems": True,
            "specified_before_any_wave_3_output_or_result_inspection": True,
        }:
            raise PackageError(
                "Balanced Extension-2 rank-25 failure/revision disclosure is invalid"
            )
        expected_count = 641
        limiting_row = 27
        accepted_count = 24
    else:
        expected_top_level.update({"failed_design", "prospective_final_design"})
        expected_schema = (
            "long-code-balanced-extension2-rank20-feasibility-failure-v1"
        )
        expected_failure = {
            "row_index": 54,
            "variant_id": (
                "cc-valid-r054-s0229-1557-c-moamen-and-xor__t5_easy_seed1"
            ),
            "statically_eligible_candidate_count": 255,
            "jdk_executed_candidate_count": 255,
            "accepted_rank_count": 19,
            "prior_frozen_accepted_rank_count": 10,
            "new_accepted_rank_count": 9,
            "missing_accepted_rank": 20,
            "exact_wave_5_19_by_5_possible": False,
            "any_uniform_wave_6_possible": False,
            "preparer_exit_message": (
                "FAIL CLOSED: row 54 supplied accepted_count=19, new cases=9; "
                "revised exact ranks 11--24 are required"
            ),
        }
        if audit.get("failed_design") != {
            "wave_4_accepted_ranks_per_problem": [11, 12, 13, 14, 15],
            "wave_5_accepted_ranks_per_problem": [16, 17, 18, 19, 20],
            "wave_6_accepted_ranks_per_problem": [21, 22, 23, 24],
            "case_count_by_wave": {
                "balanced_wave_4": 95,
                "balanced_wave_5": 95,
                "balanced_wave_6": 76,
            },
        } or audit.get("prospective_final_design") != {
            "wave_4_accepted_ranks_per_problem": [11, 12, 13, 14, 15],
            "wave_4_cases_per_problem": 5,
            "wave_4_case_count": 95,
            "wave_5_accepted_ranks_per_problem": [16, 17, 18, 19],
            "wave_5_cases_per_problem": 4,
            "wave_5_case_count": 76,
            "wave_count": 2,
            "wave_6_removed": True,
            "largest_uniform_two_wave_design_across_same_19_problems": True,
            "specified_before_any_wave_3_output_or_result_inspection": True,
        }:
            raise PackageError(
                "Balanced Extension-2 rank-20 failure/final-design disclosure is invalid"
            )
        expected_count = 1071
        limiting_row = 54
        accepted_count = 19

    external_name = f"balanced_extension2_rank{missing_rank}_feasibility_failure"
    if (
        set(audit) != expected_top_level
        or audit.get("schema_version") != expected_schema
        or audit.get("failure") != expected_failure
        or audit.get("evidence_root") != evidence_relative
        or audit.get("external_preserved_archive") != external_name
        or audit.get("evidence_file_count") != expected_count
        or audit.get("evidence_inventory_sha256")
        != BALANCED_EXTENSION2_FAILURE_INVENTORY_SHA256[missing_rank]
        or any(
            audit.get(field) != 0
            for field in (
                "model_result_files_read",
                "wave_3_result_files_read",
                "model_inference_calls",
            )
        )
    ):
        raise PackageError(
            f"Balanced Extension-2 rank-{missing_rank} failure facts are invalid"
        )

    evidence_root = _resolve_existing_under(
        extension_root / evidence_relative,
        extension_root,
        f"balanced Extension-2 rank-{missing_rank} failure evidence",
        require_file=False,
    )
    actual_files: List[Dict[str, Any]] = []
    for path in sorted(evidence_root.rglob("*"), key=lambda item: item.as_posix()):
        if path.is_symlink():
            raise PackageError(
                f"Balanced Extension-2 rank-{missing_rank} evidence contains a symlink"
            )
        if path.is_dir():
            continue
        if not path.is_file():
            raise PackageError(
                f"Balanced Extension-2 rank-{missing_rank} evidence is not regular"
            )
        relative = path.relative_to(evidence_root).as_posix()
        if not relative.startswith(("tests/", "validation/")):
            raise PackageError(
                f"Unexpected rank-{missing_rank} feasibility evidence path: {relative}"
            )
        row = {
            "path": relative,
            "bytes": path.stat().st_size,
            "sha256": _sha256_file(path),
        }
        frozen = inventory.get(f"{evidence_relative}/{relative}") or {}
        if frozen.get("bytes") != row["bytes"] or frozen.get("sha256") != row["sha256"]:
            raise PackageError(
                f"Rank-{missing_rank} feasibility evidence is absent from the freeze: {relative}"
            )
        actual_files.append(row)
    digest = _sha256_bytes(_stable_json(actual_files).encode("utf-8"))
    if (
        len(actual_files) != expected_count
        or audit.get("evidence_files") != actual_files
        or digest != BALANCED_EXTENSION2_FAILURE_INVENTORY_SHA256[missing_rank]
    ):
        raise PackageError(
            f"Balanced Extension-2 rank-{missing_rank} failure evidence inventory is invalid"
        )

    limiting_variant = str(expected_failure["variant_id"])
    validations = sorted(
        (evidence_root / "validation" / limiting_variant).rglob("*.json"),
        key=lambda item: item.as_posix(),
    )
    observed_accepted = 0
    for path in validations:
        payload = _read_json_object(
            path, f"balanced Extension-2 row-{limiting_row} validation"
        )
        if not isinstance(payload.get("accepted"), bool):
            raise PackageError(
                f"Malformed balanced Extension-2 row-{limiting_row} validation"
            )
        observed_accepted += int(payload["accepted"])
    if len(validations) != int(expected_failure["jdk_executed_candidate_count"]) or (
        observed_accepted != accepted_count
    ):
        raise PackageError(
            f"Balanced Extension-2 row-{limiting_row} feasibility counts are invalid"
        )

    external_root_raw = extension_root.parent / external_name
    if external_root_raw.is_symlink():
        raise PackageError(
            f"Balanced Extension-2 rank-{missing_rank} external archive is a symlink"
        )
    external_root = _resolve_existing_under(
        external_root_raw,
        extension_root.parent,
        f"balanced Extension-2 rank-{missing_rank} external archive",
        require_file=False,
    )
    external_files: List[Dict[str, Any]] = []
    for prefix in ("tests", "validation"):
        prefix_root = _resolve_existing_under(
            external_root / prefix,
            external_root,
            f"rank-{missing_rank} external {prefix} archive",
            require_file=False,
        )
        for path in sorted(prefix_root.rglob("*"), key=lambda item: item.as_posix()):
            if path.is_symlink():
                raise PackageError(
                    f"Rank-{missing_rank} external feasibility archive contains a symlink"
                )
            if path.is_file():
                external_files.append(
                    {
                        "path": path.relative_to(external_root).as_posix(),
                        "bytes": path.stat().st_size,
                        "sha256": _sha256_file(path),
                    }
                )
    if external_files != actual_files:
        raise PackageError(
            f"Balanced Extension-2 rank-{missing_rank} external archive differs from "
            "the frozen preservation copy"
        )
    return {
        "missing_rank": missing_rank,
        "audit_sha256": expected_audit_hash,
        "evidence_file_count": expected_count,
        "evidence_inventory_sha256": digest,
        "limiting_row_index": limiting_row,
        "statically_eligible_candidate_count": expected_failure[
            "statically_eligible_candidate_count"
        ],
        "jdk_valid_accepted_rank_count": accepted_count,
        "external_preserved_archive": external_name,
        "external_archive_validated": True,
    }


def _validate_balanced_extension2_freeze(
    extension_root: Path,
    *,
    external_anchor_path: Optional[Path] = None,
) -> Tuple[Dict[str, Any], Dict[str, Dict[str, Any]], Dict[str, Any], List[Dict[str, Any]]]:
    """Fail closed on the exact Wave-4/5 freeze, controls, and failed designs."""
    freeze_path = _resolve_existing_under(
        extension_root / "freeze_manifest.json",
        extension_root,
        "balanced Extension-2 freeze manifest",
        require_file=True,
    )
    internal_anchor = _resolve_existing_under(
        extension_root / "FREEZE.sha256",
        extension_root,
        "balanced Extension-2 internal freeze anchor",
        require_file=True,
    )
    work_root = extension_root.parent
    external_anchor = _resolve_existing_under(
        external_anchor_path or work_root / BALANCED_EXTENSION2_EXTERNAL_ANCHOR.name,
        work_root,
        "balanced Extension-2 external freeze anchor",
        require_file=True,
    )
    freeze_hash = _sha256_file(freeze_path)
    if freeze_hash != BALANCED_EXTENSION2_FREEZE_MANIFEST_SHA256:
        raise PackageError(
            "Balanced Extension-2 freeze manifest differs from the registered immutable "
            "SHA256"
        )
    if internal_anchor.read_text(encoding="utf-8") != (
        f"{freeze_hash}  freeze_manifest.json\n"
    ):
        raise PackageError("Balanced Extension-2 internal freeze anchor is invalid")
    if external_anchor.read_text(encoding="utf-8") != (
        f"{freeze_hash}  balanced_extension2_contingency/freeze_manifest.json\n"
    ):
        raise PackageError("Balanced Extension-2 external freeze anchor is invalid")

    freeze = _read_json_object(freeze_path, "balanced Extension-2 freeze manifest")
    if (
        freeze.get("schema_version") != BALANCED_EXTENSION2_FREEZE_SCHEMA
        or freeze.get("state") != "frozen_not_launched"
    ):
        raise PackageError("Balanced Extension-2 freeze schema/state is invalid")
    generated_rows = freeze.get("generated_files")
    if (
        not isinstance(generated_rows, list)
        or len(generated_rows) != BALANCED_EXTENSION2_GENERATED_FILE_COUNT
    ):
        raise PackageError("Balanced Extension-2 generated inventory must contain 3,362 files")
    inventory: Dict[str, Dict[str, Any]] = {}
    for row_any in generated_rows:
        row = row_any if isinstance(row_any, dict) else {}
        relative = _frozen_relative_path(row.get("path", ""), "Extension-2 artifact")
        key = relative.as_posix()
        if (
            set(row) != {"path", "bytes", "sha256"}
            or key in inventory
            or relative.name in {"freeze_manifest.json", "FREEZE.sha256"}
        ):
            raise PackageError(f"Duplicate/malformed Extension-2 artifact entry: {key}")
        path = _resolve_existing_under(
            extension_root / relative,
            extension_root,
            f"balanced Extension-2 artifact {key}",
            require_file=True,
        )
        if path.stat().st_size != int(row.get("bytes", -1)) or _sha256_file(path) != row.get(
            "sha256"
        ):
            raise PackageError(f"Balanced Extension-2 artifact hash/size mismatch: {key}")
        inventory[key] = dict(row)

    actual_files: set[str] = set()
    for path in sorted(extension_root.rglob("*"), key=lambda item: item.as_posix()):
        if path.is_symlink():
            raise PackageError(f"Symlink in balanced Extension-2 evidence: {path}")
        if path.is_dir():
            continue
        if not path.is_file():
            raise PackageError(f"Non-regular balanced Extension-2 evidence: {path}")
        if path.name not in {"freeze_manifest.json", "FREEZE.sha256"}:
            actual_files.add(path.relative_to(extension_root).as_posix())
    if actual_files != set(inventory):
        raise PackageError(
            "Balanced Extension-2 generated-file inventory is not exact: "
            f"missing={sorted(set(inventory) - actual_files)}, "
            f"extra={sorted(actual_files - set(inventory))}"
        )
    if any("wave_6" in path or "wave_6" in path.lower() for path in inventory):
        raise PackageError("Balanced Extension-2 freeze unexpectedly contains Wave 6")

    control_rows = freeze.get("control_files")
    if (
        not isinstance(control_rows, list)
        or len(control_rows) != BALANCED_EXTENSION2_CONTROL_FILE_COUNT
    ):
        raise PackageError("Balanced Extension-2 control inventory must contain 20 files")
    controls: Dict[str, Dict[str, Any]] = {}
    for row_any in control_rows:
        row = row_any if isinstance(row_any, dict) else {}
        relative = _frozen_relative_path(
            row.get("path", ""), "Extension-2 control file"
        )
        key = relative.as_posix()
        if set(row) != {"path", "bytes", "sha256"} or key in controls:
            raise PackageError(f"Duplicate/malformed Extension-2 control entry: {key}")
        path = _resolve_existing_under(
            work_root / relative,
            work_root,
            f"balanced Extension-2 control file {key}",
            require_file=True,
        )
        if path.stat().st_size != int(row.get("bytes", -1)) or _sha256_file(path) != row.get(
            "sha256"
        ):
            raise PackageError(f"Balanced Extension-2 control hash/size mismatch: {key}")
        controls[key] = dict(row)
    if set(controls) != BALANCED_EXTENSION2_REQUIRED_CONTROL_FILES:
        raise PackageError(
            "Balanced Extension-2 control inventory is not the registered twenty-file set"
        )

    invariants = freeze.get("invariants") or {}
    expected_invariants = {
        "adaptive_not_preregistered": True,
        "adaptive_outcome_aware_from_wave_2": True,
        "outcome_blind_in_timing": False,
        "specified_during_live_wave_3": True,
        "prospectively_revised_during_live_wave_3": True,
        "prospective_revision_count": 2,
        "wave_3_outputs_or_results_inspected": False,
        "revision_completed_before_any_wave_3_output_or_result_inspection": True,
        "case_ranking_outcome_independent": True,
        "revision_uses_model_outcomes": False,
        "waves": [4, 5],
        "wave_6_removed": True,
        "case_count_by_wave": {"4": 95, "5": 76},
        "accepted_ranks_per_problem_by_wave": {
            "4": [11, 12, 13, 14, 15],
            "5": [16, 17, 18, 19],
        },
        "shard_case_counts_by_wave": {
            "4": [24, 24, 24, 23],
            "5": [19, 19, 19, 19],
        },
        "shard_expected_run_records_by_wave": {
            "4": [288, 288, 288, 276],
            "5": [228, 228, 228, 228],
        },
        "expected_run_records_by_wave": {"4": 1140, "5": 912},
        "total_frozen_new_cases": 171,
        "maximum_expected_run_records_all_two_waves": 2052,
        "rank25_feasibility_evidence_file_count": 641,
        "rank20_feasibility_evidence_file_count": 1071,
        "model_weights_loaded": False,
        "model_inference_calls": 0,
        "model_result_files_read_by_preparer_or_finalizer": 0,
        "result_roots_created": False,
    }
    failed_invariants = [
        name for name, value in expected_invariants.items()
        if invariants.get(name) != value
    ]
    if failed_invariants:
        raise PackageError(
            f"Balanced Extension-2 freeze invariants are invalid: {failed_invariants}"
        )

    protocol_path = _resolve_existing_under(
        work_root / BALANCED_EXTENSION2_PROTOCOL_JSON,
        work_root,
        "balanced Extension-2 protocol JSON",
        require_file=True,
    )
    if (
        _sha256_file(protocol_path) != BALANCED_EXTENSION2_PROTOCOL_SHA256
        or controls[BALANCED_EXTENSION2_PROTOCOL_JSON].get("sha256")
        != BALANCED_EXTENSION2_PROTOCOL_SHA256
    ):
        raise PackageError(
            "Balanced Extension-2 protocol differs from its registered SHA256/control"
        )
    protocol_payload = _read_json_object(protocol_path, "balanced Extension-2 protocol")
    trigger = protocol_payload.get("sequential_trigger") or {}
    status = protocol_payload.get("status") or {}
    reporting = protocol_payload.get("reporting") or {}
    inference = protocol_payload.get("inference") or {}
    waves = protocol_payload.get("waves") or []
    timing = str(protocol_payload.get("timing_disclosure", ""))
    adaptive = str(protocol_payload.get("adaptive_status_disclosure", ""))
    preparation = str(protocol_payload.get("preparation_read_disclosure", ""))
    protocol_checks = {
        "schema": protocol_payload.get("schema_version")
        == BALANCED_EXTENSION2_SOURCE_SCHEMA,
        "adaptive": status.get("adaptive") is True,
        "wave2_outcome_aware": status.get("outcome_aware_from_wave_2") is True,
        "not_preregistered": status.get("preregistered") is False,
        "not_outcome_blind_timing": status.get("outcome_blind_in_timing") is False,
        "live_wave3": status.get("specified_during_live_wave_3") is True,
        "revised_live_wave3": status.get("prospectively_revised_during_live_wave_3")
        is True,
        "no_wave3_results": status.get("wave_3_outputs_or_results_inspected") is False,
        "outcome_independent": status.get(
            "case_eligibility_ranking_selection_outcome_independent"
        )
        is True,
        "revision_outcome_independent": status.get("revision_uses_model_outcomes")
        is False,
        "complete_trigger": trigger.get("audit_must_be_complete_and_valid") is True,
        "threshold": trigger.get("threshold") == 10,
        "wave4_trigger": trigger.get("wave_4")
        == "launch only when the complete valid post-Wave-3 metric is below 10",
        "wave5_trigger": trigger.get("wave_5")
        == (
            "launch only after Wave 4 is complete and the complete valid post-Wave-4 "
            "metric is below 10"
        ),
        "stop": trigger.get("stop_all_later_waves_when_threshold_reached") is True,
        "no_interim": trigger.get("interim_looks_within_wave_allowed") is False,
        "waves": [str(row.get("wave_id", "")) for row in waves]
        == ["balanced_wave_4", "balanced_wave_5"],
        "no_wave6": inference.get("wave_6_launch_plan") is False,
        "path_rule": inference.get("path_rule")
        == "all runner, manifest, and output-root arguments are HERE-relative to long-code-sample-work",
        "model": inference.get("model_id") == protocol.DEFAULT_MODEL_NAME,
        "trials": inference.get("trials_per_case") == 3,
        "conditions": inference.get("conditions") == list(ALL_CONDITIONS),
        "max_records": inference.get("maximum_expected_run_records_all_two_waves")
        == 2052,
        "outcome_selected": reporting.get("case_finding_is_outcome_selected") is True,
        "retain_pool": reporting.get("retain_complete_screened_pool") is True,
        "no_pass_at_k": reporting.get("display_pass_at_k") is False,
        "timing": "during live Wave 3" in timing
        and "No Wave-3 model output" in timing,
        "adaptive_text": "outcome-aware from the Wave-2 aggregate result" in adaptive
        and "not preregistered" in adaptive
        and "not outcome-blind in timing" in adaptive
        and "outcome-independent" in adaptive,
        "preparation": "read no inference result directory or file" in preparation
        and "no Wave-3 output or result was inspected" in preparation,
    }
    failed_protocol = [name for name, ok in protocol_checks.items() if not ok]
    if failed_protocol:
        raise PackageError(
            f"Balanced Extension-2 protocol/disclosures are invalid: {failed_protocol}"
        )

    failures = [
        _validate_balanced_extension2_failure_archive(
            extension_root=extension_root,
            inventory=inventory,
            missing_rank=missing_rank,
        )
        for missing_rank in (25, 20)
    ]
    return freeze, inventory, protocol_payload, failures


def _validate_balanced_execution_disclosure(work_root: Path) -> Dict[str, Any]:
    """Validate execution-time deviations kept outside the prelaunch freeze."""
    path = _resolve_existing_under(
        work_root / BALANCED_EXECUTION_DISCLOSURE,
        work_root,
        "balanced execution disclosure",
        require_file=True,
    )
    try:
        raw = path.read_bytes()
        payload = json.loads(raw.decode("utf-8"))
    except Exception as exc:
        raise PackageError(f"Cannot read balanced execution disclosure {path}: {exc}") from exc
    if not isinstance(payload, dict):
        raise PackageError("Balanced execution disclosure must be a JSON object")
    expected_flags = {
        "registered_protocol_interim_looks_allowed": False,
        "actual_interim_aggregate_look_occurred": True,
        "current_wave_action_changed": False,
        "current_wave_cases_changed": False,
        "current_wave_trials_or_conditions_changed": False,
        "current_wave_stopped_early": False,
        "wave_2_trigger_policy_changed": False,
        "wave_2_decision_requires_complete_valid_post_wave_1_audit": True,
        "adaptive_extension_motivated_in_part_by_interim_aggregate_look": True,
        "adaptive_extension_case_ranking_uses_model_outcomes": False,
        "adaptive_extension_launch_requires_complete_valid_post_wave_2_audit_below_ten": True,
        "excluded_path_rebase_attempt_result_contents_inspected": False,
        "pass_at_k_displayed": False,
    }
    failed = [name for name, value in expected_flags.items() if payload.get(name) is not value]
    if (
        payload.get("schema_version") != BALANCED_EXECUTION_DISCLOSURE_SCHEMA
        or failed
    ):
        raise PackageError(
            "Balanced execution disclosure schema/booleans are invalid: "
            f"{failed}"
        )
    expected_not_inspected = [
        "raw model completions",
        "reasoning traces",
        "submitted prompts",
        "oracle file contents",
        "per-CodeSteer-success content",
    ]
    if payload.get("content_not_inspected_for_the_interim_look") != expected_not_inspected:
        raise PackageError(
            "Balanced execution disclosure does not preserve the exact content-not-inspected scope"
        )
    disclosure_text = payload.get("disclosure")
    required_text = (
        "results_index aggregate exact-match counts",
        "sample identifiers attached to baseline exact hits",
        "before the wave completed",
        "execution-protocol deviation",
        "rather than described as preregistered or outcome-blind timing",
    )
    if not isinstance(disclosure_text, str) or any(
        phrase not in disclosure_text for phrase in required_text
    ):
        raise PackageError("Balanced execution disclosure text is not explicit enough")
    return {
        **payload,
        "sha256": _sha256_bytes(raw),
        "package_local_path": (
            "screened_pool/balanced_execution_evidence/"
            "balanced_execution_disclosure.json"
        ),
        "outside_prelaunch_freeze": True,
    }


def _validate_balanced_wave_manifest(
    evidence: Mapping[str, Any], *, wave_number: int, balanced_root: Path
) -> set[Tuple[int, str, int]]:
    wave_id = f"balanced_wave_{wave_number}"
    source = evidence.get("source_manifest") or {}
    filtered = evidence.get("manifest") or {}
    common_checks = {
        "schema": source.get("schema_version") == BALANCED_SOURCE_SCHEMA,
        "wave_id": source.get("wave_id") == wave_id,
        "source_state": source.get("state")
        == "model-free JDK validated; exact tokenizer gate pending",
        "case_count": source.get("case_count") == BALANCED_CASES_PER_WAVE,
        "variant_count": source.get("variant_count") == BALANCED_PROBLEMS_PER_WAVE,
        "problem_count": source.get("canonical_problem_count")
        == BALANCED_PROBLEMS_PER_WAVE,
        "frozen_sources": source.get("frozen_source_denominator") == 25,
        "eligible_sources": source.get("tokenizer_eligible_source_denominator") == 23,
        "outcome_blind": isinstance(source.get("outcome_blind_disclosure"), str)
        and "no model completion, score, or other model outcome" in source[
            "outcome_blind_disclosure"
        ],
        "timing": isinstance(source.get("timing_disclosure"), str)
        and "before corrected supplemental model outputs or scores were inspected"
        in source["timing_disclosure"],
        "denominator": isinstance(source.get("denominator_disclosure"), str)
        and "source denominator remains 25" in source["denominator_disclosure"],
    }
    failed = [name for name, ok in common_checks.items() if not ok]
    if failed:
        raise PackageError(f"Balanced {wave_id} source manifest is invalid: {failed}")
    if (
        filtered.get("schema_version") != BALANCED_SOURCE_SCHEMA
        or filtered.get("wave_id") != wave_id
        or filtered.get("state") != "exact_tokenizer_gate_passed"
        or filtered.get("case_count") != BALANCED_CASES_PER_WAVE
        or filtered.get("variant_count") != BALANCED_PROBLEMS_PER_WAVE
        or filtered.get("canonical_problem_count") != BALANCED_PROBLEMS_PER_WAVE
        or filtered.get("timing_disclosure") != source.get("timing_disclosure")
        or filtered.get("outcome_blind_disclosure") != source.get("outcome_blind_disclosure")
        or filtered.get("denominator_disclosure") != source.get("denominator_disclosure")
    ):
        raise PackageError(f"Balanced {wave_id} filtered manifest metadata is invalid")

    variants = source.get("variants")
    if not isinstance(variants, list) or len(variants) != BALANCED_PROBLEMS_PER_WAVE:
        raise PackageError(f"Balanced {wave_id} does not contain 19 source variants")
    canonical_identities: set[str] = set()
    canonical_keys: set[Tuple[int, str, int]] = set()
    row_counts: Dict[int, int] = defaultdict(int)
    concrete_count = 0
    expected_ranks = {1, 2} if wave_number == 1 else {3, 4}
    for variant_any in variants:
        variant = variant_any if isinstance(variant_any, dict) else {}
        selection = variant.get("balanced_contingency_selection") or {}
        identity = str(selection.get("canonical_problem_identity", ""))
        cases = variant.get("cases")
        if (
            selection.get("schema_version") != BALANCED_SOURCE_SCHEMA
            or selection.get("wave_id") != wave_id
            or selection.get("source_denominator_unchanged") is not True
            or not identity
            or identity in canonical_identities
            or not isinstance(cases, list)
            or len(cases) != 2
        ):
            raise PackageError(f"Balanced {wave_id} variant balance/provenance is invalid")
        canonical_identities.add(identity)
        variant_ranks: set[int] = set()
        variant_rows: set[int] = set()
        for case_any in cases:
            case = case_any if isinstance(case_any, dict) else {}
            metadata = case.get("source_case_metadata") or {}
            row_index = metadata.get("row_index")
            suite = metadata.get("suite")
            test_index = metadata.get("dataset_test_index")
            key = (row_index, suite, test_index)
            expected_key = [row_index, suite, test_index]
            rank = case.get("accepted_rank")
            if (
                metadata.get("wave_id") != wave_id
                or metadata.get("dataset_id") != CODECONTESTS_DATASET_ID
                or metadata.get("dataset_revision") != CODECONTESTS_REVISION
                or metadata.get("split") != CODECONTESTS_SPLIT
                or metadata.get("selection_stage")
                != "balanced_outcome_blind_contingency"
                or not isinstance(row_index, int)
                or suite not in {"private_tests", "generated_tests"}
                or not isinstance(test_index, int)
                or case.get("suite") != suite
                or case.get("dataset_test_index") != test_index
                or case.get("canonical_case_key") != expected_key
                or not isinstance(rank, int)
                or case.get("original_trimmed_exact_to_oracle") is not True
                or case.get("obfuscated_trimmed_exact_to_oracle") is not True
                or case.get("original_obfuscated_trimmed_agreement") is not True
            ):
                raise PackageError(f"Balanced {wave_id} concrete-case provenance is invalid")
            typed_key = (int(row_index), str(suite), int(test_index))
            if typed_key in canonical_keys:
                raise PackageError(f"Balanced {wave_id} repeats a canonical case key")
            canonical_keys.add(typed_key)
            variant_ranks.add(int(rank))
            variant_rows.add(int(row_index))
            row_counts[int(row_index)] += 1
        if (
            variant_ranks != expected_ranks
            or len(variant_rows) != 1
            or not identity.endswith(f"row-{next(iter(variant_rows)):06d}")
        ):
            raise PackageError(f"Balanced {wave_id} accepted ranks/row identity are invalid")
        concrete_count += len(cases)
    if (
        concrete_count != BALANCED_CASES_PER_WAVE
        or len(canonical_keys) != BALANCED_CASES_PER_WAVE
        or len(row_counts) != BALANCED_PROBLEMS_PER_WAVE
        or set(row_counts.values()) != {2}
    ):
        raise PackageError(f"Balanced {wave_id} is not exactly two cases for each of 19 rows")

    expected_paths = {
        "source_manifest_path": balanced_root / f"wave_{wave_number}_manifest_pre_tokenizer.json",
        "report_path": balanced_root / "tokenizer_preflight" / f"wave_{wave_number}" / "full_report.json",
        "exclusions_path": balanced_root
        / "tokenizer_preflight"
        / f"wave_{wave_number}"
        / "exclusions.jsonl",
        "manifest_path": balanced_root
        / "tokenizer_preflight"
        / f"wave_{wave_number}"
        / "inference_eligible_variants.json",
    }
    for key, expected in expected_paths.items():
        if Path(evidence.get(key, "")).resolve() != expected.resolve():
            raise PackageError(f"Balanced {wave_id} uses a non-frozen {key}")
    if (
        len(evidence.get("denominator_ids") or set()) != BALANCED_CASES_PER_WAVE
        or len(evidence.get("eligible_ids") or set()) != BALANCED_CASES_PER_WAVE
        or evidence.get("excluded_ids")
    ):
        raise PackageError(f"Balanced {wave_id} tokenizer gate is not exactly 38/38 with zero exclusions")
    return canonical_keys


def _validate_balanced_extension_manifest(
    evidence: Mapping[str, Any], *, extension_root: Path
) -> set[Tuple[int, str, int]]:
    """Validate the exact adaptive Wave-3 denominator and retained manifest."""
    source = evidence.get("source_manifest") or {}
    filtered = evidence.get("manifest") or {}
    adaptive = source.get("adaptive_status_disclosure")
    preparation = source.get("preparation_read_disclosure")
    if (
        source.get("schema_version") != BALANCED_EXTENSION_SOURCE_SCHEMA
        or source.get("wave_id") != "balanced_wave_3"
        or source.get("state") != "model-free JDK validated; exact tokenizer gate pending"
        or source.get("case_count") != BALANCED_EXTENSION_CASES
        or source.get("variant_count") != BALANCED_EXTENSION_PROBLEMS
        or source.get("canonical_problem_count") != BALANCED_EXTENSION_PROBLEMS
        or source.get("cases_per_problem") not in (None, BALANCED_EXTENSION_CASES_PER_PROBLEM)
        or source.get("frozen_source_denominator") != 25
        or source.get("tokenizer_eligible_source_denominator") != 23
        or source.get("accepted_ranks_per_problem")
        != list(BALANCED_EXTENSION_ACCEPTED_RANKS)
        or not isinstance(adaptive, str)
        or "not preregistered" not in adaptive
        or "not outcome-blind in timing" not in adaptive
        or not isinstance(preparation, str)
        or "read no inference result files" not in preparation
    ):
        raise PackageError("Balanced extension Wave-3 source manifest is invalid")
    if (
        filtered.get("schema_version") != BALANCED_EXTENSION_SOURCE_SCHEMA
        or filtered.get("wave_id") != "balanced_wave_3"
        or filtered.get("state") != "exact_tokenizer_gate_passed"
        or filtered.get("case_count") != BALANCED_EXTENSION_CASES
        or filtered.get("variant_count") != BALANCED_EXTENSION_PROBLEMS
        or filtered.get("canonical_problem_count") != BALANCED_EXTENSION_PROBLEMS
        or filtered.get("accepted_ranks_per_problem")
        != list(BALANCED_EXTENSION_ACCEPTED_RANKS)
        or filtered.get("timing_disclosure") != source.get("timing_disclosure")
        or filtered.get("adaptive_status_disclosure") != adaptive
        or filtered.get("preparation_read_disclosure") != preparation
        or filtered.get("denominator_disclosure") != source.get("denominator_disclosure")
    ):
        raise PackageError("Balanced extension Wave-3 filtered manifest metadata is invalid")

    variants = source.get("variants")
    if not isinstance(variants, list) or len(variants) != BALANCED_EXTENSION_PROBLEMS:
        raise PackageError("Balanced extension Wave 3 does not contain 19 source variants")
    canonical_identities: set[str] = set()
    canonical_keys: set[Tuple[int, str, int]] = set()
    row_counts: Dict[int, int] = defaultdict(int)
    for variant_any in variants:
        variant = variant_any if isinstance(variant_any, dict) else {}
        selection = variant.get("balanced_extension_contingency_selection") or {}
        identity = str(selection.get("canonical_problem_identity", ""))
        cases = variant.get("cases")
        if (
            selection.get("schema_version") != BALANCED_EXTENSION_SOURCE_SCHEMA
            or selection.get("wave_id") != "balanced_wave_3"
            or selection.get("source_denominator_unchanged") is not True
            or selection.get("continued_accepted_ranks")
            != list(BALANCED_EXTENSION_ACCEPTED_RANKS)
            or not identity
            or identity in canonical_identities
            or not isinstance(cases, list)
            or len(cases) != BALANCED_EXTENSION_CASES_PER_PROBLEM
        ):
            raise PackageError("Balanced extension Wave-3 variant provenance is invalid")
        canonical_identities.add(identity)
        ranks: set[int] = set()
        rows: set[int] = set()
        for case_any in cases:
            case = case_any if isinstance(case_any, dict) else {}
            metadata = case.get("source_case_metadata") or {}
            row_index = metadata.get("row_index")
            suite = metadata.get("suite")
            test_index = metadata.get("dataset_test_index")
            rank = case.get("accepted_rank")
            if (
                metadata.get("wave_id") != "balanced_wave_3"
                or metadata.get("dataset_id") != CODECONTESTS_DATASET_ID
                or metadata.get("dataset_revision") != CODECONTESTS_REVISION
                or metadata.get("split") != CODECONTESTS_SPLIT
                or metadata.get("selection_stage")
                != "balanced_extension_adaptive_outcome_independent_ranking"
                or not isinstance(row_index, int)
                or suite not in {"private_tests", "generated_tests"}
                or not isinstance(test_index, int)
                or case.get("suite") != suite
                or case.get("dataset_test_index") != test_index
                or case.get("canonical_case_key") != [row_index, suite, test_index]
                or not isinstance(rank, int)
                or case.get("original_trimmed_exact_to_oracle") is not True
                or case.get("obfuscated_trimmed_exact_to_oracle") is not True
                or case.get("original_obfuscated_trimmed_agreement") is not True
            ):
                raise PackageError("Balanced extension Wave-3 case provenance is invalid")
            key = (int(row_index), str(suite), int(test_index))
            if key in canonical_keys:
                raise PackageError("Balanced extension Wave 3 repeats a canonical case key")
            canonical_keys.add(key)
            ranks.add(int(rank))
            rows.add(int(row_index))
            row_counts[int(row_index)] += 1
        if (
            ranks != set(BALANCED_EXTENSION_ACCEPTED_RANKS)
            or len(rows) != 1
            or not identity.endswith(f"row-{next(iter(rows)):06d}")
        ):
            raise PackageError("Balanced extension Wave-3 accepted ranks/identity are invalid")
    if (
        len(canonical_keys) != BALANCED_EXTENSION_CASES
        or len(row_counts) != BALANCED_EXTENSION_PROBLEMS
        or set(row_counts.values()) != {BALANCED_EXTENSION_CASES_PER_PROBLEM}
    ):
        raise PackageError("Balanced extension Wave 3 is not exactly 19 by 6")

    expected_paths = {
        "source_manifest_path": extension_root / "wave_3_manifest_pre_tokenizer.json",
        "report_path": extension_root / "tokenizer_preflight" / "full_report.json",
        "exclusions_path": extension_root / "tokenizer_preflight" / "exclusions.jsonl",
        "manifest_path": extension_root
        / "tokenizer_preflight"
        / "inference_eligible_variants.json",
    }
    for key, expected in expected_paths.items():
        if Path(evidence.get(key, "")).resolve() != expected.resolve():
            raise PackageError(f"Balanced extension Wave 3 uses a non-frozen {key}")
    if (
        evidence.get("source_manifest_sha256") != BALANCED_EXTENSION_PRE_MANIFEST_SHA256
        or evidence.get("filtered_manifest_sha256")
        != BALANCED_EXTENSION_FILTERED_MANIFEST_SHA256
        or len(evidence.get("denominator_ids") or set()) != BALANCED_EXTENSION_CASES
        or len(evidence.get("eligible_ids") or set()) != BALANCED_EXTENSION_CASES
        or evidence.get("excluded_ids")
    ):
        raise PackageError("Balanced extension tokenizer gate is not exactly frozen 114/114")
    return canonical_keys


def _validate_balanced_extension2_manifest(
    evidence: Mapping[str, Any], *, wave_number: int, extension_root: Path
) -> set[Tuple[int, str, int]]:
    """Validate the exact frozen Wave-4 or Wave-5 denominator and provenance."""
    if wave_number not in BALANCED_EXTENSION2_WAVE_SPECS:
        raise PackageError(f"Unsupported balanced Extension-2 wave: {wave_number}")
    spec = BALANCED_EXTENSION2_WAVE_SPECS[wave_number]
    wave_id = f"balanced_wave_{wave_number}"
    expected_ranks = list(spec["accepted_ranks"])
    source = evidence.get("source_manifest") or {}
    filtered = evidence.get("manifest") or {}
    adaptive = source.get("adaptive_status_disclosure")
    timing = source.get("timing_disclosure")
    preparation = source.get("preparation_read_disclosure")
    feasibility = source.get("feasibility_revision_disclosure")
    denominator = source.get("denominator_disclosure")
    conditional = source.get("conditional_trigger")
    expected_trigger_phrase = (
        "complete valid post-Wave-3 audit"
        if wave_number == 4
        else "complete valid post-Wave-4 audit"
    )
    if (
        source.get("schema_version") != BALANCED_EXTENSION2_SOURCE_SCHEMA
        or source.get("wave_id") != wave_id
        or source.get("state")
        != "model-free JDK validated; exact tokenizer gate pending"
        or source.get("case_count") != spec["cases"]
        or source.get("variant_count") != BALANCED_EXTENSION2_PROBLEMS
        or source.get("canonical_problem_count") != BALANCED_EXTENSION2_PROBLEMS
        or source.get("cases_per_problem") != spec["cases_per_problem"]
        or source.get("frozen_source_denominator") != 25
        or source.get("tokenizer_eligible_source_denominator") != 23
        or source.get("accepted_ranks_per_problem") != expected_ranks
        or not isinstance(adaptive, str)
        or "outcome-aware from the Wave-2 aggregate result" not in adaptive
        or "not preregistered" not in adaptive
        or "not outcome-blind in timing" not in adaptive
        or "outcome-independent" not in adaptive
        or not isinstance(timing, str)
        or "during live Wave 3" not in timing
        or "No Wave-3 model output" not in timing
        or not isinstance(preparation, str)
        or "read no inference result directory or file" not in preparation
        or "no Wave-3 output or result was inspected" not in preparation
        or not isinstance(feasibility, str)
        or "row 27" not in feasibility
        or "row 54" not in feasibility
        or "largest uniform two-wave continuation" not in feasibility
        or not isinstance(denominator, str)
        or "source denominator remains 25" not in denominator
        or not isinstance(conditional, str)
        or expected_trigger_phrase not in conditional
        or "fewer than ten" not in conditional
    ):
        raise PackageError(f"Balanced Extension-2 {wave_id} source manifest is invalid")
    if (
        filtered.get("schema_version") != BALANCED_EXTENSION2_SOURCE_SCHEMA
        or filtered.get("wave_id") != wave_id
        or filtered.get("state") != "exact_tokenizer_gate_passed"
        or filtered.get("case_count") != spec["cases"]
        or filtered.get("variant_count") != BALANCED_EXTENSION2_PROBLEMS
        or filtered.get("canonical_problem_count") != BALANCED_EXTENSION2_PROBLEMS
        or filtered.get("cases_per_problem") != spec["cases_per_problem"]
        or filtered.get("accepted_ranks_per_problem") != expected_ranks
        or filtered.get("timing_disclosure") != timing
        or filtered.get("adaptive_status_disclosure") != adaptive
        or filtered.get("preparation_read_disclosure") != preparation
        or filtered.get("feasibility_revision_disclosure") != feasibility
        or filtered.get("denominator_disclosure") != denominator
        or filtered.get("conditional_trigger") != conditional
    ):
        raise PackageError(
            f"Balanced Extension-2 {wave_id} filtered manifest metadata is invalid"
        )

    variants = source.get("variants")
    if not isinstance(variants, list) or len(variants) != BALANCED_EXTENSION2_PROBLEMS:
        raise PackageError(f"Balanced Extension-2 {wave_id} lacks 19 source variants")
    canonical_identities: set[str] = set()
    canonical_keys: set[Tuple[int, str, int]] = set()
    row_counts: Dict[int, int] = defaultdict(int)
    for variant_any in variants:
        variant = variant_any if isinstance(variant_any, dict) else {}
        selection = variant.get("balanced_extension2_contingency_selection") or {}
        identity = str(selection.get("canonical_problem_identity", ""))
        cases = variant.get("cases")
        if (
            selection.get("schema_version") != BALANCED_EXTENSION2_SOURCE_SCHEMA
            or selection.get("wave_id") != wave_id
            or selection.get("source_denominator_unchanged") is not True
            or selection.get("continued_accepted_ranks") != expected_ranks
            or selection.get("selected_source_rule")
            != "same first tokenizer-eligible source used by frozen balanced Waves 1--3"
            or selection.get("protocol") != "../BALANCED_EXTENSION2_CONTINGENCY_PROTOCOL.md"
            or not identity
            or identity in canonical_identities
            or not isinstance(cases, list)
            or len(cases) != spec["cases_per_problem"]
        ):
            raise PackageError(
                f"Balanced Extension-2 {wave_id} variant provenance is invalid"
            )
        canonical_identities.add(identity)
        ranks: set[int] = set()
        rows: set[int] = set()
        for case_any in cases:
            case = case_any if isinstance(case_any, dict) else {}
            metadata = case.get("source_case_metadata") or {}
            row_index = metadata.get("row_index")
            suite = metadata.get("suite")
            test_index = metadata.get("dataset_test_index")
            rank = case.get("accepted_rank")
            if (
                metadata.get("wave_id") != wave_id
                or metadata.get("dataset_id") != CODECONTESTS_DATASET_ID
                or metadata.get("dataset_revision") != CODECONTESTS_REVISION
                or metadata.get("split") != CODECONTESTS_SPLIT
                or metadata.get("selection_stage")
                != "balanced_extension2_adaptive_outcome_independent_ranking"
                or not isinstance(row_index, int)
                or suite not in {"private_tests", "generated_tests"}
                or not isinstance(test_index, int)
                or case.get("suite") != suite
                or case.get("dataset_test_index") != test_index
                or case.get("canonical_case_key") != [row_index, suite, test_index]
                or not isinstance(rank, int)
                or case.get("original_trimmed_exact_to_oracle") is not True
                or case.get("obfuscated_trimmed_exact_to_oracle") is not True
                or case.get("original_obfuscated_trimmed_agreement") is not True
            ):
                raise PackageError(
                    f"Balanced Extension-2 {wave_id} case provenance is invalid"
                )
            key = (int(row_index), str(suite), int(test_index))
            if key in canonical_keys:
                raise PackageError(
                    f"Balanced Extension-2 {wave_id} repeats a canonical case"
                )
            canonical_keys.add(key)
            ranks.add(int(rank))
            rows.add(int(row_index))
            row_counts[int(row_index)] += 1
        if (
            ranks != set(spec["accepted_ranks"])
            or len(rows) != 1
            or not identity.endswith(f"row-{next(iter(rows)):06d}")
        ):
            raise PackageError(
                f"Balanced Extension-2 {wave_id} ranks/identity are invalid"
            )
    if (
        len(canonical_keys) != spec["cases"]
        or len(row_counts) != BALANCED_EXTENSION2_PROBLEMS
        or set(row_counts.values()) != {spec["cases_per_problem"]}
    ):
        raise PackageError(
            f"Balanced Extension-2 {wave_id} is not exactly 19 by "
            f"{spec['cases_per_problem']}"
        )

    preflight_root = extension_root / "tokenizer_preflight" / f"wave_{wave_number}"
    expected_paths = {
        "source_manifest_path": extension_root
        / f"wave_{wave_number}_manifest_pre_tokenizer.json",
        "report_path": preflight_root / "full_report.json",
        "exclusions_path": preflight_root / "exclusions.jsonl",
        "manifest_path": preflight_root / "inference_eligible_variants.json",
    }
    for key, expected in expected_paths.items():
        if Path(evidence.get(key, "")).resolve() != expected.resolve():
            raise PackageError(
                f"Balanced Extension-2 {wave_id} uses a non-frozen {key}"
            )
    if (
        evidence.get("source_manifest_sha256") != spec["pre_manifest_sha256"]
        or evidence.get("filtered_manifest_sha256")
        != spec["filtered_manifest_sha256"]
        or _sha256_file(Path(evidence["report_path"]))
        != spec["tokenizer_report_sha256"]
        or _sha256_file(Path(evidence["exclusions_path"]))
        != hashlib.sha256(b"").hexdigest()
        or len(evidence.get("denominator_ids") or set()) != spec["cases"]
        or len(evidence.get("eligible_ids") or set()) != spec["cases"]
        or evidence.get("excluded_ids")
    ):
        raise PackageError(
            f"Balanced Extension-2 {wave_id} tokenizer gate is not the exact frozen "
            f"{spec['cases']}/{spec['cases']} gate"
        )
    return canonical_keys


def _validate_balanced_launch_plan(
    evidence: Mapping[str, Any],
    *,
    wave_number: int,
    balanced_root: Path,
    inventory: Mapping[str, Mapping[str, Any]],
    control_rows: Mapping[str, Mapping[str, Any]],
) -> Dict[str, Any]:
    wave_id = f"balanced_wave_{wave_number}"
    plan_relative = f"launch_plan_wave_{wave_number}.json"
    plan_path = _resolve_existing_under(
        balanced_root / plan_relative,
        balanced_root,
        f"{wave_id} launch plan",
        require_file=True,
    )
    plan = _read_json_object(plan_path, f"{wave_id} launch plan")
    registered_ids = set(str(value) for value in (evidence.get("eligible_ids") or set()))
    shards = plan.get("shards")
    if not isinstance(shards, list) or len(shards) != 4:
        raise PackageError(f"Balanced {wave_id} launch plan does not contain four shards")
    expected_assignments = [sorted(registered_ids)[index::4] for index in range(4)]
    observed_assignments: List[List[str]] = []
    shard_union: set[str] = set()
    for index, shard_any in enumerate(shards):
        shard = shard_any if isinstance(shard_any, dict) else {}
        ids = shard.get("sample_ids")
        if not isinstance(ids, list):
            raise PackageError(f"Balanced {wave_id} shard {index} lacks sample IDs")
        normalized = [str(value) for value in ids]
        expected_manifest_arg = (
            "balanced_contingency/tokenizer_preflight/"
            f"wave_{wave_number}/inference_eligible_variants.json"
        )
        expected_output_root = (
            "balanced_contingency_inference/"
            f"wave_{wave_number}/shard_{index}"
        )
        expected_argv = [
            "python3",
            "run_long_code_experiment.py",
            "--manifest",
            expected_manifest_arg,
            "--output-root",
            expected_output_root,
            "--trials",
            "3",
            "--base-seed",
            "20260713",
            "--gpu-ids",
            str(index),
            "--sample-ids",
            ",".join(normalized),
        ]
        if (
            int(shard.get("shard_index", -1)) != index
            or str(shard.get("gpu_id", "")) != str(index)
            or normalized != expected_assignments[index]
            or int(shard.get("sample_count", -1)) != BALANCED_SHARD_SIZES[index]
            or int(shard.get("expected_run_records", -1)) != BALANCED_SHARD_RECORDS[index]
            or shard.get("output_root") != expected_output_root
            or shard.get("tmux_session") != f"longcode_bal_w{wave_number}_g{index}"
            or shard.get("argv") != expected_argv
            or shard.get("command") != shlex.join(expected_argv)
            or shard_union & set(normalized)
        ):
            raise PackageError(f"Balanced {wave_id} launch-plan shard is invalid: {index}")
        shard_union.update(normalized)
        observed_assignments.append(normalized)
    conditional_trigger = plan.get("conditional_trigger")
    if (
        plan.get("schema_version") != BALANCED_LAUNCH_SCHEMA
        or plan.get("state") != "frozen_not_launched"
        or plan.get("wave_id") != wave_id
        or plan.get("manifest_sha256") != evidence.get("filtered_manifest_sha256")
        or plan.get("runner_sha256") != control_rows["run_long_code_experiment.py"].get("sha256")
        or plan.get("runner") != "run_long_code_experiment.py"
        or plan.get("manifest")
        != (
            "balanced_contingency/tokenizer_preflight/"
            f"wave_{wave_number}/inference_eligible_variants.json"
        )
        or Path(str(plan.get("working_directory", ""))).resolve() != HERE.resolve()
        or plan.get("model") != protocol.DEFAULT_MODEL_NAME
        or plan.get("trials_per_case") != 3
        or plan.get("conditions_per_trial") != 4
        or plan.get("base_seed") != 20260713
        or plan.get("sample_count") != BALANCED_CASES_PER_WAVE
        or plan.get("expected_run_records") != BALANCED_RECORDS_PER_WAVE
        or plan.get("shard_count") != 4
        or plan.get("samples_per_shard") != list(BALANCED_SHARD_SIZES)
        or plan.get("expected_run_records_per_shard") != list(BALANCED_SHARD_RECORDS)
        or plan.get("result_roots_created") is not False
        or not isinstance(conditional_trigger, str)
        or "complete valid combined audit" not in conditional_trigger
        or "fewer than ten strict canonical problems" not in conditional_trigger
        or shard_union != registered_ids
    ):
        raise PackageError(f"Balanced {wave_id} launch plan does not bind the frozen gate")
    if inventory.get(plan_relative, {}).get("sha256") != _sha256_file(plan_path):
        raise PackageError(f"Balanced {wave_id} launch plan is absent from the freeze inventory")

    bound_roots = sorted(evidence.get("bound_roots") or set())
    root_sample_ids = evidence.get("root_sample_ids") or {}
    if len(bound_roots) != 4:
        raise PackageError(f"Balanced {wave_id} must bind exactly four completed result roots")
    configured_partitions = sorted(
        (tuple(sorted(str(value) for value in (root_sample_ids.get(root) or set()))) for root in bound_roots)
    )
    planned_partitions = sorted(tuple(sorted(values)) for values in observed_assignments)
    if configured_partitions != planned_partitions:
        raise PackageError(f"Balanced {wave_id} completed roots do not match the frozen shards")
    runner_hashes: set[str] = set()
    for root in bound_roots:
        config_path = root / "experiment_config.json"
        config = _read_json_object(config_path, "experiment config")
        environment = _read_json_object(root / "environment.json", "experiment environment")
        dependency_hash = str(
            (((environment.get("runtime_code_provenance") or {}).get("dependency_sha256") or {}).get(
                BALANCED_RUNNER_DEPENDENCY, ""
            ))
        )
        runner_hash = str(environment.get("runner_sha256", ""))
        if (
            config.get("protocol_version") != protocol.PROTOCOL_VERSION
            or config.get("manifest_sha256") != evidence.get("filtered_manifest_sha256")
            or config.get("model_name") != protocol.DEFAULT_MODEL_NAME
            or config.get("model_snapshot_commit") != protocol.MODEL_SNAPSHOT_COMMIT
            or config.get("trials") != 3
            or config.get("base_seed") != 20260713
            or config.get("conditions") != list(ALL_CONDITIONS)
            or config.get("generation") != protocol.GENERATION_DEFAULTS
            or environment.get("experiment_config_sha256") != _sha256_file(config_path)
            or not re.fullmatch(r"[0-9a-f]{64}", runner_hash)
            or runner_hash != dependency_hash
        ):
            raise PackageError(f"Balanced root runner hash/provenance disagree: {root}")
        runner_hashes.add(runner_hash)
    if runner_hashes != {str(plan.get("runner_sha256", ""))}:
        raise PackageError(f"Balanced {wave_id} roots do not bind the frozen runner hash")
    return {
        "wave_id": wave_id,
        "historical_state_at_freeze": plan["state"],
        "launch_plan_sha256": _sha256_file(plan_path),
        "inference_manifest_sha256": evidence["filtered_manifest_sha256"],
        "sample_count": BALANCED_CASES_PER_WAVE,
        "expected_run_records": BALANCED_RECORDS_PER_WAVE,
        "shard_count": 4,
        "samples_per_shard": list(BALANCED_SHARD_SIZES),
        "bound_result_root_count": 4,
        "runner_sha256": plan["runner_sha256"],
    }


def _validate_balanced_extension_launch_plan(
    evidence: Mapping[str, Any],
    *,
    extension_root: Path,
    inventory: Mapping[str, Mapping[str, Any]],
    control_rows: Mapping[str, Mapping[str, Any]],
    result_work_root: Path = HERE,
    root_metadata: Optional[Mapping[Path, Mapping[str, Any]]] = None,
) -> Dict[str, Any]:
    """Bind Wave-3 roots to the exact HERE-relative frozen four-shard plan."""
    plan_relative = "launch_plan_wave_3.json"
    plan_path = _resolve_existing_under(
        extension_root / plan_relative,
        extension_root,
        "balanced extension Wave-3 launch plan",
        require_file=True,
    )
    if _sha256_file(plan_path) != BALANCED_EXTENSION_LAUNCH_PLAN_SHA256:
        raise PackageError("Balanced extension launch plan differs from its registered SHA256")
    plan = _read_json_object(plan_path, "balanced extension Wave-3 launch plan")
    registered_ids = set(str(value) for value in (evidence.get("eligible_ids") or set()))
    shards = plan.get("shards")
    if not isinstance(shards, list) or len(shards) != 4:
        raise PackageError("Balanced extension launch plan must contain four shards")
    expected_assignments = [sorted(registered_ids)[index::4] for index in range(4)]
    observed_assignments: List[List[str]] = []
    shard_union: set[str] = set()
    expected_roots: Dict[Path, set[str]] = {}
    for index, shard_any in enumerate(shards):
        shard = shard_any if isinstance(shard_any, dict) else {}
        ids = shard.get("sample_ids")
        if not isinstance(ids, list):
            raise PackageError(f"Balanced extension shard {index} lacks sample IDs")
        normalized = [str(value) for value in ids]
        expected_manifest_arg = (
            "balanced_extension_contingency/tokenizer_preflight/"
            "inference_eligible_variants.json"
        )
        expected_output_root = (
            f"balanced_extension_contingency_inference/wave_3/shard_{index}"
        )
        expected_argv = [
            "python3",
            "run_long_code_experiment.py",
            "--manifest",
            expected_manifest_arg,
            "--output-root",
            expected_output_root,
            "--trials",
            "3",
            "--base-seed",
            "20260713",
            "--gpu-ids",
            str(index),
            "--sample-ids",
            ",".join(normalized),
        ]
        if (
            int(shard.get("shard_index", -1)) != index
            or str(shard.get("gpu_id", "")) != str(index)
            or normalized != expected_assignments[index]
            or int(shard.get("sample_count", -1))
            != BALANCED_EXTENSION_SHARD_SIZES[index]
            or int(shard.get("expected_run_records", -1))
            != BALANCED_EXTENSION_SHARD_RECORDS[index]
            or shard.get("output_root") != expected_output_root
            or shard.get("tmux_session") != f"longcode_bal_ext_w3_g{index}"
            or shard.get("argv") != expected_argv
            or shard.get("command") != shlex.join(expected_argv)
            or shard_union & set(normalized)
        ):
            raise PackageError(f"Balanced extension launch-plan shard is invalid: {index}")
        shard_union.update(normalized)
        observed_assignments.append(normalized)
        expected_roots[(result_work_root / expected_output_root).resolve()] = set(normalized)

    conditional_trigger = plan.get("conditional_trigger")
    if (
        plan.get("schema_version") != BALANCED_EXTENSION_LAUNCH_SCHEMA
        or plan.get("state") != "frozen_not_launched"
        or plan.get("wave_id") != "balanced_wave_3"
        or plan.get("manifest_sha256") != BALANCED_EXTENSION_FILTERED_MANIFEST_SHA256
        or plan.get("manifest_sha256") != evidence.get("filtered_manifest_sha256")
        or plan.get("runner_sha256")
        != control_rows["run_long_code_experiment.py"].get("sha256")
        or plan.get("runner") != "run_long_code_experiment.py"
        or plan.get("manifest")
        != (
            "balanced_extension_contingency/tokenizer_preflight/"
            "inference_eligible_variants.json"
        )
        or Path(str(plan.get("working_directory", ""))).resolve() != HERE.resolve()
        or plan.get("working_directory_label") != "long-code-sample-work"
        or plan.get("adaptive_not_preregistered") is not True
        or plan.get("case_ranking_outcome_independent") is not True
        or plan.get("model") != protocol.DEFAULT_MODEL_NAME
        or plan.get("model_type") != "base"
        or plan.get("trials_per_case") != 3
        or plan.get("conditions_per_trial") != 4
        or plan.get("do_sample") is not True
        or plan.get("temperature") != 1.05
        or plan.get("top_p") != 0.95
        or plan.get("top_k") != 7
        or plan.get("max_new_tokens") != 512
        or plan.get("base_seed") != 20260713
        or plan.get("sample_count") != BALANCED_EXTENSION_CASES
        or plan.get("expected_run_records") != BALANCED_EXTENSION_RECORDS
        or plan.get("shard_count") != 4
        or plan.get("samples_per_shard") != list(BALANCED_EXTENSION_SHARD_SIZES)
        or plan.get("expected_run_records_per_shard")
        != list(BALANCED_EXTENSION_SHARD_RECORDS)
        or plan.get("result_roots_created") is not False
        or not isinstance(conditional_trigger, str)
        or "complete valid post-Wave-2 audit" not in conditional_trigger
        or "fewer than ten strict canonical CodeContests problems" not in conditional_trigger
        or shard_union != registered_ids
    ):
        raise PackageError("Balanced extension launch plan does not bind the frozen gate")
    if inventory.get(plan_relative, {}).get("sha256") != _sha256_file(plan_path):
        raise PackageError("Balanced extension launch plan is absent from the freeze inventory")

    bound_roots = {Path(value).resolve() for value in (evidence.get("bound_roots") or set())}
    if bound_roots != set(expected_roots):
        raise PackageError(
            "Balanced extension result roots are path-rebased or differ from the frozen paths"
        )
    raw_root_sample_ids = evidence.get("root_sample_ids") or {}
    root_sample_ids = {
        Path(root).resolve(): set(str(value) for value in (values or set()))
        for root, values in raw_root_sample_ids.items()
    }
    if root_sample_ids != expected_roots:
        raise PackageError("Balanced extension completed roots do not match frozen shards")

    runner_hashes: set[str] = set()
    for root, planned_ids in sorted(expected_roots.items()):
        config_path = root / "experiment_config.json"
        if root_metadata is None:
            config = _read_json_object(
                config_path, "balanced extension experiment config"
            )
            environment = _read_json_object(
                root / "environment.json", "balanced extension experiment environment"
            )
            config_sha256 = _sha256_file(config_path)
        else:
            metadata = root_metadata.get(root) or {}
            config = metadata.get("config") or {}
            environment = metadata.get("environment") or {}
            config_sha256 = str(metadata.get("config_sha256", ""))
        dependency_hash = str(
            (((environment.get("runtime_code_provenance") or {}).get("dependency_sha256") or {}).get(
                BALANCED_RUNNER_DEPENDENCY, ""
            ))
        )
        runner_hash = str(environment.get("runner_sha256", ""))
        if (
            config.get("protocol_version") != protocol.PROTOCOL_VERSION
            or config.get("manifest_sha256") != BALANCED_EXTENSION_FILTERED_MANIFEST_SHA256
            or config.get("model_name") != protocol.DEFAULT_MODEL_NAME
            or config.get("model_snapshot_commit") != protocol.MODEL_SNAPSHOT_COMMIT
            or config.get("trials") != 3
            or config.get("base_seed") != 20260713
            or config.get("conditions") != list(ALL_CONDITIONS)
            or config.get("generation") != protocol.GENERATION_DEFAULTS
            or set(str(value) for value in (config.get("sample_ids") or [])) != planned_ids
            or len(config.get("sample_ids") or []) != len(planned_ids)
            or environment.get("experiment_config_sha256") != config_sha256
            or not re.fullmatch(r"[0-9a-f]{64}", runner_hash)
            or runner_hash != dependency_hash
        ):
            raise PackageError(f"Balanced extension root provenance disagrees: {root}")
        runner_hashes.add(runner_hash)
    if runner_hashes != {str(plan.get("runner_sha256", ""))}:
        raise PackageError("Balanced extension roots do not bind the frozen runner")
    return {
        "wave_id": "balanced_wave_3",
        "historical_state_at_freeze": plan["state"],
        "launch_plan_sha256": _sha256_file(plan_path),
        "inference_manifest_sha256": evidence["filtered_manifest_sha256"],
        "sample_count": BALANCED_EXTENSION_CASES,
        "expected_run_records": BALANCED_EXTENSION_RECORDS,
        "shard_count": 4,
        "samples_per_shard": list(BALANCED_EXTENSION_SHARD_SIZES),
        "bound_result_root_count": 4,
        "bound_result_roots": [
            str(path.relative_to(result_work_root.resolve())) for path in sorted(expected_roots)
        ],
        "runner_sha256": plan["runner_sha256"],
    }


def _lexical_absolute_path(value: Path) -> Path:
    """Normalize an expected path without probing whether it exists."""
    return Path(os.path.abspath(os.fspath(value.expanduser())))


def _validate_balanced_extension2_launch_plan(
    evidence: Mapping[str, Any],
    *,
    wave_number: int,
    extension_root: Path,
    inventory: Mapping[str, Mapping[str, Any]],
    control_rows: Mapping[str, Mapping[str, Any]],
    result_work_root: Path = HERE,
    root_metadata: Optional[Mapping[Path, Mapping[str, Any]]] = None,
) -> Dict[str, Any]:
    """Bind a completed optional wave to its exact HERE-relative frozen plan."""
    if wave_number not in BALANCED_EXTENSION2_WAVE_SPECS:
        raise PackageError(f"Unsupported balanced Extension-2 wave: {wave_number}")
    spec = BALANCED_EXTENSION2_WAVE_SPECS[wave_number]
    wave_id = f"balanced_wave_{wave_number}"
    plan_relative = f"launch_plan_wave_{wave_number}.json"
    plan_path = _resolve_existing_under(
        extension_root / plan_relative,
        extension_root,
        f"balanced Extension-2 {wave_id} launch plan",
        require_file=True,
    )
    plan_hash = _sha256_file(plan_path)
    if (
        plan_hash != spec["launch_plan_sha256"]
        or inventory.get(plan_relative, {}).get("sha256") != plan_hash
    ):
        raise PackageError(
            f"Balanced Extension-2 {wave_id} launch plan differs from its frozen SHA256"
        )
    plan = _read_json_object(
        plan_path, f"balanced Extension-2 {wave_id} launch plan"
    )
    registered_ids = set(str(value) for value in (evidence.get("eligible_ids") or set()))
    shards = plan.get("shards")
    if not isinstance(shards, list) or len(shards) != 4:
        raise PackageError(f"Balanced Extension-2 {wave_id} plan must contain four shards")
    expected_assignments = [sorted(registered_ids)[index::4] for index in range(4)]
    expected_roots: Dict[Path, set[str]] = {}
    shard_union: set[str] = set()
    for index, shard_any in enumerate(shards):
        shard = shard_any if isinstance(shard_any, dict) else {}
        ids = shard.get("sample_ids")
        if not isinstance(ids, list):
            raise PackageError(f"Balanced Extension-2 {wave_id} shard {index} lacks IDs")
        normalized = [str(value) for value in ids]
        manifest_arg = (
            "balanced_extension2_contingency/tokenizer_preflight/"
            f"wave_{wave_number}/inference_eligible_variants.json"
        )
        output_root = (
            "balanced_extension2_contingency_inference/"
            f"wave_{wave_number}/shard_{index}"
        )
        argv = [
            "python3",
            "run_long_code_experiment.py",
            "--manifest",
            manifest_arg,
            "--output-root",
            output_root,
            "--trials",
            "3",
            "--base-seed",
            "20260713",
            "--gpu-ids",
            str(index),
            "--sample-ids",
            ",".join(normalized),
        ]
        if (
            int(shard.get("shard_index", -1)) != index
            or str(shard.get("gpu_id", "")) != str(index)
            or normalized != expected_assignments[index]
            or int(shard.get("sample_count", -1)) != spec["shard_cases"][index]
            or int(shard.get("expected_run_records", -1))
            != spec["shard_records"][index]
            or shard.get("output_root") != output_root
            or shard.get("tmux_session")
            != f"longcode_bal_ext2_w{wave_number}_g{index}"
            or shard.get("argv") != argv
            or shard.get("command") != shlex.join(argv)
            or shard_union & set(normalized)
        ):
            raise PackageError(
                f"Balanced Extension-2 {wave_id} launch-plan shard is invalid: {index}"
            )
        shard_union.update(normalized)
        expected_roots[
            _lexical_absolute_path(result_work_root / output_root)
        ] = set(normalized)

    expected_trigger_audit = f"post-Wave-{wave_number - 1}"
    expected_prior_wave = f"Wave {wave_number - 1}"
    conditional = plan.get("conditional_trigger")
    path_rule = (
        "runner, manifest, and output-root arguments are HERE-relative to "
        "working_directory; the runner resolves output-root beneath this WORK_ROOT "
        "exactly once"
    )
    if (
        plan.get("schema_version") != BALANCED_EXTENSION2_LAUNCH_SCHEMA
        or plan.get("state") != "frozen_not_launched"
        or plan.get("wave_id") != wave_id
        or plan.get("wave_number") != wave_number
        or plan.get("manifest_sha256") != spec["filtered_manifest_sha256"]
        or plan.get("manifest_sha256") != evidence.get("filtered_manifest_sha256")
        or plan.get("runner_sha256")
        != control_rows["run_long_code_experiment.py"].get("sha256")
        or plan.get("runner") != "run_long_code_experiment.py"
        or plan.get("manifest")
        != (
            "balanced_extension2_contingency/tokenizer_preflight/"
            f"wave_{wave_number}/inference_eligible_variants.json"
        )
        or Path(str(plan.get("working_directory", ""))).resolve() != HERE.resolve()
        or plan.get("working_directory_label") != "long-code-sample-work"
        or plan.get("path_resolution_rule") != path_rule
        or plan.get("trigger_audit") != expected_trigger_audit
        or plan.get("prior_wave_must_be_complete") != expected_prior_wave
        or plan.get("strict_canonical_problem_threshold") != 10
        or plan.get("stop_later_waves_if_threshold_reached") is not True
        or plan.get("interim_looks_within_wave_allowed") is not False
        or plan.get("adaptive_not_preregistered") is not True
        or plan.get("adaptive_outcome_aware_from_wave_2") is not True
        or plan.get("outcome_blind_in_timing") is not False
        or plan.get("case_ranking_outcome_independent") is not True
        or plan.get("wave_3_outputs_or_results_inspected") is not False
        or plan.get("accepted_ranks_per_problem") != list(spec["accepted_ranks"])
        or plan.get("model") != protocol.DEFAULT_MODEL_NAME
        or plan.get("model_type") != "base"
        or plan.get("trials_per_case") != 3
        or plan.get("conditions_per_trial") != 4
        or plan.get("do_sample") is not True
        or plan.get("temperature") != 1.05
        or plan.get("top_p") != 0.95
        or plan.get("top_k") != 7
        or plan.get("max_new_tokens") != 512
        or plan.get("base_seed") != 20260713
        or plan.get("sample_count") != spec["cases"]
        or plan.get("expected_run_records") != spec["records"]
        or plan.get("shard_count") != 4
        or plan.get("samples_per_shard") != list(spec["shard_cases"])
        or plan.get("expected_run_records_per_shard")
        != list(spec["shard_records"])
        or plan.get("result_roots_created") is not False
        or not isinstance(conditional, str)
        or f"Wave {wave_number - 1} is complete" not in conditional
        or f"complete valid post-Wave-{wave_number - 1} audit" not in conditional
        or "fewer than 10 distinct strict canonical" not in conditional
        or shard_union != registered_ids
    ):
        raise PackageError(
            f"Balanced Extension-2 {wave_id} launch plan does not bind the frozen gate"
        )

    bound_roots = {
        _lexical_absolute_path(Path(value))
        for value in (evidence.get("bound_roots") or set())
    }
    if bound_roots != set(expected_roots):
        raise PackageError(
            f"Balanced Extension-2 {wave_id} result roots are path-rebased or differ "
            "from the frozen HERE-relative paths"
        )
    root_sample_ids = {
        _lexical_absolute_path(Path(root)): set(str(value) for value in (values or set()))
        for root, values in (evidence.get("root_sample_ids") or {}).items()
    }
    if root_sample_ids != expected_roots:
        raise PackageError(
            f"Balanced Extension-2 {wave_id} completed roots do not match frozen shards"
        )

    metadata_by_root = (
        {
            _lexical_absolute_path(Path(root)): metadata
            for root, metadata in root_metadata.items()
        }
        if root_metadata is not None
        else None
    )
    runner_hashes: set[str] = set()
    for root, planned_ids in sorted(expected_roots.items()):
        config_path = root / "experiment_config.json"
        if metadata_by_root is None:
            config = _read_json_object(
                config_path, f"balanced Extension-2 {wave_id} experiment config"
            )
            environment = _read_json_object(
                root / "environment.json",
                f"balanced Extension-2 {wave_id} experiment environment",
            )
            config_sha256 = _sha256_file(config_path)
        else:
            metadata = metadata_by_root.get(root) or {}
            config = metadata.get("config") or {}
            environment = metadata.get("environment") or {}
            config_sha256 = str(metadata.get("config_sha256", ""))
        dependency_hash = str(
            (((environment.get("runtime_code_provenance") or {}).get("dependency_sha256") or {}).get(
                BALANCED_RUNNER_DEPENDENCY, ""
            ))
        )
        runner_hash = str(environment.get("runner_sha256", ""))
        if (
            config.get("protocol_version") != protocol.PROTOCOL_VERSION
            or config.get("manifest_sha256") != spec["filtered_manifest_sha256"]
            or config.get("model_name") != protocol.DEFAULT_MODEL_NAME
            or config.get("model_snapshot_commit") != protocol.MODEL_SNAPSHOT_COMMIT
            or config.get("trials") != 3
            or config.get("base_seed") != 20260713
            or config.get("conditions") != list(ALL_CONDITIONS)
            or config.get("generation") != protocol.GENERATION_DEFAULTS
            or set(str(value) for value in (config.get("sample_ids") or []))
            != planned_ids
            or len(config.get("sample_ids") or []) != len(planned_ids)
            or environment.get("experiment_config_sha256") != config_sha256
            or not re.fullmatch(r"[0-9a-f]{64}", runner_hash)
            or runner_hash != dependency_hash
        ):
            raise PackageError(
                f"Balanced Extension-2 {wave_id} root provenance disagrees: {root}"
            )
        runner_hashes.add(runner_hash)
    if runner_hashes != {str(plan.get("runner_sha256", ""))}:
        raise PackageError(
            f"Balanced Extension-2 {wave_id} roots do not bind the frozen runner"
        )
    work_root = _lexical_absolute_path(result_work_root)
    return {
        "wave_id": wave_id,
        "historical_state_at_freeze": plan["state"],
        "launch_plan_sha256": plan_hash,
        "inference_manifest_sha256": evidence["filtered_manifest_sha256"],
        "sample_count": spec["cases"],
        "expected_run_records": spec["records"],
        "shard_count": 4,
        "samples_per_shard": list(spec["shard_cases"]),
        "expected_run_records_per_shard": list(spec["shard_records"]),
        "bound_result_root_count": 4,
        "bound_result_roots": [
            path.relative_to(work_root).as_posix() for path in sorted(expected_roots)
        ],
        "runner_sha256": plan["runner_sha256"],
    }


def _validate_balanced_contingency(
    evidence_sets: Sequence[Mapping[str, Any]],
    *,
    balanced_root: Path,
) -> Optional[Dict[str, Any]]:
    classified = _classify_tokenizer_evidence_sets(evidence_sets)
    balanced_sets = classified["balanced"]
    if not balanced_sets:
        return None
    balanced_root = _resolve_existing_under(
        balanced_root, HERE, "balanced contingency root", require_file=False
    )
    freeze, inventory, protocol_payload = _validate_balanced_freeze(balanced_root)
    execution_disclosure = _validate_balanced_execution_disclosure(
        balanced_root.parent
    )
    controls = {
        str(row["path"]): row for row in (freeze.get("control_files") or [])
    }
    by_wave: Dict[int, Mapping[str, Any]] = {}
    for evidence in balanced_sets:
        wave_id = str((evidence.get("source_manifest") or {}).get("wave_id", ""))
        match = re.fullmatch(r"balanced_wave_([12])", wave_id)
        if not match:
            raise PackageError(f"Unsupported balanced contingency wave ID: {wave_id!r}")
        wave_number = int(match.group(1))
        if wave_number in by_wave:
            raise PackageError(f"Duplicate balanced contingency wave: {wave_id}")
        by_wave[wave_number] = evidence
    if sorted(by_wave) not in ([1], [1, 2]):
        raise PackageError("Balanced contingency evidence must start with Wave 1")

    final_summary_path = balanced_root / "final_summary.json"
    previous_audit_path = balanced_root / "previous_screened_case_audit.json"
    correction_path = balanced_root / "path_correction_provenance.json"
    for relative, path in (
        ("final_summary.json", final_summary_path),
        ("previous_screened_case_audit.json", previous_audit_path),
        ("path_correction_provenance.json", correction_path),
    ):
        if inventory.get(relative, {}).get("sha256") != _sha256_file(path):
            raise PackageError(f"Balanced frozen summary/audit is absent from inventory: {relative}")
    final_summary = _read_json_object(final_summary_path, "balanced final summary")
    final_waves = final_summary.get("waves")
    if (
        final_summary.get("schema_version") != BALANCED_SOURCE_SCHEMA
        or final_summary.get("state") != "fully_frozen_tokenizer_gated_not_launched"
        or final_summary.get("wave_case_counts") != [38, 38]
        or final_summary.get("waves_disjoint") is not True
        or final_summary.get("overlap_with_previous_screens") != 0
        or final_summary.get("model_weights_loaded") is not False
        or final_summary.get("model_inference_calls") != 0
        or final_summary.get("model_result_files_read") != 0
        or final_summary.get("result_roots_created") is not False
        or final_summary.get("launch_plans_state")
        != ["frozen_not_launched", "frozen_not_launched"]
        or not isinstance(final_waves, list)
        or len(final_waves) != 2
    ):
        raise PackageError("Balanced final summary is inconsistent with the frozen protocol")
    summary_by_wave = {
        str(row.get("wave_id")): row for row in final_waves if isinstance(row, dict)
    }
    path_correction = _read_json_object(
        correction_path, "balanced path-correction provenance"
    )
    excluded_attempt = path_correction.get("excluded_attempt") or {}
    if (
        final_summary.get("path_correction_provenance")
        != "balanced_contingency/path_correction_provenance.json"
        or path_correction.get("schema_version")
        != "long-code-balanced-path-correction-v1"
        or path_correction.get("selection_frozen_before_corrected_supplemental_outcomes")
        is not True
        or path_correction.get("administrative_refreeze_after_outcomes") is not True
        or path_correction.get("case_selection_or_ranking_changed") is not False
        or path_correction.get("case_inputs_or_oracles_changed") is not False
        or path_correction.get("tokenizer_filtered_manifests_changed") is not False
        or path_correction.get("wave_1_manifest_sha256_before_and_after")
        != "77c56a24424561d210e0267af98bca99de1261d4a6a99419abf86459ac9a9281"
        or path_correction.get("wave_2_manifest_sha256_before_and_after")
        != "1ad71da922365aae463acc32511ba3809ffe5839a5267e2bd8aba66fd58b21dd"
        or path_correction.get("last_pre_outcome_freeze_manifest_sha256")
        != BALANCED_PRE_CORRECTION_FREEZE_SHA256
        or not isinstance(path_correction.get("outcome_use_disclosure"), str)
        or "No completion, score, exact-match result, or reasoning trace was used"
        not in path_correction["outcome_use_disclosure"]
        or excluded_attempt.get("relative_path_from_work_root")
        != "balanced_wave1_path_rebase_attempt"
        or excluded_attempt.get("total_completed_records") != 21
        or excluded_attempt.get("completed_records_per_shard") != [6, 3, 6, 6]
        or excluded_attempt.get("included_in_any_audit_or_selection") is not False
        or excluded_attempt.get("sessions_stopped_before_correction") is not True
    ):
        raise PackageError("Balanced path-correction provenance/disclosure is invalid")

    waves: List[Dict[str, Any]] = []
    active_case_keys: Dict[int, set[Tuple[int, str, int]]] = {}
    for wave_number in sorted(by_wave):
        evidence = by_wave[wave_number]
        active_case_keys[wave_number] = _validate_balanced_wave_manifest(
            evidence, wave_number=wave_number, balanced_root=balanced_root
        )
        required_relatives = (
            f"wave_{wave_number}_manifest_pre_tokenizer.json",
            f"tokenizer_preflight/wave_{wave_number}/full_report.json",
            f"tokenizer_preflight/wave_{wave_number}/exclusions.jsonl",
            f"tokenizer_preflight/wave_{wave_number}/inference_eligible_variants.json",
        )
        for relative in required_relatives:
            path = balanced_root / relative
            if inventory.get(relative, {}).get("sha256") != _sha256_file(path):
                raise PackageError(
                    f"Balanced wave {wave_number} evidence is absent from the freeze inventory: {relative}"
                )
        summary_wave = summary_by_wave.get(f"balanced_wave_{wave_number}") or {}
        if (
            summary_wave.get("pre_tokenizer_manifest_sha256")
            != evidence.get("source_manifest_sha256")
            or summary_wave.get("tokenizer_report_sha256")
            != _sha256_file(Path(evidence["report_path"]))
            or summary_wave.get("filtered_manifest_sha256")
            != evidence.get("filtered_manifest_sha256")
            or summary_wave.get("case_count") != BALANCED_CASES_PER_WAVE
            or summary_wave.get("canonical_problem_count")
            != BALANCED_PROBLEMS_PER_WAVE
            or set(str(value) for value in (summary_wave.get("sample_ids") or []))
            != set(evidence.get("eligible_ids") or set())
            or {tuple(value) for value in (summary_wave.get("canonical_case_keys") or [])}
            != active_case_keys[wave_number]
        ):
            raise PackageError(
                f"Balanced wave {wave_number} hashes/identities disagree with final_summary.json"
            )
        waves.append(
            _validate_balanced_launch_plan(
                evidence,
                wave_number=wave_number,
                balanced_root=balanced_root,
                inventory=inventory,
                control_rows=controls,
            )
        )

    if 2 in active_case_keys and active_case_keys[1] & active_case_keys[2]:
        raise PackageError("Balanced Wave 1 and Wave 2 canonical case keys overlap")
    previous_audit = _read_json_object(
        previous_audit_path, "balanced previous-screened-case audit"
    )
    previous_records = previous_audit.get("records")
    if not isinstance(previous_records, list):
        raise PackageError("Balanced previous-screened-case audit lacks records")
    previous_keys = {
        tuple(row.get("canonical_case_key") or [])
        for row in previous_records
        if isinstance(row, dict)
    }
    if any(len(key) != 3 for key in previous_keys):
        raise PackageError("Balanced previous-screened-case audit has malformed keys")
    if set().union(*active_case_keys.values()) & previous_keys:
        raise PackageError("Balanced contingency overlaps an initial/supplemental case key")

    return {
        "schema_version": BALANCED_SOURCE_SCHEMA,
        "freeze_schema_version": BALANCED_FREEZE_SCHEMA,
        "freeze_manifest_sha256": _sha256_file(balanced_root / "freeze_manifest.json"),
        "freeze_generated_file_count": len(inventory),
        "control_files": [dict(row) for row in freeze["control_files"]],
        "protocol_sha256": controls[BALANCED_PROTOCOL_JSON]["sha256"],
        "timing_disclosure": protocol_payload["timing_disclosure"],
        "outcome_blind_case_selection": True,
        "conditional_trigger": dict(protocol_payload["trigger"]),
        "frozen_source_denominator": 25,
        "tokenizer_eligible_source_count": 23,
        "canonical_problem_count": BALANCED_PROBLEMS_PER_WAVE,
        "balanced_wave_count": len(waves),
        "balanced_case_count": len(waves) * BALANCED_CASES_PER_WAVE,
        "waves": waves,
        "display_pass_at_k": False,
        "execution_disclosure": execution_disclosure,
        "administrative_path_correction": {
            "provenance_sha256": _sha256_file(correction_path),
            "selection_or_ranking_changed": False,
            "case_inputs_or_oracles_changed": False,
            "tokenizer_filtered_manifests_changed": False,
            "excluded_attempt_completed_records": 21,
            "excluded_attempt_included_in_any_audit_or_selection": False,
            "outcome_use_disclosure": path_correction["outcome_use_disclosure"],
        },
        "final_case_selection_remains_post_hoc_outcome_conditioned": True,
        "manual_trace_review": {
            "required_before_publication": True,
            "included_in_this_automatic_selection_evidence": False,
            "must_remain_separate_from_outcome_blind_case_generation": True,
        },
    }


def _validate_balanced_extension_contingency(
    evidence_sets: Sequence[Mapping[str, Any]],
    *,
    extension_root: Path,
    result_work_root: Path = HERE,
    root_metadata: Optional[Mapping[Path, Mapping[str, Any]]] = None,
) -> Optional[Dict[str, Any]]:
    """Validate the optional frozen adaptive Wave-3 evidence without reading outcomes."""
    classified = _classify_tokenizer_evidence_sets(evidence_sets)
    evidence = classified["extension"]
    if evidence is None:
        return None
    if len(classified["balanced"]) != 2:
        raise PackageError("Adaptive Wave 3 requires frozen balanced Waves 1 and 2")
    extension_root = _resolve_existing_under(
        extension_root, HERE, "balanced extension contingency root", require_file=False
    )
    freeze, inventory, protocol_payload = _validate_balanced_extension_freeze(
        extension_root
    )
    controls = {str(row["path"]): row for row in (freeze.get("control_files") or [])}
    execution_disclosure = _validate_balanced_execution_disclosure(extension_root.parent)
    if execution_disclosure.get("sha256") != BALANCED_ADAPTIVE_DISCLOSURE_SHA256:
        raise PackageError("Adaptive execution disclosure differs from its registered SHA256")

    canonical_keys = _validate_balanced_extension_manifest(
        evidence, extension_root=extension_root
    )
    required_hashes = {
        "wave_3_manifest_pre_tokenizer.json": BALANCED_EXTENSION_PRE_MANIFEST_SHA256,
        "tokenizer_preflight/full_report.json": BALANCED_EXTENSION_TOKENIZER_REPORT_SHA256,
        "tokenizer_preflight/exclusions.jsonl": hashlib.sha256(b"").hexdigest(),
        "tokenizer_preflight/inference_eligible_variants.json": (
            BALANCED_EXTENSION_FILTERED_MANIFEST_SHA256
        ),
        "launch_plan_wave_3.json": BALANCED_EXTENSION_LAUNCH_PLAN_SHA256,
    }
    for relative, expected_hash in required_hashes.items():
        path = extension_root / relative
        if (
            _sha256_file(path) != expected_hash
            or inventory.get(relative, {}).get("sha256") != expected_hash
        ):
            raise PackageError(
                f"Balanced extension known manifest/plan hash is invalid: {relative}"
            )

    final_summary_path = extension_root / "final_summary.json"
    previous_audit_path = extension_root / "previous_screened_case_audit.json"
    for relative, path in (
        ("final_summary.json", final_summary_path),
        ("previous_screened_case_audit.json", previous_audit_path),
    ):
        if inventory.get(relative, {}).get("sha256") != _sha256_file(path):
            raise PackageError(f"Balanced extension frozen audit is unbound: {relative}")
    final_summary = _read_json_object(final_summary_path, "balanced extension final summary")
    summary_wave = final_summary.get("wave") or {}
    if (
        final_summary.get("schema_version") != BALANCED_EXTENSION_SOURCE_SCHEMA
        or final_summary.get("state") != "fully_frozen_tokenizer_gated_not_launched"
        or final_summary.get("adaptive_not_preregistered") is not True
        or final_summary.get("outcome_blind_in_timing") is not False
        or final_summary.get("case_eligibility_ranking_selection_outcome_independent")
        is not True
        or final_summary.get("wave_3_case_count") != BALANCED_EXTENSION_CASES
        or final_summary.get("canonical_problem_count") != BALANCED_EXTENSION_PROBLEMS
        or final_summary.get("cases_per_problem") != BALANCED_EXTENSION_CASES_PER_PROBLEM
        or final_summary.get("accepted_ranks_per_problem")
        != list(BALANCED_EXTENSION_ACCEPTED_RANKS)
        or final_summary.get("overlap_with_initial_supplemental_wave_1_wave_2") != 0
        or final_summary.get("model_weights_loaded") is not False
        or final_summary.get("model_inference_calls") != 0
        or final_summary.get("model_result_files_read_by_preparer_or_finalizer") != 0
        or final_summary.get("result_roots_created") is not False
        or final_summary.get("launch_plan_state") != "frozen_not_launched"
        or summary_wave.get("pre_tokenizer_manifest_sha256")
        != BALANCED_EXTENSION_PRE_MANIFEST_SHA256
        or summary_wave.get("tokenizer_report_sha256")
        != BALANCED_EXTENSION_TOKENIZER_REPORT_SHA256
        or summary_wave.get("filtered_manifest_sha256")
        != BALANCED_EXTENSION_FILTERED_MANIFEST_SHA256
        or summary_wave.get("case_count") != BALANCED_EXTENSION_CASES
        or summary_wave.get("canonical_problem_count") != BALANCED_EXTENSION_PROBLEMS
        or summary_wave.get("accepted_ranks_per_problem")
        != list(BALANCED_EXTENSION_ACCEPTED_RANKS)
        or set(str(value) for value in (summary_wave.get("sample_ids") or []))
        != set(evidence.get("eligible_ids") or set())
        or {tuple(value) for value in (summary_wave.get("canonical_case_keys") or [])}
        != canonical_keys
    ):
        raise PackageError("Balanced extension final summary is inconsistent")
    if (
        final_summary.get("timing_disclosure") != protocol_payload.get("timing_disclosure")
        or final_summary.get("adaptive_status_disclosure")
        != protocol_payload.get("adaptive_status_disclosure")
        or final_summary.get("preparation_read_disclosure")
        != protocol_payload.get("preparation_read_disclosure")
    ):
        raise PackageError("Balanced extension protocol/final disclosure binding is invalid")

    previous_audit = _read_json_object(
        previous_audit_path, "balanced extension previous-screen audit"
    )
    previous_records = previous_audit.get("records")
    if (
        not isinstance(previous_records, list)
        or previous_audit.get("wave_3_overlap_count") != 0
    ):
        raise PackageError("Balanced extension previous-screen audit is invalid")
    previous_keys = {
        tuple(row.get("canonical_case_key") or [])
        for row in previous_records
        if isinstance(row, dict)
    }
    if any(len(key) != 3 for key in previous_keys) or canonical_keys & previous_keys:
        raise PackageError("Balanced extension overlaps a prior canonical case key")

    wave = _validate_balanced_extension_launch_plan(
        evidence,
        extension_root=extension_root,
        inventory=inventory,
        control_rows=controls,
        result_work_root=result_work_root,
        root_metadata=root_metadata,
    )
    return {
        "schema_version": BALANCED_EXTENSION_SOURCE_SCHEMA,
        "freeze_schema_version": BALANCED_EXTENSION_FREEZE_SCHEMA,
        "freeze_manifest_sha256": _sha256_file(extension_root / "freeze_manifest.json"),
        "internal_freeze_anchor_sha256": _sha256_file(extension_root / "FREEZE.sha256"),
        "internal_freeze_anchor_package_local_path": (
            "screened_pool/balanced_extension_contingency/FREEZE.sha256"
        ),
        "external_freeze_anchor_sha256": _sha256_file(
            extension_root.parent / BALANCED_EXTENSION_EXTERNAL_ANCHOR.name
        ),
        "external_freeze_anchor_package_local_path": (
            "screened_pool/balanced_extension_contingency.FREEZE.sha256"
        ),
        "freeze_generated_file_count": len(inventory),
        "control_files": [dict(row) for row in freeze["control_files"]],
        "protocol_sha256": BALANCED_EXTENSION_PROTOCOL_SHA256,
        "filtered_manifest_sha256": BALANCED_EXTENSION_FILTERED_MANIFEST_SHA256,
        "launch_plan_sha256": BALANCED_EXTENSION_LAUNCH_PLAN_SHA256,
        "timing_disclosure": protocol_payload["timing_disclosure"],
        "adaptive_status_disclosure": protocol_payload["adaptive_status_disclosure"],
        "preparation_read_disclosure": protocol_payload[
            "preparation_read_disclosure"
        ],
        "adaptive": True,
        "preregistered": False,
        "outcome_blind_in_timing": False,
        "case_ranking_outcome_independent": True,
        "case_finding_is_outcome_selected": True,
        "display_pass_at_k": False,
        "conditional_trigger": dict(protocol_payload["trigger"]),
        "wave_3_case_count": BALANCED_EXTENSION_CASES,
        "canonical_problem_count": BALANCED_EXTENSION_PROBLEMS,
        "cases_per_problem": BALANCED_EXTENSION_CASES_PER_PROBLEM,
        "accepted_ranks_per_problem": list(BALANCED_EXTENSION_ACCEPTED_RANKS),
        "wave": wave,
        "execution_disclosure": {
            **execution_disclosure,
            "extension_package_local_path": (
                "screened_pool/balanced_extension_execution_evidence/"
                f"{BALANCED_EXECUTION_DISCLOSURE}"
            ),
        },
        "adaptive_disclosure_sha256": execution_disclosure["sha256"],
        "adaptive_disclosure_package_local_path": (
            "screened_pool/balanced_extension_execution_evidence/"
            f"{BALANCED_EXECUTION_DISCLOSURE}"
        ),
        "manual_trace_review": {
            "required": True,
            "required_entry_count": CASE_COUNT,
            "distinct_canonical_strict_cases_required": True,
            "included": False,
        },
    }


def _validate_balanced_extension2_contingency(
    evidence_sets: Sequence[Mapping[str, Any]],
    *,
    extension_root: Path,
    result_work_root: Path = HERE,
    root_metadata: Optional[Mapping[Path, Mapping[str, Any]]] = None,
) -> Optional[Dict[str, Any]]:
    """Validate optional completed Wave-4/5 evidence against the immutable freeze."""
    classified = _classify_tokenizer_evidence_sets(evidence_sets)
    extension2_sets = classified["extension2"]
    if not extension2_sets:
        return None
    if classified["extension"] is None or len(classified["balanced"]) != 2:
        raise PackageError(
            "Balanced Extension-2 requires contiguous frozen evidence through Wave 3"
        )
    extension_root = _resolve_existing_under(
        extension_root,
        HERE,
        "balanced Extension-2 contingency root",
        require_file=False,
    )
    freeze, inventory, protocol_payload, failure_archives = (
        _validate_balanced_extension2_freeze(extension_root)
    )
    controls = {str(row["path"]): row for row in (freeze.get("control_files") or [])}
    packaging_disclosure = _validate_balanced_extension2_packaging_disclosure(
        extension_root.parent
    )
    refinement_disclosure = _validate_balanced_extension2_refinement_disclosure(
        extension_root.parent
    )

    static_case_keys: Dict[int, set[Tuple[int, str, int]]] = {}
    static_ids: Dict[int, set[str]] = {}
    for wave_number, spec in BALANCED_EXTENSION2_WAVE_SPECS.items():
        preflight_root = extension_root / "tokenizer_preflight" / f"wave_{wave_number}"
        source_path = extension_root / f"wave_{wave_number}_manifest_pre_tokenizer.json"
        report_path = preflight_root / "full_report.json"
        exclusions_path = preflight_root / "exclusions.jsonl"
        manifest_path = preflight_root / "inference_eligible_variants.json"
        expected_hashes = {
            source_path: spec["pre_manifest_sha256"],
            report_path: spec["tokenizer_report_sha256"],
            exclusions_path: hashlib.sha256(b"").hexdigest(),
            manifest_path: spec["filtered_manifest_sha256"],
            extension_root / f"launch_plan_wave_{wave_number}.json": spec[
                "launch_plan_sha256"
            ],
        }
        for path, expected_hash in expected_hashes.items():
            relative = path.relative_to(extension_root).as_posix()
            if (
                _sha256_file(path) != expected_hash
                or inventory.get(relative, {}).get("sha256") != expected_hash
            ):
                raise PackageError(
                    f"Balanced Extension-2 frozen Wave-{wave_number} artifact is invalid: "
                    f"{relative}"
                )
        source = _read_json_object(
            source_path, f"balanced Extension-2 Wave-{wave_number} source manifest"
        )
        filtered = _read_json_object(
            manifest_path,
            f"balanced Extension-2 Wave-{wave_number} filtered manifest",
        )
        ids = _expanded_manifest_ids(filtered)
        static_ids[wave_number] = ids
        token_report = _read_json_object(
            report_path, f"balanced Extension-2 Wave-{wave_number} tokenizer report"
        )
        counts = token_report.get("counts") or {}
        tokenizer = token_report.get("tokenizer") or {}
        if (
            token_report.get("schema_version") != "long-code-tokenizer-preflight-v1"
            or counts.get("exploded_denominator_records") != spec["cases"]
            or counts.get("inference_eligible_records") != spec["cases"]
            or counts.get("excluded_records") != 0
            or counts.get("preflight_error_records") != 0
            or tokenizer.get("model_id") != protocol.DEFAULT_MODEL_NAME
            or tokenizer.get("snapshot_commit") != protocol.MODEL_SNAPSHOT_COMMIT
            or tokenizer.get("model_weights_loaded") is not False
            or ((token_report.get("source_manifest") or {}).get("sha256"))
            != spec["pre_manifest_sha256"]
            or _expanded_manifest_ids(source) != ids
        ):
            raise PackageError(
                f"Balanced Extension-2 Wave-{wave_number} exact tokenizer evidence is invalid"
            )
        static_evidence = {
            "source_manifest": source,
            "manifest": filtered,
            "source_manifest_path": source_path,
            "source_manifest_sha256": spec["pre_manifest_sha256"],
            "report_path": report_path,
            "exclusions_path": exclusions_path,
            "manifest_path": manifest_path,
            "filtered_manifest_sha256": spec["filtered_manifest_sha256"],
            "denominator_ids": ids,
            "eligible_ids": ids,
            "excluded_ids": set(),
        }
        static_case_keys[wave_number] = _validate_balanced_extension2_manifest(
            static_evidence,
            wave_number=wave_number,
            extension_root=extension_root,
        )
    if static_case_keys[4] & static_case_keys[5]:
        raise PackageError("Balanced Extension-2 Waves 4 and 5 overlap")

    previous_path = extension_root / "previous_screened_case_audit.json"
    final_summary_path = extension_root / "final_summary.json"
    for path in (previous_path, final_summary_path):
        relative = path.relative_to(extension_root).as_posix()
        if inventory.get(relative, {}).get("sha256") != _sha256_file(path):
            raise PackageError(f"Balanced Extension-2 frozen audit is unbound: {relative}")
    previous = _read_json_object(previous_path, "balanced Extension-2 previous-case audit")
    previous_records = previous.get("records")
    if (
        previous.get("schema_version") != BALANCED_EXTENSION2_SOURCE_SCHEMA
        or not isinstance(previous_records, list)
        or previous.get("wave_4_overlap_count") != 0
        or previous.get("wave_5_overlap_count") != 0
        or previous.get("cross_new_wave_overlap_count") != 0
    ):
        raise PackageError("Balanced Extension-2 previous-case audit is invalid")
    previous_keys = {
        tuple(row.get("canonical_case_key") or [])
        for row in previous_records
        if isinstance(row, dict)
    }
    if (
        any(len(key) != 3 for key in previous_keys)
        or static_case_keys[4] & previous_keys
        or static_case_keys[5] & previous_keys
    ):
        raise PackageError("Balanced Extension-2 overlaps a previously screened case")

    final_summary = _read_json_object(
        final_summary_path, "balanced Extension-2 final summary"
    )
    summary_waves = final_summary.get("waves") or {}
    summary_timing = str(final_summary.get("timing_disclosure", ""))
    summary_adaptive = str(final_summary.get("adaptive_status_disclosure", ""))
    summary_preparation = str(final_summary.get("preparation_read_disclosure", ""))
    if (
        final_summary.get("schema_version") != BALANCED_EXTENSION2_SOURCE_SCHEMA
        or final_summary.get("state") != "fully_frozen_tokenizer_gated_not_launched"
        or final_summary.get("adaptive_not_preregistered") is not True
        or final_summary.get("adaptive_outcome_aware_from_wave_2") is not True
        or final_summary.get("outcome_blind_in_timing") is not False
        or final_summary.get("specified_during_live_wave_3") is not True
        or final_summary.get("prospectively_revised_during_live_wave_3") is not True
        or final_summary.get("wave_3_outputs_or_results_inspected") is not False
        or final_summary.get("revision_uses_model_outcomes") is not False
        or final_summary.get("case_eligibility_ranking_selection_outcome_independent")
        is not True
        or final_summary.get("overlap_with_initial_supplemental_waves_1_2_3") != 0
        or final_summary.get("overlap_across_waves_4_5") != 0
        or final_summary.get("total_frozen_new_cases") != 171
        or final_summary.get("wave_6_removed") is not True
        or final_summary.get("model_weights_loaded") is not False
        or final_summary.get("model_inference_calls") != 0
        or final_summary.get("model_result_files_read_by_preparer_or_finalizer") != 0
        or final_summary.get("result_roots_created") is not False
        or set(summary_waves) != {"4", "5"}
        or "during live Wave 3" not in summary_timing
        or "No Wave-3 model output" not in summary_timing
        or "outcome-aware from the Wave-2 aggregate result" not in summary_adaptive
        or "not preregistered" not in summary_adaptive
        or "not outcome-blind in timing" not in summary_adaptive
        or "outcome-independent" not in summary_adaptive
        or "read no inference result directory or file" not in summary_preparation
        or "no Wave-3 output or result was inspected" not in summary_preparation
    ):
        raise PackageError("Balanced Extension-2 final summary/disclosures are invalid")
    for wave_number, spec in BALANCED_EXTENSION2_WAVE_SPECS.items():
        row = summary_waves.get(str(wave_number)) or {}
        if (
            row.get("wave_id") != f"balanced_wave_{wave_number}"
            or row.get("accepted_ranks_per_problem") != list(spec["accepted_ranks"])
            or row.get("canonical_problem_count") != BALANCED_EXTENSION2_PROBLEMS
            or row.get("case_count") != spec["cases"]
            or row.get("pre_tokenizer_manifest_sha256")
            != spec["pre_manifest_sha256"]
            or row.get("tokenizer_report_sha256")
            != spec["tokenizer_report_sha256"]
            or row.get("filtered_manifest_sha256")
            != spec["filtered_manifest_sha256"]
            or set(str(value) for value in (row.get("sample_ids") or []))
            != static_ids[wave_number]
            or {tuple(value) for value in (row.get("canonical_case_keys") or [])}
            != static_case_keys[wave_number]
        ):
            raise PackageError(
                f"Balanced Extension-2 final Wave-{wave_number} summary is invalid"
            )

    waves: List[Dict[str, Any]] = []
    included_case_keys: Dict[int, set[Tuple[int, str, int]]] = {}
    for evidence in extension2_sets:
        wave_id = str((evidence.get("source_manifest") or {}).get("wave_id", ""))
        match = re.fullmatch(r"balanced_wave_([45])", wave_id)
        if not match:
            raise PackageError(f"Unsupported balanced Extension-2 wave ID: {wave_id!r}")
        wave_number = int(match.group(1))
        keys = _validate_balanced_extension2_manifest(
            evidence,
            wave_number=wave_number,
            extension_root=extension_root,
        )
        if keys != static_case_keys[wave_number] or set(
            evidence.get("eligible_ids") or set()
        ) != static_ids[wave_number]:
            raise PackageError(
                f"Completed balanced Extension-2 Wave-{wave_number} evidence differs "
                "from the frozen gate"
            )
        included_case_keys[wave_number] = keys
        waves.append(
            _validate_balanced_extension2_launch_plan(
                evidence,
                wave_number=wave_number,
                extension_root=extension_root,
                inventory=inventory,
                control_rows=controls,
                result_work_root=result_work_root,
                root_metadata=root_metadata,
            )
        )
    waves.sort(key=lambda row: str(row["wave_id"]))
    return {
        "schema_version": BALANCED_EXTENSION2_SOURCE_SCHEMA,
        "freeze_schema_version": BALANCED_EXTENSION2_FREEZE_SCHEMA,
        "freeze_manifest_sha256": BALANCED_EXTENSION2_FREEZE_MANIFEST_SHA256,
        "internal_freeze_anchor_sha256": _sha256_file(
            extension_root / "FREEZE.sha256"
        ),
        "external_freeze_anchor_sha256": _sha256_file(
            extension_root.parent / BALANCED_EXTENSION2_EXTERNAL_ANCHOR.name
        ),
        "freeze_generated_file_count": len(inventory),
        "freeze_control_file_count": len(controls),
        "control_files": [dict(row) for row in freeze["control_files"]],
        "protocol_sha256": BALANCED_EXTENSION2_PROTOCOL_SHA256,
        "adaptive": True,
        "outcome_aware_from_wave_2": True,
        "preregistered": False,
        "outcome_blind_in_timing": False,
        "specified_during_live_wave_3": True,
        "wave_3_outputs_or_results_inspected_by_freezer": False,
        "case_ranking_and_revision_outcome_independent": True,
        "post_hoc_paired_trial_refinement": True,
        "display_pass_at_k": False,
        "timing_disclosure": protocol_payload["timing_disclosure"],
        "adaptive_status_disclosure": protocol_payload[
            "adaptive_status_disclosure"
        ],
        "preparation_read_disclosure": protocol_payload[
            "preparation_read_disclosure"
        ],
        "frozen_sequential_trigger": dict(protocol_payload["sequential_trigger"]),
        "included_wave_count": len(waves),
        "included_case_count": sum(int(row["sample_count"]) for row in waves),
        "waves": waves,
        "frozen_wave_specs": {
            str(number): {
                "accepted_ranks_per_problem": list(spec["accepted_ranks"]),
                "case_count": spec["cases"],
                "samples_per_shard": list(spec["shard_cases"]),
                "expected_run_records_per_shard": list(spec["shard_records"]),
                "expected_run_records": spec["records"],
            }
            for number, spec in BALANCED_EXTENSION2_WAVE_SPECS.items()
        },
        "failure_archives": failure_archives,
        "packaging_execution_disclosure": packaging_disclosure,
        "paired_trial_protocol_refinement_disclosure": refinement_disclosure,
        "manual_trace_review": {
            "required": True,
            "required_entry_count": CASE_COUNT,
            "distinct_sample_ids_required": True,
            "distinct_canonical_problems_required": False,
            "included": False,
        },
    }


def _validate_balanced_extension_trigger(
    report: Mapping[str, Any],
    evidence_sets: Sequence[Mapping[str, Any]],
    extension_disclosure: Optional[Dict[str, Any]],
) -> None:
    """Require a complete post-Wave-2 audit below ten before accepting Wave 3."""
    if extension_disclosure is None:
        return
    classified = _classify_tokenizer_evidence_sets(evidence_sets)
    extension = classified["extension"]
    if extension is None or len(classified["balanced"]) != 2:
        raise PackageError("Adaptive Wave-3 trigger lacks complete prior-wave evidence")
    post_wave_2_ids = set(classified["initial"].get("eligible_ids") or set())
    supplemental = classified["supplemental"]
    if supplemental is None:
        raise PackageError("Adaptive Wave-3 trigger lacks supplemental evidence")
    post_wave_2_ids.update(supplemental.get("eligible_ids") or set())
    for evidence in classified["balanced"]:
        post_wave_2_ids.update(evidence.get("eligible_ids") or set())
    wave_3_ids = set(extension.get("eligible_ids") or set())

    candidates = report.get("candidates")
    if not isinstance(candidates, list):
        raise PackageError("Adaptive Wave-3 trigger reconstruction requires audit candidates")
    candidate_by_id: Dict[str, Mapping[str, Any]] = {}
    for candidate_any in candidates:
        candidate = candidate_any if isinstance(candidate_any, dict) else {}
        sample_id = str(candidate.get("sample_id", ""))
        if not sample_id or sample_id in candidate_by_id:
            raise PackageError("Adaptive Wave-3 trigger audit has invalid sample identities")
        candidate_by_id[sample_id] = candidate
    missing = sorted((post_wave_2_ids | wave_3_ids) - set(candidate_by_id))
    if missing:
        raise PackageError(f"Adaptive Wave-3 trigger audit is incomplete: missing={missing}")
    incomplete_post_wave_2 = sorted(
        sample_id
        for sample_id in post_wave_2_ids
        if candidate_by_id[sample_id].get("complete_and_valid") is not True
    )
    if incomplete_post_wave_2:
        raise PackageError(
            "Adaptive Wave-3 trigger requires a complete valid post-Wave-2 audit"
        )
    incomplete_wave_3 = sorted(
        sample_id
        for sample_id in wave_3_ids
        if candidate_by_id[sample_id].get("complete_and_valid") is not True
    )
    if incomplete_wave_3:
        raise PackageError("Adaptive Wave-3 evidence roots are not complete and valid")

    identities: set[str] = set()
    for sample_id in post_wave_2_ids:
        candidate = candidate_by_id[sample_id]
        if candidate.get("strict_eligible") is True:
            identity = str(candidate.get("canonical_problem_identity", ""))
            if not identity or identity.startswith("unresolved:"):
                raise PackageError(
                    "Adaptive Wave-3 strict trigger candidate lacks canonical identity"
                )
            identities.add(identity)
    strict_count = len(identities)
    if strict_count >= 10:
        raise PackageError(
            "Adaptive Wave 3 was not triggered: complete post-Wave-2 strict count reached ten"
        )
    extension_disclosure["trigger_audit"] = {
        "complete_valid_post_wave_2_audit": True,
        "strict_unique_canonical_problem_threshold": 10,
        "post_wave_2_strict_unique_canonical_problem_count": strict_count,
        "wave_3_trigger_satisfied": True,
        "wave_3_complete_valid_audit": True,
        "post_wave_2_candidate_count": len(post_wave_2_ids),
        "wave_3_candidate_count": len(wave_3_ids),
    }


def _validate_balanced_extension2_trigger(
    report: Mapping[str, Any],
    evidence_sets: Sequence[Mapping[str, Any]],
    extension2_disclosure: Optional[Dict[str, Any]],
) -> None:
    """Reconstruct the post-Wave-3/4 paired-input decisions from complete audits."""
    if extension2_disclosure is None:
        return
    if (report.get("validation") or {}).get("ok") is not True:
        raise PackageError(
            "Balanced Extension-2 paired trigger requires a complete valid audit"
        )
    classified = _classify_tokenizer_evidence_sets(evidence_sets)
    extension2_sets = classified["extension2"]
    extension2_by_wave = {
        str((evidence.get("source_manifest") or {}).get("wave_id", "")): evidence
        for evidence in extension2_sets
    }
    if (
        classified["extension"] is None
        or len(classified["balanced"]) != 2
        or "balanced_wave_4" not in extension2_by_wave
    ):
        raise PackageError(
            "Balanced Extension-2 paired trigger lacks contiguous evidence through Wave 4"
        )
    candidates = report.get("candidates")
    if not isinstance(candidates, list):
        raise PackageError("Balanced Extension-2 paired trigger lacks audit candidates")
    candidate_by_id: Dict[str, Mapping[str, Any]] = {}
    for candidate_any in candidates:
        candidate = candidate_any if isinstance(candidate_any, dict) else {}
        sample_id = str(candidate.get("sample_id", ""))
        if not sample_id or sample_id in candidate_by_id:
            raise PackageError(
                "Balanced Extension-2 paired trigger has invalid sample identities"
            )
        candidate_by_id[sample_id] = candidate

    post_wave_3_ids = set(classified["initial"].get("eligible_ids") or set())
    supplemental = classified["supplemental"]
    if supplemental is None:
        raise PackageError("Balanced Extension-2 paired trigger lacks supplemental evidence")
    post_wave_3_ids.update(supplemental.get("eligible_ids") or set())
    for evidence in classified["balanced"]:
        post_wave_3_ids.update(evidence.get("eligible_ids") or set())
    post_wave_3_ids.update(classified["extension"].get("eligible_ids") or set())
    wave_4_ids = set(extension2_by_wave["balanced_wave_4"].get("eligible_ids") or set())
    wave_5 = extension2_by_wave.get("balanced_wave_5")
    wave_5_ids = set(wave_5.get("eligible_ids") or set()) if wave_5 else set()

    required_ids = post_wave_3_ids | wave_4_ids | wave_5_ids
    missing = sorted(required_ids - set(candidate_by_id))
    if missing:
        raise PackageError(
            f"Balanced Extension-2 paired trigger audit is incomplete: missing={missing}"
        )

    def require_complete(ids: set[str], label: str) -> None:
        incomplete = sorted(
            sample_id
            for sample_id in ids
            if candidate_by_id[sample_id].get("complete_and_valid") is not True
        )
        if incomplete:
            raise PackageError(
                f"Balanced Extension-2 requires a complete valid {label} audit"
            )

    def paired_summary(ids: set[str]) -> Tuple[int, int]:
        paired_ids: set[str] = set()
        identities: set[str] = set()
        for sample_id in ids:
            candidate = candidate_by_id[sample_id]
            _, eligible_trials = _paired_trial_eligible_trials(candidate)
            if eligible_trials:
                paired_ids.add(sample_id)
                identity = str(candidate.get("canonical_problem_identity", ""))
                if not identity or identity.startswith("unresolved:"):
                    raise PackageError(
                        "Paired-eligible trigger candidate lacks canonical identity"
                    )
                identities.add(identity)
        return len(paired_ids), len(identities)

    require_complete(post_wave_3_ids, "post-Wave-3")
    post_wave_3_count, post_wave_3_problems = paired_summary(post_wave_3_ids)
    refinement = extension2_disclosure.get(
        "paired_trial_protocol_refinement_disclosure"
    )
    if not isinstance(refinement, Mapping):
        raise PackageError(
            "Balanced Extension-2 paired trigger lacks the hard-pinned refinement "
            "disclosure"
        )
    observed = refinement.get("observed_complete_wave_3_paired_audit") or {}
    if (
        post_wave_3_count
        != observed.get("paired_eligible_distinct_sample_id_count")
        or post_wave_3_problems != observed.get("distinct_canonical_problem_count")
    ):
        raise PackageError(
            "Complete post-Wave-3 paired audit disagrees with the hard-pinned refinement "
            "disclosure"
        )
    if post_wave_3_count >= CASE_COUNT:
        raise PackageError(
            "Balanced Extension-2 Wave 4 was not triggered: post-Wave-3 paired count "
            "reached ten"
        )
    require_complete(wave_4_ids, "Wave-4")
    post_wave_4_ids = post_wave_3_ids | wave_4_ids
    post_wave_4_count, post_wave_4_problems = paired_summary(post_wave_4_ids)
    wave_5_included = wave_5 is not None
    if wave_5_included and post_wave_4_count >= CASE_COUNT:
        raise PackageError(
            "Balanced Extension-2 Wave 5 was not triggered: complete post-Wave-4 "
            "paired count reached ten"
        )
    if not wave_5_included and post_wave_4_count < CASE_COUNT:
        raise PackageError(
            "Balanced Extension-2 Wave 5 is required because the complete post-Wave-4 "
            "paired count remains below ten"
        )
    if wave_5_included:
        require_complete(wave_5_ids, "Wave-5")
    extension2_disclosure["paired_trigger_audit"] = {
        "complete_valid_post_wave_3_audit": True,
        "paired_eligible_distinct_sample_id_threshold": CASE_COUNT,
        "post_wave_3_paired_eligible_distinct_sample_id_count": post_wave_3_count,
        "post_wave_3_distinct_canonical_problem_count": post_wave_3_problems,
        "wave_4_trigger_satisfied": True,
        "wave_4_complete_valid_audit": True,
        "post_wave_4_paired_eligible_distinct_sample_id_count": post_wave_4_count,
        "post_wave_4_distinct_canonical_problem_count": post_wave_4_problems,
        "wave_5_included": wave_5_included,
        "wave_5_trigger_satisfied": wave_5_included,
        "wave_5_stopped_because_threshold_reached": (
            not wave_5_included and post_wave_4_count >= CASE_COUNT
        ),
        "wave_5_complete_valid_audit": wave_5_included,
        "selection_unit": "distinct_sample_id",
        "same_seed_same_trial_contrast_required": True,
        "baseline_zero_of_three_required": False,
    }


def _require_balanced_extension_manual_review(
    extension_disclosure: Optional[Dict[str, Any]],
    manual_review: Optional[Mapping[str, Any]],
    *,
    allow_paired_trial_mode: bool = False,
) -> None:
    if extension_disclosure is None:
        return
    if (
        allow_paired_trial_mode
        and manual_review is not None
        and manual_review.get("schema_version") == PAIRED_MANUAL_REVIEW_SCHEMA_VERSION
    ):
        entries = manual_review.get("entries")
        sample_ids = {
            str(entry.get("sample_id", ""))
            for entry in (entries or [])
            if isinstance(entry, dict)
        }
        if (
            manual_review.get("entry_count") != CASE_COUNT
            or not isinstance(entries, list)
            or len(entries) != CASE_COUNT
            or len(sample_ids) != CASE_COUNT
            or "" in sample_ids
            or manual_review.get("all_entries_complete_and_paired_eligible") is not True
        ):
            raise PackageError(
                "Adaptive Wave 3 paired mode requires exactly ten distinct concrete inputs"
            )
        extension_disclosure["manual_trace_review"] = {
            "required": True,
            "included": True,
            "mode": "paired_trial_contrast",
            "entry_count": CASE_COUNT,
            "distinct_sample_id_count": CASE_COUNT,
            "distinct_canonical_problem_count": manual_review[
                "distinct_canonical_problem_count"
            ],
            "sha256": manual_review["sha256"],
        }
        return
    entries = (manual_review or {}).get("entries")
    identities = {
        str(entry.get("canonical_problem_identity", ""))
        for entry in (entries or [])
        if isinstance(entry, dict)
    }
    if (
        manual_review is None
        or manual_review.get("entry_count") != CASE_COUNT
        or not isinstance(entries, list)
        or len(entries) != CASE_COUNT
        or len(identities) != CASE_COUNT
        or "" in identities
        or manual_review.get("all_entries_strict_complete") is not True
    ):
        raise PackageError(
            "Adaptive Wave 3 requires manual review of exactly ten distinct canonical strict cases"
        )
    extension_disclosure["manual_trace_review"] = {
        "required": True,
        "included": True,
        "entry_count": CASE_COUNT,
        "distinct_canonical_strict_case_count": CASE_COUNT,
        "sha256": manual_review["sha256"],
    }


def _require_balanced_extension2_manual_review(
    extension2_disclosure: Optional[Dict[str, Any]],
    manual_review: Optional[Mapping[str, Any]],
) -> None:
    if extension2_disclosure is None:
        return
    if (
        manual_review is None
        or manual_review.get("schema_version") != PAIRED_MANUAL_REVIEW_SCHEMA_VERSION
        or manual_review.get("entry_count") != CASE_COUNT
        or manual_review.get("distinct_sample_id_count") != CASE_COUNT
        or manual_review.get("all_entries_complete_and_paired_eligible") is not True
    ):
        raise PackageError(
            "Balanced Extension-2 requires the exact ten-input paired-trial manual review"
        )
    extension2_disclosure["manual_trace_review"] = {
        "required": True,
        "included": True,
        "mode": "paired_trial_contrast",
        "entry_count": CASE_COUNT,
        "distinct_sample_id_count": CASE_COUNT,
        "distinct_canonical_problem_count": manual_review[
            "distinct_canonical_problem_count"
        ],
        "canonical_problem_repeat_entry_count": manual_review[
            "canonical_problem_repeat_entry_count"
        ],
        "sample_count_by_canonical_problem": manual_review[
            "sample_count_by_canonical_problem"
        ],
        "sha256": manual_review["sha256"],
    }


def _validate_balanced_trigger_sequence(
    report: Mapping[str, Any],
    evidence_sets: Sequence[Mapping[str, Any]],
    balanced_disclosure: Optional[Dict[str, Any]],
) -> None:
    """Reconstruct the two registered stop decisions from the complete final audit."""
    if balanced_disclosure is None:
        return
    classified = _classify_tokenizer_evidence_sets(evidence_sets)
    balanced_by_wave = {
        str((evidence.get("source_manifest") or {}).get("wave_id")): evidence
        for evidence in classified["balanced"]
    }
    base_ids = set(classified["initial"].get("eligible_ids") or set())
    supplemental = classified["supplemental"]
    if supplemental is None:
        raise PackageError("Balanced trigger reconstruction requires the supplemental gate")
    base_ids.update(supplemental.get("eligible_ids") or set())

    candidates = report.get("candidates")
    if not isinstance(candidates, list):
        raise PackageError("Balanced trigger reconstruction requires audit candidates")

    def strict_problem_count(allowed_ids: set[str]) -> int:
        identities: set[str] = set()
        for candidate_any in candidates:
            candidate = candidate_any if isinstance(candidate_any, dict) else {}
            if (
                str(candidate.get("sample_id", "")) in allowed_ids
                and candidate.get("strict_eligible") is True
            ):
                identity = str(candidate.get("canonical_problem_identity", ""))
                if not identity or identity.startswith("unresolved:"):
                    raise PackageError(
                        "Strict balanced-trigger candidate lacks a canonical dataset identity"
                    )
                identities.add(identity)
        return len(identities)

    pre_wave_1 = strict_problem_count(base_ids)
    if pre_wave_1 >= 10:
        raise PackageError(
            "Balanced Wave 1 was not triggered: initial+supplemental strict count is already ten"
        )
    wave_1 = balanced_by_wave.get("balanced_wave_1")
    if wave_1 is None:
        raise PackageError("Balanced trigger sequence lacks Wave 1 evidence")
    post_wave_1_ids = base_ids | set(wave_1.get("eligible_ids") or set())
    post_wave_1 = strict_problem_count(post_wave_1_ids)
    wave_2_included = "balanced_wave_2" in balanced_by_wave
    if wave_2_included and post_wave_1 >= 10:
        raise PackageError(
            "Balanced Wave 2 was not triggered: complete post-Wave-1 strict count reached ten"
        )
    if not wave_2_included and post_wave_1 < 10:
        raise PackageError(
            "Balanced Wave 2 is required because the complete post-Wave-1 strict count is below ten"
        )
    balanced_disclosure["trigger_audit"] = {
        "complete_valid_audit_required": True,
        "strict_canonical_problem_threshold": 10,
        "pre_wave_1_strict_canonical_problem_count": pre_wave_1,
        "wave_1_trigger_satisfied": True,
        "post_wave_1_strict_canonical_problem_count": post_wave_1,
        "wave_2_included": wave_2_included,
        "wave_2_trigger_satisfied": wave_2_included,
        "registered_interim_looks_allowed": False,
        "actual_interim_aggregate_look_occurred": True,
        "current_wave_action_or_selection_changed": False,
        "complete_audit_trigger_policy_preserved": True,
    }


def _copy_balanced_contingency_evidence(
    *,
    balanced_root: Path,
    destination: Path,
    disclosure: Mapping[str, Any],
) -> None:
    """Copy the complete frozen tree and its separately frozen control files."""
    balanced_root = _resolve_existing_under(
        balanced_root, HERE, "balanced contingency root", require_file=False
    )
    _copy_tree_files(balanced_root, destination / "balanced_contingency", HERE)
    control_destination = destination / "balanced_contingency_control_files"
    for row_any in disclosure.get("control_files") or []:
        row = row_any if isinstance(row_any, dict) else {}
        relative = _frozen_relative_path(row.get("path", ""), "balanced control file")
        source = _resolve_existing_under(
            balanced_root.parent / relative,
            balanced_root.parent,
            f"balanced control file {relative}",
            require_file=True,
        )
        if (
            source.stat().st_size != int(row.get("bytes", -1))
            or _sha256_file(source) != row.get("sha256")
        ):
            raise PackageError(f"Balanced control changed before copy: {relative}")
        _copy_file(source, control_destination / relative, HERE)
    execution = disclosure.get("execution_disclosure") or {}
    execution_source = _resolve_existing_under(
        balanced_root.parent / BALANCED_EXECUTION_DISCLOSURE,
        balanced_root.parent,
        "balanced execution disclosure",
        require_file=True,
    )
    if _sha256_file(execution_source) != execution.get("sha256"):
        raise PackageError("Balanced execution disclosure changed after validation")
    execution_destination = (
        destination
        / "balanced_execution_evidence"
        / BALANCED_EXECUTION_DISCLOSURE
    )
    _copy_file(execution_source, execution_destination, HERE)
    if _sha256_file(execution_destination) != execution.get("sha256"):
        raise PackageError("Copied balanced execution disclosure hash changed")


def _copy_balanced_extension_evidence(
    *,
    extension_root: Path,
    destination: Path,
    disclosure: Mapping[str, Any],
) -> None:
    """Copy the complete Wave-3 freeze, controls, both anchors, and disclosure."""
    extension_root = _resolve_existing_under(
        extension_root, HERE, "balanced extension root", require_file=False
    )
    _copy_tree_files(
        extension_root,
        destination / "balanced_extension_contingency",
        HERE,
    )
    control_destination = destination / "balanced_extension_contingency_control_files"
    for row_any in disclosure.get("control_files") or []:
        row = row_any if isinstance(row_any, dict) else {}
        relative = _frozen_relative_path(row.get("path", ""), "extension control file")
        source = _resolve_existing_under(
            extension_root.parent / relative,
            extension_root.parent,
            f"balanced extension control file {relative}",
            require_file=True,
        )
        if (
            source.stat().st_size != int(row.get("bytes", -1))
            or _sha256_file(source) != row.get("sha256")
        ):
            raise PackageError(f"Balanced extension control changed before copy: {relative}")
        _copy_file(source, control_destination / relative, HERE)

    external_source = _resolve_existing_under(
        extension_root.parent / BALANCED_EXTENSION_EXTERNAL_ANCHOR.name,
        extension_root.parent,
        "balanced extension external anchor",
        require_file=True,
    )
    if _sha256_file(external_source) != disclosure.get("external_freeze_anchor_sha256"):
        raise PackageError("Balanced extension external anchor changed after validation")
    external_destination = destination / BALANCED_EXTENSION_EXTERNAL_ANCHOR.name
    _copy_file(external_source, external_destination, HERE)
    if _sha256_file(external_destination) != disclosure.get(
        "external_freeze_anchor_sha256"
    ):
        raise PackageError("Copied balanced extension external anchor changed")

    adaptive = disclosure.get("execution_disclosure") or {}
    adaptive_source = _resolve_existing_under(
        extension_root.parent / BALANCED_EXECUTION_DISCLOSURE,
        extension_root.parent,
        "adaptive execution disclosure",
        require_file=True,
    )
    if (
        _sha256_file(adaptive_source) != BALANCED_ADAPTIVE_DISCLOSURE_SHA256
        or _sha256_file(adaptive_source) != adaptive.get("sha256")
    ):
        raise PackageError("Adaptive disclosure changed after validation")
    adaptive_destination = (
        destination
        / "balanced_extension_execution_evidence"
        / BALANCED_EXECUTION_DISCLOSURE
    )
    _copy_file(adaptive_source, adaptive_destination, HERE)
    if _sha256_file(adaptive_destination) != BALANCED_ADAPTIVE_DISCLOSURE_SHA256:
        raise PackageError("Copied adaptive disclosure hash changed")


def _copy_balanced_extension2_evidence(
    *,
    extension_root: Path,
    destination: Path,
    disclosure: Mapping[str, Any],
) -> None:
    """Copy and re-hash the full Wave-4/5 freeze, controls, anchor, and disclosures."""
    extension_root = _resolve_existing_under(
        extension_root,
        HERE,
        "balanced Extension-2 root",
        require_file=False,
    )
    copied_root = destination / "balanced_extension2_contingency"
    _copy_tree_files(extension_root, copied_root, HERE)
    if _sha256_file(copied_root / "freeze_manifest.json") != (
        BALANCED_EXTENSION2_FREEZE_MANIFEST_SHA256
    ):
        raise PackageError("Copied balanced Extension-2 freeze manifest changed")
    copied_freeze = _read_json_object(
        copied_root / "freeze_manifest.json", "copied balanced Extension-2 freeze"
    )
    expected_copied_files = {"freeze_manifest.json", "FREEZE.sha256"}
    for row_any in copied_freeze.get("generated_files") or []:
        row = row_any if isinstance(row_any, dict) else {}
        relative = _frozen_relative_path(
            row.get("path", ""), "copied Extension-2 generated file"
        )
        expected_copied_files.add(relative.as_posix())
        copied = copied_root / relative
        if (
            not copied.is_file()
            or copied.stat().st_size != int(row.get("bytes", -1))
            or _sha256_file(copied) != row.get("sha256")
        ):
            raise PackageError(
                f"Copied balanced Extension-2 generated file changed: {relative}"
            )
    actual_copied_files = {
        path.relative_to(copied_root).as_posix()
        for path in copied_root.rglob("*")
        if path.is_file()
    }
    if actual_copied_files != expected_copied_files:
        raise PackageError(
            "Copied balanced Extension-2 tree is incomplete or contains extra files"
        )
    if _sha256_file(copied_root / "FREEZE.sha256") != disclosure.get(
        "internal_freeze_anchor_sha256"
    ):
        raise PackageError("Copied balanced Extension-2 internal anchor changed")

    control_destination = destination / "balanced_extension2_contingency_control_files"
    for row_any in disclosure.get("control_files") or []:
        row = row_any if isinstance(row_any, dict) else {}
        relative = _frozen_relative_path(
            row.get("path", ""), "balanced Extension-2 control file"
        )
        source = _resolve_existing_under(
            extension_root.parent / relative,
            extension_root.parent,
            f"balanced Extension-2 control file {relative}",
            require_file=True,
        )
        if (
            source.stat().st_size != int(row.get("bytes", -1))
            or _sha256_file(source) != row.get("sha256")
        ):
            raise PackageError(
                f"Balanced Extension-2 control changed before copy: {relative}"
            )
        copied = control_destination / relative
        _copy_file(source, copied, HERE)
        if _sha256_file(copied) != row.get("sha256"):
            raise PackageError(
                f"Copied balanced Extension-2 control changed: {relative}"
            )

    external_source = _resolve_existing_under(
        extension_root.parent / BALANCED_EXTENSION2_EXTERNAL_ANCHOR.name,
        extension_root.parent,
        "balanced Extension-2 external anchor",
        require_file=True,
    )
    if _sha256_file(external_source) != disclosure.get(
        "external_freeze_anchor_sha256"
    ):
        raise PackageError("Balanced Extension-2 external anchor changed after validation")
    external_destination = destination / BALANCED_EXTENSION2_EXTERNAL_ANCHOR.name
    _copy_file(external_source, external_destination, HERE)
    if _sha256_file(external_destination) != disclosure.get(
        "external_freeze_anchor_sha256"
    ):
        raise PackageError("Copied balanced Extension-2 external anchor changed")

    execution_destination = destination / "balanced_extension2_execution_evidence"
    disclosure_specs = (
        (
            BALANCED_EXTENSION2_PACKAGING_DISCLOSURE,
            BALANCED_EXTENSION2_PACKAGING_DISCLOSURE_SHA256,
            disclosure.get("packaging_execution_disclosure") or {},
        ),
        (
            BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE,
            BALANCED_EXTENSION2_REFINEMENT_DISCLOSURE_SHA256,
            disclosure.get("paired_trial_protocol_refinement_disclosure") or {},
        ),
    )
    for name, expected_hash, validated in disclosure_specs:
        source = _resolve_existing_under(
            extension_root.parent / name,
            extension_root.parent,
            f"balanced Extension-2 external disclosure {name}",
            require_file=True,
        )
        if _sha256_file(source) != expected_hash or validated.get("sha256") != expected_hash:
            raise PackageError(f"Balanced Extension-2 disclosure changed: {name}")
        copied = execution_destination / name
        _copy_file(source, copied, HERE)
        if _sha256_file(copied) != expected_hash:
            raise PackageError(f"Copied balanced Extension-2 disclosure changed: {name}")


def _validate_supplemental_launch_plan(
    evidence_sets: Sequence[Mapping[str, Any]],
) -> Optional[Dict[str, Any]]:
    supplemental = [
        evidence
        for evidence in evidence_sets
        if (evidence.get("source_manifest") or {}).get("schema_version")
        == "long-code-supplemental-cases-v2"
    ]
    if not supplemental:
        return None
    if len(supplemental) != 1:
        raise PackageError("Expected exactly one supplemental tokenizer evidence set")
    evidence = supplemental[0]
    plan_path = _resolve_existing_under(
        HERE / "supplemental_launch_plan.json",
        HERE,
        "supplemental launch plan",
        require_file=True,
    )
    plan = _read_json_object(plan_path, "supplemental launch plan")
    shards = plan.get("shards")
    if not isinstance(shards, list) or len(shards) != 4:
        raise PackageError("Supplemental launch plan does not contain four shards")
    shard_union: set[str] = set()
    for index, shard_any in enumerate(shards):
        shard = shard_any if isinstance(shard_any, dict) else {}
        ids = shard.get("sample_ids")
        if (
            int(shard.get("shard_index", -1)) != index
            or not isinstance(ids, list)
            or len(ids) != 15
            or len(set(str(value) for value in ids)) != 15
            or shard_union & set(str(value) for value in ids)
        ):
            raise PackageError(f"Supplemental launch-plan shard is invalid: {index}")
        shard_union.update(str(value) for value in ids)
    registered = plan.get("registered_settings") or {}
    registered_runner_hashes: set[str] = set()
    runner_dependency_name = (
        "PromptSteering/long-code-sample-work/run_long_code_experiment.py"
    )
    bound_roots = sorted(evidence.get("bound_roots") or set())
    if not bound_roots:
        raise PackageError("Supplemental launch plan lacks bound result-root evidence")
    for root in bound_roots:
        environment = _read_json_object(root / "environment.json", "experiment environment")
        dependency_hash = str(
            (((environment.get("runtime_code_provenance") or {}).get("dependency_sha256") or {}).get(
                runner_dependency_name, ""
            ))
        )
        runner_hash = str(environment.get("runner_sha256", ""))
        if (
            not re.fullmatch(r"[0-9a-f]{64}", runner_hash)
            or runner_hash != dependency_hash
        ):
            raise PackageError(
                f"Supplemental root runner hash/provenance disagree: {root}"
            )
        registered_runner_hashes.add(runner_hash)
    if (
        plan.get("schema_version") != "long-code-supplemental-launch-plan-v1"
        or plan.get("state") != "prepared_not_launched"
        or plan.get("manifest_sha256") != evidence["filtered_manifest_sha256"]
        or int(plan.get("sample_count", -1)) != 60
        or int(plan.get("expected_run_records", -1)) != 720
        or shard_union != set(evidence["eligible_ids"])
        or registered.get("protocol_version") != protocol.PROTOCOL_VERSION
        or registered.get("model_name") != protocol.DEFAULT_MODEL_NAME
        or int(registered.get("trials_per_sample", plan.get("trials_per_sample", -1))) != 3
        or registered.get("conditions") != list(ALL_CONDITIONS)
        or registered_runner_hashes != {str(plan.get("runner_sha256_at_planning", ""))}
    ):
        raise PackageError("Supplemental launch plan does not bind the registered 60-case gate")
    return {
        "schema_version": plan["schema_version"],
        "historical_state_at_planning": plan["state"],
        "sha256": _sha256_file(plan_path),
        "sample_count": 60,
        "shard_count": 4,
        "expected_run_records": 720,
    }


def _candidate_run_map(candidate: Mapping[str, Any]) -> Dict[Tuple[int, str], Dict[str, Any]]:
    run_map: Dict[Tuple[int, str], Dict[str, Any]] = {}
    for run_any in candidate.get("runs", []) or []:
        if not isinstance(run_any, dict):
            raise PackageError(f"Malformed run in candidate {candidate.get('sample_id')}")
        key = (int(run_any.get("trial", -1)), str(run_any.get("condition", "")))
        if key in run_map:
            raise PackageError(f"Duplicate run {key} in candidate {candidate.get('sample_id')}")
        run_map[key] = run_any
    expected = {(trial, condition) for trial in EXPECTED_TRIALS for condition in ALL_CONDITIONS}
    if set(run_map) != expected:
        raise PackageError(
            f"Candidate {candidate.get('sample_id')} does not contain exactly three complete trials"
        )
    return run_map


def _best_codesteer_run(
    candidate: Mapping[str, Any], run_map: Mapping[Tuple[int, str], Dict[str, Any]]
) -> Dict[str, Any]:
    successful = [
        run
        for (trial, condition), run in run_map.items()
        if condition == CODESTEER_CONDITION
        and run.get("valid") is True
        and run.get("trimmed_exact_match") is True
        and run.get("parse_status") == "marker_json"
    ]
    successful.sort(
        key=lambda run: (
            -float((run.get("trace_quality") or {}).get("score", 0.0)),
            int(run.get("trial", 10**9)),
            str(run.get("fingerprint", "")),
        )
    )
    if not successful:
        raise PackageError(f"Strict candidate lacks an exact CodeSteer marker run: {candidate.get('sample_id')}")
    best = candidate.get("best_successful_codesteer_trial") or {}
    actual = successful[0]
    if (
        int(best.get("trial", -1)) != int(actual.get("trial", -2))
        or str(best.get("fingerprint", "")) != str(actual.get("fingerprint", ""))
        or float((best.get("trace_quality") or {}).get("score", -1.0))
        != float((actual.get("trace_quality") or {}).get("score", -2.0))
    ):
        raise PackageError(f"Recorded best CodeSteer ranking is inconsistent: {candidate.get('sample_id')}")
    return actual


def _validate_strict_candidate(candidate: Mapping[str, Any]) -> Tuple[Dict[Tuple[int, str], Dict[str, Any]], Dict[str, Any]]:
    sample_id = _safe_component(candidate.get("sample_id", ""), "sample id")
    problem_key = str(candidate.get("problem_key", ""))
    if not problem_key or problem_key.startswith("unresolved:"):
        raise PackageError(f"Candidate lacks a true published-dataset problem key: {sample_id}")
    if candidate.get("strict_eligible") is not True or candidate.get("complete_and_valid") is not True:
        raise PackageError(f"Candidate is not strict-eligible and complete: {sample_id}")
    if tuple(candidate.get("expected_trials", []) or []) != EXPECTED_TRIALS:
        raise PackageError(f"Candidate does not have the registered three trials: {sample_id}")
    exact_counts = candidate.get("exact_counts") or {}
    if any(int(exact_counts.get(condition, -1)) != 0 for condition in BASELINE_CONDITIONS):
        raise PackageError(f"A baseline has an exact trial for strict candidate: {sample_id}")
    if int(exact_counts.get(CODESTEER_CONDITION, 0)) < 1:
        raise PackageError(f"CodeSteer has no exact trial for strict candidate: {sample_id}")
    run_map = _candidate_run_map(candidate)
    for trial in EXPECTED_TRIALS:
        seeds = {int(run_map[(trial, condition)].get("paired_seed", -1)) for condition in ALL_CONDITIONS}
        if len(seeds) != 1:
            raise PackageError(f"Candidate trial {trial} is not seed-paired: {sample_id}")
    best = _best_codesteer_run(candidate, run_map)
    return run_map, best


def _paired_trial_eligible_trials(
    candidate: Mapping[str, Any],
) -> Tuple[Dict[Tuple[int, str], Dict[str, Any]], Tuple[int, ...]]:
    """Return same-seed trials with exact CodeSteer and three non-exact baselines."""
    sample_id = _safe_component(candidate.get("sample_id", ""), "sample id")
    if candidate.get("complete_and_valid") is not True:
        raise PackageError(f"Paired-trial candidate is not complete and valid: {sample_id}")
    if tuple(candidate.get("expected_trials", []) or []) != EXPECTED_TRIALS:
        raise PackageError(f"Paired-trial candidate lacks the registered trials: {sample_id}")
    run_map = _candidate_run_map(candidate)
    eligible: List[int] = []
    for trial in EXPECTED_TRIALS:
        runs = [run_map[(trial, condition)] for condition in ALL_CONDITIONS]
        seeds = {run.get("paired_seed") for run in runs}
        if len(seeds) != 1 or next(iter(seeds)) is None:
            raise PackageError(
                f"Paired-trial candidate trial {trial} is not same-seed paired: {sample_id}"
            )
        codesteer = run_map[(trial, CODESTEER_CONDITION)]
        baselines = [run_map[(trial, condition)] for condition in BASELINE_CONDITIONS]
        if (
            codesteer.get("valid") is True
            and codesteer.get("trimmed_exact_match") is True
            and codesteer.get("parse_status") == "marker_json"
            and all(
                run.get("valid") is True
                and run.get("trimmed_exact_match") is False
                for run in baselines
            )
        ):
            eligible.append(trial)
    return run_map, tuple(eligible)


def _require_concise_review_text(value: Any, label: str, *, max_length: int) -> str:
    if not isinstance(value, str):
        raise PackageError(f"Manual review {label} must be text")
    stripped = value.strip()
    if not stripped or len(stripped) > max_length or "\x00" in value:
        raise PackageError(
            f"Manual review {label} must be nonempty and at most {max_length} characters"
        )
    return value


def _validate_legacy_manual_trace_review(
    review_path: Path,
    *,
    report: Mapping[str, Any],
    audit_json: Path,
    audit_candidates_csv: Path,
    audit_runs_csv: Path,
) -> Dict[str, Any]:
    """Validate a post-hoc review without consulting any raw model artifact."""
    try:
        review_bytes = review_path.read_bytes()
        payload = json.loads(review_bytes.decode("utf-8"))
    except Exception as exc:
        raise PackageError(f"Cannot read manual trace review JSON {review_path}: {exc}") from exc
    if not isinstance(payload, dict):
        raise PackageError("Manual trace review must be a JSON object")
    expected_audit_hashes = {
        "json_sha256": _sha256_file(audit_json),
        "candidates_csv_sha256": _sha256_file(audit_candidates_csv),
        "runs_csv_sha256": _sha256_file(audit_runs_csv),
    }
    if (
        payload.get("schema_version") != MANUAL_REVIEW_SCHEMA_VERSION
        or payload.get("publishable") is not True
        or payload.get("post_hoc_outcome_and_oracle_aware") is not True
        or payload.get("separate_from_outcome_blind_case_generation") is not True
        or payload.get("audit_inputs") != expected_audit_hashes
    ):
        raise PackageError(
            "Manual review schema, publishability, disclosure, or audit hashes are invalid"
        )
    entries = payload.get("entries")
    if not isinstance(entries, list) or len(entries) != CASE_COUNT:
        raise PackageError("Manual review must contain exactly ten ordered entries")

    candidates = report.get("candidates")
    if not isinstance(candidates, list):
        raise PackageError("Audit lacks candidates required by the manual review")
    candidate_by_id: Dict[str, Mapping[str, Any]] = {}
    for candidate_any in candidates:
        candidate = candidate_any if isinstance(candidate_any, dict) else {}
        sample_id = str(candidate.get("sample_id", ""))
        if not sample_id or sample_id in candidate_by_id:
            raise PackageError("Audit candidate identities are invalid for manual review")
        candidate_by_id[sample_id] = candidate

    seen_samples: set[str] = set()
    seen_identities: set[str] = set()
    normalized_entries: List[Dict[str, Any]] = []
    for expected_order, entry_any in enumerate(entries, 1):
        entry = entry_any if isinstance(entry_any, dict) else {}
        sample_id = _safe_component(entry.get("sample_id", ""), "manual review sample id")
        candidate = candidate_by_id.get(sample_id)
        if candidate is None:
            raise PackageError(f"Manual review references an unaudited sample: {sample_id}")
        if (
            candidate.get("strict_eligible") is not True
            or candidate.get("complete_and_valid") is not True
        ):
            raise PackageError(f"Manual review sample is not strict and complete: {sample_id}")
        run_map, _ = _validate_strict_candidate(candidate)
        canonical_identity = str(entry.get("canonical_problem_identity", ""))
        if (
            not canonical_identity
            or canonical_identity != str(candidate.get("canonical_problem_identity", ""))
        ):
            raise PackageError(f"Manual review canonical identity mismatch: {sample_id}")
        if sample_id in seen_samples or canonical_identity in seen_identities:
            raise PackageError("Manual review samples and canonical problem identities must be distinct")
        seen_samples.add(sample_id)
        seen_identities.add(canonical_identity)

        selection_order = entry.get("selection_order")
        trial = entry.get("selected_codesteer_trial")
        fingerprint = str(entry.get("selected_codesteer_fingerprint", ""))
        if (
            isinstance(selection_order, bool)
            or selection_order != expected_order
            or isinstance(trial, bool)
            or not isinstance(trial, int)
            or trial not in EXPECTED_TRIALS
            or not re.fullmatch(r"[0-9a-f]{64}", fingerprint)
        ):
            raise PackageError(f"Manual review order/trial/fingerprint is invalid: {sample_id}")
        selected_run = run_map[(trial, CODESTEER_CONDITION)]
        if (
            str(selected_run.get("fingerprint", "")) != fingerprint
            or selected_run.get("valid") is not True
            or selected_run.get("trimmed_exact_match") is not True
            or selected_run.get("parse_status") != "marker_json"
        ):
            raise PackageError(
                f"Manual review selected CodeSteer run is not an exact valid marker-json run: {sample_id}"
            )
        exact_counts = candidate.get("exact_counts") or {}
        if any(int(exact_counts.get(condition, -1)) != 0 for condition in BASELINE_CONDITIONS):
            raise PackageError(f"Manual review sample has a successful baseline: {sample_id}")
        if entry.get("publishable") is not True:
            raise PackageError(f"Manual review entry is not publishable: {sample_id}")
        _require_concise_review_text(
            entry.get("review_note"), f"note for {sample_id}", max_length=1000
        )
        if entry.get("reasoning_quality") not in MANUAL_REASONING_QUALITY:
            raise PackageError(f"Manual review reasoning-quality enum is invalid: {sample_id}")
        grounding = entry.get("grounding_scores")
        if not isinstance(grounding, dict) or set(grounding) != MANUAL_GROUNDING_DIMENSIONS:
            raise PackageError(f"Manual review grounding dimensions are invalid: {sample_id}")
        for dimension, score in grounding.items():
            if isinstance(score, bool) or not isinstance(score, int) or not 0 <= score <= 2:
                raise PackageError(
                    f"Manual review {dimension} grounding score is outside 0-2: {sample_id}"
                )
        baseline_notes = entry.get("baseline_failure_notes")
        if not isinstance(baseline_notes, dict) or set(baseline_notes) != set(
            BASELINE_CONDITIONS
        ):
            raise PackageError(f"Manual review baseline failure notes are incomplete: {sample_id}")
        for condition in BASELINE_CONDITIONS:
            _require_concise_review_text(
                baseline_notes.get(condition),
                f"{condition} failure note for {sample_id}",
                max_length=500,
            )
        normalized_entries.append(dict(entry))

    return {
        "schema_version": MANUAL_REVIEW_SCHEMA_VERSION,
        "path": review_path,
        "sha256": _sha256_bytes(review_bytes),
        "audit_inputs": expected_audit_hashes,
        "entry_count": CASE_COUNT,
        "entries": normalized_entries,
        "distinct_canonical_problem_count": CASE_COUNT,
        "all_entries_strict_complete": True,
        "publishable": True,
        "post_hoc_outcome_and_oracle_aware": True,
        "separate_from_outcome_blind_case_generation": True,
    }


def _validate_paired_manual_trace_review(
    review_path: Path,
    *,
    report: Mapping[str, Any],
    audit_json: Path,
    audit_candidates_csv: Path,
    audit_runs_csv: Path,
) -> Dict[str, Any]:
    """Validate the explicit post-hoc same-trial, same-seed concrete-input review."""
    try:
        review_bytes = review_path.read_bytes()
        payload = json.loads(review_bytes.decode("utf-8"))
    except Exception as exc:
        raise PackageError(
            f"Cannot read paired-trial manual review JSON {review_path}: {exc}"
        ) from exc
    if not isinstance(payload, dict):
        raise PackageError("Paired-trial manual review must be a JSON object")
    expected_audit_hashes = {
        "json_sha256": _sha256_file(audit_json),
        "candidates_csv_sha256": _sha256_file(audit_candidates_csv),
        "runs_csv_sha256": _sha256_file(audit_runs_csv),
    }
    top_level_checks = {
        "schema": payload.get("schema_version") == PAIRED_MANUAL_REVIEW_SCHEMA_VERSION,
        "publishable": payload.get("publishable") is True,
        "post_hoc": payload.get("post_hoc_outcome_and_oracle_aware") is True,
        "separate": payload.get("separate_from_outcome_blind_case_generation") is True,
        "audit": payload.get("audit_inputs") == expected_audit_hashes,
        "mode": payload.get("selection_mode") == "same_seed_paired_trial_contrast",
        "sample_unit": payload.get("selection_unit") == "distinct_sample_id",
        "ten_samples": payload.get("required_distinct_sample_id_count") == CASE_COUNT,
        "baseline_other_trials": payload.get("baseline_zero_of_three_required") is False,
        "repeats": payload.get("canonical_problem_repeats_allowed") is True,
        "no_pass": payload.get("display_pass_at_k") is False,
        "no_aggregate": payload.get("aggregate_performance_claim_supported") is False,
        "no_ten_problem_claim": payload.get("ten_problem_generalization_claim_supported")
        is False,
    }
    failed_top = [name for name, ok in top_level_checks.items() if not ok]
    if failed_top:
        raise PackageError(
            f"Paired-trial manual review schema/disclosure is invalid: {failed_top}"
        )
    entries = payload.get("entries")
    if not isinstance(entries, list) or len(entries) != CASE_COUNT:
        raise PackageError("Paired-trial manual review must contain exactly ten entries")
    candidates = report.get("candidates")
    if not isinstance(candidates, list):
        raise PackageError("Audit lacks candidates required by the paired-trial review")
    candidate_by_id: Dict[str, Mapping[str, Any]] = {}
    for candidate_any in candidates:
        candidate = candidate_any if isinstance(candidate_any, dict) else {}
        sample_id = str(candidate.get("sample_id", ""))
        if not sample_id or sample_id in candidate_by_id:
            raise PackageError("Audit candidate identities are invalid for paired review")
        candidate_by_id[sample_id] = candidate

    seen_samples: set[str] = set()
    problem_counts: Dict[str, int] = defaultdict(int)
    normalized_entries: List[Dict[str, Any]] = []
    for expected_order, entry_any in enumerate(entries, 1):
        entry = entry_any if isinstance(entry_any, dict) else {}
        sample_id = _safe_component(
            entry.get("sample_id", ""), "paired manual review sample id"
        )
        candidate = candidate_by_id.get(sample_id)
        if candidate is None:
            raise PackageError(f"Paired review references an unaudited sample: {sample_id}")
        if sample_id in seen_samples:
            raise PackageError("Paired-trial manual review sample IDs must be distinct")
        seen_samples.add(sample_id)
        run_map, eligible_trials = _paired_trial_eligible_trials(candidate)
        canonical_identity = str(entry.get("canonical_problem_identity", ""))
        if (
            not canonical_identity
            or canonical_identity.startswith("unresolved:")
            or canonical_identity
            != str(candidate.get("canonical_problem_identity", ""))
        ):
            raise PackageError(f"Paired review canonical identity mismatch: {sample_id}")

        selection_order = entry.get("selection_order")
        trial = entry.get("selected_codesteer_trial")
        baseline_trial = entry.get("paired_baseline_trial")
        paired_seed = entry.get("paired_seed")
        fingerprint = str(entry.get("selected_codesteer_fingerprint", ""))
        if (
            isinstance(selection_order, bool)
            or selection_order != expected_order
            or isinstance(trial, bool)
            or not isinstance(trial, int)
            or trial not in EXPECTED_TRIALS
            or baseline_trial != trial
            or trial not in eligible_trials
            or isinstance(paired_seed, bool)
            or not isinstance(paired_seed, int)
            or not re.fullmatch(r"[0-9a-f]{64}", fingerprint)
        ):
            raise PackageError(
                f"Paired review order/trial/seed/fingerprint is invalid: {sample_id}"
            )
        selected_runs = [run_map[(trial, condition)] for condition in ALL_CONDITIONS]
        if {run.get("paired_seed") for run in selected_runs} != {paired_seed}:
            raise PackageError(f"Paired review selected trials use mismatched seeds: {sample_id}")
        codesteer = run_map[(trial, CODESTEER_CONDITION)]
        if (
            str(codesteer.get("fingerprint", "")) != fingerprint
            or codesteer.get("valid") is not True
            or codesteer.get("trimmed_exact_match") is not True
            or codesteer.get("parse_status") != "marker_json"
        ):
            raise PackageError(
                f"Paired review CodeSteer run is not exact valid marker_json: {sample_id}"
            )
        for condition in BASELINE_CONDITIONS:
            baseline = run_map[(trial, condition)]
            if (
                baseline.get("valid") is not True
                or baseline.get("trimmed_exact_match") is not False
            ):
                raise PackageError(
                    f"Paired review baseline is exact or invalid at the selected trial: "
                    f"{sample_id}/{condition}"
                )
        if entry.get("publishable") is not True:
            raise PackageError(f"Paired review entry is not publishable: {sample_id}")
        _require_concise_review_text(
            entry.get("review_note"), f"note for {sample_id}", max_length=1000
        )
        if entry.get("reasoning_quality") not in MANUAL_REASONING_QUALITY:
            raise PackageError(f"Paired review reasoning-quality enum is invalid: {sample_id}")
        grounding = entry.get("grounding_scores")
        if not isinstance(grounding, dict) or set(grounding) != MANUAL_GROUNDING_DIMENSIONS:
            raise PackageError(f"Paired review grounding dimensions are invalid: {sample_id}")
        for dimension, score in grounding.items():
            if isinstance(score, bool) or not isinstance(score, int) or not 0 <= score <= 2:
                raise PackageError(
                    f"Paired review {dimension} grounding score is outside 0-2: {sample_id}"
                )
        baseline_notes = entry.get("baseline_failure_notes")
        if not isinstance(baseline_notes, dict) or set(baseline_notes) != set(
            BASELINE_CONDITIONS
        ):
            raise PackageError(f"Paired review baseline notes are incomplete: {sample_id}")
        for condition in BASELINE_CONDITIONS:
            _require_concise_review_text(
                baseline_notes.get(condition),
                f"{condition} paired failure note for {sample_id}",
                max_length=500,
            )
        problem_counts[canonical_identity] += 1
        normalized_entries.append(
            {**dict(entry), "selection_mode": "paired_trial_contrast"}
        )

    canonical_counts = dict(sorted(problem_counts.items()))
    distinct_problem_count = len(canonical_counts)
    repeated_entry_count = CASE_COUNT - distinct_problem_count
    if (
        payload.get("reported_distinct_canonical_problem_count")
        != distinct_problem_count
        or payload.get("reported_canonical_problem_repeat_entry_count")
        != repeated_entry_count
        or payload.get("reported_sample_count_by_canonical_problem")
        != canonical_counts
    ):
        raise PackageError(
            "Paired review makes a false distinct-problem or canonical-repeat claim"
        )
    return {
        "schema_version": PAIRED_MANUAL_REVIEW_SCHEMA_VERSION,
        "mode": "paired_trial_contrast",
        "path": review_path,
        "sha256": _sha256_bytes(review_bytes),
        "audit_inputs": expected_audit_hashes,
        "entry_count": CASE_COUNT,
        "entries": normalized_entries,
        "distinct_sample_id_count": CASE_COUNT,
        "distinct_canonical_problem_count": distinct_problem_count,
        "canonical_problem_repeat_entry_count": repeated_entry_count,
        "sample_count_by_canonical_problem": canonical_counts,
        "all_entries_complete_and_paired_eligible": True,
        "baseline_zero_of_three_required": False,
        "publishable": True,
        "post_hoc_outcome_and_oracle_aware": True,
        "separate_from_outcome_blind_case_generation": True,
        "display_pass_at_k": False,
    }


def _validate_manual_trace_review(
    review_path: Path,
    *,
    report: Mapping[str, Any],
    audit_json: Path,
    audit_candidates_csv: Path,
    audit_runs_csv: Path,
) -> Dict[str, Any]:
    schema = _read_json_object(review_path, "manual trace review").get(
        "schema_version"
    )
    kwargs = {
        "report": report,
        "audit_json": audit_json,
        "audit_candidates_csv": audit_candidates_csv,
        "audit_runs_csv": audit_runs_csv,
    }
    if schema == MANUAL_REVIEW_SCHEMA_VERSION:
        return _validate_legacy_manual_trace_review(review_path, **kwargs)
    if schema == PAIRED_MANUAL_REVIEW_SCHEMA_VERSION:
        return _validate_paired_manual_trace_review(review_path, **kwargs)
    raise PackageError(f"Unsupported manual trace-review schema: {schema!r}")


def _locate_sample_snapshot(sample_id: str, roots: Sequence[Path]) -> Tuple[Dict[str, Any], Path]:
    snapshots: List[Tuple[Dict[str, Any], Path]] = []
    for root in roots:
        candidate = root / "samples" / sample_id / "sample.json"
        if candidate.exists():
            path = _resolve_existing_under(candidate, root, "sample snapshot", require_file=True)
            snapshots.append((_read_json_object(path, "sample snapshot"), path))
    if not snapshots:
        raise PackageError(f"Missing sample snapshot for {sample_id}")
    canonical = _stable_json(snapshots[0][0])
    if any(_stable_json(payload) != canonical for payload, _ in snapshots[1:]):
        raise PackageError(f"Conflicting sample snapshots for {sample_id}")
    return snapshots[0]


def _validate_problem_provenance(
    candidate: Mapping[str, Any], snapshot: Mapping[str, Any]
) -> Tuple[Dict[str, Any], str]:
    sample_id = str(candidate["sample_id"])
    if str(snapshot.get("sample_id", "")) != sample_id:
        raise PackageError(f"Sample snapshot identity mismatch for {sample_id}")
    metadata = snapshot.get("metadata") or {}
    candidate_metadata = metadata.get("candidate_metadata") or {}
    problem_key = str(candidate.get("problem_key", ""))
    if str(candidate_metadata.get("problem_key", "")) != problem_key:
        raise PackageError(f"Published-dataset problem key mismatch for {sample_id}")
    provenance = candidate_metadata.get("provenance") or {}
    required = (
        "dataset_id",
        "dataset_revision",
        "dataset_file",
        "dataset_file_sha256",
        "split",
        "row_index",
        "solution_index",
        "cf_contest_id",
        "cf_index",
        "language",
        "language_code",
        "solution_label",
        "solution_container",
        "source_code",
    )
    missing = [name for name in required if provenance.get(name) in (None, "")]
    if missing:
        raise PackageError(f"Incomplete published-dataset provenance for {sample_id}: {missing}")
    exact_checks = {
        "dataset_id": CODECONTESTS_DATASET_ID,
        "dataset_revision": CODECONTESTS_REVISION,
        "dataset_file": CODECONTESTS_PARQUET.name,
        "dataset_file_sha256": CODECONTESTS_FILE_SHA256,
        "split": CODECONTESTS_SPLIT,
        "language": CODECONTESTS_LANGUAGE,
        "language_code": CODECONTESTS_LANGUAGE_CODE,
        "solution_label": CODECONTESTS_SOLUTION_LABEL,
        "solution_container": CODECONTESTS_SOLUTION_CONTAINER,
        "source_code": CODECONTESTS_SOURCE_CODE,
    }
    mismatches = [
        f"{name}={provenance.get(name)!r} (expected {expected!r})"
        for name, expected in exact_checks.items()
        if provenance.get(name) != expected
    ]
    if mismatches:
        raise PackageError(
            f"Non-canonical CodeContests provenance for {sample_id}: {', '.join(mismatches)}"
        )
    row_index = int(provenance["row_index"])
    solution_index = int(provenance["solution_index"])
    contest_id = int(provenance["cf_contest_id"])
    contest_index = str(provenance["cf_index"])
    if row_index < 0 or solution_index < 0 or contest_id <= 0 or not re.fullmatch(r"[A-Z][A-Z0-9]*", contest_index):
        raise PackageError(f"Invalid CodeContests row/solution/contest identity for {sample_id}")
    expected_problem_key = f"codeforces-{contest_id}-{contest_index}"
    if problem_key != expected_problem_key:
        raise PackageError(
            f"problem_key does not match CodeContests contest/index for {sample_id}: "
            f"{problem_key!r} != {expected_problem_key!r}"
        )
    canonical_identity = (
        f"{CODECONTESTS_DATASET_ID}@{CODECONTESTS_REVISION}:"
        f"{CODECONTESTS_SPLIT}:row-{row_index:06d}"
    )
    return dict(candidate_metadata), canonical_identity


def _load_codecontests_rows(dataset_path: Path) -> Dict[int, Dict[str, Any]]:
    dataset_path = _resolve_existing_under(
        dataset_path, HERE, "CodeContests parquet", require_file=True
    )
    if dataset_path.name != CODECONTESTS_PARQUET.name:
        raise PackageError(f"Unexpected CodeContests parquet filename: {dataset_path.name}")
    if _sha256_file(dataset_path) != CODECONTESTS_FILE_SHA256:
        raise PackageError("Immutable CodeContests parquet SHA256 does not match")
    try:
        import pyarrow.parquet as pq

        table = pq.read_table(
            dataset_path,
            columns=["name", "cf_contest_id", "cf_index", "solutions"],
        )
    except Exception as exc:
        raise PackageError(f"Cannot read immutable CodeContests parquet: {exc}") from exc
    return {index: row for index, row in enumerate(table.to_pylist())}


def _validate_codecontests_source_binding(
    candidate_metadata: Mapping[str, Any],
    candidate_pool_root: Path,
    dataset_rows: Mapping[int, Mapping[str, Any]],
) -> Path:
    provenance = candidate_metadata.get("provenance") or {}
    row_index = int(provenance["row_index"])
    solution_index = int(provenance["solution_index"])
    row = dataset_rows.get(row_index)
    if not isinstance(row, Mapping):
        raise PackageError(f"CodeContests row is unavailable: {row_index}")
    solutions = row.get("solutions") or {}
    languages = solutions.get("language") or []
    sources = solutions.get("solution") or []
    if not (0 <= solution_index < len(languages) == len(sources)):
        raise PackageError(
            f"CodeContests solution index is unavailable: row {row_index}, solution {solution_index}"
        )
    if int(languages[solution_index]) != CODECONTESTS_LANGUAGE_CODE:
        raise PackageError(
            f"CodeContests solution is not Java: row {row_index}, solution {solution_index}"
        )
    contest_id = int(provenance["cf_contest_id"])
    contest_index = str(provenance["cf_index"])
    if int(row.get("cf_contest_id", -1)) != contest_id or str(row.get("cf_index", "")) != contest_index:
        raise PackageError("CodeContests parquet contest identity differs from provenance")
    problem_name = str(row.get("name", ""))
    if candidate_metadata.get("problem_name") != problem_name:
        raise PackageError("CodeContests parquet problem name differs from candidate metadata")
    if provenance.get("problem_name") not in (None, problem_name):
        raise PackageError("CodeContests parquet problem name differs from provenance")

    original_value = candidate_metadata.get("original_path")
    if not original_value:
        raise PackageError("CodeContests candidate source path is missing")
    original_path = _resolve_existing_under(
        Path(str(original_value)),
        candidate_pool_root,
        "CodeContests candidate source",
        require_file=True,
    )
    original_bytes = original_path.read_bytes()
    try:
        original_text = original_bytes.decode("utf-8")
    except UnicodeDecodeError as exc:
        raise PackageError(f"CodeContests candidate source is not UTF-8: {original_path}") from exc
    if sources[solution_index] != original_text:
        raise PackageError("Candidate original.java is not byte-identical to the indexed parquet solution")
    if (
        candidate_metadata.get("source_sha256") != _sha256_bytes(original_bytes)
        or int(candidate_metadata.get("source_bytes", -1)) != len(original_bytes)
        or int(candidate_metadata.get("physical_loc", -1)) != len(original_text.splitlines())
        or int(candidate_metadata.get("nonblank_loc", -1))
        != sum(bool(line.strip()) for line in original_text.splitlines())
    ):
        raise PackageError("Candidate source hashes/metrics do not match the parquet-bound source")
    return original_path


def _resolve_audited_record(run: Mapping[str, Any], roots: Sequence[Path]) -> Tuple[Path, Path]:
    root_value = Path(str(run.get("result_root", ""))).resolve()
    if root_value not in roots:
        raise PackageError(f"Run refers to an unaudited result root: {root_value}")
    relative = Path(str(run.get("relative_record_path", "")))
    if relative.is_absolute():
        raise PackageError(f"Run relative_record_path is absolute: {relative}")
    record = _resolve_existing_under(relative, root_value, "audited run record", require_file=True)
    claimed = Path(str(run.get("record_path", ""))).resolve()
    if record != claimed:
        raise PackageError(f"Run record path claim mismatch: {claimed} != {record}")
    return record, root_value


def _copy_run_bundle(
    run: Mapping[str, Any], destination: Path, roots: Sequence[Path]
) -> None:
    record_path, result_root = _resolve_audited_record(run, roots)
    run_dir = record_path.parent
    observed = {path.name for path in run_dir.iterdir() if path.is_file()}
    missing = sorted(set(REQUIRED_RUN_ARTIFACTS) - observed)
    if missing:
        raise PackageError(f"Run bundle is missing required real artifacts {missing}: {run_dir}")
    for source in sorted(run_dir.iterdir(), key=lambda path: path.name):
        if source.is_symlink() or not source.is_file():
            raise PackageError(f"Run bundle contains a non-regular entry: {source}")
        _copy_file(source, destination / source.name, result_root)


def _copy_selected_sample_bundle(
    sample_id: str, destination: Path, roots: Sequence[Path]
) -> None:
    matching: List[Tuple[Path, Path]] = []
    for root in roots:
        sample_dir = root / "samples" / sample_id
        if sample_dir.is_dir():
            matching.append((sample_dir, root))
    if not matching:
        raise PackageError(f"Missing selected sample evidence directory: {sample_id}")
    reference_hashes: Optional[Dict[str, str]] = None
    for sample_dir, root in matching:
        observed = {path.name for path in sample_dir.iterdir() if path.is_file()}
        missing = sorted(set(REQUIRED_SAMPLE_ARTIFACTS) - observed)
        if missing:
            raise PackageError(
                f"Selected sample bundle is missing preflight/oracle evidence {missing}: {sample_dir}"
            )
        hashes = {
            path.name: _sha256_file(path)
            for path in sample_dir.iterdir()
            if path.is_file()
        }
        if reference_hashes is not None and hashes != reference_hashes:
            raise PackageError(f"Conflicting selected sample evidence across roots: {sample_id}")
        reference_hashes = hashes
        if len(matching) == 1 or sample_dir == matching[0][0]:
            for source in sorted(sample_dir.iterdir(), key=lambda path: path.name):
                if source.is_symlink() or not source.is_file():
                    raise PackageError(f"Sample bundle contains a non-regular entry: {source}")
                _copy_file(source, destination / source.name, root)


def _resolve_raw_concrete_case_io(
    metadata: Mapping[str, Any],
    tokenizer_evidence: Mapping[str, Any],
    sample_id: str,
) -> Tuple[str, str]:
    """Resolve the raw child case without allowing parent-level I/O to shadow it."""
    concrete = metadata.get("concrete_case") or {}
    if not isinstance(concrete, dict):
        raise PackageError(f"Sample snapshot lacks concrete-case metadata for {sample_id}")
    stdin = concrete.get("stdin", concrete.get("input"))
    expected_stdout = concrete.get("expected_stdout", concrete.get("expected_output"))
    source_manifest_dir = Path(tokenizer_evidence["source_manifest_path"]).parent
    stdin_path_value = concrete.get("stdin_path")
    oracle_path_value = concrete.get("expected_output_path") or concrete.get(
        "expected_stdout_path"
    )

    path_stdin: Optional[str] = None
    if stdin_path_value:
        path_stdin = _resolve_existing_under(
            Path(str(stdin_path_value)),
            source_manifest_dir,
            "concrete-case stdin",
            require_file=True,
        ).read_text(encoding="utf-8")
    path_oracle: Optional[str] = None
    if oracle_path_value:
        path_oracle = _resolve_existing_under(
            Path(str(oracle_path_value)),
            source_manifest_dir,
            "concrete-case oracle",
            require_file=True,
        ).read_text(encoding="utf-8")
    if stdin is None:
        stdin = path_stdin
    elif path_stdin is not None and stdin != path_stdin:
        raise PackageError(f"Concrete stdin path/string mismatch for {sample_id}")
    if expected_stdout is None:
        expected_stdout = path_oracle
    elif path_oracle is not None and expected_stdout != path_oracle:
        raise PackageError(f"Concrete oracle path/string mismatch for {sample_id}")
    if not isinstance(stdin, str) or not isinstance(expected_stdout, str):
        raise PackageError(f"Sample snapshot lacks resolvable concrete stdin/oracle for {sample_id}")

    stdin_hash = _sha256_bytes(stdin.encode("utf-8"))
    if concrete.get("input_sha256") != stdin_hash:
        raise PackageError(f"Concrete stdin hash mismatch for {sample_id}")
    if "input_bytes" in concrete and int(concrete["input_bytes"]) != len(stdin.encode("utf-8")):
        raise PackageError(f"Concrete stdin byte count mismatch for {sample_id}")
    raw_oracle_hash = concrete.get("raw_expected_stdout_sha256")
    if raw_oracle_hash and raw_oracle_hash != _sha256_bytes(expected_stdout.encode("utf-8")):
        raise PackageError(f"Concrete raw oracle hash mismatch for {sample_id}")
    if (
        "expected_output_bytes" in concrete
        and int(concrete["expected_output_bytes"]) != len(expected_stdout.encode("utf-8"))
    ):
        raise PackageError(f"Concrete oracle byte count mismatch for {sample_id}")
    if (
        "expected_output_lines" in concrete
        and int(concrete["expected_output_lines"]) != len(expected_stdout.splitlines())
    ):
        raise PackageError(f"Concrete oracle line count mismatch for {sample_id}")
    return stdin, expected_stdout


def _validate_loaded_sample_case_io(
    sample: Any, tokenizer_evidence: Mapping[str, Any]
) -> Tuple[str, str]:
    sample_id = str(sample.sample_id)
    raw_stdin, raw_oracle = _resolve_raw_concrete_case_io(
        sample.metadata, tokenizer_evidence, sample_id
    )
    if sample.stdin != raw_stdin or sample.expected_stdout != raw_oracle:
        raise PackageError(
            f"Runner-loaded I/O is shadowed or differs from the raw child case: {sample_id}"
        )
    return raw_stdin, raw_oracle


def _validate_case_materials(
    candidate: Mapping[str, Any],
    snapshot: Mapping[str, Any],
    run_map: Mapping[Tuple[int, str], Dict[str, Any]],
    best_run: Mapping[str, Any],
    roots: Sequence[Path],
    candidate_pool_root: Path,
    tokenizer_evidence: Mapping[str, Any],
) -> Dict[str, Any]:
    sample_id = str(candidate["sample_id"])
    best_trial = int(best_run["trial"])
    original_run = run_map[(best_trial, "original_plain")]
    obfuscated_run = run_map[(best_trial, CODESTEER_CONDITION)]
    original_record, original_root = _resolve_audited_record(original_run, roots)
    obfuscated_record, obfuscated_root = _resolve_audited_record(obfuscated_run, roots)
    original_source = _resolve_existing_under(
        original_record.parent / "source.java", original_root, "original source", require_file=True
    )
    obfuscated_source = _resolve_existing_under(
        obfuscated_record.parent / "source.java", obfuscated_root, "obfuscated source", require_file=True
    )
    oracle_path = _resolve_existing_under(
        obfuscated_record.parent / "oracle_stdout.txt",
        obfuscated_root,
        "oracle stdout",
        require_file=True,
    )
    original_hash = _sha256_file(original_source)
    obfuscated_hash = _sha256_file(obfuscated_source)
    expected_original = str(original_run.get("original_sha256", ""))
    expected_obfuscated = str(obfuscated_run.get("obfuscated_sha256", ""))
    if original_hash != expected_original or obfuscated_hash != expected_obfuscated:
        raise PackageError(f"Audited source hash mismatch for {sample_id}")
    if snapshot.get("original_sha256") != original_hash:
        raise PackageError(f"Sample snapshot original hash mismatch for {sample_id}")
    if snapshot.get("obfuscated_sha256") != obfuscated_hash:
        raise PackageError(f"Sample snapshot obfuscated hash mismatch for {sample_id}")

    candidate_metadata = ((snapshot.get("metadata") or {}).get("candidate_metadata") or {})
    original_text = original_source.read_text(encoding="utf-8")
    recomputed_physical_loc = len(original_text.splitlines())
    recomputed_nonblank_loc = sum(bool(line.strip()) for line in original_text.splitlines())
    if not 250 <= recomputed_physical_loc <= 350:
        raise PackageError(
            f"Recomputed original LOC is outside 250--350 for {sample_id}: {recomputed_physical_loc}"
        )
    if int(candidate_metadata.get("physical_loc", -1)) != recomputed_physical_loc:
        raise PackageError(f"Recorded/recomputed physical LOC mismatch for {sample_id}")
    if int(candidate_metadata.get("nonblank_loc", -1)) != recomputed_nonblank_loc:
        raise PackageError(f"Recorded/recomputed nonblank LOC mismatch for {sample_id}")
    if candidate_metadata.get("source_sha256") != original_hash:
        raise PackageError(f"CodeContests candidate source hash mismatch for {sample_id}")
    if int(candidate_metadata.get("source_bytes", -1)) != len(original_text.encode("utf-8")):
        raise PackageError(f"CodeContests candidate source byte count mismatch for {sample_id}")
    candidate_source_value = candidate_metadata.get("original_path")
    if not candidate_source_value:
        raise PackageError(f"CodeContests candidate source path is missing for {sample_id}")
    candidate_source = _resolve_existing_under(
        Path(str(candidate_source_value)),
        candidate_pool_root,
        "CodeContests candidate source",
        require_file=True,
    )
    if _sha256_file(candidate_source) != original_hash or candidate_source.read_text(encoding="utf-8") != original_text:
        raise PackageError(f"Candidate-pool source lineage mismatch for {sample_id}")

    metadata = snapshot.get("metadata") or {}
    stdin, expected_stdout = _resolve_raw_concrete_case_io(
        metadata, tokenizer_evidence, sample_id
    )
    sample_evidence = _sample_evidence_dirs(sample_id, roots)
    evidence_stdin = (sample_evidence[0][0] / "stdin.txt").read_text(encoding="utf-8")
    evidence_oracle = (sample_evidence[0][0] / "oracle_stdout.txt").read_text(encoding="utf-8")
    if stdin != evidence_stdin or expected_stdout != evidence_oracle:
        raise PackageError(f"Concrete case differs from stored sample evidence for {sample_id}")
    stdin_hash = _sha256_bytes(stdin.encode("utf-8"))
    oracle = oracle_path.read_text(encoding="utf-8")
    if oracle != expected_stdout:
        raise PackageError(f"Sample snapshot and audited oracle differ for {sample_id}")
    oracle_hash = _sha256_bytes(oracle.encode("utf-8"))

    return {
        "original_source": original_source,
        "obfuscated_source": obfuscated_source,
        "oracle_path": oracle_path,
        "stdin": stdin,
        "stdin_sha256": stdin_hash,
        "oracle_sha256": oracle_hash,
        "original_sha256": original_hash,
        "obfuscated_sha256": obfuscated_hash,
        "recomputed_physical_loc": recomputed_physical_loc,
        "recomputed_nonblank_loc": recomputed_nonblank_loc,
    }


def _scrub_oracle_fields(value: Any) -> Any:
    """Remove oracle-bearing metadata before oracle-independence reconstruction."""
    if isinstance(value, dict):
        return {
            key: _scrub_oracle_fields(item)
            for key, item in value.items()
            if key
            not in {
                "expected_stdout",
                "expected_output",
                "expected_stdout_trimmed",
                "expected_stdout_path",
                "expected_output_path",
                "expected_stdout_sha256",
                "raw_expected_stdout_sha256",
                "oracle_stdout",
                "oracle_stdout_canonical",
            }
        }
    if isinstance(value, list):
        return [_scrub_oracle_fields(item) for item in value]
    return value


def _sample_evidence_dirs(sample_id: str, roots: Sequence[Path]) -> List[Tuple[Path, Path]]:
    found: List[Tuple[Path, Path]] = []
    for root in roots:
        path = root / "samples" / sample_id
        if path.is_dir():
            found.append(
                (_resolve_existing_under(path, root, "sample evidence", require_file=False), root)
            )
    if not found:
        raise PackageError(f"Missing sample evidence for {sample_id}")
    return found


def _load_registered_runner(roots: Sequence[Path]) -> Any:
    runner_hashes: set[str] = set()
    for root in roots:
        environment = _read_json_object(root / "environment.json", "experiment environment")
        provenance = environment.get("runtime_code_provenance") or {}
        dependency_hashes = provenance.get("dependency_sha256") or {}
        digest = dependency_hashes.get("PromptSteering/long-code-sample-work/run_long_code_experiment.py")
        if not isinstance(digest, str):
            raise PackageError(f"Experiment environment lacks registered runner hash: {root}")
        if environment.get("runner_sha256") != digest:
            raise PackageError(f"Experiment runner hash fields disagree: {root}")
        runner_hashes.add(digest)
    if len(runner_hashes) != 1:
        raise PackageError(f"Result roots used different runner source hashes: {sorted(runner_hashes)}")
    digest = next(iter(runner_hashes))
    source = _find_dependency_source(
        "PromptSteering/long-code-sample-work/run_long_code_experiment.py", digest
    )
    spec = importlib.util.spec_from_file_location(f"packaged_runner_{digest[:16]}", source)
    if spec is None or spec.loader is None:
        raise PackageError(f"Cannot load registered runner source: {source}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    try:
        spec.loader.exec_module(module)
    except Exception as exc:
        raise PackageError(f"Cannot import registered runner source {source}: {exc}") from exc
    finally:
        sys.modules.pop(spec.name, None)
    # A preserved runner snapshot lives in a provenance directory, so reset
    # only its path constants to the original project layout before invoking
    # pure manifest/prompt helpers. The loaded function bodies remain the exact
    # hash-registered source.
    module.WORK_ROOT = HERE
    module.PROJECT_ROOT = PROJECT_ROOT
    module.PROMPT_STEERING_ROOT = HERE.parent
    return module


def _eligible_token_record_map(token_report: Mapping[str, Any]) -> Dict[str, Dict[str, Any]]:
    return {
        str(record.get("sample_id", "")): record
        for record in (token_report.get("records") or [])
        if isinstance(record, dict)
        and (record.get("decision") or {}).get("inference_eligible") is True
    }


def _validate_recomputation_dependencies(roots: Sequence[Path]) -> None:
    """Prove that imported helper modules equal the experiment-registered sources."""
    runner_name = "PromptSteering/long-code-sample-work/run_long_code_experiment.py"
    for root in roots:
        environment = _read_json_object(root / "environment.json", "experiment environment")
        dependency_hashes = (
            (environment.get("runtime_code_provenance") or {}).get("dependency_sha256") or {}
        )
        for relative_name, expected in dependency_hashes.items():
            if relative_name == runner_name:
                continue
            source = PROJECT_ROOT / str(relative_name)
            if not source.is_file() or _sha256_file(source) != expected:
                raise PackageError(
                    "Cannot recompute tokenizer priors with a non-registered local dependency: "
                    f"{relative_name}"
                )


def _recompute_tokenizer_evidence(evidence: Mapping[str, Any], registered_runner: Any) -> None:
    """Re-tokenize and rebuild every saved prior using exact registered inputs."""
    bound_roots = sorted(evidence.get("bound_roots") or set())
    _validate_recomputation_dependencies(bound_roots)
    source_samples, _ = registered_runner.load_manifest(evidence["source_manifest_path"])
    records = evidence["report"].get("records") or []
    record_map = {str(record.get("sample_id", "")): record for record in records}
    if {sample.sample_id for sample in source_samples} != set(record_map):
        raise PackageError("Tokenizer source samples do not exactly match denominator records")
    tokenizer = tokenizer_preflight.load_offline_tokenizer(evidence["tokenizer_snapshot_dir"])
    declared_tokenizer = evidence["report"].get("tokenizer") or {}
    if (
        declared_tokenizer.get("tokenizer_class") != type(tokenizer).__name__
        or int(declared_tokenizer.get("vocab_size", -1)) != len(tokenizer)
        or int(declared_tokenizer.get("model_max_length", -1))
        != int(getattr(tokenizer, "model_max_length", -2))
        or declared_tokenizer.get("padding_side") != getattr(tokenizer, "padding_side", None)
    ):
        raise PackageError("Tokenizer identity metadata fails exact offline reload")

    def registered_prompt_builder(
        code_snippet: str,
        *,
        instruction: str,
        language: str,
        answer_prefix: str = "",
    ) -> str:
        return f"{instruction}\n\n```{language}\n{code_snippet}\n```{answer_prefix or ''}"

    tokenizer_runner = tokenizer_preflight.TokenizerOnlyRunner(
        tokenizer, prompt_builder=registered_prompt_builder
    )
    fields = (
        "denominator_index",
        "sample_id",
        "parent_variant_id",
        "case_id",
        "decision",
        "inputs",
        "prompt",
        "slicing_prior",
        "slice_hybrid",
        "inference_helper_result",
        "prompt_slice_metadata",
    )
    for denominator_index, sample in enumerate(source_samples, 1):
        saved = record_map[sample.sample_id]
        if int(saved.get("denominator_index", -1)) != denominator_index:
            raise PackageError(
                f"Tokenizer denominator order differs from source manifest: {sample.sample_id}"
            )
        recomputed = tokenizer_preflight.evaluate_sample(
            sample,
            tokenizer_runner,
            registered_runner,
            denominator_index=denominator_index,
        )
        saved_core = {field: saved.get(field) for field in fields}
        recomputed_core = {field: recomputed.get(field) for field in fields}
        if _stable_json(saved_core) != _stable_json(recomputed_core):
            raise PackageError(
                f"Tokenizer/prior report fails exact offline recomputation: {sample.sample_id}"
            )


def _validate_run_lineage(
    report: Mapping[str, Any],
    roots: Sequence[Path],
    tokenizer_evidence_sets: Sequence[Mapping[str, Any]],
) -> List[Dict[str, Any]]:
    """Reconstruct all prompts and verify source/input/oracle/output lineage."""
    sample_entries: Dict[str, Tuple[Any, Any, Dict[str, Any], Mapping[str, Any]]] = {}
    for evidence in tokenizer_evidence_sets:
        bound_roots = sorted(evidence.get("bound_roots") or set())
        registered_runner = _load_registered_runner(bound_roots)
        _recompute_tokenizer_evidence(evidence, registered_runner)
        samples, _manifest_meta = registered_runner.load_manifest(evidence["manifest_path"])
        token_records = _eligible_token_record_map(evidence["report"])
        if {sample.sample_id for sample in samples} != set(token_records):
            raise PackageError(
                "Tokenizer records do not exactly match their filtered prompt-reconstruction manifest"
            )
        for sample in samples:
            if sample.sample_id in sample_entries:
                raise PackageError(f"Duplicate sample across tokenizer evidence sets: {sample.sample_id}")
            sample_entries[sample.sample_id] = (
                sample,
                registered_runner,
                token_records[sample.sample_id],
                evidence,
            )
    candidates = report.get("candidates", []) or []
    candidate_ids = {str(candidate.get("sample_id", "")) for candidate in candidates}
    if set(sample_entries) != candidate_ids:
        raise PackageError("Prompt reconstruction samples do not exactly match audited candidates")

    lineage_rows: List[Dict[str, Any]] = []
    for candidate in candidates:
        sample_id = str(candidate["sample_id"])
        sample, registered_runner, token_record, evidence = sample_entries[sample_id]
        _validate_loaded_sample_case_io(sample, evidence)
        conditions, _prompt_meta = registered_runner.prepare_conditions(sample)
        condition_map = {condition.name: condition for condition in conditions}
        if set(condition_map) != set(ALL_CONDITIONS):
            raise PackageError(f"Runner reconstruction omitted conditions for {sample_id}")

        scrubbed_sample = dataclasses.replace(
            sample,
            expected_stdout="__WITHHELD_ORACLE_SENTINEL__",
            metadata=_scrub_oracle_fields(sample.metadata),
        )
        scrubbed_conditions, _ = registered_runner.prepare_conditions(scrubbed_sample)
        scrubbed_map = {condition.name: condition for condition in scrubbed_conditions}
        for condition_name in ALL_CONDITIONS:
            left = condition_map[condition_name]
            right = scrubbed_map[condition_name]
            if left.instruction != right.instruction or left.source_code != right.source_code:
                raise PackageError(
                    f"Prompt reconstruction depends on oracle-bearing metadata: {sample_id}/{condition_name}"
                )

        token_condition = condition_map[CODESTEER_CONDITION]
        expected_token_prompt = (
            f"{token_condition.instruction}\n\n```java\n{token_condition.source_code}\n```"
        )
        if (token_record.get("prompt") or {}).get("text") != expected_token_prompt:
            raise PackageError(f"Tokenizer prompt fails exact registered-runner reconstruction: {sample_id}")
        token_inputs = token_record.get("inputs") or {}
        if (
            token_inputs.get("original_target_method") != sample.original_target_method
            or token_inputs.get("obfuscated_target_method") != sample.obfuscated_target_method
        ):
            raise PackageError(f"Tokenizer target-method lineage mismatch: {sample_id}")
        for source_kind, sample_path in (
            ("original", sample.original_path),
            ("obfuscated", sample.obfuscated_path),
        ):
            recorded_value = token_inputs.get(f"{source_kind}_path")
            if not recorded_value:
                raise PackageError(f"Tokenizer record lacks {source_kind} source path: {sample_id}")
            recorded_path = _resolve_existing_under(
                Path(str(recorded_value)),
                HERE,
                f"tokenizer {source_kind} source",
                require_file=True,
            )
            if _sha256_file(recorded_path) != _sha256_file(sample_path):
                raise PackageError(f"Tokenizer {source_kind} source hash lineage mismatch: {sample_id}")

        evidence_dirs = _sample_evidence_dirs(sample_id, roots)
        evidence_payloads: List[Dict[str, Any]] = []
        for evidence_dir, evidence_root in evidence_dirs:
            missing = [name for name in REQUIRED_SAMPLE_ARTIFACTS if not (evidence_dir / name).is_file()]
            if missing:
                raise PackageError(f"Sample evidence is incomplete for {sample_id}: {missing}")
            stdin_text = (evidence_dir / "stdin.txt").read_text(encoding="utf-8")
            oracle_text = (evidence_dir / "oracle_stdout.txt").read_text(encoding="utf-8")
            original_text = (evidence_dir / "original.java").read_text(encoding="utf-8")
            obfuscated_text = (evidence_dir / "obfuscated.java").read_text(encoding="utf-8")
            if stdin_text != sample.stdin:
                raise PackageError(f"Stored stdin differs from inference manifest for {sample_id}")
            if sample.expected_stdout is None or oracle_text != sample.expected_stdout:
                raise PackageError(f"Stored oracle differs from inference manifest for {sample_id}")
            if original_text != sample.original_path.read_text(encoding="utf-8"):
                raise PackageError(f"Stored original source differs from inference manifest for {sample_id}")
            if obfuscated_text != sample.obfuscated_path.read_text(encoding="utf-8"):
                raise PackageError(f"Stored obfuscated source differs from inference manifest for {sample_id}")
            oracle_json = _read_json_object(evidence_dir / "oracle.json", "sample oracle")
            if (
                oracle_json.get("manifest_oracle_verified") is not True
                or oracle_json.get("semantic_equivalence_verified") is not True
                or oracle_json.get("oracle_stdout") != oracle_text
                or (oracle_json.get("original_execution") or {}).get("stdout") != oracle_text
                or (oracle_json.get("obfuscated_execution") or {}).get("stdout") != oracle_text
                or (oracle_json.get("original_execution") or {}).get("success") is not True
                or (oracle_json.get("obfuscated_execution") or {}).get("success") is not True
            ):
                raise PackageError(f"Stored executable oracle evidence is invalid for {sample_id}")
            preflight = _read_json_object(evidence_dir / "preflight.json", "sample preflight")
            prior = preflight.get("codesteer_prior") or {}
            if (
                preflight.get("eligible_for_inference") is not True
                or preflight.get("rejection_reasons") not in ([], None)
                or prior.get("algorithm_fallback_detected") is not False
                or prior.get("case_signal_active") is not True
            ):
                raise PackageError(f"Stored runtime preflight is invalid for {sample_id}")
            evidence_payloads.append(
                {
                    name: _sha256_file(evidence_dir / name)
                    for name in REQUIRED_SAMPLE_ARTIFACTS
                }
            )
        if any(payload != evidence_payloads[0] for payload in evidence_payloads[1:]):
            raise PackageError(f"Sample evidence differs across result roots for {sample_id}")

        run_map = _candidate_run_map(candidate)
        for trial in EXPECTED_TRIALS:
            for condition_name in ALL_CONDITIONS:
                run = run_map[(trial, condition_name)]
                record_path, result_root = _resolve_audited_record(run, roots)
                if (
                    result_root not in set(evidence.get("bound_roots") or set())
                    or sample_id
                    not in (evidence.get("root_sample_ids") or {}).get(result_root, set())
                ):
                    raise PackageError(
                        f"Audited run is not bound to its sample's tokenizer gate/root: "
                        f"{sample_id}/{trial}/{condition_name}"
                    )
                run_dir = record_path.parent
                missing = [name for name in REQUIRED_RUN_ARTIFACTS if not (run_dir / name).is_file()]
                if missing:
                    raise PackageError(
                        f"Run lacks complete raw lineage artifacts {missing}: {sample_id}/{trial}/{condition_name}"
                    )
                condition = condition_map[condition_name]
                expected_prompt = (
                    f"{condition.instruction}\n\n```java\n{condition.source_code}\n```"
                )
                submitted = (run_dir / "submitted_prompt.txt").read_text(encoding="utf-8")
                decoded = (run_dir / "model_prompt_decoded.txt").read_text(encoding="utf-8")
                source = (run_dir / "source.java").read_text(encoding="utf-8")
                oracle = (run_dir / "oracle_stdout.txt").read_text(encoding="utf-8")
                completion = (run_dir / "raw_completion.txt").read_text(encoding="utf-8")
                predicted = (run_dir / "predicted_stdout.txt").read_text(encoding="utf-8")
                if submitted != expected_prompt or decoded != expected_prompt:
                    raise PackageError(
                        f"Submitted/model-decoded prompt fails runner reconstruction: "
                        f"{sample_id}/{trial}/{condition_name}"
                    )
                if source != condition.source_code:
                    raise PackageError(f"Run source fails manifest lineage: {sample_id}/{trial}/{condition_name}")
                if oracle != sample.expected_stdout:
                    raise PackageError(f"Run oracle fails manifest lineage: {sample_id}/{trial}/{condition_name}")
                parsed_stdout, parse_meta = registered_runner.parse_final_output(completion)
                if predicted != (parsed_stdout if parsed_stdout is not None else ""):
                    raise PackageError(f"Saved predicted stdout fails completion lineage: {sample_id}/{trial}/{condition_name}")
                score = _read_json_object(run_dir / "score.json", "run score")
                if score.get("parse_status") != parse_meta.get("parse_status"):
                    raise PackageError(f"Run score parse status fails recomputation: {sample_id}/{trial}/{condition_name}")
                if score.get("predicted_stdout") != parsed_stdout:
                    raise PackageError(f"Run score prediction fails recomputation: {sample_id}/{trial}/{condition_name}")
                if score.get("oracle_stdout_canonical") != registered_runner.normalize_stdout(oracle):
                    raise PackageError(f"Run score oracle fails recomputation: {sample_id}/{trial}/{condition_name}")
                record = _read_json_object(run_dir / "record.json", "run record")
                status = _read_json_object(run_dir / "status.json", "run status")
                if record != status:
                    raise PackageError(f"Run status and record differ: {sample_id}/{trial}/{condition_name}")
                model_output = _read_json_object(run_dir / "model_output.json", "model output")
                if (
                    model_output.get("prompt_text") != expected_prompt
                    or model_output.get("generated_completion") != completion
                    or model_output.get("score") != score
                    or (model_output.get("experiment") or {}).get("fingerprint") != run.get("fingerprint")
                ):
                    raise PackageError(f"Model output fails run lineage: {sample_id}/{trial}/{condition_name}")
                run_config = _read_json_object(run_dir / "run_config.json", "run config")
                if run_config.get("prompt_sha256") != _sha256_bytes(expected_prompt.encode("utf-8")):
                    raise PackageError(f"Run config prompt hash fails reconstruction: {sample_id}/{trial}/{condition_name}")
                lineage_rows.append(
                    {
                        "sample_id": sample_id,
                        "trial": trial,
                        "condition": condition_name,
                        "prompt_sha256": _sha256_bytes(expected_prompt.encode("utf-8")),
                        "stdin_sha256": _sha256_bytes(sample.stdin.encode("utf-8")),
                        "oracle_sha256": _sha256_bytes(oracle.encode("utf-8")),
                        "oracle_withheld_reconstruction_identical": True,
                        "record_relative_path": str(run.get("relative_record_path", "")),
                    }
                )
    return lineage_rows


def _select_cases(
    report: Mapping[str, Any],
    roots: Sequence[Path],
    candidate_pool_root: Path,
    dataset_rows: Mapping[int, Mapping[str, Any]],
    manual_review: Optional[Mapping[str, Any]] = None,
) -> List[Dict[str, Any]]:
    candidates = report.get("candidates", [])
    strict = [candidate for candidate in candidates if candidate.get("strict_eligible") is True]
    declared_count = int((report.get("selection") or {}).get("strict_eligible_count", -1))
    if declared_count != len(strict):
        raise PackageError("Audit strict-eligible count is internally inconsistent")
    paired_mode = (
        manual_review is not None
        and manual_review.get("schema_version") == PAIRED_MANUAL_REVIEW_SCHEMA_VERSION
    )
    if paired_mode:
        selected_ids = {
            str(entry.get("sample_id", ""))
            for entry in (manual_review.get("entries") or [])
            if isinstance(entry, dict)
        }
        candidate_pool = [
            candidate
            for candidate in candidates
            if isinstance(candidate, dict)
            and str(candidate.get("sample_id", "")) in selected_ids
        ]
        if len(selected_ids) != CASE_COUNT or len(candidate_pool) != CASE_COUNT:
            raise PackageError(
                "Paired-trial review does not resolve to ten distinct audited inputs"
            )
    else:
        candidate_pool = strict

    grouped: Dict[str, List[Dict[str, Any]]] = defaultdict(list)
    problem_to_identity: Dict[str, str] = {}
    identity_to_problem: Dict[str, str] = {}
    enriched: List[Dict[str, Any]] = []
    for candidate_any in candidate_pool:
        if not isinstance(candidate_any, dict):
            raise PackageError("Malformed selected candidate in audit")
        candidate = candidate_any
        if paired_mode:
            run_map, eligible_trials = _paired_trial_eligible_trials(candidate)
            if not eligible_trials:
                raise PackageError(
                    f"Selected candidate lacks a paired-eligible trial: "
                    f"{candidate.get('sample_id')}"
                )
            best = _best_codesteer_run(candidate, run_map)
        else:
            run_map, best = _validate_strict_candidate(candidate)
        sample_id = str(candidate["sample_id"])
        snapshot, snapshot_path = _locate_sample_snapshot(sample_id, roots)
        candidate_metadata, canonical_identity = _validate_problem_provenance(candidate, snapshot)
        parquet_bound_source = _validate_codecontests_source_binding(
            candidate_metadata, candidate_pool_root, dataset_rows
        )
        provenance = candidate_metadata["provenance"]
        expected_identity_fields = {
            "dataset_id": CODECONTESTS_DATASET_ID,
            "dataset_revision": CODECONTESTS_REVISION,
            "dataset_file_sha256": CODECONTESTS_FILE_SHA256,
            "split": CODECONTESTS_SPLIT,
            "row_index": int(provenance["row_index"]),
            "cf_contest_id": int(provenance["cf_contest_id"]),
            "cf_index": str(provenance["cf_index"]).strip(),
        }
        if candidate.get("canonical_problem_identity") != canonical_identity:
            raise PackageError(
                f"Packager/auditor canonical problem identity mismatch for {sample_id}"
            )
        if candidate.get("canonical_problem_identity_fields") != expected_identity_fields:
            raise PackageError(
                f"Packager/auditor canonical problem identity fields mismatch for {sample_id}"
            )
        problem_key = str(candidate["problem_key"])
        prior_identity = problem_to_identity.setdefault(problem_key, canonical_identity)
        prior_problem = identity_to_problem.setdefault(canonical_identity, problem_key)
        if prior_identity != canonical_identity or prior_problem != problem_key:
            raise PackageError(
                "Audit problem keys and canonical CodeContests row/contest identities are not one-to-one"
            )
        item = {
            "candidate": candidate,
            "run_map": run_map,
            "best": best,
            "snapshot": snapshot,
            "snapshot_path": snapshot_path,
            "candidate_metadata": candidate_metadata,
            "canonical_problem_identity": canonical_identity,
            "parquet_bound_source": parquet_bound_source,
        }
        grouped[canonical_identity].append(item)
        enriched.append(item)

    if paired_mode:
        if len(enriched) != CASE_COUNT:
            raise PackageError("Paired-trial enrichment did not retain exactly ten inputs")
    elif len(strict) < CASE_COUNT or len(grouped) < CASE_COUNT:
        raise PackageError(
            f"Need at least {CASE_COUNT} strict candidates from distinct true problem keys; "
            f"found {len(strict)} candidates across {len(grouped)} problems"
        )

    if manual_review is not None:
        enriched_by_sample = {
            str(item["candidate"]["sample_id"]): item for item in enriched
        }
        ordered: List[Dict[str, Any]] = []
        for entry_any in manual_review.get("entries") or []:
            entry = entry_any if isinstance(entry_any, dict) else {}
            sample_id = str(entry.get("sample_id", ""))
            item = enriched_by_sample.get(sample_id)
            if item is None:
                raise PackageError(
                    f"Validated manual-review sample is absent from strict enrichment: {sample_id}"
                )
            trial = int(entry["selected_codesteer_trial"])
            selected_run = item["run_map"][(trial, CODESTEER_CONDITION)]
            if selected_run.get("fingerprint") != entry.get(
                "selected_codesteer_fingerprint"
            ):
                raise PackageError(f"Manual review run changed during selection: {sample_id}")
            ordered.append(
                {
                    **item,
                    "heuristic_best": item["best"],
                    "best": selected_run,
                    "manual_review_entry": dict(entry),
                }
            )
        if len(ordered) != CASE_COUNT:
            raise PackageError("Manual review did not resolve to exactly ten selected cases")
        return ordered

    per_problem: List[Dict[str, Any]] = []
    for canonical_identity in sorted(grouped):
        variants = sorted(
            grouped[canonical_identity],
            key=lambda item: (
                -float((item["best"].get("trace_quality") or {}).get("score", 0.0)),
                str(item["candidate"]["sample_id"]),
            ),
        )
        per_problem.append(variants[0])
    per_problem.sort(
        key=lambda item: (
            -float((item["best"].get("trace_quality") or {}).get("score", 0.0)),
            str(item["candidate"]["sample_id"]),
            str(item["canonical_problem_identity"]),
        )
    )
    return per_problem[:CASE_COUNT]


def _validate_all_audited_dataset_bindings(
    report: Mapping[str, Any],
    roots: Sequence[Path],
    candidate_pool_root: Path,
    dataset_rows: Mapping[int, Mapping[str, Any]],
) -> None:
    for candidate_any in report.get("candidates", []) or []:
        if not isinstance(candidate_any, dict):
            raise PackageError("Malformed candidate in audit")
        candidate = candidate_any
        sample_id = str(candidate.get("sample_id", ""))
        snapshot, _ = _locate_sample_snapshot(sample_id, roots)
        candidate_metadata, canonical_identity = _validate_problem_provenance(
            candidate, snapshot
        )
        parquet_source = _validate_codecontests_source_binding(
            candidate_metadata, candidate_pool_root, dataset_rows
        )
        snapshot_original_value = snapshot.get("original_source_path")
        if not snapshot_original_value:
            raise PackageError(f"Sample snapshot lacks original source path for {sample_id}")
        snapshot_original = _resolve_existing_under(
            Path(str(snapshot_original_value)),
            HERE,
            "audited original source",
            require_file=True,
        )
        parquet_hash = _sha256_file(parquet_source)
        if (
            _sha256_file(snapshot_original) != parquet_hash
            or snapshot.get("original_sha256") != parquet_hash
            or snapshot_original.read_bytes() != parquet_source.read_bytes()
        ):
            raise PackageError(
                f"Audited original source is not the parquet-bound Java solution: {sample_id}"
            )
        provenance = candidate_metadata["provenance"]
        expected_fields = {
            "dataset_id": CODECONTESTS_DATASET_ID,
            "dataset_revision": CODECONTESTS_REVISION,
            "dataset_file_sha256": CODECONTESTS_FILE_SHA256,
            "split": CODECONTESTS_SPLIT,
            "row_index": int(provenance["row_index"]),
            "cf_contest_id": int(provenance["cf_contest_id"]),
            "cf_index": str(provenance["cf_index"]),
        }
        if (
            candidate.get("canonical_problem_identity") != canonical_identity
            or candidate.get("canonical_problem_identity_fields") != expected_fields
        ):
            raise PackageError(
                f"Auditor canonical CodeContests identity mismatch for {sample_id}"
            )


def _case_readme(case_number: int, item: Mapping[str, Any]) -> str:
    candidate = item["candidate"]
    best = item["best"]
    exact = candidate["exact_counts"]
    manual_entry = item.get("manual_review_entry")
    if isinstance(manual_entry, dict):
        grounding = manual_entry["grounding_scores"]
        if manual_entry.get("selection_mode") == "paired_trial_contrast":
            return (
                f"# Case {case_number:02d}: {candidate['problem_key']}\n\n"
                "This concrete input was selected in an explicitly post-hoc, outcome- and "
                "oracle-aware paired-trial qualitative review. At the selected trial and "
                "paired seed, CodeSteer is exact while all three baselines are valid and "
                "non-exact. Baselines may be exact on other trials, and canonical problems "
                "may repeat across the ten selected inputs. This does not support an "
                "aggregate-performance or ten-problem generalization claim.\n\n"
                f"- Sample: `{candidate['sample_id']}`\n"
                f"- Selected paired trial: `{best['trial']}` "
                f"(paired seed `{best['paired_seed']}`)\n"
                f"- Reasoning quality: `{manual_entry['reasoning_quality']}`\n"
                f"- Grounding scores (source/input/state): `{grounding['source']}/"
                f"{grounding['input']}/{grounding['state']}`\n"
                f"- Review note: {manual_entry['review_note']}\n"
                f"- Exact outputs over all three trials (context only): original/plain "
                f"`{exact['original_plain']}/3`, obfuscated/plain "
                f"`{exact['obfuscated_plain']}/3`, prompt steering "
                f"`{exact['obfuscated_prompt_slice']}/3`, CodeSteer "
                f"`{exact['obfuscated_codesteer']}/3`\n\n"
                "The three folders under `paired_baselines/` are the same selected trial "
                "and seed as `codesteer_best/`; `all_trials/` retains the full twelve-run "
                "evidence and the review retains a note for every paired baseline failure.\n"
            )
        return (
            f"# Case {case_number:02d}: {candidate['problem_key']}\n\n"
            "This case is part of a post-hoc, outcome- and oracle-aware manual qualitative "
            "review. The review is separate from the frozen model-outcome-independent "
            "case-generation/ranking rules and does not "
            "support an aggregate-performance estimate.\n\n"
            f"- Sample: `{candidate['sample_id']}`\n"
            f"- Manually selected CodeSteer trial: `{best['trial']}` "
            f"(paired seed `{best['paired_seed']}`)\n"
            f"- Reasoning quality: `{manual_entry['reasoning_quality']}`\n"
            f"- Grounding scores (source/input/state): `{grounding['source']}/"
            f"{grounding['input']}/{grounding['state']}`\n"
            f"- Review note: {manual_entry['review_note']}\n"
            f"- Exact outputs over three trials: original/plain `{exact['original_plain']}/3`, "
            f"obfuscated/plain `{exact['obfuscated_plain']}/3`, prompt steering "
            f"`{exact['obfuscated_prompt_slice']}/3`, CodeSteer "
            f"`{exact['obfuscated_codesteer']}/3`\n\n"
            "The three folders under `paired_baselines/` use the same trial and seed as the "
            "manually selected run under the legacy path `codesteer_best/`. The complete "
            "twelve-run record is under `all_trials/`.\n"
        )
    return (
        f"# Case {case_number:02d}: {candidate['problem_key']}\n\n"
        "This case is part of a post-hoc, outcome-selected qualitative set. It was retained "
        "only after all three comparison conditions produced zero exact outputs across three "
        "sampled trials and CodeSteer produced at least one exact output. It is not an "
        "aggregate-performance estimate.\n\n"
        f"- Sample: `{candidate['sample_id']}`\n"
        f"- Best CodeSteer trial: `{best['trial']}` (paired seed `{best['paired_seed']}`)\n"
        f"- Best recorded trace-heuristic score: `{best['trace_quality']['score']}`\n"
        f"- Exact outputs over three trials: original/plain `{exact['original_plain']}/3`, "
        f"obfuscated/plain `{exact['obfuscated_plain']}/3`, prompt steering "
        f"`{exact['obfuscated_prompt_slice']}/3`, CodeSteer `{exact['obfuscated_codesteer']}/3`\n\n"
        "The three folders under `paired_baselines/` use the same trial and seed as "
        "`codesteer_best/`. The complete twelve-run record is under `all_trials/`.\n"
    )


def _summary_markdown(
    report: Mapping[str, Any],
    selected: Sequence[Mapping[str, Any]],
    token_report: Mapping[str, Any],
    supplemental_disclosure: Optional[Mapping[str, Any]] = None,
    balanced_disclosure: Optional[Mapping[str, Any]] = None,
    manual_review: Optional[Mapping[str, Any]] = None,
    balanced_extension_disclosure: Optional[Mapping[str, Any]] = None,
    balanced_extension2_disclosure: Optional[Mapping[str, Any]] = None,
) -> str:
    validation = report["validation"]
    selection = report["selection"]
    token_counts = token_report["counts"]
    paired_review = (
        manual_review is not None
        and manual_review.get("schema_version") == PAIRED_MANUAL_REVIEW_SCHEMA_VERSION
    )
    selection_description = (
        "The packaged order and selected trial are taken exactly from the validated paired-trial "
        "manual review. Each of its ten distinct sample IDs has one same-seed trial where "
        "CodeSteer is valid and exact while all three baselines are valid and non-exact. "
        "Baseline success on other trials is allowed. Canonical problems may repeat, so the "
        "actual distinct-problem count and repeat counts are reported explicitly."
        if paired_review
        else (
        "The deterministic selection first keeps the highest recorded best-trace heuristic "
        "candidate for each true dataset problem key (ties: lexical sample ID), then ranks "
        "those problem-level candidates by the same score (ties: lexical sample ID and problem key). "
        "The trace heuristic is applied only after the exact-output gate, never reads the oracle, "
        "and still requires manual qualitative review before publication."
        if manual_review is None
        else
        "The packaged order and displayed CodeSteer trial are taken exactly from the validated "
        "manual trace-review artifact. That review occurs only after the strict exact-output gate, "
        "is outcome- and oracle-aware, and is separate from the frozen "
        "model-outcome-independent case-generation/ranking rules. It "
        "does not change the complete screened pool or support an aggregate-performance claim."
        )
    )
    opening = (
        "This artifact is an explicitly post-hoc, outcome-selected qualitative set of ten "
        "distinct concrete inputs. Selection uses a same-trial paired contrast, not baseline "
        "zero-of-three across all trials and not ten distinct canonical problems. It does not "
        "support an aggregate-performance or ten-problem generalization claim."
        if paired_review
        else (
            "This artifact is a post-hoc, outcome-selected qualitative case set. The ten cases "
            "were chosen because CodeSteer had an exact output while all three comparison "
            "conditions had zero exact outputs across the registered three trials. Therefore, "
            "this subset is not representative and does not support an aggregate-performance claim."
        )
    )
    lines = [
        "# Ten long-code qualitative cases",
        "",
        opening,
        "",
        selection_description,
        "",
        "## Screen accounting",
        "",
        f"- Tokenizer/static denominator records: {token_counts['exploded_denominator_records']}",
        f"- Tokenizer exclusions: {token_counts['excluded_records']}",
        f"- Audited candidate records: {validation['candidate_count']}",
        f"- Complete and valid audited candidates: {validation['complete_valid_candidate_count']}",
        f"- Strict outcome-eligible candidates: {selection['strict_eligible_count']}",
        f"- Distinct strict-eligible problem keys: {selection['unique_problem_eligible_count']}",
        f"- Packaged cases: {len(selected)}",
        "",
    ]
    if supplemental_disclosure is not None:
        lines.extend(
            [
                "## Supplemental-screen disclosure",
                "",
                "The screened-source denominator remains frozen at 25. The 60 supplemental "
                "cases are repeated measurements on those sources, not new source-level "
                "observations.",
                "",
                f"- Outcome-blind selection: {supplemental_disclosure['outcome_blind_disclosure']}",
                f"- Timing: {supplemental_disclosure['timing_disclosure']}",
                "",
            ]
        )
    if balanced_disclosure is not None:
        wave_ids = ", ".join(
            str(wave["wave_id"]) for wave in balanced_disclosure["waves"]
        )
        execution = balanced_disclosure["execution_disclosure"]
        lines.extend(
            [
                "## Balanced-contingency disclosure",
                "",
                "The balanced contingency generated repeated concrete inputs without reading "
                "a model completion, score, or other outcome. Its immutable source denominator "
                "remains 25 (23 tokenizer-eligible sources spanning 19 canonical problems). "
                "Each included wave contributes exactly two cases per problem; invoking a wave "
                "still requires the registered complete-audit trigger.",
                "",
                f"- Included frozen waves: {wave_ids}",
                f"- Included balanced cases: {balanced_disclosure['balanced_case_count']}",
                f"- Timing: {balanced_disclosure['timing_disclosure']}",
                "- Administrative path correction: a 21-record startup attempt at a "
                "duplicated filesystem prefix was stopped and excluded from every audit and "
                "selection. The plans were path-rebased and refrozen without changing either "
                "case manifest, case input/oracle, or ranking.",
                "- Path-correction outcome-use disclosure: "
                f"{balanced_disclosure['administrative_path_correction']['outcome_use_disclosure']}",
                "- Execution-protocol deviation: the registered protocol prohibited interim "
                "looks, but an aggregate interim look did occur during corrected Wave 1. "
                f"{execution['disclosure']}",
                "- Current-wave consequence: no action, case, trial/condition, or stopping "
                "decision for the running wave changed because of that look.",
                "- Trigger preservation: Wave 2 still requires a complete valid post-Wave-1 "
                "audit. Any Wave 3/adaptive-extension launch still requires a complete valid "
                "post-Wave-2 audit below ten strict canonical problems.",
                "- Adaptive extension: it was motivated in part by the interim aggregate look, "
                "but its case ranking does not use model outcomes.",
                "- Excluded startup attempt: its result contents were not inspected.",
                "- Final strict eligibility and this ten-case qualitative selection remain "
                "post-hoc and outcome-conditioned. The automatic selection evidence does not "
                "stand in for the separately required manual trace review.",
                "",
            ]
        )
    if balanced_extension_disclosure is not None:
        extension_trigger = balanced_extension_disclosure["trigger_audit"]
        lines.extend(
            [
                "## Adaptive Wave-3 extension disclosure",
                "",
                "Wave 3 is an adaptive contingency. It is not preregistered and is not "
                "outcome-blind in timing: it was specified after an aggregate interim "
                "corrected-Wave-1 exact-count look. Its frozen case eligibility and ranks "
                "5--10 are deterministic and outcome-independent. The full frozen tree, "
                "both freeze anchors, control files, launch plan, and adaptive execution "
                "disclosure are included and checksummed.",
                "",
                f"- Timing: {balanced_extension_disclosure['timing_disclosure']}",
                "- Trigger: a complete valid post-Wave-2 audit was required and contained "
                f"{extension_trigger['post_wave_2_strict_unique_canonical_problem_count']} "
                "distinct strict canonical problems, below the threshold of ten.",
                f"- Included Wave-3 cases: {balanced_extension_disclosure['wave_3_case_count']}",
                "- Result-root binding: exactly four roots at the frozen HERE-relative "
                "paths, with shard sizes 29, 29, 28, and 28.",
                (
                    "- Publication selection: the included paired-trial review contains exactly "
                    f"ten distinct concrete inputs across {manual_review['distinct_canonical_problem_count']} "
                    "canonical problems; repeated problems are disclosed."
                    if paired_review and manual_review is not None
                    else "- Publication selection: the included manual review contains exactly "
                    "ten distinct canonical strict cases."
                ),
                "- Reporting remains qualitative and post-hoc; no aggregate success-rate "
                "display is supported for this selected case set.",
                "",
            ]
        )
    if balanced_extension2_disclosure is not None:
        trigger = balanced_extension2_disclosure["paired_trigger_audit"]
        included_waves = ", ".join(
            str(wave["wave_id"]) for wave in balanced_extension2_disclosure["waves"]
        )
        listing = balanced_extension2_disclosure[
            "packaging_execution_disclosure"
        ]
        lines.extend(
            [
                "## Adaptive Wave-4/5 extension and paired-trial refinement",
                "",
                "The frozen second extension is adaptive, outcome-aware from Wave 2, not "
                "preregistered, and not outcome-blind in timing. Its frozen case ranking and "
                "two prospective feasibility revisions were specified during live Wave 3 "
                "without inspecting a Wave-3 output or result. After the complete Wave-3 "
                "audit, the user requested an explicitly post-hoc paired-trial interpretation "
                "whose unit is a distinct concrete input rather than a canonical problem.",
                "",
                f"- Included completed waves: {included_waves}",
                "- Complete post-Wave-3 paired-eligible inputs: "
                f"{trigger['post_wave_3_paired_eligible_distinct_sample_id_count']} across "
                f"{trigger['post_wave_3_distinct_canonical_problem_count']} canonical problems.",
                "- Complete post-Wave-4 paired-eligible inputs: "
                f"{trigger['post_wave_4_paired_eligible_distinct_sample_id_count']} across "
                f"{trigger['post_wave_4_distinct_canonical_problem_count']} canonical problems.",
                "- Wave-5 decision: "
                + (
                    "included because the complete post-Wave-4 paired-input count remained "
                    "below ten."
                    if trigger["wave_5_included"]
                    else "stopped/skipped because the complete post-Wave-4 paired-input count "
                    "reached at least ten."
                ),
                "- Frozen evidence: both anchors, exactly 3,362 generated files, 20 controls, "
                "both failed larger-design archives, exact tokenizer gates, and exact launch "
                "plans are included and checksummed.",
                "- Packaging-process correction: a filename-only search did list result path "
                "names. It did not read result-file content, inspect progress or outcomes, or "
                "change cases, settings, the ongoing run, or a trigger decision. "
                f"Recorded disclosure flag: `{listing['result_path_names_listed']}`.",
                "- Publication selection remains qualitative and post-hoc. The artifact "
                "reports the actual canonical-problem count and repeats and makes no "
                "ten-problem or aggregate-performance claim.",
                "",
            ]
        )
    if manual_review is not None:
        if paired_review:
            lines.extend(
                [
                    "## Paired-trial manual review disclosure",
                    "",
                    "The review is explicitly post-hoc, outcome- and oracle-aware. It selects "
                    "exactly ten distinct sample IDs, requires one same-seed paired trial per "
                    "entry, retains the exact CodeSteer fingerprint and three baseline failure "
                    "notes, and allows canonical-problem repeats and baseline successes on "
                    "other trials.",
                    "",
                    f"- Schema: `{manual_review['schema_version']}`",
                    f"- Review SHA-256: `{manual_review['sha256']}`",
                    f"- Distinct concrete inputs: {manual_review['distinct_sample_id_count']}",
                    "- Actual distinct canonical problems: "
                    f"{manual_review['distinct_canonical_problem_count']}",
                    "- Entries repeating an already represented canonical problem: "
                    f"{manual_review['canonical_problem_repeat_entry_count']}",
                    "",
                ]
            )
        else:
            lines.extend(
            [
                "## Manual trace-review disclosure",
                "",
                "The included review is explicitly post-hoc, outcome- and oracle-aware. It is "
                "a qualitative publication screen, not part of the outcome-blind generation of "
                "initial, supplemental, or balanced concrete cases. Its ordered ten entries "
                "override only the heuristic choice/order and displayed exact CodeSteer trial.",
                "",
                f"- Schema: `{manual_review['schema_version']}`",
                f"- Review SHA-256: `{manual_review['sha256']}`",
                f"- Publishable entries: {manual_review['entry_count']}",
                "",
            ]
            )
    lines.extend(
        [
            "## Selected cases",
            "",
            (
                "| Case | Problem key | Sample | Reviewed trial | Paired seed | Trace score | "
                "Exact outputs (orig / obf / prompt / CodeSteer) |"
                if manual_review is not None
                else "| Case | Problem key | Sample | Best trial | Paired seed | Trace score | "
                "Exact outputs (orig / obf / prompt / CodeSteer) |"
            ),
            "|---:|---|---|---:|---:|---:|---|",
        ]
    )
    for index, item in enumerate(selected, 1):
        candidate = item["candidate"]
        best = item["best"]
        exact = candidate["exact_counts"]
        counts = (
            f"{exact['original_plain']}/3 / {exact['obfuscated_plain']}/3 / "
            f"{exact['obfuscated_prompt_slice']}/3 / {exact['obfuscated_codesteer']}/3"
        )
        lines.append(
            f"| {index:02d} | {candidate['problem_key']} | `{candidate['sample_id']}` | "
            f"{best['trial']} | {best['paired_seed']} | {best['trace_quality']['score']} | {counts} |"
        )
    lines.extend(
        [
            "",
            "The complete audit JSON/CSVs and tokenizer exclusions are in `screened_pool/`; "
            "the exact scripts, configurations, and provenance records are retained alongside them.",
            "",
        ]
    )
    return "\n".join(lines)


def _root_config_files(root: Path) -> List[Path]:
    names = (
        "experiment_config.json",
        "environment.json",
        "preflight_rejections.json",
        "results_index.json",
    )
    return [root / name for name in names if (root / name).is_file()]


def _copy_complete_screened_roots(
    roots: Sequence[Path], destination: Path, report: Mapping[str, Any]
) -> List[Dict[str, Any]]:
    """Copy every stored run/sample bundle, not only selected examples."""
    root_index = {root: index for index, root in enumerate(roots, 1)}
    for root, index in root_index.items():
        root_dest = destination / f"root_{index:02d}"
        for tree_name in ("runs", "samples"):
            tree = root / tree_name
            if not tree.is_dir():
                raise PackageError(f"Screened result root lacks {tree_name}/: {root}")
            _copy_tree_files(tree, root_dest / tree_name, root)
        for source in sorted(root.iterdir(), key=lambda path: path.name):
            if source.is_file():
                _copy_file(source, root_dest / source.name, root)

    local_rows: List[Dict[str, Any]] = []
    for candidate in report.get("candidates", []) or []:
        sample_id = str(candidate.get("sample_id", ""))
        for run in candidate.get("runs", []) or []:
            record, root = _resolve_audited_record(run, roots)
            index = root_index[root]
            relative = record.relative_to(root)
            local_path = Path(f"root_{index:02d}") / relative
            if not (destination / local_path).is_file():
                raise PackageError(f"Copied local audit path is missing: {local_path}")
            local_rows.append(
                {
                    "sample_id": sample_id,
                    "trial": run.get("trial"),
                    "condition": run.get("condition"),
                    "fingerprint": run.get("fingerprint"),
                    "audited_relative_record_path": str(run.get("relative_record_path", "")),
                    "package_local_record_path": local_path.as_posix(),
                    "sha256": _sha256_file(destination / local_path),
                }
            )
    _write_json(destination / "local_audit_path_index.json", local_rows)
    return local_rows


def _find_dependency_source(relative_name: str, expected_hash: str) -> Path:
    relative = Path(relative_name)
    if relative.is_absolute() or ".." in relative.parts:
        raise PackageError(f"Unsafe runtime dependency path: {relative_name}")
    candidates: List[Path] = [PROJECT_ROOT / relative]
    snapshot_root = HERE / "runtime_snapshots"
    if snapshot_root.is_dir():
        candidates.extend(sorted(snapshot_root.rglob(relative.name)))
    for candidate in candidates:
        if candidate.is_file() and _sha256_file(candidate) == expected_hash:
            return candidate.resolve()
    raise PackageError(
        f"No exact runtime dependency source matches {relative_name} SHA256 {expected_hash}"
    )


def _copy_runtime_dependency_snapshots(
    roots: Sequence[Path], destination: Path
) -> List[Dict[str, Any]]:
    registered: Dict[Tuple[str, str], set[str]] = defaultdict(set)
    for root in roots:
        environment = _read_json_object(root / "environment.json", "experiment environment")
        provenance = environment.get("runtime_code_provenance") or {}
        dependency_hashes = provenance.get("dependency_sha256") or {}
        if not isinstance(dependency_hashes, dict) or not dependency_hashes:
            raise PackageError(f"Missing runtime dependency hashes: {root}")
        for relative_name, digest in dependency_hashes.items():
            digest_text = str(digest)
            if not re.fullmatch(r"[0-9a-f]{64}", digest_text):
                raise PackageError(f"Invalid runtime dependency digest in {root}: {relative_name}")
            registered[(str(relative_name), digest_text)].add(str(root))

    rows: List[Dict[str, Any]] = []
    for (relative_name, digest), source_roots in sorted(registered.items()):
        source = _find_dependency_source(relative_name, digest)
        relative = Path(relative_name)
        local = Path("by_sha256") / digest / relative
        _copy_file(source, destination / local, PROJECT_ROOT if source.is_relative_to(PROJECT_ROOT) else HERE)
        copied_hash = _sha256_file(destination / local)
        if copied_hash != digest:
            raise PackageError(f"Copied runtime dependency hash changed: {relative_name}")
        rows.append(
            {
                "dependency_path": relative.as_posix(),
                "sha256": digest,
                "package_local_path": local.as_posix(),
                "registered_by_result_roots": sorted(source_roots),
            }
        )
    _write_json(destination / "index.json", rows)
    return rows


def _write_checksums(package_root: Path) -> None:
    files = [
        path
        for path in package_root.rglob("*")
        if path.is_file() and path.name != "SHA256SUMS"
    ]
    rows = [
        f"{_sha256_file(path)}  {path.relative_to(package_root).as_posix()}"
        for path in sorted(files, key=lambda value: value.relative_to(package_root).as_posix())
    ]
    _write_text(package_root / "SHA256SUMS", "\n".join(rows) + "\n")


def package_case_study(
    *,
    audit_json: Path,
    audit_candidates_csv: Path,
    audit_runs_csv: Path,
    result_roots: Sequence[Path],
    output_dir: Path,
    tokenizer_report: Path,
    tokenizer_exclusions: Path,
    tokenizer_manifest: Path,
    tokenizer_evidence_set_name: Optional[str] = None,
    additional_tokenizer_evidence_sets: Sequence[
        Tuple[str, Path, Path, Path]
    ] = (),
    provenance_root: Path = HERE / "provenance",
    candidate_pool_root: Path = HERE / "candidate_pool",
    prepared_root: Path = HERE / "prepared_variants",
    dataset_path: Path = CODECONTESTS_PARQUET,
    balanced_contingency_root: Path = BALANCED_CONTINGENCY_ROOT,
    balanced_extension_contingency_root: Path = BALANCED_EXTENSION_ROOT,
    balanced_extension2_contingency_root: Path = BALANCED_EXTENSION2_ROOT,
    manual_review: Optional[Path] = None,
) -> Dict[str, Any]:
    """Validate inputs and atomically build one staging directory below ``HERE``."""
    # Every read source is intentionally constrained to the experiment work root.
    audit_json = _resolve_existing_under(audit_json, HERE, "audit JSON", require_file=True)
    audit_candidates_csv = _resolve_existing_under(
        audit_candidates_csv, HERE, "audit candidate CSV", require_file=True
    )
    audit_runs_csv = _resolve_existing_under(
        audit_runs_csv, HERE, "audit run CSV", require_file=True
    )
    manual_review_path = (
        _resolve_existing_under(
            manual_review, HERE, "manual trace review", require_file=True
        )
        if manual_review is not None
        else None
    )
    raw_tokenizer_sets: List[Tuple[str, Path, Path, Path]] = [
        (
            tokenizer_evidence_set_name or tokenizer_report.parent.name,
            tokenizer_report,
            tokenizer_exclusions,
            tokenizer_manifest,
        )
    ]
    raw_tokenizer_sets.extend(additional_tokenizer_evidence_sets)
    tokenizer_inputs: List[Dict[str, Any]] = []
    seen_tokenizer_names: set[str] = set()
    for raw_name, raw_report, raw_exclusions, raw_manifest in raw_tokenizer_sets:
        name = _safe_component(raw_name, "tokenizer evidence-set name")
        if name in seen_tokenizer_names:
            raise PackageError(f"Duplicate tokenizer evidence-set name: {name}")
        seen_tokenizer_names.add(name)
        tokenizer_inputs.append(
            {
                "name": name,
                "report_path": _resolve_existing_under(
                    raw_report, HERE, f"{name} tokenizer report", require_file=True
                ),
                "exclusions_path": _resolve_existing_under(
                    raw_exclusions, HERE, f"{name} tokenizer exclusions", require_file=True
                ),
                "manifest_path": _resolve_existing_under(
                    raw_manifest, HERE, f"{name} tokenizer manifest", require_file=True
                ),
            }
        )
    provenance_root = _resolve_existing_under(
        provenance_root, HERE, "provenance root", require_file=False
    )
    candidate_pool_root = _resolve_existing_under(
        candidate_pool_root, HERE, "candidate-pool root", require_file=False
    )
    prepared_root = _resolve_existing_under(
        prepared_root, HERE, "prepared-variants root", require_file=False
    )
    dataset_path = _resolve_existing_under(
        dataset_path, HERE, "CodeContests parquet", require_file=True
    )
    destination = _resolve_output_dir(output_dir)
    if destination.exists():
        raise PackageError(f"Staging destination already exists (no implicit overwrite): {destination}")
    if not destination.parent.is_dir():
        raise PackageError(
            "Staging parent must already exist; the packager creates no directories outside "
            f"its atomic build tree: {destination.parent}"
        )
    temp = Path(tempfile.mkdtemp(prefix=f".{destination.name}.building-", dir=destination.parent))
    try:
        validation_scratch = temp / ".validation" / "canonical_audit"
        report, roots = _validate_and_refresh_audit(
            audit_json,
            audit_candidates_csv,
            audit_runs_csv,
            result_roots,
            validation_scratch,
        )
        manual_review_evidence = (
            _validate_manual_trace_review(
                manual_review_path,
                report=report,
                audit_json=audit_json,
                audit_candidates_csv=audit_candidates_csv,
                audit_runs_csv=audit_runs_csv,
            )
            if manual_review_path is not None
            else None
        )
        strict_ids = [
            str(candidate["sample_id"])
            for candidate in report.get("candidates", [])
            if candidate.get("strict_eligible") is True
        ]
        audited_ids = [str(candidate["sample_id"]) for candidate in report.get("candidates", [])]
        tokenizer_evidence_sets: List[Dict[str, Any]] = []
        for tokenizer_input in tokenizer_inputs:
            evidence = _validate_tokenizer_evidence(
                tokenizer_input["report_path"],
                tokenizer_input["exclusions_path"],
                tokenizer_input["manifest_path"],
                roots,
            )
            evidence["name"] = tokenizer_input["name"]
            tokenizer_evidence_sets.append(evidence)
        _validate_tokenizer_evidence_union(
            tokenizer_evidence_sets,
            audited_sample_ids=audited_ids,
            strict_sample_ids=strict_ids,
            result_roots=roots,
        )
        supplemental_disclosure = _validate_supplemental_disclosure(
            tokenizer_evidence_sets
        )
        supplemental_launch_plan = _validate_supplemental_launch_plan(
            tokenizer_evidence_sets
        )
        balanced_disclosure = _validate_balanced_contingency(
            tokenizer_evidence_sets,
            balanced_root=balanced_contingency_root,
        )
        balanced_extension_disclosure = _validate_balanced_extension_contingency(
            tokenizer_evidence_sets,
            extension_root=balanced_extension_contingency_root,
        )
        balanced_extension2_disclosure = _validate_balanced_extension2_contingency(
            tokenizer_evidence_sets,
            extension_root=balanced_extension2_contingency_root,
        )
        _validate_balanced_trigger_sequence(
            report, tokenizer_evidence_sets, balanced_disclosure
        )
        _validate_balanced_extension_trigger(
            report, tokenizer_evidence_sets, balanced_extension_disclosure
        )
        _validate_balanced_extension2_trigger(
            report, tokenizer_evidence_sets, balanced_extension2_disclosure
        )
        _require_balanced_extension_manual_review(
            balanced_extension_disclosure,
            manual_review_evidence,
            allow_paired_trial_mode=balanced_extension2_disclosure is not None,
        )
        _require_balanced_extension2_manual_review(
            balanced_extension2_disclosure, manual_review_evidence
        )
        if balanced_disclosure is not None and manual_review_evidence is not None:
            balanced_disclosure["manual_trace_review"] = {
                "required_before_publication": True,
                "included_in_this_automatic_selection_evidence": False,
                "included_as_separate_post_hoc_review": True,
                "sha256": manual_review_evidence["sha256"],
                "must_remain_separate_from_outcome_blind_case_generation": True,
            }
        resolved_balanced_root = (
            _resolve_existing_under(
                balanced_contingency_root,
                HERE,
                "balanced contingency root",
                require_file=False,
            )
            if balanced_disclosure is not None
            else None
        )
        resolved_balanced_extension_root = (
            _resolve_existing_under(
                balanced_extension_contingency_root,
                HERE,
                "balanced extension contingency root",
                require_file=False,
            )
            if balanced_extension_disclosure is not None
            else None
        )
        resolved_balanced_extension2_root = (
            _resolve_existing_under(
                balanced_extension2_contingency_root,
                HERE,
                "balanced Extension-2 contingency root",
                require_file=False,
            )
            if balanced_extension2_disclosure is not None
            else None
        )
        lineage_rows = _validate_run_lineage(report, roots, tokenizer_evidence_sets)
        dataset_rows = _load_codecontests_rows(dataset_path)
        _validate_all_audited_dataset_bindings(
            report, roots, candidate_pool_root, dataset_rows
        )
        selected = _select_cases(
            report,
            roots,
            candidate_pool_root,
            dataset_rows,
            manual_review_evidence,
        )
        aggregate_token_report = {
            "counts": {
                key: sum(
                    int((evidence["report"].get("counts") or {}).get(key, 0))
                    for evidence in tokenizer_evidence_sets
                )
                for key in (
                    "exploded_denominator_records",
                    "inference_eligible_records",
                    "excluded_records",
                    "preflight_error_records",
                )
            }
        }
        tokenizer_evidence_by_sample = {
            sample_id: evidence
            for evidence in tokenizer_evidence_sets
            for sample_id in evidence["eligible_ids"]
        }
        shutil.rmtree(temp / ".validation")

        _write_text(
            temp / "README.md",
            "# Long-code output-prediction case-study artifact\n\n"
            "Start with `SUMMARY.md`. This is a deterministic staging artifact for ten "
            "post-hoc, outcome-selected qualitative cases. It makes no aggregate-performance "
            "claim. It is self-contained for the stored experiment evidence: all screened raw "
            "run and sample bundles, referenced candidate/prepared source trees, exact runtime "
            "dependency snapshots, audit reports, and selected-case views are included. It does "
            "not include model weights, tokenizer binaries, the upstream dataset parquet, a "
            "JDK, the Python/CUDA environment, GPU driver/runtime, or installed third-party "
            "Python libraries, so reproducing inference/execution still requires those external "
            "dependencies. The small Java compatibility JAR used by the protocol is included "
            "and checksummed under `scripts/runtime_dependencies/java_compat/`. Original "
            "absolute paths remain provenance only; use "
            "`screened_pool/result_roots/local_audit_path_index.json` for package-local run "
            "paths. Treat `screened_pool/` as the relocated experiment work root when resolving "
            "the copied tokenizer, candidate-pool, and prepared-variant relative paths.\n",
        )
        _write_text(
            temp / "SUMMARY.md",
            _summary_markdown(
                report,
                selected,
                aggregate_token_report,
                supplemental_disclosure,
                balanced_disclosure,
                manual_review_evidence,
                balanced_extension_disclosure,
                balanced_extension2_disclosure,
            ),
        )
        _copy_file(HERE / "PROTOCOL.md", temp / "PROTOCOL.md", HERE)

        audit_dest = temp / "screened_pool" / "audit"
        _copy_file(audit_json, audit_dest / "long_code_audit.json", HERE)
        _copy_file(audit_candidates_csv, audit_dest / "long_code_candidates.csv", HERE)
        _copy_file(audit_runs_csv, audit_dest / "long_code_runs.csv", HERE)
        if manual_review_evidence is not None:
            if _sha256_file(manual_review_evidence["path"]) != manual_review_evidence[
                "sha256"
            ]:
                raise PackageError("Manual trace review changed after validation")
            copied_review_path = temp / "selection_review" / "manual_trace_review.json"
            _copy_file(
                manual_review_evidence["path"],
                copied_review_path,
                HERE,
            )
            if _sha256_file(copied_review_path) != manual_review_evidence["sha256"]:
                raise PackageError("Copied manual trace review hash changed")
        for evidence in tokenizer_evidence_sets:
            tokenizer_dest = temp / "screened_pool" / str(evidence["name"])
            _copy_file(
                evidence["report_path"],
                tokenizer_dest / Path(evidence["report_path"]).name,
                HERE,
            )
            _copy_file(
                evidence["exclusions_path"],
                tokenizer_dest / Path(evidence["exclusions_path"]).name,
                HERE,
            )
            _copy_file(
                evidence["manifest_path"],
                tokenizer_dest / Path(evidence["manifest_path"]).name,
                HERE,
            )

        if supplemental_disclosure is not None:
            supplemental_root = _resolve_existing_under(
                HERE / "supplemental_cases",
                HERE,
                "supplemental cases",
                require_file=False,
            )
            for name in SUPPLEMENTAL_PIPELINE_FILES:
                _resolve_existing_under(
                    HERE / name,
                    HERE,
                    f"supplemental pipeline file {name}",
                    require_file=True,
                )
            _copy_tree_files(
                supplemental_root,
                temp / "screened_pool" / "supplemental_cases",
                HERE,
            )
            _copy_file(
                HERE / "supplemental_launch_plan.json",
                temp / "screened_pool" / "supplemental_launch_plan.json",
                HERE,
            )

        if balanced_disclosure is not None:
            assert resolved_balanced_root is not None
            _copy_balanced_contingency_evidence(
                balanced_root=resolved_balanced_root,
                destination=temp / "screened_pool",
                disclosure=balanced_disclosure,
            )
        if balanced_extension_disclosure is not None:
            assert resolved_balanced_extension_root is not None
            _copy_balanced_extension_evidence(
                extension_root=resolved_balanced_extension_root,
                destination=temp / "screened_pool",
                disclosure=balanced_extension_disclosure,
            )
        if balanced_extension2_disclosure is not None:
            assert resolved_balanced_extension2_root is not None
            _copy_balanced_extension2_evidence(
                extension_root=resolved_balanced_extension2_root,
                destination=temp / "screened_pool",
                disclosure=balanced_extension2_disclosure,
            )

        _copy_tree_files(provenance_root, temp / "provenance" / "dataset", HERE)
        prepared_provenance = prepared_root / "provenance"
        if not prepared_provenance.is_dir():
            raise PackageError(f"Prepared-variant provenance is missing: {prepared_provenance}")
        for name in PREPARED_EVIDENCE_FILES:
            if not (prepared_root / name).is_file():
                raise PackageError(f"Required prepared-variant evidence is missing: {prepared_root / name}")

        # Preserve every referenced source/tree so paths in the candidate and
        # preparation manifests can be resolved inside the artifact.
        _copy_tree_files(
            candidate_pool_root, temp / "screened_pool" / "candidate_pool", HERE
        )
        _copy_tree_files(prepared_root, temp / "screened_pool" / "prepared_variants", HERE)

        # Preserve all screened raw data, including nonselected candidates.
        local_audit_paths = _copy_complete_screened_roots(
            roots, temp / "screened_pool" / "result_roots", report
        )
        _write_json(temp / "screened_pool" / "prompt_oracle_lineage.json", lineage_rows)

        # Copy the current pipeline scripts *and tests*, plus immutable source
        # snapshots matching every dependency hash registered by the runs.
        for source in sorted(HERE.glob("*.py"), key=lambda path: path.name):
            _copy_file(source, temp / "scripts" / "pipeline" / source.name, HERE)
        for source in sorted(HERE.glob("*PROTOCOL*.md"), key=lambda path: path.name):
            _copy_file(source, temp / "scripts" / "pipeline" / source.name, HERE)
        if supplemental_disclosure is not None:
            _copy_file(
                HERE / "supplemental_launch_plan.json",
                temp / "scripts" / "pipeline" / "supplemental_launch_plan.json",
                HERE,
            )
        runtime_dependencies = _copy_runtime_dependency_snapshots(
            roots, temp / "scripts" / "runtime_dependencies"
        )
        java_compat_jar = _resolve_existing_under(
            HERE.parent / "artifacts" / "java_compat" / "javatuples-compat.jar",
            HERE.parent,
            "Java compatibility JAR",
            require_file=True,
        )
        _copy_file(
            java_compat_jar,
            temp
            / "scripts"
            / "runtime_dependencies"
            / "java_compat"
            / java_compat_jar.name,
            HERE.parent,
        )
        if (HERE / "runtime_snapshots").is_dir():
            _copy_tree_files(
                HERE / "runtime_snapshots",
                temp / "scripts" / "recorded_runtime_snapshots",
                HERE,
            )
        for index, root in enumerate(roots, 1):
            root_dest = temp / "experiment" / "result_roots" / f"root_{index:02d}"
            for source in _root_config_files(root):
                _copy_file(source, root_dest / source.name, root)
            _write_json(
                root_dest / "root_descriptor.json",
                {
                    "audit_result_root": str(root),
                    "configuration_files": sorted(path.name for path in _root_config_files(root)),
                },
            )

        packaged_cases: List[Dict[str, Any]] = []
        for index, item in enumerate(selected, 1):
            candidate = item["candidate"]
            run_map = item["run_map"]
            best = item["best"]
            snapshot = item["snapshot"]
            materials = _validate_case_materials(
                candidate,
                snapshot,
                run_map,
                best,
                roots,
                candidate_pool_root,
                tokenizer_evidence_by_sample[str(candidate["sample_id"])],
            )
            case_dir = temp / "cases" / f"case_{index:02d}"
            _write_text(case_dir / "README.md", _case_readme(index, item))
            _copy_file(materials["original_source"], case_dir / "original.java", HERE)
            _copy_file(materials["obfuscated_source"], case_dir / "obfuscated.java", HERE)
            _write_text(case_dir / "stdin.txt", materials["stdin"])
            _copy_file(materials["oracle_path"], case_dir / "oracle_stdout.txt", HERE)
            _copy_selected_sample_bundle(
                str(candidate["sample_id"]), case_dir / "sample_evidence", roots
            )

            best_trial = int(best["trial"])
            _copy_run_bundle(best, case_dir / "codesteer_best", roots)
            for condition in BASELINE_CONDITIONS:
                _copy_run_bundle(
                    run_map[(best_trial, condition)],
                    case_dir / "paired_baselines" / condition,
                    roots,
                )

            trial_index: List[Dict[str, Any]] = []
            for trial in EXPECTED_TRIALS:
                for condition in ALL_CONDITIONS:
                    run = run_map[(trial, condition)]
                    _copy_run_bundle(
                        run,
                        case_dir / "all_trials" / f"trial_{trial:03d}" / condition,
                        roots,
                    )
                    trial_index.append(
                        {
                            "trial": trial,
                            "paired_seed": run["paired_seed"],
                            "condition": condition,
                            "valid": run["valid"],
                            "trimmed_exact_match": run["trimmed_exact_match"],
                            "parse_status": run["parse_status"],
                            "fingerprint": run["fingerprint"],
                            "trace_quality": run["trace_quality"],
                            "artifact_path": (
                                f"all_trials/trial_{trial:03d}/{condition}"
                            ),
                        }
                    )
            _write_json(case_dir / "all_trials" / "index.json", trial_index)
            _write_json(
                case_dir / "metadata.json",
                {
                    "schema_version": PACKAGE_SCHEMA_VERSION,
                    "case_number": index,
                    "sample_id": candidate["sample_id"],
                    "problem_key": candidate["problem_key"],
                    "canonical_problem_identity": item["canonical_problem_identity"],
                    "selection_rank": index,
                    "selection_is_post_hoc_outcome_conditioned": True,
                    "aggregate_claim_supported": False,
                    "expected_trials": list(EXPECTED_TRIALS),
                    "exact_counts": candidate["exact_counts"],
                    "best_codesteer_trial": best,
                    **(
                        {
                            "manual_trace_review": {
                                **dict(item["manual_review_entry"]),
                                "ordered_selection_override_applied": True,
                                "legacy_best_field_contains_manual_selected_run": True,
                                "heuristic_best_codesteer_trial": item[
                                    "heuristic_best"
                                ],
                            }
                        }
                        if isinstance(item.get("manual_review_entry"), dict)
                        else {}
                    ),
                    "source_and_io_sha256": {
                        "original_java": materials["original_sha256"],
                        "obfuscated_java": materials["obfuscated_sha256"],
                        "stdin": materials["stdin_sha256"],
                        "oracle_stdout": materials["oracle_sha256"],
                    },
                    "recomputed_source_metrics": {
                        "physical_loc": materials["recomputed_physical_loc"],
                        "nonblank_loc": materials["recomputed_nonblank_loc"],
                    },
                    "candidate_metadata": item["candidate_metadata"],
                },
            )
            _write_json(case_dir / "provenance" / "source_sample_snapshot.json", snapshot)
            packaged_cases.append(
                {
                    "case_number": index,
                    "sample_id": candidate["sample_id"],
                    "problem_key": candidate["problem_key"],
                    "canonical_problem_identity": item["canonical_problem_identity"],
                    "best_codesteer_trial": best_trial,
                    "paired_seed": best["paired_seed"],
                    "best_trace_quality_score": best["trace_quality"]["score"],
                    "exact_counts": candidate["exact_counts"],
                    "path": f"cases/case_{index:02d}",
                    **(
                        {
                            "manual_review_selection": {
                                "selection_order": item["manual_review_entry"][
                                    "selection_order"
                                ],
                                "publishable": True,
                                "reasoning_quality": item["manual_review_entry"][
                                    "reasoning_quality"
                                ],
                                "selected_codesteer_fingerprint": item[
                                    "manual_review_entry"
                                ]["selected_codesteer_fingerprint"],
                                **(
                                    {
                                        "selection_mode": "paired_trial_contrast",
                                        "paired_baseline_trial": item[
                                            "manual_review_entry"
                                        ]["paired_baseline_trial"],
                                        "paired_seed": item["manual_review_entry"][
                                            "paired_seed"
                                        ],
                                    }
                                    if item["manual_review_entry"].get(
                                        "selection_mode"
                                    )
                                    == "paired_trial_contrast"
                                    else {}
                                ),
                            }
                        }
                        if isinstance(item.get("manual_review_entry"), dict)
                        else {}
                    ),
                }
            )

        manifest = {
            "schema_version": PACKAGE_SCHEMA_VERSION,
            "deterministic": True,
            "case_count": len(packaged_cases),
            "post_hoc_outcome_selected": True,
            "aggregate_performance_claim_supported": False,
            "selection_rule": (
                "Require complete matched three-trial/four-condition records and select "
                "exactly ten distinct sample IDs from the validated post-hoc paired-trial "
                "manual review. For each input, its selected trial must use one paired seed, "
                "CodeSteer must be valid trimmed-exact marker JSON, and all three baselines "
                "must be valid non-exact at that same trial. Baselines may be exact on other "
                "trials and canonical problems may repeat."
                if manual_review_evidence is not None
                and manual_review_evidence["schema_version"]
                == PAIRED_MANUAL_REVIEW_SCHEMA_VERSION
                else (
                "Require complete three-trial matched four-condition records, at least one "
                "exact FINAL_OUTPUT_JSON CodeSteer result, and zero exact results for each of "
                "the three comparison conditions; then use exactly the ten distinct canonical "
                "problem identities, ordered samples, and exact CodeSteer trials in the validated "
                "post-hoc outcome- and oracle-aware manual trace-review artifact."
                if manual_review_evidence is not None
                else (
                    "Require complete three-trial matched four-condition records, at least one "
                    "exact FINAL_OUTPUT_JSON CodeSteer result, and zero exact results for each of "
                    "the three comparison conditions; keep the highest best-trace score per true "
                    "canonical CodeContests row/contest-index identity, cross-check its problem key, "
                    "then rank by score with lexical deterministic ties and take ten."
                )
                )
            ),
            "audit_inputs": {
                "json_sha256": _sha256_file(audit_json),
                "candidates_csv_sha256": _sha256_file(audit_candidates_csv),
                "runs_csv_sha256": _sha256_file(audit_runs_csv),
            },
            "tokenizer_inputs": {
                "evidence_sets": [
                    {
                        "name": evidence["name"],
                        "full_report_sha256": _sha256_file(evidence["report_path"]),
                        "exclusions_sha256": _sha256_file(evidence["exclusions_path"]),
                        "inference_manifest_sha256": evidence[
                            "filtered_manifest_sha256"
                        ],
                        "source_manifest_sha256": evidence[
                            "source_manifest_sha256"
                        ],
                        **(
                            {
                                "source_manifest_schema_version": evidence[
                                    "source_manifest"
                                ].get("schema_version"),
                                "wave_id": evidence["source_manifest"].get("wave_id"),
                            }
                            if evidence["source_manifest"].get("schema_version")
                            in {
                                BALANCED_SOURCE_SCHEMA,
                                BALANCED_EXTENSION_SOURCE_SCHEMA,
                                BALANCED_EXTENSION2_SOURCE_SCHEMA,
                            }
                            else {}
                        ),
                        "denominator_records": len(evidence["denominator_ids"]),
                        "eligible_records": len(evidence["eligible_ids"]),
                        "excluded_records": len(evidence["excluded_ids"]),
                        "bound_result_root_count": len(evidence["bound_roots"]),
                    }
                    for evidence in tokenizer_evidence_sets
                ],
                "aggregate_counts": aggregate_token_report["counts"],
                "eligible_id_union_equals_audited_ids": True,
                "evidence_sets_pairwise_disjoint": True,
                "offline_tokenizer_and_prior_recomputation_identical": True,
            },
            "supplemental_screen_disclosure": supplemental_disclosure,
            "supplemental_launch_plan": supplemental_launch_plan,
            "codecontests_dataset_binding": {
                "dataset_id": CODECONTESTS_DATASET_ID,
                "revision": CODECONTESTS_REVISION,
                "split": CODECONTESTS_SPLIT,
                "parquet_filename": dataset_path.name,
                "parquet_sha256": CODECONTESTS_FILE_SHA256,
                "parquet_hash_verified_during_build": True,
                "all_audited_solution_sources_byte_identical": True,
                "selected_solution_sources_byte_identical": True,
                "parquet_included": False,
            },
            "audit_screen": {
                "candidate_count": report["validation"]["candidate_count"],
                "complete_valid_candidate_count": report["validation"]["complete_valid_candidate_count"],
                "strict_eligible_count": report["selection"]["strict_eligible_count"],
                "unique_problem_eligible_count": report["selection"]["unique_problem_eligible_count"],
            },
            "stored_evidence": {
                "complete_screened_run_count": len(local_audit_paths),
                "validated_prompt_oracle_lineage_run_count": len(lineage_rows),
                "runtime_dependency_snapshot_count": len(runtime_dependencies),
                "model_weights_included": False,
                "tokenizer_binaries_included": False,
                "upstream_dataset_parquet_included": False,
                "java_compatibility_jar_included": True,
                "java_compatibility_jar_sha256": _sha256_file(java_compat_jar),
            },
            "cases": packaged_cases,
        }
        if balanced_disclosure is not None:
            manifest["balanced_contingency_disclosure"] = balanced_disclosure
            manifest["stored_evidence"][
                "complete_balanced_contingency_tree_included"
            ] = True
            manifest["stored_evidence"][
                "balanced_execution_disclosure_included"
            ] = True
        if balanced_extension_disclosure is not None:
            manifest[
                "balanced_extension_contingency_disclosure"
            ] = balanced_extension_disclosure
            manifest["stored_evidence"][
                "complete_balanced_extension_contingency_tree_included"
            ] = True
            manifest["stored_evidence"][
                "balanced_extension_internal_and_external_freeze_anchors_included"
            ] = True
            manifest["stored_evidence"][
                "adaptive_execution_disclosure_included"
            ] = True
        if balanced_extension2_disclosure is not None:
            manifest[
                "balanced_extension2_contingency_disclosure"
            ] = balanced_extension2_disclosure
            manifest["stored_evidence"][
                "complete_balanced_extension2_contingency_tree_included"
            ] = True
            manifest["stored_evidence"][
                "balanced_extension2_internal_and_external_freeze_anchors_included"
            ] = True
            manifest["stored_evidence"][
                "balanced_extension2_all_20_controls_included"
            ] = True
            manifest["stored_evidence"][
                "balanced_extension2_failure_archives_included_in_frozen_tree"
            ] = True
            manifest["stored_evidence"][
                "balanced_extension2_external_disclosures_included"
            ] = True
        if manual_review_evidence is not None:
            manifest["manual_trace_review"] = {
                "schema_version": manual_review_evidence["schema_version"],
                "included": True,
                "publishable": True,
                "package_local_path": "selection_review/manual_trace_review.json",
                "sha256": manual_review_evidence["sha256"],
                "audit_inputs": manual_review_evidence["audit_inputs"],
                "entry_count": CASE_COUNT,
                "ordered_selection_override_applied": True,
                "post_hoc_outcome_and_oracle_aware": True,
                "separate_from_outcome_blind_case_generation": True,
                **(
                    {
                        "selection_mode": "same_seed_paired_trial_contrast",
                        "selection_unit": "distinct_sample_id",
                        "distinct_sample_id_count": CASE_COUNT,
                        "distinct_canonical_problem_count": manual_review_evidence[
                            "distinct_canonical_problem_count"
                        ],
                        "canonical_problem_repeat_entry_count": manual_review_evidence[
                            "canonical_problem_repeat_entry_count"
                        ],
                        "sample_count_by_canonical_problem": manual_review_evidence[
                            "sample_count_by_canonical_problem"
                        ],
                        "baseline_zero_of_three_required": False,
                        "canonical_problem_repeats_allowed": True,
                        "aggregate_performance_or_ten_problem_generalization_claim_supported": False,
                        "display_pass_at_k": False,
                    }
                    if manual_review_evidence["schema_version"]
                    == PAIRED_MANUAL_REVIEW_SCHEMA_VERSION
                    else {}
                ),
                "selections": [
                    {
                        "selection_order": entry["selection_order"],
                        "sample_id": entry["sample_id"],
                        "canonical_problem_identity": entry[
                            "canonical_problem_identity"
                        ],
                        "selected_codesteer_trial": entry[
                            "selected_codesteer_trial"
                        ],
                        "selected_codesteer_fingerprint": entry[
                            "selected_codesteer_fingerprint"
                        ],
                        **(
                            {
                                "paired_baseline_trial": entry[
                                    "paired_baseline_trial"
                                ],
                                "paired_seed": entry["paired_seed"],
                            }
                            if manual_review_evidence["schema_version"]
                            == PAIRED_MANUAL_REVIEW_SCHEMA_VERSION
                            else {}
                        ),
                    }
                    for entry in manual_review_evidence["entries"]
                ],
            }
        elif balanced_disclosure is not None:
            manifest["manual_trace_review"] = {
                "required_before_publication": True,
                "included": False,
                "selection_override_applied": False,
                "separate_from_automatic_strict_selection": True,
            }
        _write_json(temp / "manifest.json", manifest)
        _write_checksums(temp)
        os.replace(temp, destination)
    except Exception:
        shutil.rmtree(temp, ignore_errors=True)
        raise

    return {
        "schema_version": PACKAGE_SCHEMA_VERSION,
        "output_dir": str(destination),
        "case_count": CASE_COUNT,
        "sample_ids": [str(item["candidate"]["sample_id"]) for item in selected],
        "manifest_sha256": _sha256_file(destination / "manifest.json"),
        "checksums_sha256": _sha256_file(destination / "SHA256SUMS"),
    }


def parse_args(argv: Optional[Sequence[str]] = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("result_roots", nargs="+", type=Path)
    parser.add_argument("--audit-json", type=Path, required=True)
    parser.add_argument("--audit-candidates-csv", type=Path, required=True)
    parser.add_argument("--audit-runs-csv", type=Path, required=True)
    parser.add_argument(
        "--tokenizer-report",
        type=Path,
        action="append",
        default=None,
        help="Repeat once per disjoint tokenizer gate (paired by option order).",
    )
    parser.add_argument(
        "--tokenizer-exclusions",
        type=Path,
        action="append",
        default=None,
        help="Repeat once per disjoint tokenizer gate (paired by option order).",
    )
    parser.add_argument(
        "--tokenizer-manifest",
        type=Path,
        action="append",
        default=None,
        help="Repeat once per disjoint tokenizer gate (paired by option order).",
    )
    parser.add_argument(
        "--tokenizer-set-name",
        action="append",
        default=None,
        help="Optional safe name for each repeated tokenizer evidence triple.",
    )
    parser.add_argument("--provenance-root", type=Path, default=HERE / "provenance")
    parser.add_argument("--candidate-pool-root", type=Path, default=HERE / "candidate_pool")
    parser.add_argument("--prepared-root", type=Path, default=HERE / "prepared_variants")
    parser.add_argument("--dataset-path", type=Path, default=CODECONTESTS_PARQUET)
    parser.add_argument(
        "--balanced-contingency-root",
        type=Path,
        default=BALANCED_CONTINGENCY_ROOT,
        help=(
            "Frozen balanced evidence root; read only when one or two registered balanced "
            "tokenizer gates are supplied."
        ),
    )
    parser.add_argument(
        "--balanced-extension-contingency-root",
        type=Path,
        default=BALANCED_EXTENSION_ROOT,
        help=(
            "Frozen optional adaptive Wave-3 evidence root; read only when the registered "
            "balanced_wave_3 tokenizer gate is supplied."
        ),
    )
    parser.add_argument(
        "--balanced-extension2-contingency-root",
        type=Path,
        default=BALANCED_EXTENSION2_ROOT,
        help=(
            "Frozen optional adaptive Wave-4/5 evidence root; read only when registered "
            "balanced_wave_4 and optional balanced_wave_5 tokenizer gates are supplied."
        ),
    )
    parser.add_argument(
        "--manual-review",
        type=Path,
        default=None,
        help=(
            "Optional legacy strict or paired-trial manual-review artifact that replaces "
            "only the post-audit ten-input order/trial choice."
        ),
    )
    parser.add_argument("--output-dir", type=Path, default=HERE / "case-study-staging")
    return parser.parse_args(argv)


def main(argv: Optional[Sequence[str]] = None) -> int:
    args = parse_args(argv)
    try:
        supplied_tokenizer_options = (
            args.tokenizer_report is not None,
            args.tokenizer_exclusions is not None,
            args.tokenizer_manifest is not None,
        )
        if any(supplied_tokenizer_options) and not all(supplied_tokenizer_options):
            raise PackageError(
                "Tokenizer report/exclusions/manifest options must be supplied together"
            )
        tokenizer_reports = args.tokenizer_report or [
            HERE / "tokenizer_preflight" / "full_report.json"
        ]
        tokenizer_exclusions = args.tokenizer_exclusions or [
            HERE / "tokenizer_preflight" / "exclusions.jsonl"
        ]
        tokenizer_manifests = args.tokenizer_manifest or [
            HERE / "tokenizer_preflight" / "inference_eligible_variants.json"
        ]
        if not (
            len(tokenizer_reports)
            == len(tokenizer_exclusions)
            == len(tokenizer_manifests)
        ):
            raise PackageError(
                "Repeated tokenizer report/exclusions/manifest options must have equal counts"
            )
        names = args.tokenizer_set_name or [path.parent.name for path in tokenizer_reports]
        if len(names) != len(tokenizer_reports):
            raise PackageError("Tokenizer evidence-set name count does not match its triples")
        extra_sets = [
            (names[index], tokenizer_reports[index], tokenizer_exclusions[index], tokenizer_manifests[index])
            for index in range(1, len(tokenizer_reports))
        ]
        result = package_case_study(
            audit_json=args.audit_json,
            audit_candidates_csv=args.audit_candidates_csv,
            audit_runs_csv=args.audit_runs_csv,
            result_roots=args.result_roots,
            output_dir=args.output_dir,
            tokenizer_report=tokenizer_reports[0],
            tokenizer_exclusions=tokenizer_exclusions[0],
            tokenizer_manifest=tokenizer_manifests[0],
            tokenizer_evidence_set_name=names[0],
            additional_tokenizer_evidence_sets=extra_sets,
            provenance_root=args.provenance_root,
            candidate_pool_root=args.candidate_pool_root,
            prepared_root=args.prepared_root,
            dataset_path=args.dataset_path,
            balanced_contingency_root=args.balanced_contingency_root,
            balanced_extension_contingency_root=(
                args.balanced_extension_contingency_root
            ),
            balanced_extension2_contingency_root=(
                args.balanced_extension2_contingency_root
            ),
            manual_review=args.manual_review,
        )
    except (PackageError, ValueError, TypeError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        return 2
    print(json.dumps(result, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
