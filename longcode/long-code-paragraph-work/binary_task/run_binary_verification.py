#!/usr/bin/env python3
"""Run the frozen Qwen2.5-Coder-7B binary output-verification experiment.

One generation judges six independently constructed candidate outputs for one
program.  The paper statistic is label accuracy over all 60 labels from the one
registered Pass@1 attempt.  This runner has no repair or retry path: if the
six-label object is malformed, missing, duplicated, or has extras, all six
labels in that completion score wrong.
"""

from __future__ import annotations

import argparse
import dataclasses
import hashlib
import importlib.util
import json
import os
import re
import socket
import sys
import tempfile
import time
from dataclasses import dataclass
from datetime import datetime, timezone
from pathlib import Path
from types import ModuleType
from typing import Any, Dict, List, Mapping, Optional, Sequence, Tuple


sys.dont_write_bytecode = True

HERE = Path(__file__).resolve().parent
PARAGRAPH_ROOT = HERE.parent
PROMPT_STEERING_ROOT = PARAGRAPH_ROOT.parent
PROJECT_ROOT = PROMPT_STEERING_ROOT.parent
BASE_RUNNER_PATH = (
    PROMPT_STEERING_ROOT / "long-code-sample-work" / "run_long_code_experiment.py"
)
MODEL_LOCK_PATH = PARAGRAPH_ROOT / "model_lock.json"
FROZEN_SAMPLE_PATH = PARAGRAPH_ROOT / "frozen_sample" / "inference_manifest.json"
DEFAULT_MANIFEST = HERE / "inference_manifest.json"
DEFAULT_OUTPUT_ROOT = HERE / "results"
GLOBAL_PREFLIGHT_SUMMARY = DEFAULT_OUTPUT_ROOT / "model_preflight" / "model_preflight_summary.json"

PROTOCOL_VERSION = "long-code-binary-output-verification-run-v1"
MANIFEST_SCHEMA = "long-code-binary-output-verification-v1"
MANIFEST_SHA256 = "ab6b82d31c5beddf54fb938b1c700ab536d0f6c826caf66d40a63db6c3490471"
FROZEN_SAMPLE_SHA256 = "d88f4c04a7d837e70b496c0c6a9dd83acfde915323a79538c7e7d0935b411f00"
MODEL_LOCK_SHA256 = "6ec43e6bf8d1985ab0e323611b12ed95b6a2f45bd062f6e1d02b33daac33f43d"
BASE_RUNNER_SHA256 = "1e9f541505bbe4776c1c96a7318be17dcd8d3e125f2c1ec3fc9efab888242c57"
MODEL_NAME = "Qwen/Qwen2.5-Coder-7B-Instruct"
MODEL_SNAPSHOT_COMMIT = "c03e6d358207e414f1eca0bb1891e29f1db0e242"
MODEL_CACHE = Path("/data/xxr230000/model_cache/qwen25_7b_instruct")

CONDITIONS: Tuple[str, ...] = (
    "original_plain",
    "obfuscated_plain",
    "obfuscated_codesteer",
)
TRIALS = 1
BASE_SEED = 20260713
PROGRAM_COUNT = 10
CASES_PER_PROGRAM = 6
LABEL_COUNT = PROGRAM_COUNT * CASES_PER_PROGRAM
GENERATIONS_PER_PROGRAM = TRIALS * len(CONDITIONS)
EXPECTED_GENERATIONS = PROGRAM_COUNT * GENERATIONS_PER_PROGRAM

EXPECTED_PROGRAM_IDS: Tuple[str, ...] = (
    "cc-valid-r044-s0096-1556-a-a-variety-of-operations__t5_easy_seed1",
    "cc-valid-r098-s0215-1569-a-balanced-substring__t5_easy_seed1",
    "cc-valid-r069-s0346-1560-d-make-a-power-of-two__t5_easy_seed1",
    "cc-valid-r078-s0458-1562-a-the-miracle-and-the-sleeper__t5_easy_seed1",
    "cc-valid-r013-s0260-1551-d2-domino-hard-version__t5_easy_seed1",
    "cc-valid-r065-s0055-1559-e-mocha-and-stars__t5_easy_seed1",
    "cc-valid-r035-s0203-1554-c-mikasa__t5_easy_seed1",
    "cc-valid-r026-s0376-1553-c-penalty__t5_easy_seed1",
    "cc-valid-r094-s0350-1567-c-carrying-conundrum__t5_easy_seed1",
    "cc-valid-r005-s0097-1549-b-gregor-and-the-pawn-game__t5_easy_seed1",
)

GENERATION: Dict[str, Any] = {
    "do_sample": True,
    "temperature": 1.05,
    "top_p": 0.95,
    "top_k": 7,
    "max_new_tokens": 192,
}

CODESTEER_PROFILE: Dict[str, Any] = {
    "enabled_levels": [2],
    "prior": "slice_hybrid",
    "beta_post": 0.8,
    "beta_bias": 0.0,
    "n_bins": 12,
    "binning": "equal_count",
    "recency_mix": True,
    "recency_rho": 0.2,
    "recency_window": 64,
    "recency_apply_after_prompt": True,
    "recency_scope": "prefer_generated",
    "only_first_decode_step": False,
    "head_subset_mode": "none",
    "head_mask_apply_to": "both",
    "steer_last_n_layers": 8,
}

MODEL_CONFIG_EXPECTED: Dict[str, Any] = {
    "architectures": ["Qwen2ForCausalLM"],
    "model_type": "qwen2",
    "hidden_size": 3584,
    "num_hidden_layers": 28,
    "num_attention_heads": 28,
    "num_key_value_heads": 4,
    "vocab_size": 152064,
    "torch_dtype": "bfloat16",
}

OPEN_MARKER = "<FINAL_JSON>"
CLOSE_MARKER = "</FINAL_JSON>"
OPAQUE_ID = re.compile(r"bv-[0-9a-f]{20}\Z")


class ProtocolError(RuntimeError):
    """A requested or observed artifact differs from the frozen protocol."""


@dataclass(frozen=True)
class BinaryCase:
    case_id: str
    source_case_id: str
    pack_position: int
    stdin: str
    candidate_stdout: str
    label: bool
    raw: Mapping[str, Any]


@dataclass(frozen=True)
class Program:
    program_id: str
    original_path: Path
    obfuscated_path: Path
    original_target_method: str
    obfuscated_target_method: str
    cases: Tuple[BinaryCase, ...]


class JSONObject(list):
    """JSON object represented as ordered pairs so duplicate keys survive."""


def sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def sha256_text(payload: str) -> str:
    return sha256_bytes(payload.encode("utf-8"))


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def canonical_json_bytes(value: Any) -> bytes:
    return json.dumps(
        value, ensure_ascii=False, sort_keys=True, separators=(",", ":")
    ).encode("utf-8")


def stable_json(value: Any) -> str:
    return json.dumps(
        value,
        ensure_ascii=False,
        sort_keys=True,
        separators=(",", ":"),
        default=lambda item: str(item) if isinstance(item, Path) else item,
    )


def atomic_write_text(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    temporary.write_text(text, encoding="utf-8")
    os.replace(temporary, path)


def atomic_write_bytes(path: Path, payload: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    temporary.write_bytes(payload)
    os.replace(temporary, path)


def atomic_write_json(path: Path, payload: Any) -> None:
    atomic_write_text(
        path,
        json.dumps(payload, ensure_ascii=False, indent=2, sort_keys=True, default=str)
        + "\n",
    )


def _load_json(path: Path, label: str) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except Exception as exc:
        raise ProtocolError(f"Cannot parse {label} {path}: {exc}") from exc


def _resolve_under(raw: Any, root: Path, label: str) -> Path:
    if not isinstance(raw, str) or not raw:
        raise ProtocolError(f"Missing {label}")
    candidate = Path(raw).expanduser()
    candidate = candidate if candidate.is_absolute() else root / candidate
    try:
        path = candidate.resolve(strict=True)
        path.relative_to(root.resolve(strict=True))
    except Exception as exc:
        raise ProtocolError(f"{label} is missing or escapes {root}: {candidate}") from exc
    if not path.is_file():
        raise ProtocolError(f"{label} is not a regular file: {path}")
    return path


def _require_manifest_anchor(path: Path, expected_hash: str) -> None:
    anchor = path.with_suffix(".sha256")
    if not anchor.is_file():
        raise ProtocolError(f"Missing external manifest anchor: {anchor}")
    fields = anchor.read_text(encoding="utf-8").strip().split()
    if fields != [expected_hash, path.name]:
        raise ProtocolError(f"Manifest anchor differs from the registered hash: {anchor}")


def validate_model_lock() -> Dict[str, Any]:
    if sha256_file(MODEL_LOCK_PATH) != MODEL_LOCK_SHA256:
        raise ProtocolError("Pinned model_lock.json SHA-256 changed")
    payload = _load_json(MODEL_LOCK_PATH, "model lock")
    if not isinstance(payload, dict) or any(
        (
            payload.get("schema_version")
            != "qwen25-coder-7b-instruct-model-lock-v1",
            payload.get("model_id") != MODEL_NAME,
            payload.get("snapshot_commit") != MODEL_SNAPSHOT_COMMIT,
            payload.get("substitute_model_allowed") is not False,
            payload.get("requested_snapshot_locally_cached") is not True,
        )
    ):
        raise ProtocolError("Qwen2.5-Coder-7B-Instruct model lock is invalid")
    return payload


def cached_snapshot_status() -> Dict[str, Any]:
    """Verify the exact existing cache as read-only input; never download."""
    cache = MODEL_CACHE.resolve(strict=False)
    repository_name = "models--" + MODEL_NAME.replace("/", "--")
    repository = next(
        (
            candidate
            for candidate in (cache / repository_name, cache / "hub" / repository_name)
            if candidate.is_dir()
        ),
        None,
    )
    if repository is None:
        return {"available": False, "reason": "repository absent", "cache": str(cache)}
    ref = repository / "refs" / "main"
    observed_ref = ref.read_text(encoding="utf-8").strip() if ref.is_file() else None
    snapshot = repository / "snapshots" / MODEL_SNAPSHOT_COMMIT
    required = ("config.json", "tokenizer.json", "model.safetensors.index.json")
    missing = [name for name in required if not (snapshot / name).is_file()]
    mismatches: Dict[str, Any] = {}
    shards: List[str] = []
    if not missing:
        config = _load_json(snapshot / "config.json", "cached model config")
        mismatches = {
            key: {"expected": expected, "observed": config.get(key)}
            for key, expected in MODEL_CONFIG_EXPECTED.items()
            if config.get(key) != expected
        }
        index = _load_json(
            snapshot / "model.safetensors.index.json", "cached weight index"
        )
        shards = sorted(set((index.get("weight_map") or {}).values()))
        missing.extend(
            name
            for name in shards
            if not (snapshot / name).is_file() or (snapshot / name).stat().st_size <= 0
        )
    available = (
        observed_ref == MODEL_SNAPSHOT_COMMIT
        and snapshot.is_dir()
        and not missing
        and not mismatches
        and len(shards) == 4
    )
    return {
        "available": available,
        "cache": str(cache),
        "repository": str(repository),
        "snapshot_path": str(snapshot),
        "expected_commit": MODEL_SNAPSHOT_COMMIT,
        "observed_main_ref": observed_ref,
        "weight_shard_count": len(shards),
        "missing": sorted(set(missing)),
        "config_mismatches": mismatches,
        "reason": None if available else "snapshot/ref is incomplete or mismatched",
    }


def _validate_parent_sample(payload: Mapping[str, Any]) -> Dict[str, Mapping[str, Any]]:
    source = payload.get("source_sample")
    if not isinstance(source, Mapping):
        raise ProtocolError("Binary manifest lacks source_sample binding")
    if source.get("sha256") != FROZEN_SAMPLE_SHA256:
        raise ProtocolError("Binary manifest changed the frozen ten-program source hash")
    source_path = (HERE / str(source.get("path", ""))).resolve(strict=True)
    if source_path != FROZEN_SAMPLE_PATH.resolve(strict=True):
        raise ProtocolError("Binary manifest points to an unregistered source sample")
    if sha256_file(source_path) != FROZEN_SAMPLE_SHA256:
        raise ProtocolError("Frozen ten-program source manifest hash changed")
    parent = _load_json(source_path, "frozen source manifest")
    variants = parent.get("variants") if isinstance(parent, Mapping) else None
    if not isinstance(variants, list):
        raise ProtocolError("Frozen source manifest lacks variants")
    ids = tuple(str(row.get("id")) for row in variants if isinstance(row, Mapping))
    registered = tuple(source.get("program_ids_in_frozen_order") or ())
    if ids != EXPECTED_PROGRAM_IDS or registered != EXPECTED_PROGRAM_IDS:
        raise ProtocolError("Binary task is not bound to the exact frozen ten programs")
    return {str(row["id"]): row for row in variants}


def validate_manifest(path: Path = DEFAULT_MANIFEST) -> Tuple[Dict[str, Any], Tuple[Program, ...]]:
    """Fail closed unless the exact frozen 60-case manifest is present."""
    try:
        manifest_path = path.expanduser().resolve(strict=True)
    except Exception as exc:
        raise ProtocolError(f"Binary manifest is missing: {path}") from exc
    if manifest_path != DEFAULT_MANIFEST.resolve(strict=True):
        raise ProtocolError("Only the registered binary_task/inference_manifest.json is allowed")
    observed_hash = sha256_file(manifest_path)
    if observed_hash != MANIFEST_SHA256:
        raise ProtocolError(
            f"Binary manifest SHA-256 is {observed_hash}, expected {MANIFEST_SHA256}"
        )
    _require_manifest_anchor(manifest_path, MANIFEST_SHA256)
    payload = _load_json(manifest_path, "binary manifest")
    if not isinstance(payload, dict):
        raise ProtocolError("Binary manifest root must be an object")
    required_top = {
        "schema_version": MANIFEST_SCHEMA,
        "program_count": PROGRAM_COUNT,
        "source_io_case_count": LABEL_COUNT,
        "binary_case_count": LABEL_COUNT,
        "true_case_count": LABEL_COUNT // 2,
        "false_case_count": LABEL_COUNT // 2,
        "cases_per_program": CASES_PER_PROGRAM,
        "source_conditions": list(CONDITIONS),
    }
    bad_top = {
        key: {"expected": expected, "observed": payload.get(key)}
        for key, expected in required_top.items()
        if payload.get(key) != expected
    }
    if bad_top:
        raise ProtocolError(f"Binary manifest top-level contract changed: {bad_top}")
    parent_by_id = _validate_parent_sample(payload)
    rows = payload.get("cases")
    if not isinstance(rows, list) or len(rows) != LABEL_COUNT:
        raise ProtocolError("Binary manifest must contain exactly 60 case records")

    seen_ids: set[str] = set()
    seen_source_keys: set[Tuple[str, str]] = set()
    grouped: Dict[str, List[Mapping[str, Any]]] = {key: [] for key in EXPECTED_PROGRAM_IDS}
    required_provenance = {
        "dataset_id",
        "dataset_revision",
        "split",
        "row_index",
        "solution_index",
        "solution_container",
        "solution_label",
        "language",
        "language_code",
        "problem_name",
        "cf_contest_id",
        "cf_index",
        "source_variant_id",
        "source_case_id",
        "stdin_sha256",
        "oracle_stdout_sha256",
        "candidate_stdout_sha256",
    }
    for index, row_any in enumerate(rows, start=1):
        if not isinstance(row_any, Mapping):
            raise ProtocolError(f"Binary case {index} is not an object")
        row = row_any
        if "pair_id" in row:
            raise ProtocolError("Duplicated complementary-pair construction is forbidden")
        case_id = str(row.get("id", ""))
        program_id = str(row.get("program_id", ""))
        source_case_id = str(row.get("source_case_id", ""))
        if not OPAQUE_ID.fullmatch(case_id) or case_id in seen_ids:
            raise ProtocolError(f"Case {index} has a non-opaque or duplicate ID")
        if program_id not in grouped:
            raise ProtocolError(f"Case {case_id} has an unregistered program")
        source_key = (program_id, source_case_id)
        if not source_case_id or source_key in seen_source_keys:
            raise ProtocolError(f"Case {case_id} duplicates a source input identity")
        if type(row.get("label")) is not bool:
            raise ProtocolError(f"Case {case_id} label is not a JSON boolean")
        position = row.get("pack_position")
        if type(position) is not int or not 1 <= position <= CASES_PER_PROGRAM:
            raise ProtocolError(f"Case {case_id} has invalid pack_position")
        stdin = row.get("stdin")
        candidate = row.get("candidate_stdout")
        if not isinstance(stdin, str) or not isinstance(candidate, str):
            raise ProtocolError(f"Case {case_id} input/candidate must be strings")
        if row.get("stdin_sha256") != sha256_text(stdin):
            raise ProtocolError(f"Case {case_id} stdin hash differs")
        if row.get("candidate_stdout_sha256") != sha256_text(candidate):
            raise ProtocolError(f"Case {case_id} candidate hash differs")
        provenance = row.get("provenance")
        if not isinstance(provenance, Mapping) or not required_provenance.issubset(provenance):
            raise ProtocolError(f"Case {case_id} lost canonical provenance")
        if any(
            (
                provenance.get("source_variant_id") != program_id,
                provenance.get("source_case_id") != source_case_id,
                provenance.get("stdin_sha256") != row.get("stdin_sha256"),
                provenance.get("candidate_stdout_sha256")
                != row.get("candidate_stdout_sha256"),
            )
        ):
            raise ProtocolError(f"Case {case_id} provenance hashes differ")
        oracle_hash = provenance.get("oracle_stdout_sha256")
        candidate_hash = row.get("candidate_stdout_sha256")
        if (candidate_hash == oracle_hash) is not row.get("label"):
            raise ProtocolError(f"Case {case_id} label is inconsistent with frozen hashes")
        seen_ids.add(case_id)
        seen_source_keys.add(source_key)
        grouped[program_id].append(row)

    programs: List[Program] = []
    true_by_position = {position: 0 for position in range(1, CASES_PER_PROGRAM + 1)}
    for program_id in EXPECTED_PROGRAM_IDS:
        program_rows = sorted(grouped[program_id], key=lambda row: int(row["pack_position"]))
        if len(program_rows) != CASES_PER_PROGRAM:
            raise ProtocolError(f"{program_id} does not have six distinct cases")
        if [row["pack_position"] for row in program_rows] != list(
            range(1, CASES_PER_PROGRAM + 1)
        ):
            raise ProtocolError(f"{program_id} pack positions are not exactly 1..6")
        if len({str(row["stdin_sha256"]) for row in program_rows}) != CASES_PER_PROGRAM:
            raise ProtocolError(f"{program_id} does not contain six distinct inputs")
        labels = [row["label"] for row in program_rows]
        if sum(label is True for label in labels) != 3:
            raise ProtocolError(f"{program_id} is not exactly 3T/3F")
        for row in program_rows:
            true_by_position[int(row["pack_position"])] += int(row["label"] is True)

        first = program_rows[0]
        invariant_fields = (
            "original_path",
            "obfuscated_path",
            "original_sha256",
            "obfuscated_sha256",
            "original_target_method",
            "obfuscated_target_method",
            "original_main_class",
            "obfuscated_main_class",
        )
        for row in program_rows[1:]:
            if any(row.get(key) != first.get(key) for key in invariant_fields):
                raise ProtocolError(f"{program_id} case records disagree on source metadata")
        original = _resolve_under(first.get("original_path"), HERE, "original source")
        obfuscated = _resolve_under(first.get("obfuscated_path"), HERE, "obfuscated source")
        if sha256_file(original) != first.get("original_sha256") or sha256_file(
            obfuscated
        ) != first.get("obfuscated_sha256"):
            raise ProtocolError(f"{program_id} copied source hash differs")
        parent = parent_by_id[program_id]
        if any(
            (
                parent.get("original_sha256") != first.get("original_sha256"),
                parent.get("obfuscated_sha256") != first.get("obfuscated_sha256"),
                parent.get("original_target_method") != first.get("original_target_method"),
                parent.get("obfuscated_target_method") != first.get("obfuscated_target_method"),
            )
        ):
            raise ProtocolError(f"{program_id} differs from the frozen program source")
        cases = tuple(
            BinaryCase(
                case_id=str(row["id"]),
                source_case_id=str(row["source_case_id"]),
                pack_position=int(row["pack_position"]),
                stdin=str(row["stdin"]),
                candidate_stdout=str(row["candidate_stdout"]),
                label=bool(row["label"]),
                raw=row,
            )
            for row in program_rows
        )
        programs.append(
            Program(
                program_id=program_id,
                original_path=original,
                obfuscated_path=obfuscated,
                original_target_method=str(first["original_target_method"]),
                obfuscated_target_method=str(first["obfuscated_target_method"]),
                cases=cases,
            )
        )
    if true_by_position != {position: 5 for position in range(1, 7)}:
        raise ProtocolError(f"Pack-position labels are not balanced: {true_by_position}")
    if sum(case.label for program in programs for case in program.cases) != LABEL_COUNT // 2:
        raise ProtocolError("Global binary labels are not exactly 30T/30F")
    return payload, tuple(programs)


def build_instruction(program: Program, target_method: str) -> str:
    """Render only task-visible fields; hidden labels/oracles never enter the prompt."""
    lines: List[str] = []
    for case in program.cases:
        visible = {
            "case_id": case.case_id,
            "stdin": case.stdin,
            "candidate_stdout": case.candidate_stdout,
        }
        lines.append(
            f"c{case.pack_position:03d}: "
            + json.dumps(visible, ensure_ascii=False, sort_keys=True, separators=(",", ":"))
        )
    instruction = (
        "Verify six candidate outputs for this deterministic Java program. "
        f"The recorded algorithm method is `{target_method}`. For each case, run the same "
        "program mentally on the given stdin. Replace CRLF or CR with LF and strip only outer "
        "whitespace from both outputs; all internal whitespace remains exact. Answer T exactly "
        "when candidate_stdout equals what the program prints, otherwise answer F. Judge every "
        "case independently.\n"
        "### CASES_BEGIN\n"
        + "\n".join(lines)
        + "\n### CASES_END\n\n"
        "Return no reasoning or commentary: emit exactly one marked JSON object. The labels object "
        "must contain each of the six listed case_id values exactly once, with an exact uppercase "
        "string value T or F. Extra IDs are forbidden. Format:\n"
        '<FINAL_JSON>{"labels":{"opaque-case-id":"T"}}</FINAL_JSON>'
    )
    forbidden = ("oracle_stdout", '"label"', "mutation_seed", "false_pack_positions")
    if any(token in instruction for token in forbidden):
        raise AssertionError("Prompt construction exposed hidden answer metadata")
    if tuple(re.findall(r"bv-[0-9a-f]{20}", instruction)) != tuple(
        case.case_id for case in program.cases
    ):
        raise AssertionError("Prompt did not include each opaque case ID exactly once")
    return instruction


def load_engine() -> ModuleType:
    if not BASE_RUNNER_PATH.is_file():
        raise ProtocolError(f"Missing immutable base execution engine: {BASE_RUNNER_PATH}")
    if sha256_file(BASE_RUNNER_PATH) != BASE_RUNNER_SHA256:
        raise ProtocolError("Pinned immutable base execution-engine SHA-256 changed")
    name = "_binary_output_verification_base_engine"
    spec = importlib.util.spec_from_file_location(name, BASE_RUNNER_PATH)
    if spec is None or spec.loader is None:
        raise ProtocolError("Cannot import base execution engine")
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    if dict(module.CODESTEER_DEFAULTS) != CODESTEER_PROFILE:
        raise ProtocolError("Base CodeSteer L2 profile changed")
    return module


def prepare_conditions(program: Program, engine: ModuleType) -> Tuple[Any, Any, Any]:
    original_code = program.original_path.read_text(encoding="utf-8")
    obfuscated_code = program.obfuscated_path.read_text(encoding="utf-8")
    original_instruction = build_instruction(program, program.original_target_method)
    obfuscated_instruction = build_instruction(program, program.obfuscated_target_method)
    plain_original = engine.ConditionInput(
        "original_plain",
        "original",
        program.original_path,
        original_code,
        program.original_target_method,
        original_instruction,
        {"enabled": False, "mechanism": "none"},
        False,
    )
    plain_obfuscated = engine.ConditionInput(
        "obfuscated_plain",
        "obfuscated",
        program.obfuscated_path,
        obfuscated_code,
        program.obfuscated_target_method,
        obfuscated_instruction,
        {"enabled": False, "mechanism": "none"},
        False,
    )
    steered_obfuscated = engine.ConditionInput(
        "obfuscated_codesteer",
        "obfuscated",
        program.obfuscated_path,
        obfuscated_code,
        program.obfuscated_target_method,
        obfuscated_instruction,
        {"enabled": False, "mechanism": "activation_level_only"},
        True,
    )
    if plain_obfuscated.instruction != steered_obfuscated.instruction:
        raise AssertionError("Obfuscated plain/CodeSteer instructions must be byte-identical")
    return plain_original, plain_obfuscated, steered_obfuscated


def _blank_parse(expected_ids: Sequence[str], status: str, error: str) -> Dict[str, Any]:
    return {
        "parse_status": status,
        "parse_error": error,
        "marker_open_count": 0,
        "marker_close_count": 0,
        "predictions": {case_id: None for case_id in expected_ids},
        "valid_prediction": {case_id: False for case_id in expected_ids},
        "missing_ids": list(expected_ids),
        "duplicate_ids": [],
        "invalid_value_ids": [],
        "unexpected_ids": [],
        "unexpected_duplicate_ids": [],
        "raw_marked_json": None,
        "pack_valid": False,
    }


def parse_final_labels(completion: str, expected_ids: Sequence[str]) -> Dict[str, Any]:
    """Parse one uniquely marked object while preserving duplicate JSON keys."""
    parsed = _blank_parse(expected_ids, "marker_error", "missing or duplicate marker")
    open_count = completion.count(OPEN_MARKER)
    close_count = completion.count(CLOSE_MARKER)
    parsed["marker_open_count"] = open_count
    parsed["marker_close_count"] = close_count
    if open_count != 1 or close_count != 1:
        return parsed
    stripped = completion.strip()
    if not stripped.startswith(OPEN_MARKER) or not stripped.endswith(CLOSE_MARKER):
        parsed["parse_error"] = "completion contains text outside the marked JSON object"
        return parsed
    start = len(OPEN_MARKER)
    end = len(stripped) - len(CLOSE_MARKER)
    if end < start:
        parsed["parse_error"] = "closing marker precedes opening marker"
        return parsed
    raw_json = stripped[start:end].strip()
    parsed["raw_marked_json"] = raw_json
    try:
        root = json.loads(raw_json, object_pairs_hook=JSONObject)
    except Exception as exc:
        parsed["parse_status"] = "json_error"
        parsed["parse_error"] = f"{type(exc).__name__}: {exc}"
        return parsed
    if not isinstance(root, JSONObject):
        parsed["parse_status"] = "schema_error"
        parsed["parse_error"] = "marked JSON root is not an object"
        return parsed
    label_roots = [value for key, value in root if key == "labels"]
    extra_root_keys = [str(key) for key, _ in root if key != "labels"]
    if len(label_roots) != 1 or extra_root_keys or not isinstance(label_roots[0], JSONObject):
        parsed["parse_status"] = "schema_error"
        parsed["parse_error"] = "root must contain exactly one labels object and no other keys"
        return parsed
    labels: JSONObject = label_roots[0]
    predictions: Dict[str, Optional[str]] = {}
    valid: Dict[str, bool] = {}
    missing: List[str] = []
    duplicates: List[str] = []
    invalid: List[str] = []
    expected_set = set(expected_ids)
    unexpected = sorted({str(key) for key, _ in labels if str(key) not in expected_set})
    unexpected_duplicates = sorted(
        key for key in unexpected if sum(str(raw_key) == key for raw_key, _ in labels) > 1
    )
    for case_id in expected_ids:
        values = [value for key, value in labels if key == case_id]
        if not values:
            predictions[case_id] = None
            valid[case_id] = False
            missing.append(case_id)
        elif len(values) > 1:
            predictions[case_id] = None
            valid[case_id] = False
            duplicates.append(case_id)
        elif type(values[0]) is not str or values[0] not in ("T", "F"):
            predictions[case_id] = None
            valid[case_id] = False
            invalid.append(case_id)
        else:
            predictions[case_id] = values[0]
            valid[case_id] = True
    pack_errors = bool(missing or duplicates or invalid or unexpected)
    if pack_errors:
        # The registered unit is one six-case pack. A malformed labels object is
        # not partially salvaged: all six labels are parse failures and wrong.
        valid = {case_id: False for case_id in expected_ids}
    parsed.update(
        {
            "parse_status": "pack_invalid" if pack_errors else "ok",
            "parse_error": (
                "six-label object has missing, duplicate, invalid, or unexpected IDs"
                if pack_errors
                else None
            ),
            "pack_valid": not pack_errors,
            "predictions": predictions,
            "valid_prediction": valid,
            "missing_ids": missing,
            "duplicate_ids": duplicates,
            "invalid_value_ids": invalid,
            "unexpected_ids": unexpected,
            "unexpected_duplicate_ids": unexpected_duplicates,
        }
    )
    return parsed


def score_completion(program: Program, completion: str) -> Dict[str, Any]:
    expected_ids = [case.case_id for case in program.cases]
    parsed = parse_final_labels(completion, expected_ids)
    scores: List[Dict[str, Any]] = []
    for case in program.cases:
        expected = "T" if case.label else "F"
        predicted = parsed["predictions"].get(case.case_id)
        valid = bool(parsed["valid_prediction"].get(case.case_id))
        scores.append(
            {
                "case_id": case.case_id,
                "pack_position": case.pack_position,
                "expected_label": expected,
                "predicted_label": predicted,
                "valid_prediction": valid,
                "correct": bool(valid and predicted == expected),
            }
        )
    correct = sum(int(row["correct"]) for row in scores)
    return {
        **parsed,
        "label_scores": scores,
        "correct_label_count": correct,
        "label_count": CASES_PER_PROGRAM,
        "label_accuracy": correct / CASES_PER_PROGRAM,
        "scoring_policy": (
            "The pack is valid only when each expected ID occurs exactly once with exact string T/F "
            "and no unexpected IDs. Any marker, JSON, schema, missing, duplicate, invalid-value, or "
            "extra-ID error makes all six labels wrong. No partial salvage, repair, or retry."
        ),
    }


def paired_seed(program_id: str, trial: int) -> int:
    material = f"{PROTOCOL_VERSION}\0{BASE_SEED}\0{program_id}\0{trial}".encode("utf-8")
    return int.from_bytes(hashlib.sha256(material).digest()[:4], "big") & 0x7FFFFFFF


def _output_root(raw: Path) -> Path:
    candidate = raw.expanduser()
    candidate = candidate if candidate.is_absolute() else HERE / candidate
    path = candidate.resolve(strict=False)
    try:
        path.relative_to(HERE)
    except ValueError as exc:
        raise ProtocolError(f"All output must remain inside {HERE}: {path}") from exc
    if path == HERE:
        raise ProtocolError("Output root cannot be the binary_task source directory itself")
    return path


def configure_local_mutable_state(output_root: Path) -> Dict[str, str]:
    scratch = output_root / "scratch"
    paths = {
        "HOME": scratch / "home",
        "TMPDIR": scratch / "tmp",
        "TMP": scratch / "tmp",
        "TEMP": scratch / "tmp",
        "HF_HOME": scratch / "hf-home",
        "HF_HUB_CACHE": scratch / "hf-hub-cache",
        "HUGGINGFACE_HUB_CACHE": scratch / "hf-hub-cache",
        "TRANSFORMERS_CACHE": scratch / "transformers-cache",
        "XDG_CACHE_HOME": scratch / "xdg-cache",
        "TORCH_HOME": scratch / "torch-home",
        "CUDA_CACHE_PATH": scratch / "cuda-cache",
        "PYTORCH_KERNEL_CACHE_PATH": scratch / "pytorch-kernel-cache",
        "TORCHINDUCTOR_CACHE_DIR": scratch / "torchinductor-cache",
        "TRITON_CACHE_DIR": scratch / "triton-cache",
    }
    for path in set(paths.values()):
        path.mkdir(parents=True, exist_ok=True)
    rendered = {key: str(path.resolve()) for key, path in paths.items()}
    os.environ.update(rendered)
    os.environ.update(
        {
            "HF_HUB_OFFLINE": "1",
            "TRANSFORMERS_OFFLINE": "1",
            "TOKENIZERS_PARALLELISM": "false",
        }
    )
    tempfile.tempdir = rendered["TMPDIR"]
    return rendered


def code_provenance() -> Dict[str, Any]:
    paths = (
        Path(__file__).resolve(),
        BASE_RUNNER_PATH,
        MODEL_LOCK_PATH,
        DEFAULT_MANIFEST,
        DEFAULT_MANIFEST.with_suffix(".sha256"),
    )
    return {str(path): sha256_file(path) for path in paths}


def validate_global_model_preflight() -> Dict[str, Any]:
    if not GLOBAL_PREFLIGHT_SUMMARY.is_file():
        raise ProtocolError(
            "Global all-ten-program model preflight has not passed; run plan_shards.py's "
            "preflight_gate command before any outcome shard"
        )
    summary = _load_json(GLOBAL_PREFLIGHT_SUMMARY, "global model preflight summary")
    expected = {
        "protocol_version": PROTOCOL_VERSION,
        "status": "passed",
        "manifest_sha256": MANIFEST_SHA256,
        "model_id": MODEL_NAME,
        "model_snapshot_commit": MODEL_SNAPSHOT_COMMIT,
        "program_count": PROGRAM_COUNT,
        "program_ids": list(EXPECTED_PROGRAM_IDS),
        "outcome_generation_count": 0,
        "code_provenance": code_provenance(),
    }
    differences = {
        key: {"expected": value, "observed": summary.get(key)}
        for key, value in expected.items()
        if summary.get(key) != value
    }
    if differences:
        raise ProtocolError(f"Global model preflight evidence is stale/mismatched: {differences}")
    hashes = summary.get("program_preflight_sha256")
    if not isinstance(hashes, Mapping) or set(hashes) != set(EXPECTED_PROGRAM_IDS):
        raise ProtocolError("Global model preflight lacks all ten program artifacts")
    root = GLOBAL_PREFLIGHT_SUMMARY.parent
    for program_id, expected_hash in hashes.items():
        path = root / "programs" / _safe_program_id(program_id) / "preflight.json"
        if not path.is_file() or sha256_file(path) != expected_hash:
            raise ProtocolError(f"Global model preflight artifact changed: {program_id}")
    return summary


def _safe_program_id(value: str) -> str:
    safe = re.sub(r"[^A-Za-z0-9_.-]+", "_", value).strip("._")
    if not safe:
        raise ProtocolError(f"Unsafe program id: {value!r}")
    return safe


def _write_program_snapshot(root: Path, program: Program) -> None:
    destination = root / "programs" / _safe_program_id(program.program_id)
    atomic_write_bytes(destination / "original.java", program.original_path.read_bytes())
    atomic_write_bytes(destination / "obfuscated.java", program.obfuscated_path.read_bytes())
    atomic_write_json(
        destination / "program.json",
        {
            "program_id": program.program_id,
            "original_source_path": str(program.original_path),
            "obfuscated_source_path": str(program.obfuscated_path),
            "original_sha256": sha256_file(program.original_path),
            "obfuscated_sha256": sha256_file(program.obfuscated_path),
            "original_target_method": program.original_target_method,
            "obfuscated_target_method": program.obfuscated_target_method,
            "cases": [
                {
                    "case_id": case.case_id,
                    "source_case_id": case.source_case_id,
                    "pack_position": case.pack_position,
                    "stdin_sha256": sha256_text(case.stdin),
                    "candidate_stdout_sha256": sha256_text(case.candidate_stdout),
                    "expected_label": "T" if case.label else "F",
                }
                for case in program.cases
            ],
        },
    )


def _fingerprint(payload: Mapping[str, Any]) -> str:
    return sha256_text(stable_json(payload))


def _complete_record(run_dir: Path, fingerprint: str) -> bool:
    record_path = run_dir / "record.json"
    if not record_path.is_file():
        return False
    try:
        record = json.loads(record_path.read_text(encoding="utf-8"))
    except Exception:
        return False
    required = (
        "submitted_prompt.txt",
        "raw_completion.txt",
        "run_config.json",
        "score.json",
        "steering_debug.json",
    )
    return (
        record.get("status") == "complete"
        and record.get("fingerprint") == fingerprint
        and all((run_dir / name).is_file() for name in required)
    )


def rebuild_results_index(output_root: Path) -> None:
    records: List[Dict[str, Any]] = []
    for path in sorted((output_root / "runs").glob("*/trial_*/*/record.json")):
        try:
            record = json.loads(path.read_text(encoding="utf-8"))
        except Exception:
            continue
        records.append(
            {
                "program_id": record.get("program_id"),
                "trial": record.get("trial"),
                "condition": record.get("condition"),
                "paired_seed": record.get("paired_seed"),
                "correct_label_count": record.get("score", {}).get("correct_label_count"),
                "label_count": record.get("score", {}).get("label_count"),
                "parse_status": record.get("score", {}).get("parse_status"),
                "record_path": str(path.relative_to(output_root)),
            }
        )
    atomic_write_json(
        output_root / "results_index.json",
        {
            "protocol_version": PROTOCOL_VERSION,
            "completed_generation_count": len(records),
            "completed_label_judgment_count": len(records) * CASES_PER_PROGRAM,
            "runs": records,
        },
    )


def _static_preflight(program: Program, conditions: Sequence[Any], engine: ModuleType) -> Dict[str, Any]:
    original = engine.analyze_target_method(
        program.original_path.read_text(encoding="utf-8"), program.original_target_method
    )
    obfuscated = engine.analyze_target_method(
        program.obfuscated_path.read_text(encoding="utf-8"), program.obfuscated_target_method
    )
    if not original.get("recorded_target_found") or not obfuscated.get("recorded_target_found"):
        raise ProtocolError(f"{program.program_id}: recorded target method is absent")
    if obfuscated.get("codesteer_target_matches_recorded") is False:
        raise ProtocolError(f"{program.program_id}: CodeSteer selected a different target method")
    if conditions[1].instruction != conditions[2].instruction:
        raise ProtocolError(f"{program.program_id}: obfuscated prompts differ by condition")
    return {
        "program_id": program.program_id,
        "case_count": len(program.cases),
        "opaque_case_ids_in_prompt_order": [case.case_id for case in program.cases],
        "original_line_count": len(
            program.original_path.read_text(encoding="utf-8").splitlines()
        ),
        "obfuscated_line_count": len(
            program.obfuscated_path.read_text(encoding="utf-8").splitlines()
        ),
        "original_method_analysis": original,
        "obfuscated_method_analysis": obfuscated,
        "hidden_fields_rendered_in_instruction": False,
    }


def _select_programs(programs: Sequence[Program], raw: str) -> Tuple[Program, ...]:
    requested = [value.strip() for value in raw.split(",") if value.strip()]
    if not requested:
        return tuple(programs)
    if len(requested) != len(set(requested)):
        raise ProtocolError("--program-ids contains duplicates")
    known = {program.program_id: program for program in programs}
    missing = sorted(set(requested) - set(known))
    if missing:
        raise ProtocolError(f"Unknown program IDs: {missing}")
    requested_set = set(requested)
    return tuple(program for program in programs if program.program_id in requested_set)


def parse_args(argv: Optional[Sequence[str]] = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT_ROOT)
    parser.add_argument(
        "--program-ids",
        default="",
        help="Comma-separated deterministic shard membership; empty means all ten programs.",
    )
    parser.add_argument(
        "--gpu-id", type=int, default=None, help="One physical GPU ID; required for inference."
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Validate frozen inputs and static prompts without creating files or loading the model.",
    )
    parser.add_argument(
        "--model-preflight-only",
        action="store_true",
        help=(
            "Load the pinned model and run token/context/CodeSteer prior checks for all ten "
            "programs, write no model outcomes, then exit."
        ),
    )
    return parser.parse_args(argv)


def main(argv: Optional[Sequence[str]] = None) -> int:
    args = parse_args(argv)
    validate_model_lock()
    manifest, all_programs = validate_manifest(args.manifest)
    if args.model_preflight_only and args.program_ids.strip():
        raise ProtocolError("--model-preflight-only must cover all ten programs")
    if args.model_preflight_only and args.dry_run:
        raise ProtocolError("Choose either --dry-run or --model-preflight-only")
    programs = _select_programs(all_programs, args.program_ids)
    if not programs:
        raise ProtocolError("No programs selected")
    engine = load_engine()
    prepared = {program.program_id: prepare_conditions(program, engine) for program in programs}
    static = {
        program.program_id: _static_preflight(program, prepared[program.program_id], engine)
        for program in programs
    }
    if args.dry_run:
        print(
            json.dumps(
                {
                    "status": "static_preflight_passed",
                    "protocol_version": PROTOCOL_VERSION,
                    "manifest_sha256": MANIFEST_SHA256,
                    "program_count": len(programs),
                    "generation_count": len(programs) * GENERATIONS_PER_PROGRAM,
                    "label_judgment_count": len(programs)
                    * GENERATIONS_PER_PROGRAM
                    * CASES_PER_PROGRAM,
                    "program_ids": [program.program_id for program in programs],
                },
                indent=2,
                sort_keys=True,
            )
        )
        return 0
    if args.gpu_id is None or args.gpu_id < 0:
        raise ProtocolError("Inference requires one non-negative --gpu-id")

    cache_status = cached_snapshot_status()
    if not cache_status["available"]:
        raise ProtocolError(f"Exact cached model is unavailable: {stable_json(cache_status)}")
    if not args.model_preflight_only:
        validate_global_model_preflight()
    output_root = _output_root(args.output_root)
    output_root.mkdir(parents=True, exist_ok=True)
    mutable_paths = configure_local_mutable_state(output_root)
    os.environ["CUDA_VISIBLE_DEVICES"] = str(args.gpu_id)

    experiment_config = {
        "protocol_version": PROTOCOL_VERSION,
        "manifest_path": str(DEFAULT_MANIFEST),
        "manifest_sha256": MANIFEST_SHA256,
        "manifest_schema": MANIFEST_SCHEMA,
        "model_id": MODEL_NAME,
        "model_snapshot_commit": MODEL_SNAPSHOT_COMMIT,
        "model_cache_read_only_input": str(MODEL_CACHE),
        "conditions": list(CONDITIONS),
        "trials": TRIALS,
        "base_seed": BASE_SEED,
        "generation": GENERATION,
        "codesteer_profile": CODESTEER_PROFILE,
        "selected_program_ids": [program.program_id for program in programs],
        "expected_generation_count": len(programs) * GENERATIONS_PER_PROGRAM,
        "labels_per_generation": CASES_PER_PROGRAM,
        "paper_metric": (
            "one-attempt Pass@1 micro label accuracy: correct labels / 60 over ten clustered "
            "program prompts per condition"
        ),
        "completion_policy": "one completion per program/condition/trial; no repair or retry",
        "run_mode": "model_preflight_only" if args.model_preflight_only else "inference",
        "code_provenance": code_provenance(),
    }
    config_path = output_root / "experiment_config.json"
    if config_path.exists():
        old = _load_json(config_path, "existing experiment config")
        if old != experiment_config:
            raise ProtocolError(f"Existing output root has a different experiment config: {config_path}")
    else:
        atomic_write_json(config_path, experiment_config)
    for program in programs:
        _write_program_snapshot(output_root, program)
        atomic_write_json(
            output_root / "programs" / _safe_program_id(program.program_id) / "static_preflight.json",
            static[program.program_id],
        )

    if str(PROJECT_ROOT) not in sys.path:
        sys.path.insert(0, str(PROJECT_ROOT))
    from models import ModelRunner

    import torch
    import transformers

    if not torch.cuda.is_available() or torch.cuda.device_count() != 1:
        raise ProtocolError(
            f"Expected exactly one visible CUDA device, observed {torch.cuda.device_count()}"
        )
    prior_cache = engine.install_static_prior_vector_cache()
    steering_config = engine.build_codesteer_config()
    runner = ModelRunner()
    runner.set_steering_config(steering_config)
    # Load from the pinned snapshot directory directly. This keeps the external
    # Hugging Face cache a read-only input and places any mutable loader cache below output_root.
    snapshot_path = str(cache_status["snapshot_path"])
    runner.config(
        key_scope="prompt",
        max_devices=1,
        model_name=snapshot_path,
        cache_dir=str((output_root / "scratch" / "hf-loader-cache").resolve()),
        temperature=GENERATION["temperature"],
        top_p=GENERATION["top_p"],
        top_k=GENERATION["top_k"],
        max_new_tokens=GENERATION["max_new_tokens"],
    )
    runner.build()
    layer_start, layer_end, num_layers = engine.set_last_n_layers(
        steering_config, runner.model, CODESTEER_PROFILE["steer_last_n_layers"]
    )
    # Logical identity is restored after the direct local-snapshot load.
    runner.model_name = MODEL_NAME
    steering_config.model_name = MODEL_NAME
    steering_payload = dataclasses.asdict(steering_config)
    model_config = runner.model.config.to_dict()
    config_mismatch = {
        key: {"expected": expected, "observed": model_config.get(key)}
        for key, expected in MODEL_CONFIG_EXPECTED.items()
        if model_config.get(key) != expected
    }
    if config_mismatch or (layer_start, layer_end, num_layers) != (20, 27, 28):
        runner.free()
        raise ProtocolError(
            f"Loaded model/config differs from registered Qwen2.5-7B: {config_mismatch} "
            f"layers={(layer_start, layer_end, num_layers)}"
        )
    atomic_write_json(
        output_root / "environment.json",
        {
            "protocol_version": PROTOCOL_VERSION,
            "started_utc": datetime.now(timezone.utc).isoformat(),
            "hostname": socket.gethostname(),
            "python_version": sys.version,
            "torch_version": torch.__version__,
            "transformers_version": transformers.__version__,
            "cuda_runtime_version": torch.version.cuda,
            "cuda_device_name": torch.cuda.get_device_name(0),
            "physical_gpu_id_requested": args.gpu_id,
            "visible_cuda_device_count": torch.cuda.device_count(),
            "model_id": MODEL_NAME,
            "model_snapshot_commit": MODEL_SNAPSHOT_COMMIT,
            "model_snapshot_status": cache_status,
            "model_loaded_directly_from_snapshot": snapshot_path,
            "model_config": model_config,
            "codesteer_config": steering_payload,
            "codesteer_layer_start": layer_start,
            "codesteer_layer_end": layer_end,
            "static_prior_cache": prior_cache,
            "mutable_paths_inside_output_root": mutable_paths,
            "code_provenance": code_provenance(),
        },
    )

    try:
        # Complete all prompt/context/prior checks before the first generation.
        for program in programs:
            condition_map = {
                condition.name: condition for condition in prepared[program.program_id]
            }
            token_preflight: Dict[str, Any] = {}
            for condition_name in CONDITIONS:
                condition = condition_map[condition_name]
                token = engine.prompt_token_preflight(
                    runner, condition, GENERATION["max_new_tokens"]
                )
                if not token["fits_context"]:
                    raise ProtocolError(
                        f"{program.program_id}/{condition_name} exceeds model context"
                    )
                token_preflight[condition_name] = token
            if (
                token_preflight["obfuscated_plain"]["prompt_sha256"]
                != token_preflight["obfuscated_codesteer"]["prompt_sha256"]
            ):
                raise ProtocolError(f"{program.program_id}: paired obfuscated prompts differ")
            prior = engine.codesteer_prior_preflight(
                runner, condition_map["obfuscated_codesteer"]
            )
            if prior["algorithm_fallback_detected"]:
                raise ProtocolError(f"{program.program_id}: slicing prior fell back")
            if prior.get("parsed_case_ids") != [f"c{index:03d}" for index in range(1, 7)]:
                raise ProtocolError(
                    f"{program.program_id}: slice_hybrid did not parse all six case signals"
                )
            atomic_write_json(
                output_root / "programs" / _safe_program_id(program.program_id) / "preflight.json",
                {
                    **static[program.program_id],
                    "prompt_tokens_by_condition": token_preflight,
                    "codesteer_prior": prior,
                    "eligible_for_inference": True,
                },
            )

        if args.model_preflight_only:
            summary = {
                "protocol_version": PROTOCOL_VERSION,
                "status": "passed",
                "manifest_sha256": MANIFEST_SHA256,
                "model_id": MODEL_NAME,
                "model_snapshot_commit": MODEL_SNAPSHOT_COMMIT,
                "program_count": len(programs),
                "program_ids": [program.program_id for program in programs],
                "outcome_generation_count": 0,
                "code_provenance": code_provenance(),
                "program_preflight_sha256": {
                    program.program_id: sha256_file(
                        output_root
                        / "programs"
                        / _safe_program_id(program.program_id)
                        / "preflight.json"
                    )
                    for program in programs
                },
                "checks": [
                    "exact model/cache/config",
                    "all prompts fit context with max_new_tokens=192",
                    "obfuscated plain/CodeSteer prompt identity",
                    "non-fallback slice prior",
                    "six parsed slice_hybrid case signals per program",
                ],
            }
            atomic_write_json(output_root / "model_preflight_summary.json", summary)
            print(f"[model-preflight-complete] {output_root / 'model_preflight_summary.json'}")
            return 0

        for program in programs:
            condition_map = {
                condition.name: condition for condition in prepared[program.program_id]
            }
            preflight = _load_json(
                output_root / "programs" / _safe_program_id(program.program_id) / "preflight.json",
                "program preflight",
            )
            for trial in range(1, TRIALS + 1):
                seed = paired_seed(program.program_id, trial)
                for condition_name in CONDITIONS:
                    condition = condition_map[condition_name]
                    prompt = runner._build_prompt(
                        condition.source_code,
                        instruction=condition.instruction,
                        language="java",
                        answer_prefix="",
                    )
                    fingerprint_payload = {
                        "protocol_version": PROTOCOL_VERSION,
                        "manifest_sha256": MANIFEST_SHA256,
                        "program_id": program.program_id,
                        "case_ids_in_prompt_order": [case.case_id for case in program.cases],
                        "original_sha256": sha256_file(program.original_path),
                        "obfuscated_sha256": sha256_file(program.obfuscated_path),
                        "condition": condition_name,
                        "trial": trial,
                        "paired_seed": seed,
                        "model_id": MODEL_NAME,
                        "model_snapshot_commit": MODEL_SNAPSHOT_COMMIT,
                        "generation": GENERATION,
                        "prompt_sha256": sha256_text(prompt),
                        "steering": steering_payload if condition.activation_steering else None,
                    }
                    fingerprint = _fingerprint(fingerprint_payload)
                    run_dir = (
                        output_root
                        / "runs"
                        / _safe_program_id(program.program_id)
                        / f"trial_{trial:03d}"
                        / condition_name
                    )
                    if _complete_record(run_dir, fingerprint):
                        print(
                            f"[skip] {program.program_id} trial={trial} condition={condition_name}"
                        )
                        continue
                    if run_dir.exists() and any(run_dir.iterdir()):
                        raise ProtocolError(
                            f"Incomplete/stale attempt exists at {run_dir}; automatic retries and "
                            "outcome-selective replacement are forbidden"
                        )
                    run_dir.mkdir(parents=True, exist_ok=True)
                    run_config = {
                        **fingerprint_payload,
                        "fingerprint": fingerprint,
                        "source_kind": condition.source_kind,
                        "target_method": condition.target_method,
                        "activation_steering": condition.activation_steering,
                        "token_preflight": preflight["prompt_tokens_by_condition"][condition_name],
                        "codesteer_prior_preflight": (
                            preflight["codesteer_prior"] if condition.activation_steering else None
                        ),
                        "paired_design": "same seed across all three conditions",
                        "hidden_labels_in_prompt": False,
                    }
                    atomic_write_json(run_dir / "run_config.json", run_config)
                    atomic_write_text(run_dir / "submitted_prompt.txt", prompt)
                    atomic_write_text(run_dir / "source.java", condition.source_code)
                    atomic_write_json(
                        run_dir / "status.json",
                        {
                            "status": "running",
                            "fingerprint": fingerprint,
                            "started_at_unix": time.time(),
                            "attempt": 1,
                            "automatic_retry_allowed": False,
                        },
                    )
                    runner.steering_config = (
                        steering_config if condition.activation_steering else None
                    )
                    engine.seed_everything(seed)
                    try:
                        result = runner.run_llama(
                            condition.source_code,
                            instruction=condition.instruction,
                            language="java",
                            answer_prefix="",
                            max_new_tokens=GENERATION["max_new_tokens"],
                            temperature=GENERATION["temperature"],
                            top_p=GENERATION["top_p"],
                            top_k=GENERATION["top_k"],
                            do_sample=True,
                            record_layers=False,
                            record_attention=False,
                            vocab_tokens=[],
                            steering_code_snippet=condition.source_code,
                        )
                    except Exception as exc:
                        atomic_write_json(
                            run_dir / "status.json",
                            {
                                "status": "infrastructure_failure_no_completion",
                                "fingerprint": fingerprint,
                                "attempt": 1,
                                "automatic_retry_allowed": False,
                                "exception_type": type(exc).__name__,
                                "exception": str(exc),
                            },
                        )
                        raise
                    completion = str(result.get("generated_completion") or "")
                    score = score_completion(program, completion)
                    debug = result.get("steering_debug") or {}
                    engine.validate_steering_debug(condition, debug)
                    reasoning = (
                        completion.split(OPEN_MARKER, 1)[0].strip()
                        if OPEN_MARKER in completion
                        else completion.strip()
                    )
                    result["experiment"] = {
                        "program_id": program.program_id,
                        "trial": trial,
                        "condition": condition_name,
                        "paired_seed": seed,
                        "fingerprint": fingerprint,
                    }
                    result["score"] = score
                    result.pop("full_decode_head_tensors", None)
                    atomic_write_text(run_dir / "raw_completion.txt", completion)
                    atomic_write_text(run_dir / "reasoning.txt", reasoning)
                    atomic_write_text(
                        run_dir / "model_prompt_decoded.txt", str(result.get("prompt_text", ""))
                    )
                    atomic_write_json(run_dir / "score.json", score)
                    atomic_write_json(run_dir / "steering_debug.json", debug)
                    atomic_write_json(run_dir / "model_output.json", result)
                    record = {
                        "status": "complete",
                        "completed_at_unix": time.time(),
                        "attempt": 1,
                        "automatic_retry_used": False,
                        "fingerprint": fingerprint,
                        "program_id": program.program_id,
                        "trial": trial,
                        "condition": condition_name,
                        "paired_seed": seed,
                        "score": score,
                        "artifacts": {
                            "submitted_prompt": "submitted_prompt.txt",
                            "raw_completion": "raw_completion.txt",
                            "reasoning": "reasoning.txt",
                            "run_config": "run_config.json",
                            "score": "score.json",
                            "steering_debug": "steering_debug.json",
                            "model_output": "model_output.json",
                        },
                    }
                    atomic_write_json(run_dir / "record.json", record)
                    atomic_write_json(run_dir / "status.json", record)
                    rebuild_results_index(output_root)
                    print(
                        f"[done] {program.program_id} trial={trial} condition={condition_name} "
                        f"labels={score['correct_label_count']}/6 seed={seed}"
                    )
    finally:
        runner.free()
    rebuild_results_index(output_root)
    print(f"[complete] {output_root / 'results_index.json'}")
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ProtocolError, ValueError, TypeError, FileNotFoundError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(2)
