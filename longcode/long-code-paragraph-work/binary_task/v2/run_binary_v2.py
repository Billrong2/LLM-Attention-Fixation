#!/usr/bin/env python3
"""Run the frozen chat-templated v2 binary output-verification protocol.

The study design is ten six-case program packs x three paired conditions x one
attempt (30 generations). Before study execution, a non-study holdout liveness
run must demonstrate a non-degenerate, parseable response, the protocol must be
frozen, and an outcome-free all-ten model preflight must pass.
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
V1_ROOT = HERE.parent
PARAGRAPH_ROOT = V1_ROOT.parent
PROMPT_STEERING_ROOT = PARAGRAPH_ROOT.parent
PROJECT_ROOT = PROMPT_STEERING_ROOT.parent
V1_RUNNER_PATH = V1_ROOT / "run_binary_verification.py"
BASE_RUNNER_PATH = PROMPT_STEERING_ROOT / "long-code-sample-work" / "run_long_code_experiment.py"
MODELS_PATH = PROJECT_ROOT / "models.py"
ELEMENT_PROMPTING_PATH = PROMPT_STEERING_ROOT / "element_prompting.py"
PROMPT_PATH = PROMPT_STEERING_ROOT / "prompt.py"
STEERING_ROOT = PROJECT_ROOT / "steering"
MODEL_LOCK_PATH = PARAGRAPH_ROOT / "model_lock.json"
STUDY_MANIFEST_PATH = V1_ROOT / "inference_manifest.json"
HOLDOUT_MANIFEST_PATH = HERE / "holdout_manifest.json"
HOLDOUT_ANCHOR_PATH = HERE / "holdout_manifest.sha256"
PROTOCOL_FREEZE_PATH = HERE / "FROZEN_PROTOCOL.sha256"
PROTOCOL_FREEZE_METADATA_PATH = HERE / "protocol_freeze.json"
DEFAULT_RESULTS_ROOT = HERE / "results"
LIVENESS_ROOT = DEFAULT_RESULTS_ROOT / "liveness"
MODEL_PREFLIGHT_ROOT = DEFAULT_RESULTS_ROOT / "study_preflight"
STUDY_RESULTS_ROOT = DEFAULT_RESULTS_ROOT / "study"

PROTOCOL_VERSION = "long-code-binary-output-verification-chat-v2"
V1_RUNNER_SHA256 = "f81edaad2b30d2bcab0b183f95691382cf898d25fdde9e6cf34a717fabc39faf"
STUDY_MANIFEST_SHA256 = "ab6b82d31c5beddf54fb938b1c700ab536d0f6c826caf66d40a63db6c3490471"
HOLDOUT_MANIFEST_SHA256 = "829a4fda5a421dddcb2c6fd9800d045cccd71a704bed99abd72d59b3fb09c238"
TOKENIZER_CONFIG_SHA256 = "959e7f1d9a1b7641a6d6ce05ca97b75c7894fcb66cbe5a040406458fb1128ee4"
CHAT_TEMPLATE_SHA256 = "cd8e9439f0570856fd70470bf8889ebd8b5d1107207f67a5efb46e342330527f"
CHAT_GENERATION_SUFFIX = "<|im_start|>assistant\n"
RUNTIME_DEPENDENCY_SHA256: Tuple[Tuple[Path, str], ...] = (
    (MODELS_PATH, "5f35c81c83f00b36019193001d185e014f53687d3893c7edee933b1cca7ad159"),
    (
        ELEMENT_PROMPTING_PATH,
        "609edaa98e2e8b5efa0368ab4a22ad3c54c9d110fee68dc6e0acf749b2288fca",
    ),
    (PROMPT_PATH, "f16a0c73a7ee5e41e780d6eb60d8a148eda58aade4befb9e394cae242caba64a"),
    (
        STEERING_ROOT / "config.py",
        "2ba6a1131fb3f1bdaf588e5f206d1ad43a4a00b4b5c65330c251c678bc4f6580",
    ),
    (
        STEERING_ROOT / "runtime.py",
        "24a6011b209443f749f0ce4aaf2d0ea2fc0252b51aeffaf7ab7801bd77c8b631",
    ),
    (
        STEERING_ROOT / "priors.py",
        "b3055f307cec4aa123e4dea3850ad0aef884a507a5b0124e8386c058dd81b12e",
    ),
    (
        STEERING_ROOT / "levels.py",
        "0d9d5ce882924e4a10fd4a4b478b4e6f2d8aaaba1db873069ea3d78d39ad9933",
    ),
    (
        STEERING_ROOT / "backends" / "qwen2_backend.py",
        "1ed077ef0f33b7c766043eb6cba3ca23855493f83fbb7642a330e311ea515f9b",
    ),
)

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
LABEL_COUNT = 60
GENERATIONS_PER_PROGRAM = 3
EXPECTED_GENERATIONS = 30
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
REGISTERED_SHARD_MEMBERSHIP: Tuple[Tuple[str, ...], ...] = (
    (
        "cc-valid-r069-s0346-1560-d-make-a-power-of-two__t5_easy_seed1",
        "cc-valid-r065-s0055-1559-e-mocha-and-stars__t5_easy_seed1",
        "cc-valid-r005-s0097-1549-b-gregor-and-the-pawn-game__t5_easy_seed1",
    ),
    (
        "cc-valid-r013-s0260-1551-d2-domino-hard-version__t5_easy_seed1",
        "cc-valid-r026-s0376-1553-c-penalty__t5_easy_seed1",
        "cc-valid-r094-s0350-1567-c-carrying-conundrum__t5_easy_seed1",
    ),
    (
        "cc-valid-r044-s0096-1556-a-a-variety-of-operations__t5_easy_seed1",
        "cc-valid-r098-s0215-1569-a-balanced-substring__t5_easy_seed1",
    ),
    (
        "cc-valid-r078-s0458-1562-a-the-miracle-and-the-sleeper__t5_easy_seed1",
        "cc-valid-r035-s0203-1554-c-mikasa__t5_easy_seed1",
    ),
)
EXPECTED_FREEZE_FILES: Tuple[str, ...] = (
    "PROTOCOL.md",
    "README.md",
    "build_holdout_manifest.py",
    "freeze_protocol.py",
    "holdout_manifest.json",
    "holdout_manifest.sha256",
    "launch_plan.json",
    "plan_v2_shards.py",
    "run_binary_v2.py",
    "test_v2_protocol.py",
)
HOLDOUT_PROGRAM_ID = "cc-valid-r045-s0246-1556-b-take-your-places__t5_easy_seed1"


class ProtocolError(RuntimeError):
    """The requested mode or observed evidence differs from frozen v2."""


class JSONObject(list):
    """Ordered JSON pairs; duplicate keys are intentionally retained."""


@dataclass(frozen=True)
class CaseView:
    case_id: str
    pack_position: int
    stdin: str
    candidate_stdout: str
    label: Optional[bool] = None


@dataclass(frozen=True)
class Pack:
    program_id: str
    original_path: Path
    obfuscated_path: Path
    original_target_method: str
    obfuscated_target_method: str
    cases: Tuple[CaseView, ...]
    is_study: bool


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


def stable_json(payload: Any) -> str:
    return json.dumps(
        payload,
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
        json.dumps(payload, ensure_ascii=False, indent=2, sort_keys=True, default=str) + "\n",
    )


def read_json(path: Path, label: str) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except Exception as exc:
        raise ProtocolError(f"Cannot read {label} {path}: {exc}") from exc


def load_v1() -> ModuleType:
    if not V1_RUNNER_PATH.is_file() or sha256_file(V1_RUNNER_PATH) != V1_RUNNER_SHA256:
        raise ProtocolError("Frozen v1 runner changed; v2 refuses an unreviewed dependency")
    name = "_binary_v2_frozen_v1_dependency"
    spec = importlib.util.spec_from_file_location(name, V1_RUNNER_PATH)
    if spec is None or spec.loader is None:
        raise ProtocolError("Cannot import frozen v1 validation dependency")
    module = importlib.util.module_from_spec(spec)
    sys.modules[name] = module
    spec.loader.exec_module(module)
    return module


V1 = load_v1()


def _resolve_inside(raw: Path, root: Path, *, must_exist: bool, label: str) -> Path:
    candidate = raw.expanduser()
    candidate = candidate if candidate.is_absolute() else root / candidate
    try:
        path = candidate.resolve(strict=must_exist)
        path.relative_to(root.resolve(strict=True))
    except Exception as exc:
        raise ProtocolError(f"{label} is missing or escapes {root}: {candidate}") from exc
    return path


def _output_root(raw: Path) -> Path:
    return _resolve_inside(raw, HERE, must_exist=False, label="v2 output root")


def study_packs() -> Tuple[Pack, ...]:
    if sha256_file(STUDY_MANIFEST_PATH) != STUDY_MANIFEST_SHA256:
        raise ProtocolError("Frozen v1 study manifest changed")
    _, programs = V1.validate_manifest(STUDY_MANIFEST_PATH)
    if tuple(program.program_id for program in programs) != EXPECTED_PROGRAM_IDS:
        raise ProtocolError("Study cohort differs from the frozen ten programs")
    return tuple(
        Pack(
            program_id=program.program_id,
            original_path=program.original_path,
            obfuscated_path=program.obfuscated_path,
            original_target_method=program.original_target_method,
            obfuscated_target_method=program.obfuscated_target_method,
            cases=tuple(
                CaseView(
                    case_id=case.case_id,
                    pack_position=case.pack_position,
                    stdin=case.stdin,
                    candidate_stdout=case.candidate_stdout,
                    label=case.label,
                )
                for case in program.cases
            ),
            is_study=True,
        )
        for program in programs
    )


def holdout_pack() -> Pack:
    if sha256_file(HOLDOUT_MANIFEST_PATH) != HOLDOUT_MANIFEST_SHA256:
        raise ProtocolError("Non-study holdout manifest hash changed")
    fields = HOLDOUT_ANCHOR_PATH.read_text(encoding="utf-8").strip().split()
    if fields != [HOLDOUT_MANIFEST_SHA256, HOLDOUT_MANIFEST_PATH.name]:
        raise ProtocolError("Non-study holdout external anchor changed")
    payload = read_json(HOLDOUT_MANIFEST_PATH, "holdout manifest")
    required = {
        "schema_version": "long-code-binary-v2-non-study-liveness-v1",
        "study_outcomes_read": False,
        "study_outcomes_written": False,
        "program_count": 1,
        "case_count": 6,
        "program_id": HOLDOUT_PROGRAM_ID,
        "program_is_outside_study_cohort": True,
        "study_program_ids": list(EXPECTED_PROGRAM_IDS),
    }
    failed = [key for key, expected in required.items() if payload.get(key) != expected]
    if failed or HOLDOUT_PROGRAM_ID in EXPECTED_PROGRAM_IDS:
        raise ProtocolError(f"Holdout cohort contract changed: {failed}")
    prepared = (HERE / str(payload["prepared_manifest_path"])).resolve(strict=True)
    if sha256_file(prepared) != payload.get("prepared_manifest_sha256"):
        raise ProtocolError("Holdout prepared-manifest binding changed")
    original = (HERE / str(payload["original_path"])).resolve(strict=True)
    obfuscated = (HERE / str(payload["obfuscated_path"])).resolve(strict=True)
    for path, expected, label in (
        (original, payload.get("original_sha256"), "original"),
        (obfuscated, payload.get("obfuscated_sha256"), "obfuscated"),
    ):
        try:
            path.relative_to(PROMPT_STEERING_ROOT.resolve(strict=True))
        except ValueError as exc:
            raise ProtocolError(f"Holdout {label} source escapes PromptSteering") from exc
        if sha256_file(path) != expected:
            raise ProtocolError(f"Holdout {label} source hash changed")
    cases_raw = payload.get("cases")
    if not isinstance(cases_raw, list) or len(cases_raw) != 6:
        raise ProtocolError("Holdout must contain exactly six cases")
    cases: List[CaseView] = []
    seen_ids: set[str] = set()
    seen_inputs: set[str] = set()
    for position, raw in enumerate(cases_raw, start=1):
        if not isinstance(raw, Mapping):
            raise ProtocolError("Holdout case is not an object")
        case_id = str(raw.get("id") or "")
        stdin = str(raw.get("stdin") or "")
        candidate = str(raw.get("candidate_stdout") or "")
        if any(
            (
                not re.fullmatch(r"lv-[0-9a-f]{20}", case_id),
                case_id in seen_ids,
                raw.get("pack_position") != position,
                raw.get("stdin_sha256") != sha256_text(stdin),
                raw.get("candidate_stdout_sha256") != sha256_text(candidate),
                sha256_text(stdin) in seen_inputs,
            )
        ):
            raise ProtocolError(f"Malformed holdout case at position {position}")
        seen_ids.add(case_id)
        seen_inputs.add(sha256_text(stdin))
        cases.append(CaseView(case_id, position, stdin, candidate, None))
    return Pack(
        program_id=HOLDOUT_PROGRAM_ID,
        original_path=original,
        obfuscated_path=obfuscated,
        original_target_method=str(payload["original_target_method"]),
        obfuscated_target_method=str(payload["obfuscated_target_method"]),
        cases=tuple(cases),
        is_study=False,
    )


def _balanced_object_blocks(text: str) -> Tuple[List[str], bool]:
    """Return non-overlapping top-level brace blocks, respecting JSON strings."""
    blocks: List[str] = []
    depth = 0
    start: Optional[int] = None
    in_string = False
    escaped = False
    stray_close = False
    for index, character in enumerate(text):
        if in_string:
            if escaped:
                escaped = False
            elif character == "\\":
                escaped = True
            elif character == '"':
                in_string = False
            continue
        if character == '"':
            in_string = True
        elif character == "{":
            if depth == 0:
                start = index
            depth += 1
        elif character == "}":
            if depth == 0:
                stray_close = True
                continue
            depth -= 1
            if depth == 0 and start is not None:
                blocks.append(text[start : index + 1])
                start = None
    malformed = depth != 0 or in_string or stray_close
    return blocks, malformed


def parse_response(completion: str, expected_ids: Sequence[str]) -> Dict[str, Any]:
    """Parse exactly one whole/fenced/embedded JSON object, all-or-nothing."""
    expected = list(expected_ids)
    if len(expected) != CASES_PER_PROGRAM or len(set(expected)) != CASES_PER_PROGRAM:
        raise ProtocolError("Parser requires exactly six distinct expected opaque IDs")
    blank = {
        "parse_status": "object_count_error",
        "pack_valid": False,
        "object_count": 0,
        "response_mode": None,
        "predictions": {case_id: None for case_id in expected},
        "valid_prediction": {case_id: False for case_id in expected},
        "missing_ids": list(expected),
        "duplicate_ids": [],
        "unexpected_ids": [],
        "invalid_value_ids": [],
        "raw_json_object": None,
    }
    blocks, malformed = _balanced_object_blocks(completion)
    blank["object_count"] = len(blocks)
    if malformed or len(blocks) != 1:
        blank["parse_status"] = "malformed_or_object_count_error"
        return blank
    raw = blocks[0]
    blank["raw_json_object"] = raw
    try:
        root = json.loads(raw, object_pairs_hook=JSONObject)
    except Exception:
        blank["parse_status"] = "json_error"
        return blank
    if not isinstance(root, JSONObject):
        blank["parse_status"] = "schema_error"
        return blank
    predictions: Dict[str, Optional[str]] = {}
    valid: Dict[str, bool] = {}
    missing: List[str] = []
    duplicates: List[str] = []
    invalid: List[str] = []
    expected_set = set(expected)
    unexpected = sorted({str(key) for key, _ in root if str(key) not in expected_set})
    for case_id in expected:
        values = [value for key, value in root if key == case_id]
        if not values:
            predictions[case_id] = None
            valid[case_id] = False
            missing.append(case_id)
        elif len(values) != 1:
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
    pack_valid = not (missing or duplicates or unexpected or invalid) and len(root) == len(expected)
    if not pack_valid:
        predictions = {case_id: None for case_id in expected}
        valid = {case_id: False for case_id in expected}
    stripped = completion.strip()
    response_mode = "whole_json" if stripped == raw else "embedded_or_fenced_json"
    return {
        **blank,
        "parse_status": "ok" if pack_valid else "pack_invalid",
        "pack_valid": pack_valid,
        "response_mode": response_mode,
        "predictions": predictions,
        "valid_prediction": valid,
        "missing_ids": missing,
        "duplicate_ids": duplicates,
        "unexpected_ids": unexpected,
        "invalid_value_ids": invalid,
    }


def score_study_completion(pack: Pack, completion: str) -> Dict[str, Any]:
    if not pack.is_study or any(case.label is None for case in pack.cases):
        raise ProtocolError("Study scoring cannot be applied to a liveness holdout")
    parsed = parse_response(completion, [case.case_id for case in pack.cases])
    rows: List[Dict[str, Any]] = []
    for case in pack.cases:
        expected = "T" if case.label else "F"
        predicted = parsed["predictions"].get(case.case_id)
        valid = bool(parsed["valid_prediction"].get(case.case_id))
        rows.append(
            {
                "case_id": case.case_id,
                "pack_position": case.pack_position,
                "expected_label": expected,
                "predicted_label": predicted,
                "valid_prediction": valid,
                "correct": bool(valid and predicted == expected),
            }
        )
    correct = sum(int(row["correct"]) for row in rows)
    return {
        **parsed,
        "label_scores": rows,
        "correct_label_count": correct,
        "label_count": CASES_PER_PROGRAM,
        "label_accuracy": correct / CASES_PER_PROGRAM,
        "scoring_policy": (
            "Exactly one whole/fenced/embedded object must map exactly the six expected IDs to "
            "exact T/F strings. Any parse/schema/key/value error invalidates all six; no partial "
            "salvage, repair, retry, or drop."
        ),
    }


def build_instruction(pack: Pack, target_method: str) -> str:
    lines: List[str] = []
    for case in pack.cases:
        visible = {
            "case_id": case.case_id,
            "stdin": case.stdin,
            "candidate_stdout": case.candidate_stdout,
        }
        lines.append(
            f"c{case.pack_position:03d}: "
            + json.dumps(visible, ensure_ascii=False, sort_keys=True, separators=(",", ":"))
        )
    key_list = json.dumps([case.case_id for case in pack.cases], separators=(",", ":"))
    instruction = (
        "Verify six candidate outputs for this deterministic Java program. "
        f"The recorded algorithm method is `{target_method}`. For each case, run the same program "
        "mentally on stdin. Replace CRLF or CR with LF and strip only outer whitespace from both "
        "outputs; internal whitespace remains exact. Map a case ID to the exact string \"T\" when "
        "candidate_stdout equals what the program prints, otherwise map it to \"F\". Judge cases "
        "independently.\n"
        "### CASES_BEGIN\n"
        + "\n".join(lines)
        + "\n### CASES_END\n\n"
        "Return one JSON object mapping the six case IDs directly to \"T\" or \"F\". Prefer only "
        "the JSON object; one fenced or prose-embedded object is also parseable. Do not use a "
        "labels wrapper, omit a key, add a key, repeat a key, or emit a second JSON object. "
        f"Required keys: {key_list}"
    )
    forbidden = ("oracle_stdout", '"label"', "mutation_seed", "expected_label")
    if any(token in instruction for token in forbidden):
        raise AssertionError("Instruction exposed hidden answer metadata")
    for case in pack.cases:
        if instruction.count(case.case_id) != 2:
            raise AssertionError("Instruction must show each ID once in its case and once in key list")
    return instruction


def build_user_content(code: str, instruction: str, language: str = "java") -> str:
    return f"{instruction}\n\n```{language}\n{code}\n```"


def messages_for(code: str, instruction: str, language: str = "java") -> List[Dict[str, str]]:
    return [{"role": "user", "content": build_user_content(code, instruction, language)}]


def prepare_conditions(pack: Pack, engine: ModuleType) -> Tuple[Any, Any, Any]:
    original_code = pack.original_path.read_text(encoding="utf-8")
    obfuscated_code = pack.obfuscated_path.read_text(encoding="utf-8")
    original_instruction = build_instruction(pack, pack.original_target_method)
    obfuscated_instruction = build_instruction(pack, pack.obfuscated_target_method)
    original = engine.ConditionInput(
        "original_plain",
        "original",
        pack.original_path,
        original_code,
        pack.original_target_method,
        original_instruction,
        {"enabled": False, "mechanism": "none", "chat_template": True},
        False,
    )
    obfuscated = engine.ConditionInput(
        "obfuscated_plain",
        "obfuscated",
        pack.obfuscated_path,
        obfuscated_code,
        pack.obfuscated_target_method,
        obfuscated_instruction,
        {"enabled": False, "mechanism": "none", "chat_template": True},
        False,
    )
    steered = engine.ConditionInput(
        "obfuscated_codesteer",
        "obfuscated",
        pack.obfuscated_path,
        obfuscated_code,
        pack.obfuscated_target_method,
        obfuscated_instruction,
        {"enabled": False, "mechanism": "activation_level_only", "chat_template": True},
        True,
    )
    if obfuscated.instruction != steered.instruction:
        raise AssertionError("Paired obfuscated instructions differ")
    return original, obfuscated, steered


def make_chat_runner_class(base_class: Any) -> Any:
    class QwenChatTemplateRunner(base_class):
        def _build_prompt(
            self,
            code_snippet: str,
            *,
            instruction: str,
            language: str,
            answer_prefix: str = "",
        ) -> str:
            if answer_prefix:
                raise ProtocolError("v2 forbids an answer prefix outside the Qwen chat template")
            if self.tokenizer is None:
                raise ProtocolError("Tokenizer must be loaded before rendering a v2 prompt")
            template = str(getattr(self.tokenizer, "chat_template", "") or "")
            if sha256_text(template) != CHAT_TEMPLATE_SHA256:
                raise ProtocolError("Loaded Qwen chat template changed")
            rendered = self.tokenizer.apply_chat_template(
                messages_for(code_snippet, instruction, language),
                tokenize=False,
                add_generation_prompt=True,
            )
            if not isinstance(rendered, str) or not rendered.endswith(CHAT_GENERATION_SUFFIX):
                raise ProtocolError("Qwen chat prompt lacks the assistant generation suffix")
            return rendered

    QwenChatTemplateRunner.__name__ = "QwenChatTemplateRunnerV2"
    return QwenChatTemplateRunner


def chat_prompt_evidence(runner: Any, condition: Any) -> Dict[str, Any]:
    messages = messages_for(condition.source_code, condition.instruction, "java")
    rendered = runner._build_prompt(
        condition.source_code,
        instruction=condition.instruction,
        language="java",
        answer_prefix="",
    )
    direct_ids = runner.tokenizer.apply_chat_template(
        messages, tokenize=True, add_generation_prompt=True
    )
    if hasattr(direct_ids, "tolist"):
        direct_ids = direct_ids.tolist()
    encoded = runner.tokenizer(rendered, add_special_tokens=True)
    encoded_ids = encoded.get("input_ids", []) if isinstance(encoded, Mapping) else encoded.input_ids
    if encoded_ids and isinstance(encoded_ids[0], list):
        encoded_ids = encoded_ids[0]
    if list(direct_ids) != list(encoded_ids):
        raise ProtocolError("apply_chat_template token IDs differ from runtime prompt tokenization")
    return {
        "method": "tokenizer.apply_chat_template",
        "add_generation_prompt": True,
        "message_count": 1,
        "message_roles": ["user"],
        "chat_template_sha256": CHAT_TEMPLATE_SHA256,
        "rendered_prompt_sha256": sha256_text(rendered),
        "rendered_prompt_token_count": len(encoded_ids),
        "assistant_generation_suffix": CHAT_GENERATION_SUFFIX,
        "assistant_generation_suffix_present": rendered.endswith(CHAT_GENERATION_SUFFIX),
        "direct_template_ids_equal_runtime_ids": True,
        "user_content_sha256": sha256_text(messages[0]["content"]),
    }


def paired_seed(program_id: str) -> int:
    material = f"{PROTOCOL_VERSION}\0{BASE_SEED}\0{program_id}\0{TRIALS}".encode("utf-8")
    return int.from_bytes(hashlib.sha256(material).digest()[:4], "big") & 0x7FFFFFFF


def configure_local_state(output_root: Path) -> Dict[str, str]:
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


def code_provenance() -> Dict[str, str]:
    paths = (
        Path(__file__).resolve(),
        V1_RUNNER_PATH,
        BASE_RUNNER_PATH,
        MODEL_LOCK_PATH,
        STUDY_MANIFEST_PATH,
        HOLDOUT_MANIFEST_PATH,
        HOLDOUT_ANCHOR_PATH,
    ) + tuple(path for path, _ in RUNTIME_DEPENDENCY_SHA256)
    return {str(path.resolve(strict=True)): sha256_file(path) for path in paths}


def validate_runtime_dependencies() -> None:
    failed = [
        str(path)
        for path, expected in RUNTIME_DEPENDENCY_SHA256
        if not path.is_file() or sha256_file(path) != expected
    ]
    if failed:
        raise ProtocolError(f"Pinned live runtime dependency changed: {failed}")


def validate_protocol_freeze() -> Dict[str, Any]:
    if not PROTOCOL_FREEZE_PATH.is_file() or not PROTOCOL_FREEZE_METADATA_PATH.is_file():
        raise ProtocolError("v2 is not frozen; run freeze_protocol.py after liveness passes")
    entries: Dict[str, str] = {}
    for line in PROTOCOL_FREEZE_PATH.read_text(encoding="utf-8").splitlines():
        fields = line.split(maxsplit=1)
        if len(fields) != 2 or not re.fullmatch(r"[0-9a-f]{64}", fields[0]):
            raise ProtocolError("Malformed v2 protocol freeze manifest")
        relative = fields[1].strip()
        if relative in entries:
            raise ProtocolError("Duplicate v2 protocol freeze entry")
        entries[relative] = fields[0]
    if set(entries) != set(EXPECTED_FREEZE_FILES):
        raise ProtocolError("v2 protocol freeze registry changed")
    for relative, expected in entries.items():
        path = (HERE / relative).resolve(strict=True)
        try:
            path.relative_to(HERE.resolve(strict=True))
        except ValueError as exc:
            raise ProtocolError("Protocol freeze entry escapes v2") from exc
        if sha256_file(path) != expected:
            raise ProtocolError(f"Frozen v2 file changed: {relative}")
    metadata = read_json(PROTOCOL_FREEZE_METADATA_PATH, "protocol freeze metadata")
    required = {
        "schema_version": "long-code-binary-v2-protocol-freeze-v1",
        "protocol_version": PROTOCOL_VERSION,
        "study_generation_count": EXPECTED_GENERATIONS,
        "study_outcomes_present_at_freeze": False,
        "liveness_passed_before_freeze": True,
        "freeze_manifest_sha256": sha256_file(PROTOCOL_FREEZE_PATH),
        "runner_sha256": sha256_file(Path(__file__).resolve()),
        "liveness_summary_sha256": sha256_file(LIVENESS_ROOT / "liveness_summary.json"),
        "freeze_file_count": len(EXPECTED_FREEZE_FILES),
        "freeze_files": sorted(EXPECTED_FREEZE_FILES),
        "runtime_dependency_sha256": {
            str(path.resolve(strict=True)): digest
            for path, digest in RUNTIME_DEPENDENCY_SHA256
        },
    }
    failed = [key for key, expected in required.items() if metadata.get(key) != expected]
    if failed:
        raise ProtocolError(f"Protocol freeze metadata differs: {failed}")
    return metadata


def validate_liveness_summary() -> Dict[str, Any]:
    path = LIVENESS_ROOT / "liveness_summary.json"
    if not path.is_file():
        raise ProtocolError("Non-study v2 liveness has not passed")
    payload = read_json(path, "liveness summary")
    required = {
        "schema_version": "long-code-binary-v2-liveness-result-v1",
        "protocol_version": PROTOCOL_VERSION,
        "status": "passed",
        "holdout_program_id": HOLDOUT_PROGRAM_ID,
        "holdout_manifest_sha256": HOLDOUT_MANIFEST_SHA256,
        "study_program_overlap_count": 0,
        "study_outcomes_read": False,
        "study_outcomes_written": False,
        "study_generation_count": 0,
        "runner_sha256": sha256_file(Path(__file__).resolve()),
        "chat_template_sha256": CHAT_TEMPLATE_SHA256,
        "response_pack_valid": True,
        "decoded_completion_nonempty": True,
        "first_generated_token_is_eos": False,
        "more_than_one_non_special_token": True,
    }
    failed = [key for key, expected in required.items() if payload.get(key) != expected]
    if failed or int(payload.get("generated_non_special_token_count", 0)) <= 1:
        raise ProtocolError(f"Non-study liveness evidence is stale or failed: {failed}")
    return payload


def validate_model_preflight_summary() -> Dict[str, Any]:
    path = MODEL_PREFLIGHT_ROOT / "model_preflight_summary.json"
    if not path.is_file():
        raise ProtocolError("All-ten v2 model preflight has not passed")
    payload = read_json(path, "model preflight summary")
    required = {
        "schema_version": "long-code-binary-v2-model-preflight-v1",
        "protocol_version": PROTOCOL_VERSION,
        "status": "passed",
        "program_ids": list(EXPECTED_PROGRAM_IDS),
        "program_count": 10,
        "study_generation_count": 0,
        "runner_sha256": sha256_file(Path(__file__).resolve()),
        "study_manifest_sha256": STUDY_MANIFEST_SHA256,
        "chat_template_sha256": CHAT_TEMPLATE_SHA256,
        "protocol_freeze_sha256": sha256_file(PROTOCOL_FREEZE_PATH),
    }
    failed = [key for key, expected in required.items() if payload.get(key) != expected]
    if failed:
        raise ProtocolError(f"All-ten model preflight evidence is stale: {failed}")
    return payload


def load_runtime(output_root: Path, gpu_id: int, engine: ModuleType) -> Tuple[Any, Any, Dict[str, Any]]:
    validate_runtime_dependencies()
    V1.validate_model_lock()
    cache = V1.cached_snapshot_status()
    if not cache["available"]:
        raise ProtocolError(f"Exact cached model unavailable: {stable_json(cache)}")
    mutable = configure_local_state(output_root)
    os.environ["CUDA_VISIBLE_DEVICES"] = str(gpu_id)
    if str(PROJECT_ROOT) not in sys.path:
        sys.path.insert(0, str(PROJECT_ROOT))
    from models import ModelRunner

    import torch
    import transformers

    if not torch.cuda.is_available() or torch.cuda.device_count() != 1:
        raise ProtocolError(f"Expected exactly one visible GPU, got {torch.cuda.device_count()}")
    RunnerClass = make_chat_runner_class(ModelRunner)
    prior_cache = engine.install_static_prior_vector_cache()
    steering = engine.build_codesteer_config()
    runner = RunnerClass()
    runner.set_steering_config(steering)
    snapshot = Path(str(cache["snapshot_path"]))
    tokenizer_config = snapshot / "tokenizer_config.json"
    if sha256_file(tokenizer_config) != TOKENIZER_CONFIG_SHA256:
        raise ProtocolError("Pinned tokenizer_config.json changed")
    runner.config(
        key_scope="prompt",
        max_devices=1,
        model_name=str(snapshot),
        cache_dir=str((output_root / "scratch" / "hf-loader-cache").resolve()),
        temperature=GENERATION["temperature"],
        top_p=GENERATION["top_p"],
        top_k=GENERATION["top_k"],
        max_new_tokens=GENERATION["max_new_tokens"],
    )
    runner.build()
    if sha256_text(str(runner.tokenizer.chat_template or "")) != CHAT_TEMPLATE_SHA256:
        runner.free()
        raise ProtocolError("Loaded tokenizer chat template differs")
    layer_start, layer_end, num_layers = engine.set_last_n_layers(steering, runner.model, 8)
    runner.model_name = MODEL_NAME
    steering.model_name = MODEL_NAME
    model_config = runner.model.config.to_dict()
    mismatches = {
        key: {"expected": expected, "observed": model_config.get(key)}
        for key, expected in V1.MODEL_CONFIG_EXPECTED.items()
        if model_config.get(key) != expected
    }
    if mismatches or (layer_start, layer_end, num_layers) != (20, 27, 28):
        runner.free()
        raise ProtocolError(f"Loaded model differs: {mismatches}")
    evidence = {
        "protocol_version": PROTOCOL_VERSION,
        "hostname": socket.gethostname(),
        "started_utc": datetime.now(timezone.utc).isoformat(),
        "python_version": sys.version,
        "torch_version": torch.__version__,
        "transformers_version": transformers.__version__,
        "cuda_runtime_version": torch.version.cuda,
        "cuda_device_name": torch.cuda.get_device_name(0),
        "physical_gpu_id_requested": gpu_id,
        "visible_cuda_device_count": torch.cuda.device_count(),
        "model_id": MODEL_NAME,
        "model_snapshot_commit": MODEL_SNAPSHOT_COMMIT,
        "model_snapshot_status": cache,
        "model_config": model_config,
        "tokenizer_config_sha256": TOKENIZER_CONFIG_SHA256,
        "chat_template_sha256": CHAT_TEMPLATE_SHA256,
        "chat_render_method": "tokenizer.apply_chat_template",
        "add_generation_prompt": True,
        "codesteer_config": dataclasses.asdict(steering),
        "codesteer_layer_start": layer_start,
        "codesteer_layer_end": layer_end,
        "static_prior_cache": prior_cache,
        "mutable_paths_inside_output_root": mutable,
        "code_provenance": code_provenance(),
    }
    return runner, steering, evidence


def static_preflight(pack: Pack, conditions: Sequence[Any], engine: ModuleType) -> Dict[str, Any]:
    original = engine.analyze_target_method(
        pack.original_path.read_text(encoding="utf-8"), pack.original_target_method
    )
    obfuscated = engine.analyze_target_method(
        pack.obfuscated_path.read_text(encoding="utf-8"), pack.obfuscated_target_method
    )
    if not original.get("recorded_target_found") or not obfuscated.get("recorded_target_found"):
        raise ProtocolError(f"{pack.program_id}: target method missing")
    if obfuscated.get("codesteer_target_matches_recorded") is False:
        raise ProtocolError(f"{pack.program_id}: CodeSteer target mismatch")
    if conditions[1].instruction != conditions[2].instruction:
        raise ProtocolError(f"{pack.program_id}: paired obfuscated instructions differ")
    return {
        "program_id": pack.program_id,
        "is_study": pack.is_study,
        "case_ids": [case.case_id for case in pack.cases],
        "original_method_analysis": original,
        "obfuscated_method_analysis": obfuscated,
        "hidden_answer_fields_rendered": False,
    }


def model_preflight(
    runner: Any, pack: Pack, conditions: Sequence[Any], engine: ModuleType
) -> Dict[str, Any]:
    by_name = {condition.name: condition for condition in conditions}
    token: Dict[str, Any] = {}
    chat: Dict[str, Any] = {}
    for name in CONDITIONS:
        condition = by_name[name]
        chat[name] = chat_prompt_evidence(runner, condition)
        token[name] = engine.prompt_token_preflight(
            runner, condition, GENERATION["max_new_tokens"]
        )
        if not token[name]["fits_context"]:
            raise ProtocolError(f"{pack.program_id}/{name} exceeds model context")
        if token[name]["prompt_sha256"] != chat[name]["rendered_prompt_sha256"]:
            raise ProtocolError(f"{pack.program_id}/{name} prompt builders differ")
    if token["obfuscated_plain"]["prompt_sha256"] != token["obfuscated_codesteer"][
        "prompt_sha256"
    ]:
        raise ProtocolError(f"{pack.program_id}: obfuscated paired prompts differ")
    prior = engine.codesteer_prior_preflight(runner, by_name["obfuscated_codesteer"])
    if prior["algorithm_fallback_detected"] or prior.get("parsed_case_ids") != [
        f"c{index:03d}" for index in range(1, 7)
    ]:
        raise ProtocolError(f"{pack.program_id}: CodeSteer prior preflight failed")
    return {
        "prompt_tokens_by_condition": token,
        "chat_template_by_condition": chat,
        "codesteer_prior": prior,
        "eligible_for_inference": True,
    }


def seed_everything(engine: ModuleType, seed: int) -> None:
    engine.seed_everything(seed)


def generated_token_evidence(result: Mapping[str, Any], runner: Any) -> Dict[str, Any]:
    ids = result.get("token_ids_all")
    prompt_length = result.get("prompt_length_tokens")
    if not isinstance(ids, list) or type(prompt_length) is not int:
        raise ProtocolError("Model result lacks generated token evidence")
    if prompt_length < 0 or prompt_length > len(ids):
        raise ProtocolError("Model result has an invalid prompt length")
    generated = [int(value) for value in ids[prompt_length:]]
    special = {int(value) for value in runner.tokenizer.all_special_ids}
    raw_eos = getattr(runner.tokenizer, "eos_token_id", None)
    if isinstance(raw_eos, (list, tuple, set)):
        eos_ids = {int(value) for value in raw_eos}
    elif raw_eos is None:
        eos_ids = set()
    else:
        eos_ids = {int(raw_eos)}
    non_special = [value for value in generated if value not in special]
    tokens = runner.tokenizer.convert_ids_to_tokens(generated)
    return {
        "generated_token_ids": generated,
        "generated_tokens": tokens,
        "generated_token_count": len(generated),
        "generated_non_special_token_ids": non_special,
        "generated_non_special_token_count": len(non_special),
        "special_token_ids": sorted(special),
        "eos_token_ids": sorted(eos_ids),
        "first_generated_token_id": generated[0] if generated else None,
        "first_generated_token_is_eos": bool(generated and generated[0] in eos_ids),
    }


def liveness_gate(
    completion: str, parsed: Mapping[str, Any], tokens: Mapping[str, Any]
) -> Dict[str, bool]:
    checks = {
        "decoded_completion_nonempty": bool(completion.strip()),
        "response_pack_valid": parsed.get("pack_valid") is True,
        "more_than_one_non_special_token": (
            int(tokens.get("generated_non_special_token_count", 0)) > 1
        ),
        "first_generated_token_not_eos": (
            tokens.get("first_generated_token_id") is not None
            and tokens.get("first_generated_token_is_eos") is False
        ),
    }
    checks["passed"] = all(checks.values())
    return checks


def _fingerprint(payload: Mapping[str, Any]) -> str:
    return sha256_text(stable_json(payload))


def _safe_id(value: str) -> str:
    safe = re.sub(r"[^A-Za-z0-9_.-]+", "_", value).strip("._")
    if not safe:
        raise ProtocolError("Unsafe program ID")
    return safe


def _complete_record(run_dir: Path, fingerprint: str) -> bool:
    path = run_dir / "record.json"
    if not path.is_file():
        return False
    record = read_json(path, "record")
    return (
        record.get("status") == "complete"
        and record.get("fingerprint") == fingerprint
        and all(
            (run_dir / name).is_file()
            for name in ("submitted_prompt.txt", "raw_completion.txt", "score.json", "run_config.json")
        )
    )


def rebuild_index(output_root: Path) -> None:
    rows: List[Dict[str, Any]] = []
    for path in sorted((output_root / "runs").glob("*/trial_001/*/record.json")):
        record = read_json(path, "record")
        rows.append(
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
            "completed_generation_count": len(rows),
            "completed_label_judgment_count": len(rows) * CASES_PER_PROGRAM,
            "runs": rows,
        },
    )


def _ensure_new_or_same_config(path: Path, expected: Mapping[str, Any]) -> None:
    if path.is_file():
        if read_json(path, "existing config") != expected:
            raise ProtocolError(f"Existing config differs: {path}")
    else:
        atomic_write_json(path, expected)


def run_liveness(gpu_id: int, engine: ModuleType) -> int:
    # This branch intentionally never calls study_packs() and never traverses a
    # study result directory. Its only model input is the non-study holdout.
    pack = holdout_pack()
    if pack.program_id in EXPECTED_PROGRAM_IDS or pack.is_study:
        raise ProtocolError("Liveness holdout overlaps study")
    if any(STUDY_RESULTS_ROOT.glob("shard_*/runs/*/trial_*/*/record.json")):
        raise ProtocolError("Liveness must precede every v2 study outcome")
    summary_path = LIVENESS_ROOT / "liveness_summary.json"
    if summary_path.is_file():
        validate_liveness_summary()
        print(f"[liveness-skip-passed] {summary_path}")
        return 0
    if LIVENESS_ROOT.exists() and any(LIVENESS_ROOT.iterdir()):
        raise ProtocolError("Incomplete/stale liveness attempt exists; automatic retry is forbidden")
    LIVENESS_ROOT.mkdir(parents=True)
    conditions = prepare_conditions(pack, engine)
    condition = conditions[0]
    static = static_preflight(pack, conditions, engine)
    runner, steering, environment = load_runtime(LIVENESS_ROOT, gpu_id, engine)
    try:
        preflight = model_preflight(runner, pack, conditions, engine)
        prompt = runner._build_prompt(
            condition.source_code,
            instruction=condition.instruction,
            language="java",
            answer_prefix="",
        )
        fingerprint_payload = {
            "protocol_version": PROTOCOL_VERSION,
            "mode": "non_study_liveness",
            "holdout_manifest_sha256": HOLDOUT_MANIFEST_SHA256,
            "holdout_program_id": pack.program_id,
            "condition": "original_plain",
            "paired_seed": paired_seed(pack.program_id),
            "model_id": MODEL_NAME,
            "model_snapshot_commit": MODEL_SNAPSHOT_COMMIT,
            "generation": GENERATION,
            "chat_template_sha256": CHAT_TEMPLATE_SHA256,
            "prompt_sha256": sha256_text(prompt),
            "runner_sha256": sha256_file(Path(__file__).resolve()),
        }
        fingerprint = _fingerprint(fingerprint_payload)
        atomic_write_json(
            LIVENESS_ROOT / "run_config.json",
            {
                **fingerprint_payload,
                "fingerprint": fingerprint,
                "study_program_overlap_count": 0,
                "study_outcomes_read": False,
                "study_outcomes_written": False,
                "study_generation_count": 0,
                "preflight": preflight,
                "static_preflight": static,
            },
        )
        atomic_write_json(LIVENESS_ROOT / "environment.json", environment)
        atomic_write_text(LIVENESS_ROOT / "submitted_prompt.txt", prompt)
        atomic_write_json(
            LIVENESS_ROOT / "status.json",
            {"status": "running", "attempt": 1, "automatic_retry_allowed": False},
        )
        runner.steering_config = None
        seed_everything(engine, paired_seed(pack.program_id))
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
        completion = str(result.get("generated_completion") or "")
        parsed = parse_response(completion, [case.case_id for case in pack.cases])
        tokens = generated_token_evidence(result, runner)
        debug = result.get("steering_debug") or {}
        engine.validate_steering_debug(condition, debug)
        gate = liveness_gate(completion, parsed, tokens)
        passed = gate["passed"]
        atomic_write_text(LIVENESS_ROOT / "raw_completion.txt", completion)
        atomic_write_json(LIVENESS_ROOT / "response_parse.json", parsed)
        atomic_write_json(LIVENESS_ROOT / "token_evidence.json", tokens)
        result["response_parse"] = parsed
        result["token_evidence"] = tokens
        result.pop("full_decode_head_tensors", None)
        atomic_write_json(LIVENESS_ROOT / "model_output.json", result)
        summary = {
            "schema_version": "long-code-binary-v2-liveness-result-v1",
            "protocol_version": PROTOCOL_VERSION,
            "status": "passed" if passed else "failed",
            "attempt": 1,
            "automatic_retry_used": False,
            "holdout_program_id": pack.program_id,
            "holdout_manifest_sha256": HOLDOUT_MANIFEST_SHA256,
            "study_program_overlap_count": 0,
            "study_outcomes_read": False,
            "study_outcomes_written": False,
            "study_generation_count": 0,
            "runner_sha256": sha256_file(Path(__file__).resolve()),
            "chat_template_sha256": CHAT_TEMPLATE_SHA256,
            "add_generation_prompt": True,
            "response_pack_valid": parsed["pack_valid"],
            "response_mode": parsed["response_mode"],
            "decoded_completion_nonempty": gate["decoded_completion_nonempty"],
            "first_generated_token_is_eos": tokens["first_generated_token_is_eos"],
            "first_generated_token_not_eos": gate["first_generated_token_not_eos"],
            "more_than_one_non_special_token": gate["more_than_one_non_special_token"],
            "generated_token_count": tokens["generated_token_count"],
            "generated_non_special_token_count": tokens["generated_non_special_token_count"],
            "completion_sha256": sha256_text(completion),
            "fingerprint": fingerprint,
        }
        atomic_write_json(summary_path, summary)
        atomic_write_json(LIVENESS_ROOT / "status.json", summary)
        if not passed:
            raise ProtocolError(
                "Non-study liveness failed; v2 must not be frozen or used for study inference"
            )
        print(f"[liveness-passed] {summary_path}")
        return 0
    finally:
        runner.free()


def _select_packs(packs: Sequence[Pack], raw: str) -> Tuple[Pack, ...]:
    requested = [value.strip() for value in raw.split(",") if value.strip()]
    if not requested:
        return tuple(packs)
    if len(requested) != len(set(requested)):
        raise ProtocolError("Duplicate --program-ids")
    known = {pack.program_id for pack in packs}
    missing = sorted(set(requested) - known)
    if missing:
        raise ProtocolError(f"Unknown study program IDs: {missing}")
    chosen = set(requested)
    return tuple(pack for pack in packs if pack.program_id in chosen)


def run_model_preflight(gpu_id: int, engine: ModuleType) -> int:
    validate_liveness_summary()
    freeze = validate_protocol_freeze()
    packs = study_packs()
    if any(STUDY_RESULTS_ROOT.glob("shard_*/runs/*/trial_*/*/record.json")):
        raise ProtocolError("All-ten model preflight must precede study outcomes")
    if MODEL_PREFLIGHT_ROOT.exists() and (MODEL_PREFLIGHT_ROOT / "model_preflight_summary.json").is_file():
        validate_model_preflight_summary()
        print(f"[model-preflight-skip-passed] {MODEL_PREFLIGHT_ROOT}")
        return 0
    if MODEL_PREFLIGHT_ROOT.exists() and any(MODEL_PREFLIGHT_ROOT.iterdir()):
        raise ProtocolError("Incomplete/stale model preflight exists")
    MODEL_PREFLIGHT_ROOT.mkdir(parents=True)
    conditions = {pack.program_id: prepare_conditions(pack, engine) for pack in packs}
    static = {
        pack.program_id: static_preflight(pack, conditions[pack.program_id], engine)
        for pack in packs
    }
    runner, steering, environment = load_runtime(MODEL_PREFLIGHT_ROOT, gpu_id, engine)
    try:
        hashes: Dict[str, str] = {}
        for pack in packs:
            evidence = {
                **static[pack.program_id],
                **model_preflight(runner, pack, conditions[pack.program_id], engine),
            }
            path = MODEL_PREFLIGHT_ROOT / "programs" / _safe_id(pack.program_id) / "preflight.json"
            atomic_write_json(path, evidence)
            hashes[pack.program_id] = sha256_file(path)
        atomic_write_json(MODEL_PREFLIGHT_ROOT / "environment.json", environment)
        summary = {
            "schema_version": "long-code-binary-v2-model-preflight-v1",
            "protocol_version": PROTOCOL_VERSION,
            "status": "passed",
            "program_ids": list(EXPECTED_PROGRAM_IDS),
            "program_count": 10,
            "study_generation_count": 0,
            "runner_sha256": sha256_file(Path(__file__).resolve()),
            "study_manifest_sha256": STUDY_MANIFEST_SHA256,
            "chat_template_sha256": CHAT_TEMPLATE_SHA256,
            "add_generation_prompt": True,
            "protocol_freeze_sha256": sha256_file(PROTOCOL_FREEZE_PATH),
            "protocol_freeze_metadata_sha256": sha256_file(PROTOCOL_FREEZE_METADATA_PATH),
            "liveness_summary_sha256": sha256_file(LIVENESS_ROOT / "liveness_summary.json"),
            "program_preflight_sha256": hashes,
            "freeze_metadata": freeze,
        }
        atomic_write_json(MODEL_PREFLIGHT_ROOT / "model_preflight_summary.json", summary)
        print(f"[model-preflight-passed] {MODEL_PREFLIGHT_ROOT / 'model_preflight_summary.json'}")
        return 0
    finally:
        runner.free()


def _write_pack_snapshot(root: Path, pack: Pack) -> None:
    destination = root / "programs" / _safe_id(pack.program_id)
    atomic_write_bytes(destination / "original.java", pack.original_path.read_bytes())
    atomic_write_bytes(destination / "obfuscated.java", pack.obfuscated_path.read_bytes())
    atomic_write_json(
        destination / "pack.json",
        {
            "program_id": pack.program_id,
            "case_ids": [case.case_id for case in pack.cases],
            "original_sha256": sha256_file(pack.original_path),
            "obfuscated_sha256": sha256_file(pack.obfuscated_path),
            "original_target_method": pack.original_target_method,
            "obfuscated_target_method": pack.obfuscated_target_method,
        },
    )


def run_study(
    output_root: Path, gpu_id: int, program_ids: str, engine: ModuleType
) -> int:
    liveness = validate_liveness_summary()
    freeze = validate_protocol_freeze()
    global_preflight = validate_model_preflight_summary()
    packs = _select_packs(study_packs(), program_ids)
    if not packs:
        raise ProtocolError("No study packs selected")
    resolved_root = output_root.resolve(strict=False)
    registered_roots = tuple(
        (STUDY_RESULTS_ROOT / f"shard_{index}").resolve(strict=False)
        for index in range(len(REGISTERED_SHARD_MEMBERSHIP))
    )
    if resolved_root not in registered_roots:
        raise ProtocolError("Study output must be one exact registered v2 shard root")
    shard_index = registered_roots.index(resolved_root)
    if {pack.program_id for pack in packs} != set(REGISTERED_SHARD_MEMBERSHIP[shard_index]):
        raise ProtocolError("Selected programs do not match the registered size-balanced shard")
    conditions = {pack.program_id: prepare_conditions(pack, engine) for pack in packs}
    static = {
        pack.program_id: static_preflight(pack, conditions[pack.program_id], engine)
        for pack in packs
    }
    output_root.mkdir(parents=True, exist_ok=True)
    config = {
        "protocol_version": PROTOCOL_VERSION,
        "run_mode": "study_inference",
        "study_manifest_path": str(STUDY_MANIFEST_PATH),
        "study_manifest_sha256": STUDY_MANIFEST_SHA256,
        "model_id": MODEL_NAME,
        "model_snapshot_commit": MODEL_SNAPSHOT_COMMIT,
        "conditions": list(CONDITIONS),
        "trials": 1,
        "base_seed": BASE_SEED,
        "generation": GENERATION,
        "codesteer_profile": CODESTEER_PROFILE,
        "chat_render_method": "tokenizer.apply_chat_template",
        "chat_template_sha256": CHAT_TEMPLATE_SHA256,
        "add_generation_prompt": True,
        "response_parser": "one whole/fenced/embedded flat JSON object; exact six IDs/T/F",
        "selected_program_ids": [pack.program_id for pack in packs],
        "registered_shard_index": shard_index,
        "expected_generation_count": len(packs) * GENERATIONS_PER_PROGRAM,
        "labels_per_generation": 6,
        "liveness_summary_sha256": sha256_file(LIVENESS_ROOT / "liveness_summary.json"),
        "protocol_freeze_sha256": sha256_file(PROTOCOL_FREEZE_PATH),
        "model_preflight_summary_sha256": sha256_file(
            MODEL_PREFLIGHT_ROOT / "model_preflight_summary.json"
        ),
        "liveness_gate": liveness,
        "freeze_metadata": freeze,
        "global_model_preflight": global_preflight,
        "code_provenance": code_provenance(),
    }
    _ensure_new_or_same_config(output_root / "experiment_config.json", config)
    for pack in packs:
        _write_pack_snapshot(output_root, pack)
    runner, steering, environment = load_runtime(output_root, gpu_id, engine)
    atomic_write_json(output_root / "environment.json", environment)
    try:
        local_preflight: Dict[str, Any] = {}
        for pack in packs:
            evidence = {
                **static[pack.program_id],
                **model_preflight(runner, pack, conditions[pack.program_id], engine),
            }
            local_preflight[pack.program_id] = evidence
            atomic_write_json(
                output_root / "programs" / _safe_id(pack.program_id) / "preflight.json",
                evidence,
            )
        steering_payload = dataclasses.asdict(steering)
        for pack in packs:
            by_name = {condition.name: condition for condition in conditions[pack.program_id]}
            seed = paired_seed(pack.program_id)
            for condition_name in CONDITIONS:
                condition = by_name[condition_name]
                prompt = runner._build_prompt(
                    condition.source_code,
                    instruction=condition.instruction,
                    language="java",
                    answer_prefix="",
                )
                fingerprint_payload = {
                    "protocol_version": PROTOCOL_VERSION,
                    "study_manifest_sha256": STUDY_MANIFEST_SHA256,
                    "program_id": pack.program_id,
                    "case_ids_in_prompt_order": [case.case_id for case in pack.cases],
                    "condition": condition_name,
                    "trial": 1,
                    "paired_seed": seed,
                    "model_id": MODEL_NAME,
                    "model_snapshot_commit": MODEL_SNAPSHOT_COMMIT,
                    "generation": GENERATION,
                    "chat_template_sha256": CHAT_TEMPLATE_SHA256,
                    "add_generation_prompt": True,
                    "prompt_sha256": sha256_text(prompt),
                    "steering": steering_payload if condition.activation_steering else None,
                }
                fingerprint = _fingerprint(fingerprint_payload)
                run_dir = (
                    output_root
                    / "runs"
                    / _safe_id(pack.program_id)
                    / "trial_001"
                    / condition_name
                )
                if _complete_record(run_dir, fingerprint):
                    print(f"[skip] {pack.program_id} {condition_name}")
                    continue
                if run_dir.exists() and any(run_dir.iterdir()):
                    raise ProtocolError(f"Incomplete/stale study attempt exists: {run_dir}")
                run_dir.mkdir(parents=True, exist_ok=True)
                run_config = {
                    **fingerprint_payload,
                    "fingerprint": fingerprint,
                    "source_kind": condition.source_kind,
                    "target_method": condition.target_method,
                    "activation_steering": condition.activation_steering,
                    "paired_design": "same seed across all three conditions",
                    "token_preflight": local_preflight[pack.program_id][
                        "prompt_tokens_by_condition"
                    ][condition_name],
                    "chat_template_evidence": local_preflight[pack.program_id][
                        "chat_template_by_condition"
                    ][condition_name],
                    "codesteer_prior_preflight": (
                        local_preflight[pack.program_id]["codesteer_prior"]
                        if condition.activation_steering
                        else None
                    ),
                    "hidden_labels_in_prompt": False,
                    "attempt": 1,
                    "automatic_retry_allowed": False,
                }
                atomic_write_json(run_dir / "run_config.json", run_config)
                atomic_write_text(run_dir / "submitted_prompt.txt", prompt)
                atomic_write_text(run_dir / "source.java", condition.source_code)
                atomic_write_json(run_dir / "status.json", {"status": "running", "attempt": 1})
                runner.steering_config = steering if condition.activation_steering else None
                seed_everything(engine, seed)
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
                completion = str(result.get("generated_completion") or "")
                score = score_study_completion(pack, completion)
                token_evidence = generated_token_evidence(result, runner)
                debug = result.get("steering_debug") or {}
                engine.validate_steering_debug(condition, debug)
                result["experiment"] = {
                    "program_id": pack.program_id,
                    "condition": condition_name,
                    "trial": 1,
                    "paired_seed": seed,
                    "fingerprint": fingerprint,
                }
                result["score"] = score
                result["generated_token_evidence"] = token_evidence
                result.pop("full_decode_head_tensors", None)
                atomic_write_text(run_dir / "raw_completion.txt", completion)
                atomic_write_json(run_dir / "score.json", score)
                atomic_write_json(run_dir / "generated_token_evidence.json", token_evidence)
                atomic_write_json(run_dir / "steering_debug.json", debug)
                atomic_write_json(run_dir / "model_output.json", result)
                record = {
                    "status": "complete",
                    "completed_at_unix": time.time(),
                    "attempt": 1,
                    "automatic_retry_used": False,
                    "fingerprint": fingerprint,
                    "program_id": pack.program_id,
                    "trial": 1,
                    "condition": condition_name,
                    "paired_seed": seed,
                    "score": score,
                }
                atomic_write_json(run_dir / "record.json", record)
                atomic_write_json(run_dir / "status.json", record)
                rebuild_index(output_root)
                print(
                    f"[done] {pack.program_id} {condition_name} "
                    f"labels={score['correct_label_count']}/6 parse={score['parse_status']}"
                )
    finally:
        runner.free()
    rebuild_index(output_root)
    return 0


def parse_args(argv: Optional[Sequence[str]] = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--dry-run", action="store_true")
    mode.add_argument("--liveness-only", action="store_true")
    mode.add_argument("--model-preflight-only", action="store_true")
    parser.add_argument("--gpu-id", type=int, default=None)
    parser.add_argument("--program-ids", default="")
    parser.add_argument("--output-root", type=Path, default=None)
    return parser.parse_args(argv)


def main(argv: Optional[Sequence[str]] = None) -> int:
    args = parse_args(argv)
    V1.validate_model_lock()
    validate_runtime_dependencies()
    engine = V1.load_engine()
    if args.liveness_only:
        if args.program_ids or args.output_root not in (None, LIVENESS_ROOT):
            raise ProtocolError("Liveness is fixed to the non-study holdout/default root")
        if args.gpu_id is None or args.gpu_id < 0:
            raise ProtocolError("Liveness requires one --gpu-id")
        return run_liveness(args.gpu_id, engine)
    packs = study_packs()
    selected = _select_packs(packs, args.program_ids)
    prepared = {pack.program_id: prepare_conditions(pack, engine) for pack in selected}
    for pack in selected:
        static_preflight(pack, prepared[pack.program_id], engine)
    if args.dry_run:
        print(
            json.dumps(
                {
                    "status": "static_preflight_passed",
                    "protocol_version": PROTOCOL_VERSION,
                    "study_manifest_sha256": STUDY_MANIFEST_SHA256,
                    "program_ids": [pack.program_id for pack in selected],
                    "program_count": len(selected),
                    "generation_count": len(selected) * 3,
                    "chat_template_required": True,
                    "add_generation_prompt": True,
                    "response_parser": "one whole/fenced/embedded exact-six-key JSON object",
                },
                indent=2,
                sort_keys=True,
            )
        )
        return 0
    if args.gpu_id is None or args.gpu_id < 0:
        raise ProtocolError("Model execution requires one --gpu-id")
    if args.model_preflight_only:
        if args.program_ids or args.output_root not in (None, MODEL_PREFLIGHT_ROOT):
            raise ProtocolError("Model preflight must cover all ten at the default root")
        return run_model_preflight(args.gpu_id, engine)
    if args.output_root is None:
        raise ProtocolError("Study execution requires an explicit v2 --output-root")
    root = _output_root(args.output_root)
    try:
        root.relative_to(STUDY_RESULTS_ROOT.resolve(strict=False))
    except ValueError as exc:
        raise ProtocolError("Study output root must remain below v2/results/study") from exc
    return run_study(root, args.gpu_id, args.program_ids, engine)


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (ProtocolError, ValueError, TypeError, FileNotFoundError, KeyError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(2)
