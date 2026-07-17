#!/usr/bin/env python3
"""Run the paired four-condition long-code output-prediction experiment.

The runner intentionally keeps experiment artifacts below this directory.  Source
files in the manifest may live anywhere, but they are only read.  A completed run
is resumable at the (sample, trial, condition) level and records the exact prompt,
raw completion, oracle, generation configuration, and steering diagnostics.
"""

from __future__ import annotations

import argparse
import dataclasses
import hashlib
import importlib.metadata
import json
import os
import random
import re
import shutil
import socket
import subprocess
import sys
import tempfile
import time
from dataclasses import dataclass, field
from datetime import datetime, timezone
from pathlib import Path
from typing import Any, Dict, List, Mapping, Optional, Sequence, Tuple


sys.dont_write_bytecode = True

WORK_ROOT = Path(__file__).resolve().parent
PROJECT_ROOT = WORK_ROOT.parents[1]
PROMPT_STEERING_ROOT = WORK_ROOT.parent
DEFAULT_OUTPUT_ROOT = WORK_ROOT / "results"
DEFAULT_MODEL_NAME = "Qwen/Qwen2.5-14B"
DEFAULT_CACHE_DIR = "/data/xxr230000/model_cache"
MODEL_SNAPSHOT_COMMIT = "97e1e76335b7017d8f67c08a19d103c0504298c9"
PROTOCOL_VERSION = "long-code-output-v1"

CONDITIONS: Tuple[str, ...] = (
    "original_plain",
    "obfuscated_plain",
    "obfuscated_prompt_slice",
    "obfuscated_codesteer",
)

GENERATION_DEFAULTS: Dict[str, Any] = {
    "do_sample": True,
    "temperature": 1.05,
    "top_p": 0.95,
    "top_k": 7,
    "max_new_tokens": 512,
}

CODESTEER_DEFAULTS: Dict[str, Any] = {
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

STATIC_PRIOR_CACHE_PROFILE: Dict[str, Any] = {
    "enabled": True,
    "scope": "one SteeringManager instance",
    "key": "(current_bin, number_of_bins)",
    "semantic_effect": "none; memoizes a deterministic prompt-static prior vector",
    "reason": (
        "The unmodified runtime requests the same prompt-static slice once per steered "
        "layer and decode token. Recomputing it changes neither the vector nor sampling, "
        "but is prohibitively expensive for 250--350-line programs."
    ),
}


def install_static_prior_vector_cache() -> Dict[str, Any]:
    """Memoize deterministic prior vectors per manager/bin without changing values.

    ``SteeringManager.prior_vector`` has no decode-state input beyond the current
    bin.  The provider context (prompt tokens, code, and concrete case text) is
    immutable for the lifetime of a manager, so calls within one bin are exactly
    redundant.  This local runner patch deliberately leaves the shared steering
    implementation untouched.
    """
    from steering.manager import SteeringManager

    marker = "_long_code_static_prior_cache_v1"
    if getattr(SteeringManager, marker, False):
        return dict(STATIC_PRIOR_CACHE_PROFILE, installed=True, already_installed=True)

    original_init_bins = SteeringManager.init_bins
    original_prior_vector = SteeringManager.prior_vector

    def cached_init_bins(self: Any, total_steps: int) -> None:
        original_init_bins(self, total_steps)
        self._long_code_prior_vector_cache = {}

    def cached_prior_vector(self: Any) -> Any:
        if self.state is None:
            return original_prior_vector(self)
        bins = self.state.bins
        key = (int(self.state.current_bin), int(len(bins)))
        cache = getattr(self, "_long_code_prior_vector_cache", None)
        if cache is None:
            cache = {}
            self._long_code_prior_vector_cache = cache
        if key not in cache:
            cache[key] = original_prior_vector(self)
        return cache[key]

    SteeringManager.init_bins = cached_init_bins
    SteeringManager.prior_vector = cached_prior_vector
    setattr(SteeringManager, marker, True)
    return dict(STATIC_PRIOR_CACHE_PROFILE, installed=True, already_installed=False)


@dataclass(frozen=True)
class Sample:
    sample_id: str
    original_path: Path
    obfuscated_path: Path
    original_target_method: str
    obfuscated_target_method: str
    stdin: str = ""
    argv: Tuple[str, ...] = ()
    expected_stdout: Optional[str] = None
    original_main_class: Optional[str] = None
    obfuscated_main_class: Optional[str] = None
    case_spec: Optional[str] = None
    classpath: Tuple[Path, ...] = ()
    metadata: Dict[str, Any] = field(default_factory=dict)


@dataclass(frozen=True)
class ConditionInput:
    name: str
    source_kind: str
    source_path: Path
    source_code: str
    target_method: str
    instruction: str
    prompt_metadata: Dict[str, Any]
    activation_steering: bool


def _sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def sha256_file(path: Path) -> str:
    return _sha256_bytes(path.read_bytes())


def cached_model_ref_commit(cache_dir: Path, model_name: str, ref: str = "main") -> Optional[str]:
    model_cache_name = "models--" + model_name.replace("/", "--")
    candidates = (
        cache_dir / model_cache_name / "refs" / ref,
        cache_dir / "hub" / model_cache_name / "refs" / ref,
    )
    for path in candidates:
        if path.is_file():
            value = path.read_text(encoding="utf-8").strip()
            if re.fullmatch(r"[0-9a-fA-F]{40,64}", value):
                return value.lower()
    return None


def _package_version(name: str) -> Optional[str]:
    try:
        return importlib.metadata.version(name)
    except importlib.metadata.PackageNotFoundError:
        return None


def runtime_code_provenance() -> Dict[str, Any]:
    dependencies = (
        PROJECT_ROOT / "models.py",
        PROMPT_STEERING_ROOT / "element_prompting.py",
        PROMPT_STEERING_ROOT / "prompt.py",
        PROJECT_ROOT / "steering" / "config.py",
        PROJECT_ROOT / "steering" / "runtime.py",
        PROJECT_ROOT / "steering" / "priors.py",
        PROJECT_ROOT / "steering" / "levels.py",
        PROJECT_ROOT / "steering" / "backends" / "qwen2_backend.py",
        Path(__file__).resolve(),
    )
    file_hashes = {
        str(path.relative_to(PROJECT_ROOT)): sha256_file(path)
        for path in dependencies
        if path.is_file()
    }

    def git_output(*args: str) -> str:
        proc = subprocess.run(
            ["git", *args],
            cwd=PROJECT_ROOT,
            capture_output=True,
            text=True,
            check=False,
        )
        return proc.stdout.strip() if proc.returncode == 0 else ""

    revision = git_output("rev-parse", "HEAD")
    status = git_output("status", "--porcelain")
    relevant_rel = [str(path.relative_to(PROJECT_ROOT)) for path in dependencies]
    relevant_diff = git_output("diff", "--", *relevant_rel)
    return {
        "dependency_sha256": file_hashes,
        "git_revision": revision or None,
        "git_dirty": bool(status),
        "git_status_sha256": _sha256_bytes(status.encode("utf-8")),
        "relevant_tracked_diff_sha256": _sha256_bytes(relevant_diff.encode("utf-8")),
    }


def _stable_json(payload: Any) -> str:
    return json.dumps(payload, ensure_ascii=False, sort_keys=True, separators=(",", ":"), default=_json_default)


def _json_default(value: Any) -> Any:
    if isinstance(value, Path):
        return str(value)
    if dataclasses.is_dataclass(value):
        return dataclasses.asdict(value)
    if isinstance(value, (set, tuple)):
        return list(value)
    item = getattr(value, "item", None)
    if callable(item):
        return item()
    raise TypeError(f"Cannot JSON-serialize {type(value).__name__}")


def atomic_write_text(path: Path, text: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    tmp.write_text(text, encoding="utf-8")
    os.replace(tmp, path)


def atomic_write_bytes(path: Path, payload: bytes) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    tmp.write_bytes(payload)
    os.replace(tmp, path)


def atomic_write_json(path: Path, payload: Any) -> None:
    atomic_write_text(
        path,
        json.dumps(payload, ensure_ascii=False, indent=2, sort_keys=True, default=_json_default) + "\n",
    )


def _resolve_read_path(value: Any, *, base: Path, label: str) -> Path:
    if isinstance(value, Mapping):
        value = (
            value.get("path")
            or value.get("source_path")
            or value.get("java_path")
            or value.get("file")
            or value.get("java")
        )
    if not isinstance(value, (str, os.PathLike)) or not str(value).strip():
        raise ValueError(f"Manifest sample is missing {label}.")
    path = Path(value).expanduser()
    if not path.is_absolute():
        path = base / path
    path = path.resolve()
    if not path.is_file():
        raise FileNotFoundError(f"{label} does not exist: {path}")
    return path


def _optional_text_from_path(raw: Mapping[str, Any], key: str, *, base: Path) -> Optional[str]:
    direct = raw.get(key)
    if direct is not None:
        if not isinstance(direct, str):
            raise TypeError(f"{key} must be a string.")
        return direct
    path_value = raw.get(f"{key}_path")
    if path_value is None:
        return None
    return _resolve_read_path(path_value, base=base, label=f"{key}_path").read_text(encoding="utf-8")


def _pick(raw: Mapping[str, Any], *keys: str) -> Any:
    for key in keys:
        if key in raw and raw[key] is not None:
            return raw[key]
    return None


def _safe_sample_id(raw: str) -> str:
    rendered = re.sub(r"[^A-Za-z0-9_.-]+", "_", str(raw).strip()).strip("._")
    if not rendered:
        raise ValueError(f"Invalid empty sample id derived from {raw!r}.")
    return rendered


def load_manifest(path: Path) -> Tuple[List[Sample], Dict[str, Any]]:
    path = path.expanduser().resolve()
    payload = json.loads(path.read_text(encoding="utf-8"))
    if isinstance(payload, list):
        rows = payload
        manifest_meta: Dict[str, Any] = {}
    elif isinstance(payload, dict):
        rows = payload.get("samples") or payload.get("variants") or payload.get("cases") or payload.get("items")
        if not isinstance(rows, list):
            raise ValueError("Manifest must be a list or contain a `samples` list.")
        manifest_meta = {
            key: value
            for key, value in payload.items()
            if key not in {"samples", "variants", "cases", "items"}
        }
    else:
        raise TypeError("Manifest root must be an object or array.")

    # A prepared variant may carry several concrete validation cases.  Each case
    # is an independent output-prediction item, while preserving its parent
    # candidate id in metadata.
    expanded_rows: List[Dict[str, Any]] = []
    for raw_any in rows:
        if not isinstance(raw_any, dict):
            expanded_rows.append(raw_any)
            continue
        concrete_cases = raw_any.get("cases")
        if not isinstance(concrete_cases, list) or not concrete_cases:
            expanded_rows.append(dict(raw_any))
            continue
        parent_id = str(_pick(raw_any, "id", "sample_id", "candidate_id", "name") or "sample")
        for case_index, case_any in enumerate(concrete_cases, start=1):
            if not isinstance(case_any, dict):
                raise TypeError(f"Variant {parent_id} case {case_index} is not an object.")
            case = dict(case_any)
            case_id = str(_pick(case, "case_id", "id", "name") or f"c{case_index:03d}")
            merged = dict(raw_any)
            merged.pop("cases", None)
            for key in ("stdin", "stdin_path", "input", "argv", "args", "case_spec"):
                if key in case:
                    merged[key] = case[key]
            if "expected_output" in case:
                merged["expected_stdout"] = case["expected_output"]
            if "expected_stdout" in case:
                merged["expected_stdout"] = case["expected_stdout"]
            if "expected_output_path" in case:
                merged["expected_stdout_path"] = case["expected_output_path"]
            merged["id"] = f"{parent_id}__{case_id}"
            merged["parent_candidate_id"] = parent_id
            merged["concrete_case"] = case
            expanded_rows.append(merged)

    samples: List[Sample] = []
    seen: set[str] = set()
    for index, raw_any in enumerate(expanded_rows, start=1):
        if not isinstance(raw_any, dict):
            raise TypeError(f"Manifest row {index} is not an object.")
        raw: Dict[str, Any] = dict(raw_any)
        sample_id = _safe_sample_id(
            str(_pick(raw, "id", "sample_id", "candidate_id", "name") or f"sample_{index:02d}")
        )
        if sample_id in seen:
            raise ValueError(f"Duplicate sample id: {sample_id}")
        seen.add(sample_id)

        sources = raw.get("sources") if isinstance(raw.get("sources"), dict) else {}
        original_value = (
            _pick(raw, "original_path", "original_source_path", "original_java", "original")
            or sources.get("original")
        )
        obfuscated_value = (
            _pick(raw, "obfuscated_path", "obfuscated_source_path", "obfuscated_java", "obfuscated")
            or sources.get("obfuscated")
        )
        original_path = _resolve_read_path(original_value, base=path.parent, label="original_path")
        obfuscated_path = _resolve_read_path(obfuscated_value, base=path.parent, label="obfuscated_path")

        target_value = _pick(raw, "target_method", "algorithm_method", "codesteer_target_method")
        original_target = _pick(raw, "original_target_method")
        obfuscated_target = _pick(raw, "obfuscated_target_method")
        if isinstance(target_value, dict):
            original_target = original_target or target_value.get("original")
            obfuscated_target = obfuscated_target or target_value.get("obfuscated") or target_value.get("name")
        else:
            original_target = original_target or target_value
            obfuscated_target = obfuscated_target or target_value
        if not original_target or not obfuscated_target:
            raise ValueError(
                f"Sample {sample_id} must record target_method (or original/obfuscated target methods)."
            )

        stdin = _optional_text_from_path(raw, "stdin", base=path.parent)
        if stdin is None:
            input_value = raw.get("input")
            stdin = input_value if isinstance(input_value, str) else ""
        expected_stdout = _optional_text_from_path(raw, "expected_stdout", base=path.parent)
        if expected_stdout is None and isinstance(raw.get("expected_output"), str):
            expected_stdout = str(raw["expected_output"])
        argv_raw = raw.get("argv", raw.get("args", [])) or []
        if not isinstance(argv_raw, list):
            raise TypeError(f"Sample {sample_id} argv must be a list.")
        cp_raw = raw.get("classpath", []) or []
        if isinstance(cp_raw, str):
            cp_raw = [cp_raw]
        classpath = tuple(
            _resolve_read_path(entry, base=path.parent, label="classpath entry") for entry in cp_raw
        )

        original_spec = raw.get("original") if isinstance(raw.get("original"), dict) else {}
        obfuscated_spec = raw.get("obfuscated") if isinstance(raw.get("obfuscated"), dict) else {}
        samples.append(
            Sample(
                sample_id=sample_id,
                original_path=original_path,
                obfuscated_path=obfuscated_path,
                original_target_method=str(original_target),
                obfuscated_target_method=str(obfuscated_target),
                stdin=stdin,
                argv=tuple(str(value) for value in argv_raw),
                expected_stdout=expected_stdout,
                original_main_class=(
                    _pick(raw, "original_main_class", "main_class")
                    or _pick(original_spec, "main_class", "class_name", "class")
                ),
                obfuscated_main_class=(
                    _pick(raw, "obfuscated_main_class", "main_class")
                    or _pick(obfuscated_spec, "main_class", "class_name", "class")
                ),
                case_spec=str(raw["case_spec"]) if raw.get("case_spec") is not None else None,
                classpath=classpath,
                metadata=raw,
            )
        )
    if not samples:
        raise ValueError("Manifest has no samples.")
    return samples, manifest_meta


def paired_seed(base_seed: int, sample_id: str, trial: int) -> int:
    """Stable seed shared by all conditions in one sample/trial pair."""
    material = f"{PROTOCOL_VERSION}\0{int(base_seed)}\0{sample_id}\0{int(trial)}".encode("utf-8")
    return int.from_bytes(hashlib.sha256(material).digest()[:4], "big") & 0x7FFFFFFF


def seed_everything(seed: int) -> None:
    random.seed(seed)
    try:
        import numpy as np

        np.random.seed(seed % (2**32))
    except ImportError:
        pass
    import torch

    torch.manual_seed(seed)
    if torch.cuda.is_available():
        torch.cuda.manual_seed_all(seed)


def normalize_stdout(text: str) -> str:
    """Historical Table-2 canonicalization: LF line endings, then outer trim.

    Internal spaces and newlines remain significant.  The legacy function name
    is retained because the auditor and early staged artifacts import it.
    """
    return str(text).replace("\r\n", "\n").replace("\r", "\n").strip()


def _stdout_from_json(value: Any) -> Optional[str]:
    if isinstance(value, dict) and isinstance(value.get("stdout"), str):
        return value["stdout"]
    return None


def parse_final_output(completion: str) -> Tuple[Optional[str], Dict[str, Any]]:
    """Parse the required final JSON while retaining a conservative fallback."""
    text = str(completion or "")
    marker = "FINAL_OUTPUT_JSON:"
    positions = [match.start() for match in re.finditer(re.escape(marker), text)]
    decoder = json.JSONDecoder()
    for position in reversed(positions):
        tail = text[position + len(marker) :].lstrip()
        try:
            value, consumed = decoder.raw_decode(tail)
        except json.JSONDecodeError:
            continue
        stdout = _stdout_from_json(value)
        if stdout is not None:
            return stdout, {"parse_status": "marker_json", "json_chars": consumed}

    fences = list(re.finditer(r"```(?:json)?\s*(\{.*?\})\s*```", text, flags=re.IGNORECASE | re.DOTALL))
    for match in reversed(fences):
        try:
            value = json.loads(match.group(1))
        except json.JSONDecodeError:
            continue
        stdout = _stdout_from_json(value)
        if stdout is not None:
            return stdout, {"parse_status": "fenced_json"}

    for line in reversed(text.splitlines()):
        candidate = line.strip()
        if candidate.startswith("{") and candidate.endswith("}"):
            try:
                value = json.loads(candidate)
            except json.JSONDecodeError:
                continue
            stdout = _stdout_from_json(value)
            if stdout is not None:
                return stdout, {"parse_status": "bare_json_line"}
    return None, {"parse_status": "missing_or_invalid_final_json"}


def _one_line_case_spec(sample: Sample, target_method: str) -> str:
    if sample.case_spec:
        return " ".join(sample.case_spec.split())
    stdin_json = json.dumps(sample.stdin, ensure_ascii=False, separators=(",", ":"))
    argv_json = json.dumps(list(sample.argv), ensure_ascii=False, separators=(",", ":"))
    return f"invoke program entry point; target_method={target_method}; stdin={stdin_json}; argv={argv_json}"


def build_base_instruction(sample: Sample, *, target_method: str) -> str:
    case_spec = _one_line_case_spec(sample, target_method)
    return (
        "Predict the exact standard output of this deterministic Java program for the concrete case below. "
        f"The recorded algorithm method is `{target_method}`. This is output prediction, not code generation.\n"
        "### CASES_BEGIN\n"
        f"c001: {case_spec}\n"
        "### CASES_END\n\n"
        "Give concise reasoning that tracks only state and control flow needed for the output. "
        "Then end with exactly one machine-readable line in this form:\n"
        'FINAL_OUTPUT_JSON: {"stdout":"exact output with newlines encoded as \\n"}\n'
        "The JSON stdout string must contain only what the program prints, with no commentary or code fence."
    )


def prepare_conditions(sample: Sample) -> Tuple[List[ConditionInput], Dict[str, Any]]:
    if str(PROJECT_ROOT) not in sys.path:
        sys.path.insert(0, str(PROJECT_ROOT))
    if str(PROMPT_STEERING_ROOT) not in sys.path:
        sys.path.insert(0, str(PROMPT_STEERING_ROOT))
    from element_prompting import build_artifact_conditioned_instruction, extract_structural_elements

    original_code = sample.original_path.read_text(encoding="utf-8")
    obfuscated_code = sample.obfuscated_path.read_text(encoding="utf-8")
    original_instruction = build_base_instruction(sample, target_method=sample.original_target_method)
    obfuscated_instruction = build_base_instruction(sample, target_method=sample.obfuscated_target_method)
    prompt_instruction, prompt_meta = build_artifact_conditioned_instruction(
        obfuscated_instruction,
        "slice",
        java_code=obfuscated_code,
        task="output_prediction",
        target_method_name=sample.obfuscated_target_method,
        max_elements=24,
    )
    eligible_meta = extract_structural_elements(
        obfuscated_code,
        "slice",
        target_method_name=sample.obfuscated_target_method,
        max_elements=1_000_000,
    )
    emitted = len(prompt_meta.get("elements", []) or [])
    eligible = len(eligible_meta.get("elements", []) or [])
    prompt_meta.update(
        {
            "max_elements": 24,
            "emitted_element_count": emitted,
            "eligible_element_count": eligible,
            "emitted_over_eligible": (float(emitted) / float(eligible)) if eligible else 0.0,
            "eligible_count_is_lower_bound": eligible_meta.get("parse_status") != "javalang",
            "recorded_target_method": sample.obfuscated_target_method,
        }
    )
    if str(prompt_meta.get("target_method", "")) != sample.obfuscated_target_method:
        raise RuntimeError(
            f"Prompt slice selected {prompt_meta.get('target_method')!r}, expected "
            f"{sample.obfuscated_target_method!r} for {sample.sample_id}."
        )

    plain_meta = {
        "enabled": False,
        "mechanism": "none",
        "recorded_target_method": sample.obfuscated_target_method,
    }
    conditions = [
        ConditionInput(
            "original_plain",
            "original",
            sample.original_path,
            original_code,
            sample.original_target_method,
            original_instruction,
            dict(plain_meta, recorded_target_method=sample.original_target_method),
            False,
        ),
        ConditionInput(
            "obfuscated_plain",
            "obfuscated",
            sample.obfuscated_path,
            obfuscated_code,
            sample.obfuscated_target_method,
            obfuscated_instruction,
            plain_meta,
            False,
        ),
        ConditionInput(
            "obfuscated_prompt_slice",
            "obfuscated",
            sample.obfuscated_path,
            obfuscated_code,
            sample.obfuscated_target_method,
            prompt_instruction,
            prompt_meta,
            False,
        ),
        ConditionInput(
            "obfuscated_codesteer",
            "obfuscated",
            sample.obfuscated_path,
            obfuscated_code,
            sample.obfuscated_target_method,
            obfuscated_instruction,
            {
                "enabled": False,
                "mechanism": "activation_level_only",
                "recorded_target_method": sample.obfuscated_target_method,
            },
            True,
        ),
    ]
    return conditions, prompt_meta


def analyze_target_method(code: str, recorded_target: str) -> Dict[str, Any]:
    """Use CodeSteer's own selector for a faithful static preflight."""
    if str(PROJECT_ROOT) not in sys.path:
        sys.path.insert(0, str(PROJECT_ROOT))
    try:
        from steering.priors import PriorContext, SlicingPrior

        prior = SlicingPrior(PriorContext(prompt_tokens=[], code_text=code, vocab_tokens=[], prompt_text=""))
        javalang_mod = prior._try_import()
        if javalang_mod is None:
            raise RuntimeError("javalang unavailable")
        _lines, _tokens, tree = prior._prepare_parse_artifacts(javalang_mod)
        if tree is None:
            raise RuntimeError("javalang parse failed")
        methods = [node for _, node in tree.filter(javalang_mod.tree.MethodDeclaration)]
        selected = prior._select_target_method(tree, javalang_mod)
        selected_name = str(getattr(selected, "name", "") or "")
        recorded_nodes = [method for method in methods if str(getattr(method, "name", "")) == recorded_target]
        recorded_node = recorded_nodes[0] if recorded_nodes else None
        parameter_count = len(getattr(recorded_node, "parameters", []) or []) if recorded_node else None
        return_sink_count = (
            sum(1 for _path, _node in recorded_node.filter(javalang_mod.tree.ReturnStatement))
            if recorded_node is not None
            else None
        )
        return {
            "parse_status": "javalang",
            "fallback_used": False,
            "method_names": [str(getattr(method, "name", "")) for method in methods],
            "recorded_target_method": recorded_target,
            "recorded_target_found": recorded_node is not None,
            "codesteer_selected_target_method": selected_name,
            "codesteer_target_matches_recorded": selected_name == recorded_target,
            "parameter_count": parameter_count,
            "return_sink_count": return_sink_count,
        }
    except Exception as exc:
        method_found = bool(re.search(rf"\b{re.escape(recorded_target)}\s*\(", code))
        return {
            "parse_status": "fallback_regex",
            "fallback_used": True,
            "fallback_reason": f"{type(exc).__name__}: {exc}",
            "recorded_target_method": recorded_target,
            "recorded_target_found": method_found,
            "codesteer_selected_target_method": None,
            "codesteer_target_matches_recorded": None,
            "parameter_count": None,
            "return_sink_count": len(re.findall(r"\breturn\b", code)),
        }


def _infer_java_entry(code: str, explicit: Optional[str]) -> Tuple[str, str]:
    package_match = re.search(r"(?m)^\s*package\s+([A-Za-z_]\w*(?:\.[A-Za-z_]\w*)*)\s*;", code)
    package = package_match.group(1) if package_match else ""
    if explicit:
        qualified = str(explicit).strip()
        simple = qualified.rsplit(".", 1)[-1]
        if package and "." not in qualified:
            qualified = f"{package}.{qualified}"
        return simple, qualified
    public_match = re.search(r"\bpublic\s+(?:final\s+|abstract\s+)?class\s+([A-Za-z_]\w*)", code)
    if public_match:
        simple = public_match.group(1)
    else:
        main_match = re.search(
            r"\bclass\s+([A-Za-z_]\w*)\b[\s\S]*?\bstatic\s+void\s+main\s*\(", code
        )
        if not main_match:
            raise ValueError("Could not infer Java class containing main(); record main_class in the manifest.")
        simple = main_match.group(1)
    return simple, f"{package}.{simple}" if package else simple


def run_java_source(
    *,
    code: str,
    explicit_main_class: Optional[str],
    stdin: str,
    argv: Sequence[str],
    classpath: Sequence[Path],
    java_home: Optional[Path],
    timeout_seconds: int,
    scratch_root: Path,
) -> Dict[str, Any]:
    simple_class, qualified_class = _infer_java_entry(code, explicit_main_class)
    javac = (java_home / "bin" / "javac") if java_home else Path(shutil.which("javac") or "javac")
    java = (java_home / "bin" / "java") if java_home else Path(shutil.which("java") or "java")
    compat_jar = PROMPT_STEERING_ROOT / "artifacts" / "java_compat" / "javatuples-compat.jar"
    cp_entries = [str(path) for path in classpath]
    if compat_jar.is_file():
        cp_entries.append(str(compat_jar))
    scratch_root = scratch_root.expanduser().resolve()
    try:
        scratch_root.relative_to(WORK_ROOT)
    except ValueError as exc:
        raise ValueError(f"Java scratch root must stay inside {WORK_ROOT}: {scratch_root}") from exc
    scratch_root.mkdir(parents=True, exist_ok=True)
    java_env = dict(os.environ)
    for unsafe_name in ("JAVA_TOOL_OPTIONS", "JDK_JAVA_OPTIONS", "_JAVA_OPTIONS", "CLASSPATH"):
        java_env.pop(unsafe_name, None)
    with tempfile.TemporaryDirectory(prefix="long-code-java-", dir=scratch_root) as temp_raw:
        temp = Path(temp_raw)
        process_env = dict(java_env)
        process_env.update(
            {
                "HOME": str(temp),
                "TMPDIR": str(temp),
                "TMP": str(temp),
                "TEMP": str(temp),
            }
        )
        classes = temp / "classes"
        classes.mkdir()
        source = temp / f"{simple_class}.java"
        source.write_text(code, encoding="utf-8")
        compile_cmd = [
            str(javac),
            f"-J-Djava.io.tmpdir={temp}",
            f"-J-Duser.home={temp}",
            "-J-XX:-UsePerfData",
            "-encoding",
            "UTF-8",
            "-Xlint:none",
            "-nowarn",
            "-d",
            str(classes),
        ]
        if cp_entries:
            compile_cmd += ["-cp", os.pathsep.join(cp_entries)]
        compile_cmd.append(str(source))
        compile_proc = subprocess.run(
            compile_cmd,
            cwd=temp,
            capture_output=True,
            text=True,
            timeout=timeout_seconds,
            check=False,
            env=process_env,
        )
        result: Dict[str, Any] = {
            "main_class": qualified_class,
            "compile_command": compile_cmd,
            "compile_returncode": compile_proc.returncode,
            "compile_stdout": compile_proc.stdout,
            "compile_stderr": compile_proc.stderr,
            "compiled": compile_proc.returncode == 0,
        }
        if compile_proc.returncode != 0:
            return result
        runtime_cp = [str(classes), *cp_entries]
        run_cmd = [
            str(java),
            "-Dfile.encoding=UTF-8",
            f"-Djava.io.tmpdir={temp}",
            f"-Duser.home={temp}",
            "-XX:-UsePerfData",
            "-ea",
            "-cp",
            os.pathsep.join(runtime_cp),
            qualified_class,
            *argv,
        ]
        run_proc = subprocess.run(
            run_cmd,
            cwd=temp,
            input=stdin,
            capture_output=True,
            text=True,
            timeout=timeout_seconds,
            check=False,
            env=process_env,
        )
        result.update(
            {
                "run_command": run_cmd,
                "run_returncode": run_proc.returncode,
                "stdout": run_proc.stdout,
                "stderr": run_proc.stderr,
                "ran": True,
                "success": run_proc.returncode == 0,
            }
        )
        return result


def establish_oracle(
    sample: Sample,
    *,
    java_home: Optional[Path],
    timeout_seconds: int,
    scratch_root: Path,
) -> Dict[str, Any]:
    original_code = sample.original_path.read_text(encoding="utf-8")
    obfuscated_code = sample.obfuscated_path.read_text(encoding="utf-8")
    original = run_java_source(
        code=original_code,
        explicit_main_class=sample.original_main_class,
        stdin=sample.stdin,
        argv=sample.argv,
        classpath=sample.classpath,
        java_home=java_home,
        timeout_seconds=timeout_seconds,
        scratch_root=scratch_root,
    )
    obfuscated = run_java_source(
        code=obfuscated_code,
        explicit_main_class=sample.obfuscated_main_class,
        stdin=sample.stdin,
        argv=sample.argv,
        classpath=sample.classpath,
        java_home=java_home,
        timeout_seconds=timeout_seconds,
        scratch_root=scratch_root,
    )
    for label, result in (("original", original), ("obfuscated", obfuscated)):
        if not result.get("compiled"):
            raise RuntimeError(f"{sample.sample_id} {label} compile failed: {result.get('compile_stderr', '')}")
        if not result.get("success"):
            raise RuntimeError(f"{sample.sample_id} {label} execution failed: {result.get('stderr', '')}")
        if str(result.get("compile_stderr", "")):
            raise RuntimeError(
                f"{sample.sample_id} {label} compiler emitted stderr: {result.get('compile_stderr', '')}"
            )
        if str(result.get("stderr", "")):
            raise RuntimeError(
                f"{sample.sample_id} {label} runtime emitted stderr: {result.get('stderr', '')}"
            )
    original_stdout = str(original.get("stdout", ""))
    obfuscated_stdout = str(obfuscated.get("stdout", ""))
    canonical_original = normalize_stdout(original_stdout)
    canonical_obfuscated = normalize_stdout(obfuscated_stdout)
    if canonical_original != canonical_obfuscated:
        raise RuntimeError(f"{sample.sample_id} obfuscation changed stdout.")
    if sample.expected_stdout is not None and normalize_stdout(sample.expected_stdout) != canonical_original:
        raise RuntimeError(f"{sample.sample_id} manifest expected_stdout disagrees with execution.")
    oracle_stdout = sample.expected_stdout if sample.expected_stdout is not None else original_stdout
    return {
        "oracle_stdout": oracle_stdout,
        "oracle_stdout_canonical": normalize_stdout(oracle_stdout),
        "normalization": "CRLF/CR to LF, then strip leading/trailing whitespace; internal whitespace preserved",
        "original_execution": original,
        "obfuscated_execution": obfuscated,
        "semantic_equivalence_verified": True,
        "manifest_oracle_verified": sample.expected_stdout is not None,
    }


def build_codesteer_config() -> Any:
    if str(PROJECT_ROOT) not in sys.path:
        sys.path.insert(0, str(PROJECT_ROOT))
    from steering import SteeringConfig

    return SteeringConfig(
        enabled_levels=[2],
        prior="slice_hybrid",
        n_bins=12,
        binning="equal_count",
        beta_bias=0.0,
        beta_post=0.8,
        recency_mix=True,
        recency_rho=0.2,
        recency_window=64,
        recency_apply_after_prompt=True,
        recency_scope="prefer_generated",
        only_first_decode_step=False,
        head_subset_mode="none",
        head_mask_apply_to="both",
        residual_scale=False,
    )


def set_last_n_layers(config: Any, model: Any, n: int = 8) -> Tuple[int, int, int]:
    num_layers = getattr(getattr(model, "config", None), "num_hidden_layers", None)
    if not isinstance(num_layers, int) or num_layers <= 0:
        layers = getattr(getattr(model, "model", None), "layers", None)
        num_layers = len(layers) if layers is not None else None
    if not isinstance(num_layers, int) or num_layers <= 0:
        raise RuntimeError("Could not infer model layer count for last-8-layer CodeSteer.")
    start = max(0, num_layers - min(max(1, n), num_layers))
    end = num_layers - 1
    config.steer_layer_start = start
    config.steer_layer_end = end
    return start, end, num_layers


def _serializable_steering_config(config: Any) -> Dict[str, Any]:
    payload = dataclasses.asdict(config)
    return json.loads(json.dumps(payload, default=_json_default))


def _model_context_limit(runner: Any) -> Optional[int]:
    values: List[int] = []
    for value in (
        getattr(getattr(runner, "model", None), "config", None),
        getattr(runner, "tokenizer", None),
    ):
        if value is None:
            continue
        for attr in ("max_position_embeddings", "model_max_length"):
            candidate = getattr(value, attr, None)
            if isinstance(candidate, int) and 0 < candidate < 10_000_000:
                values.append(candidate)
    return min(values) if values else None


def prompt_token_preflight(runner: Any, condition: ConditionInput, max_new_tokens: int) -> Dict[str, Any]:
    prompt = runner._build_prompt(
        condition.source_code,
        instruction=condition.instruction,
        language="java",
        answer_prefix="",
    )
    encoded = runner.tokenizer(prompt, add_special_tokens=True)
    ids = encoded.get("input_ids", []) if isinstance(encoded, dict) else getattr(encoded, "input_ids", [])
    if ids and isinstance(ids[0], list):
        ids = ids[0]
    prompt_tokens = len(ids)
    context_limit = _model_context_limit(runner)
    margin = context_limit - prompt_tokens - max_new_tokens if context_limit is not None else None
    return {
        "prompt_sha256": _sha256_bytes(prompt.encode("utf-8")),
        "prompt_token_count": prompt_tokens,
        "context_limit": context_limit,
        "max_new_tokens": max_new_tokens,
        "context_margin_tokens": margin,
        "fits_context": margin is None or margin >= 0,
    }


def codesteer_prior_preflight(runner: Any, condition: ConditionInput) -> Dict[str, Any]:
    """Prove that the algorithm prior and CASES signal are both non-fallback.

    The static parse check is insufficient: prompt-token alignment can still make
    SlicingPrior return its positional fallback.  This check uses the exact prompt
    and tokenizer that generation will use.
    """
    if str(PROJECT_ROOT) not in sys.path:
        sys.path.insert(0, str(PROJECT_ROOT))
    import numpy as np
    from steering.priors import PriorContext, SlicingHybridPrior, SlicingPrior

    prompt = runner._build_prompt(
        condition.source_code,
        instruction=condition.instruction,
        language="java",
        answer_prefix="",
    )
    encoded = runner.tokenizer(prompt, add_special_tokens=True)
    ids = encoded.get("input_ids", []) if isinstance(encoded, dict) else getattr(encoded, "input_ids", [])
    if ids and isinstance(ids[0], list):
        ids = ids[0]
    prompt_tokens = runner.tokenizer.convert_ids_to_tokens(ids)
    context = PriorContext(
        prompt_tokens=prompt_tokens,
        code_text=condition.source_code,
        vocab_tokens=[],
        prompt_text=prompt,
    )
    algorithm_prior = SlicingPrior(context)
    actual = algorithm_prior.vector(0, 12)
    positional = algorithm_prior._normalize(algorithm_prior._fallback_chunk(0, 12))
    algorithm_fallback_detected = bool(
        actual.shape == positional.shape and np.allclose(actual, positional, rtol=1e-7, atol=1e-10)
    )
    l1_distance = (
        float(np.abs(actual - positional).sum()) if actual.shape == positional.shape else None
    )
    hybrid = SlicingHybridPrior(context)
    case_ids = list(getattr(hybrid, "_case_ids", []) or [])
    return {
        "algorithm_fallback_detected": algorithm_fallback_detected,
        "algorithm_vs_fallback_l1": l1_distance,
        "algorithm_vector_length": int(actual.size),
        "fallback_vector_length": int(positional.size),
        "case_signal_active": bool(case_ids),
        "parsed_case_ids": case_ids,
        "case_vector_count": len(getattr(hybrid, "_case_vectors", []) or []),
        "n_bins": 12,
        "prompt_sha256": _sha256_bytes(prompt.encode("utf-8")),
    }


def validate_steering_debug(condition: ConditionInput, debug: Mapping[str, Any]) -> None:
    enabled = bool(debug.get("enabled", False))
    calls = int(debug.get("steer_calls", 0) or 0)
    if condition.activation_steering:
        level_counts = debug.get("level_call_counts") or {}
        checks = {
            "enabled": enabled,
            "steer_calls_positive": calls > 0,
            "recency_mix": debug.get("recency_mix") is True,
            "recency_rho": abs(float(debug.get("recency_rho", -1.0)) - 0.2) < 1e-9,
            "recency_window": int(debug.get("recency_window", -1)) == 64,
            "head_subset_none": debug.get("head_subset_mode") == "none",
            "l2_calls_positive": int(level_counts.get("l2_calls", 0) or 0) > 0,
            "l1_calls_zero": int(level_counts.get("l1_calls", 0) or 0) == 0,
            "l3_active_steps_zero": int(level_counts.get("l3_active_steps", 0) or 0) == 0,
            "l4_calls_zero": int(level_counts.get("l4_calls", 0) or 0) == 0,
            "l5_calls_zero": int(level_counts.get("l5_calls", 0) or 0) == 0,
        }
        failed = [name for name, ok in checks.items() if not ok]
        if failed:
            raise RuntimeError(f"CodeSteer debug validation failed: {', '.join(failed)}")
    elif enabled or calls != 0:
        raise RuntimeError(
            f"Condition {condition.name} unexpectedly activated attention steering "
            f"(enabled={enabled}, steer_calls={calls})."
        )


def _experiment_output_root(raw: Path) -> Path:
    path = raw.expanduser()
    if not path.is_absolute():
        path = WORK_ROOT / path
    path = path.resolve()
    try:
        path.relative_to(WORK_ROOT)
    except ValueError as exc:
        raise ValueError(f"Output root must stay inside {WORK_ROOT}: {path}") from exc
    return path


def configure_local_scratch(output_root: Path) -> Dict[str, str]:
    scratch = output_root / "scratch"
    paths = {
        "TMPDIR": scratch / "tmp",
        "TMP": scratch / "tmp",
        "TEMP": scratch / "tmp",
        "CUDA_CACHE_PATH": scratch / "cuda-cache",
        "XDG_CACHE_HOME": scratch / "xdg-cache",
        "TORCHINDUCTOR_CACHE_DIR": scratch / "torchinductor-cache",
        "TRITON_CACHE_DIR": scratch / "triton-cache",
    }
    for path in set(paths.values()):
        path.mkdir(parents=True, exist_ok=True)
    rendered = {name: str(path.resolve()) for name, path in paths.items()}
    os.environ.update(rendered)
    tempfile.tempdir = rendered["TMPDIR"]
    return rendered


def _run_fingerprint(payload: Mapping[str, Any]) -> str:
    return _sha256_bytes(_stable_json(payload).encode("utf-8"))


def _is_complete_run(run_dir: Path, fingerprint: str) -> bool:
    record_path = run_dir / "record.json"
    if not record_path.is_file():
        return False
    try:
        record = json.loads(record_path.read_text(encoding="utf-8"))
    except Exception:
        return False
    required = ("submitted_prompt.txt", "raw_completion.txt", "run_config.json", "steering_debug.json")
    return (
        record.get("status") == "complete"
        and record.get("fingerprint") == fingerprint
        and all((run_dir / name).is_file() for name in required)
    )


def _write_sample_snapshot(root: Path, sample: Sample) -> None:
    sample_root = root / "samples" / sample.sample_id
    atomic_write_bytes(sample_root / "original.java", sample.original_path.read_bytes())
    atomic_write_bytes(sample_root / "obfuscated.java", sample.obfuscated_path.read_bytes())
    atomic_write_text(sample_root / "stdin.txt", sample.stdin)
    atomic_write_json(
        sample_root / "sample.json",
        {
            "sample_id": sample.sample_id,
            "original_source_path": sample.original_path,
            "obfuscated_source_path": sample.obfuscated_path,
            "original_sha256": sha256_file(sample.original_path),
            "obfuscated_sha256": sha256_file(sample.obfuscated_path),
            "original_target_method": sample.original_target_method,
            "obfuscated_target_method": sample.obfuscated_target_method,
            "argv": sample.argv,
            "metadata": sample.metadata,
        },
    )


def rebuild_results_index(output_root: Path) -> None:
    rows: List[Dict[str, Any]] = []
    for record_path in sorted((output_root / "runs").glob("*/trial_*/*/record.json")):
        try:
            record = json.loads(record_path.read_text(encoding="utf-8"))
        except Exception:
            continue
        rows.append(
            {
                "sample_id": record.get("sample_id"),
                "trial": record.get("trial"),
                "paired_seed": record.get("paired_seed"),
                "condition": record.get("condition"),
                "trimmed_exact_match": record.get("score", {}).get("trimmed_exact_match"),
                "exact_match_whitespace_normalized": record.get("score", {}).get(
                    "exact_match_whitespace_normalized"
                ),
                "parse_status": record.get("score", {}).get("parse_status"),
                "record_path": str(record_path.relative_to(output_root)),
            }
        )
    atomic_write_json(
        output_root / "results_index.json",
        {"protocol_version": PROTOCOL_VERSION, "completed_run_count": len(rows), "runs": rows},
    )


def parse_args(argv: Optional[Sequence[str]] = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT_ROOT)
    parser.add_argument("--model-name", default=DEFAULT_MODEL_NAME)
    parser.add_argument("--cache-dir", default=DEFAULT_CACHE_DIR)
    parser.add_argument("--trials", type=int, default=3)
    parser.add_argument("--base-seed", type=int, default=20260713)
    parser.add_argument("--max-new-tokens", type=int, default=GENERATION_DEFAULTS["max_new_tokens"])
    parser.add_argument("--temperature", type=float, default=GENERATION_DEFAULTS["temperature"])
    parser.add_argument("--top-p", type=float, default=GENERATION_DEFAULTS["top_p"])
    parser.add_argument("--top-k", type=int, default=GENERATION_DEFAULTS["top_k"])
    parser.add_argument("--conditions", default=",".join(CONDITIONS))
    parser.add_argument("--sample-ids", default="", help="Optional comma-separated sample ids.")
    parser.add_argument("--gpu-ids", default=None, help="CUDA ids separated by comma or plus.")
    parser.add_argument("--gpus", type=int, default=None)
    parser.add_argument("--java-home", type=Path, default=Path("/people/cs/x/xxr230000/jdks/jdk-17.0.11+9"))
    parser.add_argument("--java-timeout", type=int, default=30)
    parser.add_argument("--offline", choices=["on", "off"], default="on")
    parser.add_argument("--hf-login", choices=["on", "off"], default="off")
    parser.add_argument("--force", action="store_true", help="Overwrite a completed run if its fingerprint differs.")
    parser.add_argument("--allow-target-mismatch", action="store_true")
    parser.add_argument("--allow-algorithm-fallback", action="store_true")
    parser.add_argument("--dry-run", action="store_true", help="Validate manifest/static preflight without loading the model.")
    return parser.parse_args(argv)


def _selected_values(raw: str, allowed: Sequence[str], label: str) -> List[str]:
    selected = [value.strip() for value in raw.split(",") if value.strip()]
    unknown = sorted(set(selected) - set(allowed))
    if unknown:
        raise ValueError(f"Unknown {label}: {unknown}; allowed={list(allowed)}")
    return [value for value in allowed if value in selected]


def _configure_cuda(gpu_ids_raw: Optional[str], gpus: Optional[int]) -> Optional[int]:
    ids: List[int] = []
    if gpu_ids_raw:
        for part in re.split(r"[+,]", gpu_ids_raw):
            if part.strip():
                ids.append(int(part.strip()))
        os.environ["CUDA_VISIBLE_DEVICES"] = ",".join(str(value) for value in ids)
    import torch

    visible = torch.cuda.device_count() if torch.cuda.is_available() else 0
    if ids and visible:
        return min(len(ids), visible)
    if gpus is not None and visible:
        return min(max(1, gpus), visible)
    return None


def main(argv: Optional[Sequence[str]] = None) -> int:
    started_utc = datetime.now(timezone.utc)
    started_local = datetime.now().astimezone()
    args = parse_args(argv)
    output_root = _experiment_output_root(args.output_root)
    samples, manifest_metadata = load_manifest(args.manifest)
    selected_conditions = _selected_values(args.conditions, CONDITIONS, "conditions")
    requested_ids = {value.strip() for value in args.sample_ids.split(",") if value.strip()}
    if requested_ids:
        known = {sample.sample_id for sample in samples}
        missing = requested_ids - known
        if missing:
            raise ValueError(f"Unknown sample ids: {sorted(missing)}")
        samples = [sample for sample in samples if sample.sample_id in requested_ids]
    if args.trials < 1:
        raise ValueError("--trials must be positive.")
    generation = {
        "do_sample": True,
        "temperature": float(args.temperature),
        "top_p": float(args.top_p),
        "top_k": int(args.top_k),
        "max_new_tokens": int(args.max_new_tokens),
    }
    if generation != GENERATION_DEFAULTS:
        raise ValueError(
            f"Generation overrides differ from the registered protocol: {generation} != "
            f"{GENERATION_DEFAULTS}"
        )
    if args.model_name != DEFAULT_MODEL_NAME:
        raise ValueError(
            f"This unified experiment is registered for {DEFAULT_MODEL_NAME}, not {args.model_name}."
        )

    static_preflights: Dict[str, Dict[str, Any]] = {}
    prepared: Dict[str, List[ConditionInput]] = {}
    for sample in samples:
        conditions, prompt_meta = prepare_conditions(sample)
        prepared[sample.sample_id] = conditions
        original_analysis = analyze_target_method(
            sample.original_path.read_text(encoding="utf-8"), sample.original_target_method
        )
        obfuscated_analysis = analyze_target_method(
            sample.obfuscated_path.read_text(encoding="utf-8"), sample.obfuscated_target_method
        )
        preflight = {
            "sample_id": sample.sample_id,
            "original_line_count": len(sample.original_path.read_text(encoding="utf-8").splitlines()),
            "obfuscated_line_count": len(sample.obfuscated_path.read_text(encoding="utf-8").splitlines()),
            "original_method_analysis": original_analysis,
            "obfuscated_method_analysis": obfuscated_analysis,
            "prompt_slice": prompt_meta,
        }
        static_preflights[sample.sample_id] = preflight
        target_match = obfuscated_analysis.get("codesteer_target_matches_recorded")
        if target_match is False and not args.allow_target_mismatch:
            raise RuntimeError(
                f"{sample.sample_id}: CodeSteer selected "
                f"{obfuscated_analysis.get('codesteer_selected_target_method')!r}, not recorded target "
                f"{sample.obfuscated_target_method!r}. Use a corrected manifest/source."
            )
        if not obfuscated_analysis.get("recorded_target_found"):
            raise RuntimeError(f"{sample.sample_id}: recorded obfuscated target method was not found.")

    print(
        f"[preflight] samples={len(samples)} trials={args.trials} conditions={selected_conditions} "
        f"model={args.model_name}"
    )
    if args.dry_run:
        for sample in samples:
            pf = static_preflights[sample.sample_id]
            method = pf["obfuscated_method_analysis"]
            prompt = pf["prompt_slice"]
            print(
                f"  {sample.sample_id}: target={method.get('codesteer_selected_target_method')} "
                f"parse={method.get('parse_status')} params={method.get('parameter_count')} "
                f"returns={method.get('return_sink_count')} prompt_elements="
                f"{prompt.get('emitted_element_count')}/{prompt.get('eligible_element_count')}"
            )
        return 0

    output_root.mkdir(parents=True, exist_ok=True)
    local_scratch_paths = configure_local_scratch(output_root)
    manifest_hash = sha256_file(args.manifest.expanduser().resolve())
    experiment_config = {
        "protocol_version": PROTOCOL_VERSION,
        "created_at_unix": time.time(),
        "manifest_path": str(args.manifest.expanduser().resolve()),
        "manifest_sha256": manifest_hash,
        "manifest_metadata": manifest_metadata,
        "model_name": args.model_name,
        "model_snapshot_commit": MODEL_SNAPSHOT_COMMIT,
        "cache_dir": args.cache_dir,
        "trials": args.trials,
        "base_seed": args.base_seed,
        "conditions": selected_conditions,
        "generation": generation,
        "score_definition": {
            "name": "trimmed_exact_match",
            "canonicalization": (
                "CRLF/CR to LF, then strip leading/trailing whitespace; internal whitespace preserved"
            ),
        },
        "codesteer_registered_profile": CODESTEER_DEFAULTS,
        "static_prior_cache": STATIC_PRIOR_CACHE_PROFILE,
        "sample_ids": [sample.sample_id for sample in samples],
        "outcome_selection_note": (
            "The complete screened pool is retained. Any later all-baselines-fail/CodeSteer-succeeds "
            "case-study subset is outcome-selected and must be labeled as such."
        ),
    }
    experiment_config_path = output_root / "experiment_config.json"
    atomic_write_json(experiment_config_path, experiment_config)
    experiment_config_sha256 = sha256_file(experiment_config_path)

    for sample in samples:
        _write_sample_snapshot(output_root, sample)
        oracle = establish_oracle(
            sample,
            java_home=args.java_home.expanduser().resolve() if args.java_home else None,
            timeout_seconds=max(1, args.java_timeout),
            scratch_root=output_root / "scratch" / "java",
        )
        preflight_root = output_root / "samples" / sample.sample_id
        atomic_write_json(preflight_root / "oracle.json", oracle)
        atomic_write_text(preflight_root / "oracle_stdout.txt", str(oracle["oracle_stdout"]))
        atomic_write_json(preflight_root / "static_preflight.json", static_preflights[sample.sample_id])

    if args.offline == "on":
        os.environ["HF_HUB_OFFLINE"] = "1"
        os.environ["TRANSFORMERS_OFFLINE"] = "1"
    cached_commit = cached_model_ref_commit(Path(args.cache_dir).expanduser(), args.model_name)
    if args.model_name == DEFAULT_MODEL_NAME and cached_commit != MODEL_SNAPSHOT_COMMIT:
        raise RuntimeError(
            f"Cached {args.model_name} main ref is {cached_commit!r}, expected registered snapshot "
            f"{MODEL_SNAPSHOT_COMMIT}."
        )
    max_devices = _configure_cuda(args.gpu_ids, args.gpus)
    if str(PROJECT_ROOT) not in sys.path:
        sys.path.insert(0, str(PROJECT_ROOT))
    from models import ModelRunner

    prior_cache_runtime = install_static_prior_vector_cache()
    codesteer_config = build_codesteer_config()
    runner = ModelRunner()
    runner.set_steering_config(codesteer_config)  # hooks must be installed during build
    if args.hf_login == "on":
        runner.login_hf()
    runner.config(
        key_scope="prompt",
        max_devices=max_devices,
        model_name=args.model_name,
        cache_dir=args.cache_dir,
        temperature=generation["temperature"],
        top_p=generation["top_p"],
        top_k=generation["top_k"],
        max_new_tokens=generation["max_new_tokens"],
    )
    runner.build()
    layer_start, layer_end, num_layers = set_last_n_layers(codesteer_config, runner.model, 8)
    codesteer_config.model_name = args.model_name
    steering_config_payload = _serializable_steering_config(codesteer_config)
    if layer_end - layer_start + 1 != min(8, num_layers):
        raise AssertionError("CodeSteer layer band is not the last eight layers.")
    import torch
    import transformers

    model_config_obj = getattr(runner.model, "config", None)
    model_config_payload = (
        model_config_obj.to_dict()
        if model_config_obj is not None and callable(getattr(model_config_obj, "to_dict", None))
        else {}
    )
    loaded_commit = getattr(model_config_obj, "_commit_hash", None)
    if loaded_commit is not None and str(loaded_commit) != MODEL_SNAPSHOT_COMMIT:
        raise RuntimeError(
            f"Loaded model snapshot {loaded_commit!r} differs from registered snapshot "
            f"{MODEL_SNAPSHOT_COMMIT}."
        )
    atomic_write_json(
        output_root / "environment.json",
        {
            "protocol_version": PROTOCOL_VERSION,
            "hostname": socket.gethostname(),
            "experiment_started_utc": started_utc.isoformat(),
            "experiment_started_local": started_local.isoformat(),
            "local_timezone": str(started_local.tzinfo),
            "python_version": sys.version,
            "torch_version": torch.__version__,
            "transformers_version": transformers.__version__,
            "accelerate_version": _package_version("accelerate"),
            "cuda_runtime_version": torch.version.cuda,
            "cuda_available": torch.cuda.is_available(),
            "cuda_device_count": torch.cuda.device_count() if torch.cuda.is_available() else 0,
            "cuda_device_names": (
                [torch.cuda.get_device_name(index) for index in range(torch.cuda.device_count())]
                if torch.cuda.is_available()
                else []
            ),
            "model_name": args.model_name,
            "model_snapshot_commit_registered": MODEL_SNAPSHOT_COMMIT,
            "model_snapshot_commit_cached_ref": cached_commit,
            "model_snapshot_commit_loaded_config": loaded_commit,
            "model_snapshot_commit_verified": (
                cached_commit == MODEL_SNAPSHOT_COMMIT
                and (loaded_commit is None or str(loaded_commit) == MODEL_SNAPSHOT_COMMIT)
            ),
            "experiment_config_sha256": experiment_config_sha256,
            "runner_sha256": sha256_file(Path(__file__).resolve()),
            "runtime_code_provenance": runtime_code_provenance(),
            "sanitized_local_cache_and_temp_paths": local_scratch_paths,
            "model_config": model_config_payload,
            "generation": generation,
            "codesteer_config": steering_config_payload,
            "static_prior_cache": prior_cache_runtime,
        },
    )

    try:
        preflight_rejections: List[Dict[str, Any]] = []
        for sample in samples:
            oracle = json.loads(
                (output_root / "samples" / sample.sample_id / "oracle.json").read_text(encoding="utf-8")
            )
            oracle_stdout = str(oracle["oracle_stdout"])
            condition_map = {condition.name: condition for condition in prepared[sample.sample_id]}
            token_preflight: Dict[str, Any] = {}
            prior_preflight: Optional[Dict[str, Any]] = None
            rejection_reasons: List[str] = []
            # Preflight all conditions even when a launch shard requests only a
            # subset, so every shard rejects the same fallback/context-invalid
            # candidates before producing unmatched baseline runs.
            for condition_name in CONDITIONS:
                condition = condition_map[condition_name]
                token_info = prompt_token_preflight(runner, condition, generation["max_new_tokens"])
                token_preflight[condition_name] = token_info
                if not token_info["fits_context"]:
                    rejection_reasons.append(
                        f"{sample.sample_id}/{condition_name} exceeds model context by "
                        f"{-int(token_info['context_margin_tokens'])} tokens."
                    )
                if condition.activation_steering:
                    prior_preflight = codesteer_prior_preflight(runner, condition)
                    if prior_preflight["algorithm_fallback_detected"] and not args.allow_algorithm_fallback:
                        rejection_reasons.append(
                            f"{sample.sample_id}: CodeSteer algorithm prior equals its positional fallback; "
                            "candidate excluded before inference."
                        )
                    if not prior_preflight["case_signal_active"]:
                        rejection_reasons.append(
                            f"{sample.sample_id}: slice_hybrid did not parse the ### CASES_BEGIN/END signal."
                        )
            full_preflight = dict(static_preflights[sample.sample_id])
            full_preflight.update(
                {
                    "prompt_tokens_by_condition": token_preflight,
                    "codesteer_layer_start": layer_start,
                    "codesteer_layer_end": layer_end,
                    "model_num_hidden_layers": num_layers,
                    "codesteer_prior": prior_preflight,
                    "eligible_for_inference": not rejection_reasons,
                    "rejection_reasons": rejection_reasons,
                }
            )
            atomic_write_json(output_root / "samples" / sample.sample_id / "preflight.json", full_preflight)
            if rejection_reasons:
                rejection = {
                    "sample_id": sample.sample_id,
                    "reasons": rejection_reasons,
                    "codesteer_prior": prior_preflight,
                    "prompt_tokens_by_condition": token_preflight,
                }
                preflight_rejections.append(rejection)
                atomic_write_json(
                    output_root / "preflight_rejections.json",
                    {
                        "protocol_version": PROTOCOL_VERSION,
                        "rejection_count": len(preflight_rejections),
                        "rejections": preflight_rejections,
                    },
                )
                print(f"[preflight-reject] {sample.sample_id}: {' | '.join(rejection_reasons)}")
                continue

            for trial in range(1, args.trials + 1):
                seed = paired_seed(args.base_seed, sample.sample_id, trial)
                for condition_name in selected_conditions:
                    condition = condition_map[condition_name]
                    prompt = runner._build_prompt(
                        condition.source_code,
                        instruction=condition.instruction,
                        language="java",
                        answer_prefix="",
                    )
                    fingerprint_payload = {
                        "protocol_version": PROTOCOL_VERSION,
                        "manifest_sha256": manifest_hash,
                        "sample_id": sample.sample_id,
                        "original_sha256": sha256_file(sample.original_path),
                        "obfuscated_sha256": sha256_file(sample.obfuscated_path),
                        "condition": condition.name,
                        "trial": trial,
                        "paired_seed": seed,
                        "model_name": args.model_name,
                        "model_snapshot_commit": MODEL_SNAPSHOT_COMMIT,
                        "generation": generation,
                        "prompt_sha256": _sha256_bytes(prompt.encode("utf-8")),
                        "steering": steering_config_payload if condition.activation_steering else None,
                    }
                    fingerprint = _run_fingerprint(fingerprint_payload)
                    run_dir = (
                        output_root
                        / "runs"
                        / sample.sample_id
                        / f"trial_{trial:03d}"
                        / condition.name
                    )
                    if _is_complete_run(run_dir, fingerprint):
                        print(f"[skip] {sample.sample_id} trial={trial} condition={condition.name}")
                        continue
                    existing_record = run_dir / "record.json"
                    if existing_record.is_file() and not args.force:
                        old = json.loads(existing_record.read_text(encoding="utf-8"))
                        if old.get("status") == "complete" and old.get("fingerprint") != fingerprint:
                            raise RuntimeError(
                                f"Stale completed run at {run_dir}; pass --force to replace it explicitly."
                            )
                    run_dir.mkdir(parents=True, exist_ok=True)
                    run_config = {
                        **fingerprint_payload,
                        "fingerprint": fingerprint,
                        "source_kind": condition.source_kind,
                        "source_path": str(condition.source_path),
                        "target_method": condition.target_method,
                        "prompt_metadata": condition.prompt_metadata,
                        "token_preflight": token_preflight[condition.name],
                        "codesteer_prior_preflight": (
                            prior_preflight if condition.activation_steering else None
                        ),
                        "activation_steering": condition.activation_steering,
                        "paired_design": "same seed for all four conditions in this sample/trial",
                    }
                    atomic_write_json(run_dir / "run_config.json", run_config)
                    atomic_write_text(run_dir / "submitted_prompt.txt", prompt)
                    atomic_write_text(run_dir / "source.java", condition.source_code)
                    atomic_write_json(
                        run_dir / "status.json",
                        {"status": "running", "started_at_unix": time.time(), "fingerprint": fingerprint},
                    )

                    runner.steering_config = codesteer_config if condition.activation_steering else None
                    seed_everything(seed)
                    result = runner.run_llama(
                        condition.source_code,
                        instruction=condition.instruction,
                        language="java",
                        answer_prefix="",
                        max_new_tokens=generation["max_new_tokens"],
                        temperature=generation["temperature"],
                        top_p=generation["top_p"],
                        top_k=generation["top_k"],
                        do_sample=True,
                        record_layers=False,
                        record_attention=False,
                        vocab_tokens=[],
                        steering_code_snippet=condition.source_code,
                    )
                    completion = str(result.get("generated_completion") or "")
                    predicted_stdout, parse_meta = parse_final_output(completion)
                    reasoning_text = (
                        completion.rsplit("FINAL_OUTPUT_JSON:", 1)[0].strip()
                        if "FINAL_OUTPUT_JSON:" in completion
                        else completion.strip()
                    )
                    predicted_normalized = (
                        normalize_stdout(predicted_stdout) if predicted_stdout is not None else None
                    )
                    oracle_normalized = normalize_stdout(oracle_stdout)
                    score = {
                        **parse_meta,
                        "predicted_stdout": predicted_stdout,
                        "predicted_stdout_canonical": predicted_normalized,
                        "oracle_stdout_canonical": oracle_normalized,
                        "normalization": (
                            "CRLF/CR to LF, then strip leading/trailing whitespace; "
                            "internal whitespace preserved"
                        ),
                        "trimmed_exact_match": (
                            predicted_stdout is not None and predicted_normalized == oracle_normalized
                        ),
                        "reasoning_character_count": len(reasoning_text),
                    }
                    # Compatibility alias for early staged tooling; despite its
                    # name this now has the stricter historical trimmed-exact semantics.
                    score["exact_match_whitespace_normalized"] = score["trimmed_exact_match"]
                    debug = result.get("steering_debug") or {}
                    validate_steering_debug(condition, debug)
                    result["experiment"] = {
                        "sample_id": sample.sample_id,
                        "trial": trial,
                        "condition": condition.name,
                        "paired_seed": seed,
                        "fingerprint": fingerprint,
                    }
                    result["score"] = score
                    result.pop("full_decode_head_tensors", None)
                    atomic_write_text(run_dir / "raw_completion.txt", completion)
                    atomic_write_text(run_dir / "reasoning.txt", reasoning_text)
                    atomic_write_text(run_dir / "model_prompt_decoded.txt", str(result.get("prompt_text", "")))
                    atomic_write_text(
                        run_dir / "predicted_stdout.txt", predicted_stdout if predicted_stdout is not None else ""
                    )
                    atomic_write_text(run_dir / "oracle_stdout.txt", oracle_stdout)
                    atomic_write_json(run_dir / "steering_debug.json", debug)
                    atomic_write_json(run_dir / "score.json", score)
                    atomic_write_json(run_dir / "model_output.json", result)
                    record = {
                        "status": "complete",
                        "completed_at_unix": time.time(),
                        "fingerprint": fingerprint,
                        "sample_id": sample.sample_id,
                        "trial": trial,
                        "condition": condition.name,
                        "paired_seed": seed,
                        "score": score,
                        "artifacts": {
                            "submitted_prompt": "submitted_prompt.txt",
                            "raw_completion": "raw_completion.txt",
                            "reasoning": "reasoning.txt",
                            "run_config": "run_config.json",
                            "steering_debug": "steering_debug.json",
                            "model_output": "model_output.json",
                        },
                    }
                    atomic_write_json(run_dir / "record.json", record)
                    atomic_write_json(run_dir / "status.json", record)
                    rebuild_results_index(output_root)
                    print(
                        f"[done] {sample.sample_id} trial={trial} condition={condition.name} "
                        f"exact={score['exact_match_whitespace_normalized']} seed={seed}"
                    )
        atomic_write_json(
            output_root / "preflight_rejections.json",
            {
                "protocol_version": PROTOCOL_VERSION,
                "rejection_count": len(preflight_rejections),
                "rejections": preflight_rejections,
            },
        )
    finally:
        runner.free()

    rebuild_results_index(output_root)
    print(f"[complete] results={output_root / 'results_index.json'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
