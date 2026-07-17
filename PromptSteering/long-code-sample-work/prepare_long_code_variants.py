#!/usr/bin/env python3
"""Prepare and verify deterministic long-code Java obfuscation variants.

This is a data-preparation program only: it never imports a model runner or
performs inference.  It consumes the candidate manifest, copies the canonical
obfuscator profiles into the local artifact, applies one or more selected
technique passes, and independently executes every manifest test against both
the original and transformed source with JDK 17.

All generated files, including Java compiler scratch space, remain below this
script's directory.
"""

from __future__ import annotations

import argparse
import dataclasses
import hashlib
import importlib
import inspect
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile
import time
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Iterable, Mapping, Sequence


# Dynamic imports must leave the upstream eyetracking and CodeSteer trees
# read-only; profile snapshots and all caches belong in this local workspace.
sys.dont_write_bytecode = True


WORK_ROOT = Path(__file__).resolve().parent
PROJECT_ROOT = WORK_ROOT.parents[1]
DEFAULT_MANIFEST = WORK_ROOT / "candidate_pool" / "candidate_manifest.json"
DEFAULT_OUTPUT_ROOT = WORK_ROOT / "prepared_variants"
DEFAULT_EYETRACKING_ROOT = Path("/home/cs/x/xxr230000/eyetracking")
DEFAULT_JAVA_HOME = Path("/people/cs/x/xxr230000/jdks/jdk-17.0.11+9")
SCHEMA_VERSION = "long-code-obfuscated-variants-v1"
SUPPORTED_TECHNIQUES = {
    "T1": "identifier_renaming",
    "T5": "bogus_control_flow",
    "T6": "control_flow_flattening",
    "T8": "call_indirection",
}


@dataclass(frozen=True)
class IOCase:
    case_id: str
    stdin: str
    expected_stdout: str
    argv: tuple[str, ...]
    metadata: dict[str, Any]


@dataclass(frozen=True)
class Candidate:
    candidate_id: str
    source: str
    source_path: Path | None
    main_class: str | None
    manifest_target_method: str | None
    cases: tuple[IOCase, ...]
    metadata: dict[str, Any]


def sha256_bytes(payload: bytes) -> str:
    return hashlib.sha256(payload).hexdigest()


def sha256_text(text: str) -> str:
    return sha256_bytes(text.encode("utf-8"))


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def trim_stdout(text: str) -> str:
    """Apply the historical Table-2 output comparator normalization.

    Only CRLF line endings and outer whitespace are normalized.  Internal
    newlines, indentation, and repeated spaces remain significant.
    """

    return str(text).replace("\r\n", "\n").strip()


def trimmed_exact_match(actual: str, expected: str) -> bool:
    return trim_stdout(actual) == trim_stdout(expected)


def without_legacy_output_score_labels(value: Any) -> Any:
    """Retain source metadata without importing incompatible score labels."""

    obsolete = {
        "stdout_exact_byte_match",
        "normalized_exact_match",
        "exact_match_whitespace_normalized",
    }
    if isinstance(value, Mapping):
        return {
            str(key): without_legacy_output_score_labels(item)
            for key, item in value.items()
            if str(key) not in obsolete
        }
    if isinstance(value, list):
        return [without_legacy_output_score_labels(item) for item in value]
    if isinstance(value, tuple):
        return [without_legacy_output_score_labels(item) for item in value]
    return value


def json_default(value: Any) -> Any:
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


def atomic_write_json(path: Path, payload: Any) -> None:
    atomic_write_text(
        path,
        json.dumps(payload, indent=2, sort_keys=True, ensure_ascii=False, default=json_default) + "\n",
    )


def require_local_write_path(path: Path, label: str) -> Path:
    resolved = path.expanduser().resolve()
    try:
        resolved.relative_to(WORK_ROOT)
    except ValueError as exc:
        raise ValueError(f"{label} must remain under {WORK_ROOT}: {resolved}") from exc
    return resolved


def safe_id(value: Any, fallback: str) -> str:
    rendered = re.sub(r"[^A-Za-z0-9_.-]+", "-", str(value or fallback).strip()).strip(".-")
    if not rendered:
        raise ValueError(f"Could not derive a safe identifier from {value!r}")
    return rendered[:180]


def first_present(raw: Mapping[str, Any], keys: Sequence[str]) -> Any:
    for key in keys:
        if key in raw and raw[key] is not None:
            return raw[key]
    return None


def resolve_read_path(value: Any, base: Path, label: str) -> Path:
    if isinstance(value, Mapping):
        value = first_present(value, ("path", "file", "java_path", "source_path"))
    if not isinstance(value, (str, os.PathLike)) or not str(value).strip():
        raise ValueError(f"Missing {label}")
    path = Path(value).expanduser()
    if not path.is_absolute():
        path = base / path
    path = path.resolve()
    if not path.is_file():
        raise FileNotFoundError(f"{label} does not exist: {path}")
    return path


def text_or_file(
    raw: Mapping[str, Any],
    *,
    direct_keys: Sequence[str],
    path_keys: Sequence[str],
    base: Path,
    label: str,
    required: bool = True,
) -> tuple[str | None, Path | None]:
    direct = first_present(raw, direct_keys)
    if isinstance(direct, Mapping):
        nested_text = first_present(direct, ("text", "content", "source", "code", "value"))
        nested_path = first_present(direct, ("path", "file", "source_path", "java_path"))
        if nested_text is not None:
            return str(nested_text), None
        if nested_path is not None:
            path = resolve_read_path(nested_path, base, label)
            return path.read_text(encoding="utf-8"), path
    elif direct is not None:
        if not isinstance(direct, (str, os.PathLike)):
            raise TypeError(f"{label} must be text, a path, or an object")
        rendered = str(direct)
        possible_path = Path(rendered).expanduser()
        if not possible_path.is_absolute():
            possible_path = base / possible_path
        if "\n" not in rendered and possible_path.is_file():
            path = possible_path.resolve()
            return path.read_text(encoding="utf-8"), path
        return rendered, None

    path_value = first_present(raw, path_keys)
    if path_value is not None:
        path = resolve_read_path(path_value, base, label)
        return path.read_text(encoding="utf-8"), path
    if required:
        raise ValueError(f"Missing {label}")
    return None, None


def manifest_rows(payload: Any) -> tuple[list[Mapping[str, Any]], dict[str, Any]]:
    if isinstance(payload, list):
        rows = payload
        metadata: dict[str, Any] = {}
    elif isinstance(payload, Mapping):
        row_key = next(
            (
                key
                for key in ("samples", "candidates", "variants", "items", "records", "cases")
                if isinstance(payload.get(key), list)
            ),
            None,
        )
        if row_key is not None:
            rows = list(payload[row_key])
            metadata = {str(key): value for key, value in payload.items() if key != row_key}
        else:
            mapped = [value for value in payload.values() if isinstance(value, Mapping)]
            if not mapped:
                raise ValueError("Manifest has no candidate list")
            rows = mapped
            metadata = {}
    else:
        raise TypeError("Manifest root must be an object or array")
    if not rows:
        raise ValueError("Manifest candidate list is empty")
    if not all(isinstance(row, Mapping) for row in rows):
        raise TypeError("Every candidate manifest row must be an object")
    return list(rows), metadata


def read_manifest_payload(path: Path) -> Any:
    if path.suffix.lower() == ".jsonl":
        rows: list[Any] = []
        for line_number, line in enumerate(path.read_text(encoding="utf-8").splitlines(), start=1):
            if not line.strip():
                continue
            try:
                rows.append(json.loads(line))
            except json.JSONDecodeError as exc:
                raise ValueError(f"Invalid JSONL at {path}:{line_number}: {exc}") from exc
        return rows
    return json.loads(path.read_text(encoding="utf-8"))


def _read_case_text(
    raw: Mapping[str, Any],
    *,
    direct_keys: Sequence[str],
    path_keys: Sequence[str],
    base: Path,
    label: str,
    default: str | None = None,
) -> str:
    direct = first_present(raw, direct_keys)
    if direct is not None:
        if isinstance(direct, bytes):
            return direct.decode("utf-8", "strict")
        if isinstance(direct, (str, int, float, bool)):
            return str(direct)
        raise TypeError(f"{label} must be scalar text")
    path_value = first_present(raw, path_keys)
    if path_value is not None:
        return resolve_read_path(path_value, base, label).read_text(encoding="utf-8")
    if default is not None:
        return default
    raise ValueError(f"Missing {label}")


def load_cases(raw: Mapping[str, Any], base: Path, candidate_id: str) -> tuple[IOCase, ...]:
    case_rows: Any = None
    for key in ("tests", "cases", "io_cases", "validation_cases", "stdin_cases", "inputs"):
        value = raw.get(key)
        if isinstance(value, list) and value:
            case_rows = value
            break

    outputs = raw.get("outputs") or raw.get("expected_outputs")
    if case_rows and not isinstance(case_rows[0], Mapping) and isinstance(outputs, list):
        case_rows = [
            {"input": stdin, "expected_stdout": expected}
            for stdin, expected in zip(case_rows, outputs)
        ]

    if not case_rows:
        singular_input = first_present(raw, ("stdin", "input", "input_text", "stdin_path", "input_path"))
        singular_output = first_present(
            raw,
            (
                "expected_stdout",
                "expected_output",
                "output",
                "stdout",
                "expected_stdout_path",
                "expected_output_path",
            ),
        )
        if singular_input is None and singular_output is None:
            raise ValueError(f"{candidate_id} has no stdin cases")
        case_rows = [raw]

    cases: list[IOCase] = []
    seen: set[str] = set()
    for index, case_any in enumerate(case_rows, start=1):
        if isinstance(case_any, Mapping):
            case_raw = dict(case_any)
        elif isinstance(case_any, (list, tuple)) and len(case_any) >= 2:
            case_raw = {"input": case_any[0], "expected_stdout": case_any[1]}
        else:
            raise TypeError(f"{candidate_id} case {index} must be an object or [input, output]")
        case_id = safe_id(first_present(case_raw, ("id", "case_id", "name")), f"case-{index:03d}")
        if case_id in seen:
            raise ValueError(f"{candidate_id} has duplicate case id {case_id}")
        seen.add(case_id)
        stdin = _read_case_text(
            case_raw,
            direct_keys=("stdin", "input", "input_text"),
            path_keys=("stdin_path", "input_path"),
            base=base,
            label=f"{candidate_id}/{case_id} stdin",
            default="",
        )
        expected = _read_case_text(
            case_raw,
            direct_keys=("expected_stdout", "expected_output", "output", "stdout", "output_text"),
            path_keys=("expected_stdout_path", "expected_output_path", "output_path"),
            base=base,
            label=f"{candidate_id}/{case_id} expected stdout",
        )
        input_hash = case_raw.get("input_sha256") or case_raw.get("stdin_sha256")
        expected_hash = case_raw.get("expected_stdout_sha256") or case_raw.get("expected_output_sha256")
        if input_hash and sha256_text(stdin) != str(input_hash):
            raise ValueError(f"{candidate_id}/{case_id} input hash mismatch")
        if expected_hash and sha256_text(expected) != str(expected_hash):
            raise ValueError(f"{candidate_id}/{case_id} expected-output hash mismatch")
        argv_value = case_raw.get("argv", raw.get("argv", [])) or []
        if not isinstance(argv_value, list):
            raise TypeError(f"{candidate_id}/{case_id} argv must be an array")
        cases.append(
            IOCase(
                case_id=case_id,
                stdin=stdin,
                expected_stdout=expected,
                argv=tuple(str(value) for value in argv_value),
                metadata=case_raw,
            )
        )
    return tuple(cases)


def load_candidates(path: Path) -> tuple[list[Candidate], dict[str, Any]]:
    payload = read_manifest_payload(path)
    rows, metadata = manifest_rows(payload)
    result: list[Candidate] = []
    seen: set[str] = set()
    for index, raw_any in enumerate(rows, start=1):
        raw = dict(raw_any)
        candidate_id = safe_id(
            first_present(raw, ("id", "candidate_id", "sample_id", "program_id", "snippet_id", "name")),
            f"candidate-{index:03d}",
        )
        if candidate_id in seen:
            raise ValueError(f"Duplicate candidate id {candidate_id}")
        seen.add(candidate_id)

        source, source_path = text_or_file(
            raw,
            direct_keys=("source_text", "java_source", "code", "source", "original"),
            path_keys=("original_path", "source_path", "java_path", "original_java", "source_file"),
            base=path.parent,
            label=f"{candidate_id} original source",
        )
        assert source is not None
        expected_source_hash = raw.get("source_sha256") or raw.get("original_sha256")
        if expected_source_hash and sha256_text(source) != str(expected_source_hash):
            raise ValueError(f"{candidate_id} source hash mismatch")
        target_value = first_present(raw, ("target_method", "algorithm_method", "original_target_method"))
        if isinstance(target_value, Mapping):
            target_value = first_present(target_value, ("original", "name", "method"))
        cases = load_cases(raw, path.parent, candidate_id)
        result.append(
            Candidate(
                candidate_id=candidate_id,
                source=source,
                source_path=source_path,
                main_class=str(raw["main_class"]) if raw.get("main_class") else None,
                manifest_target_method=str(target_value) if target_value else None,
                cases=cases,
                metadata=raw,
            )
        )
    return result, metadata


def clean_subprocess_env() -> dict[str, str]:
    env = os.environ.copy()
    for variable in ("JAVA_TOOL_OPTIONS", "JDK_JAVA_OPTIONS", "_JAVA_OPTIONS", "CLASSPATH"):
        env.pop(variable, None)
    env.update({"LC_ALL": "C", "LANG": "C"})
    return env


def run_version(command: Path, scratch_root: Path) -> dict[str, Any]:
    scratch_root = require_local_write_path(scratch_root, "JDK version-check scratch root")
    scratch_root.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix="jdk17-version-", dir=scratch_root) as temp_name:
        temp = Path(temp_name)
        env = clean_subprocess_env()
        env.update({"TMPDIR": str(temp), "TMP": str(temp), "TEMP": str(temp), "HOME": str(temp)})
        if command.name == "javac":
            version_command = [
                str(command),
                f"-J-Djava.io.tmpdir={temp}",
                f"-J-Duser.home={temp}",
                "-J-XX:-UsePerfData",
                "-version",
            ]
        else:
            version_command = [
                str(command),
                f"-Djava.io.tmpdir={temp}",
                f"-Duser.home={temp}",
                "-XX:-UsePerfData",
                "-version",
            ]
        process = subprocess.run(
            version_command,
            stdin=subprocess.DEVNULL,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            text=True,
            timeout=15,
            check=False,
            env=env,
        )
    rendered = (process.stdout + "\n" + process.stderr).strip()
    match = re.search(r'\bversion\s+"?(\d+)(?:\.|"|\s|$)|\bjavac\s+(\d+)', rendered)
    major = int(next(group for group in match.groups() if group)) if match else None
    return {"path": str(command), "returncode": process.returncode, "version": rendered, "major": major}


def validate_jdk17(java_home: Path, scratch_root: Path) -> tuple[Path, Path, dict[str, Any]]:
    javac = (java_home / "bin" / "javac").resolve()
    java = (java_home / "bin" / "java").resolve()
    if not javac.is_file() or not java.is_file():
        raise FileNotFoundError(f"JDK tools not found below {java_home}")
    javac_info = run_version(javac, scratch_root)
    java_info = run_version(java, scratch_root)
    if javac_info["returncode"] != 0 or java_info["returncode"] != 0:
        raise RuntimeError("Could not execute requested JDK")
    if javac_info["major"] != 17 or java_info["major"] != 17:
        raise RuntimeError(f"JDK 17 required, got javac={javac_info['major']} java={java_info['major']}")
    return javac, java, {"java_home": str(java_home.resolve()), "javac": javac_info, "java": java_info}


def tree_hashes(root: Path) -> dict[str, str]:
    return {
        str(path.relative_to(root)): sha256_file(path)
        for path in sorted(root.rglob("*"))
        if path.is_file()
    }


def copy_profile_snapshot(eyetracking_root: Path, output_root: Path) -> tuple[Path, dict[str, str]]:
    source = eyetracking_root / "obfuscation" / "profiles"
    if not source.is_dir():
        raise FileNotFoundError(f"Canonical profile directory not found: {source}")
    config_root = output_root / "provenance" / "eyetracking_obfuscation_config"
    destination = config_root / "profiles"
    source_hashes = tree_hashes(source)
    if destination.exists():
        destination_hashes = tree_hashes(destination)
        if destination_hashes != source_hashes:
            raise RuntimeError(
                f"Existing local profile snapshot differs from canonical profiles: {destination}. "
                "Use --overwrite to create a fresh artifact."
            )
    else:
        destination.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(source, destination)
    return config_root, source_hashes


def git_revision(root: Path) -> str | None:
    process = subprocess.run(
        ["git", "-C", str(root), "rev-parse", "HEAD"],
        stdin=subprocess.DEVNULL,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        text=True,
        timeout=15,
        check=False,
    )
    return process.stdout.strip() if process.returncode == 0 else None


def import_obfuscator(eyetracking_root: Path) -> dict[str, Any]:
    root = eyetracking_root.resolve()
    if str(root) not in sys.path:
        sys.path.insert(0, str(root))
    pipeline = importlib.import_module("obfuscation.core.pipeline")
    utils = importlib.import_module("obfuscation.java.passes.utils")
    module_path = Path(inspect.getfile(pipeline)).resolve()
    try:
        module_path.relative_to(root)
    except ValueError as exc:
        raise RuntimeError(f"Imported obfuscator from unexpected location: {module_path}") from exc
    return {
        "obfuscate_program": pipeline.obfuscate_program,
        "method_coverage_stats": utils.method_coverage_stats,
        "iter_method_blocks": utils.iter_method_blocks,
        "pipeline_path": module_path,
        "utils_path": Path(inspect.getfile(utils)).resolve(),
    }


def import_codesteer_selector() -> dict[str, Any]:
    if str(PROJECT_ROOT) not in sys.path:
        sys.path.insert(0, str(PROJECT_ROOT))
    priors = importlib.import_module("steering.priors")
    return {
        "PriorContext": priors.PriorContext,
        "SlicingHybridPrior": priors.SlicingHybridPrior,
        "SlicingPrior": priors.SlicingPrior,
        "source_path": Path(inspect.getfile(priors)).resolve(),
        "selector_sha256": sha256_text(inspect.getsource(priors.SlicingPrior._select_target_method)),
    }


def java_type_text(node: Any) -> str | None:
    if node is None:
        return None
    name = getattr(node, "name", None)
    dimensions = getattr(node, "dimensions", None) or []
    arguments = getattr(node, "arguments", None) or []
    rendered = str(name or type(node).__name__)
    if arguments:
        rendered += "<...>"
    rendered += "[]" * len(dimensions)
    return rendered


def analyze_codesteer_target(source: str, selector_api: Mapping[str, Any]) -> dict[str, Any]:
    context = selector_api["PriorContext"](
        prompt_tokens=[], code_text=source, vocab_tokens=[], prompt_text=""
    )
    prior = selector_api["SlicingHybridPrior"](context)
    javalang_mod = prior._try_import()
    if javalang_mod is None:
        raise RuntimeError("CodeSteer could not import javalang")
    parsed_source, tokens, tree = prior._prepare_parse_artifacts(javalang_mod)
    if tree is None or not tokens:
        raise RuntimeError("CodeSteer could not parse Java source")
    target = prior._select_target_method(tree, javalang_mod)
    if target is None:
        raise RuntimeError("CodeSteer did not select a target method")
    methods = [node for _, node in tree.filter(javalang_mod.tree.MethodDeclaration)]
    main = next((method for method in methods if getattr(method, "name", None) == "main"), None)
    called_from_main: set[str] = set()
    if main is not None:
        for _, invocation in main.filter(javalang_mod.tree.MethodInvocation):
            member = getattr(invocation, "member", None)
            if member:
                called_from_main.add(str(member))
    return_nodes = [node for _, node in target.filter(javalang_mod.tree.ReturnStatement)]
    genuine_return_nodes = [node for node in return_nodes if getattr(node, "expression", None) is not None]
    parameters = list(getattr(target, "parameters", []) or [])
    position = getattr(target, "position", None)
    target_name = str(getattr(target, "name", "") or "")
    result = {
        "selector": "steering.priors.SlicingHybridPrior._select_target_method",
        "selector_implementation_owner": "steering.priors.SlicingPrior",
        "selector_source_sha256": selector_api["selector_sha256"],
        "parse_status": "javalang" if parsed_source == source else "javalang_sanitized",
        "selected_method": target_name,
        "selected_method_line": int(position.line) if position is not None else None,
        "parameter_count": len(parameters),
        "parameters": [
            {"name": str(getattr(param, "name", "") or ""), "type": java_type_text(getattr(param, "type", None))}
            for param in parameters
        ],
        "return_type": java_type_text(getattr(target, "return_type", None)),
        "return_sink_count": len(return_nodes),
        "genuine_return_sink_count": len(genuine_return_nodes),
        "called_directly_from_main": target_name in called_from_main,
        "main_called_method_names": sorted(called_from_main),
        "method_names": [str(getattr(method, "name", "") or "") for method in methods],
    }
    result["eligible_parameter_to_return_target"] = bool(
        result["parameter_count"] > 0
        and result["return_type"] is not None
        and result["genuine_return_sink_count"] > 0
        and result["called_directly_from_main"]
    )
    return result


def selected_target_touch_evidence(
    *,
    original_source: str,
    obfuscated_source: str,
    original_target_method: str,
    obfuscated_target_method: str,
    original_target_line: int | None,
    obfuscated_target_line: int | None,
    iter_method_blocks: Any,
) -> dict[str, Any]:
    """Compare the exact selected algorithm method before and after the pass.

    The canonical coverage helper compares method blocks by source order.  We
    use the same blocks for reproducibility, but identify the original target
    by its exact CodeSteer-selected name and retain the concrete before/after
    hashes as auditable evidence.  This is intentionally separate from
    ``main_touched``: the helper's regex does not recognize method declarations
    with a ``throws`` clause between ``)`` and ``{``.
    """

    before_blocks = list(iter_method_blocks(original_source))
    after_blocks = list(iter_method_blocks(obfuscated_source))
    def block_line(source: str, block: Any) -> int:
        return source.count("\n", 0, int(block.start)) + 1

    before_matches = [
        (index, block)
        for index, block in enumerate(before_blocks)
        if str(block.name) == original_target_method
    ]
    after_matches = [
        (index, block)
        for index, block in enumerate(after_blocks)
        if str(block.name) == obfuscated_target_method
    ]
    if original_target_line is not None:
        line_matches = [
            pair for pair in before_matches if block_line(original_source, pair[1]) == original_target_line
        ]
        if line_matches:
            before_matches = line_matches
    if obfuscated_target_line is not None:
        line_matches = [
            pair for pair in after_matches if block_line(obfuscated_source, pair[1]) == obfuscated_target_line
        ]
        if line_matches:
            after_matches = line_matches
    evidence: dict[str, Any] = {
        "method_block_parser": "eyetracking.obfuscation.java.passes.utils.iter_method_blocks",
        "original_target_method": original_target_method,
        "obfuscated_target_method": obfuscated_target_method,
        "original_target_line": original_target_line,
        "obfuscated_target_line": obfuscated_target_line,
        "original_match_count": len(before_matches),
        "obfuscated_match_count": len(after_matches),
        "verifiable": False,
        "touched": False,
    }
    if len(before_matches) != 1:
        evidence["reason"] = "original_target_block_not_unique"
        return evidence
    if len(after_matches) != 1:
        evidence["reason"] = "obfuscated_target_block_not_unique"
        return evidence
    original_index, before = before_matches[0]
    obfuscated_index, after = after_matches[0]
    before_text = original_source[before.start : before.end + 1]
    after_text = obfuscated_source[after.start : after.end + 1]
    evidence.update(
        {
            "verifiable": True,
            "original_method_index": original_index,
            "obfuscated_method_index": obfuscated_index,
            "original_method_start_line": block_line(original_source, before),
            "obfuscated_method_start_line": block_line(obfuscated_source, after),
            "original_block_name": str(before.name),
            "obfuscated_block_name": str(after.name),
            "obfuscated_name_matches_codesteer_target": str(after.name) == obfuscated_target_method,
            "original_method_sha256": sha256_text(before_text),
            "obfuscated_method_sha256": sha256_text(after_text),
            "original_method_bytes": len(before_text.encode("utf-8")),
            "obfuscated_method_bytes": len(after_text.encode("utf-8")),
            "touched": before_text != after_text,
            "reason": "method_source_changed" if before_text != after_text else "method_source_unchanged",
        }
    )
    return evidence


def infer_java_entry(source: str, explicit_main_class: str | None = None) -> dict[str, str]:
    import javalang

    try:
        tree = javalang.parse.parse(source)
        package = str(getattr(getattr(tree, "package", None), "name", "") or "")
        main_classes: list[str] = []
        for path, method in tree.filter(javalang.tree.MethodDeclaration):
            if getattr(method, "name", None) != "main" or "static" not in (getattr(method, "modifiers", set()) or set()):
                continue
            owner = next(
                (
                    node
                    for node in reversed(path)
                    if isinstance(node, (javalang.tree.ClassDeclaration, javalang.tree.EnumDeclaration))
                ),
                None,
            )
            if owner is not None:
                main_classes.append(str(owner.name))
        public_types = [
            str(node.name)
            for node in getattr(tree, "types", []) or []
            if "public" in (getattr(node, "modifiers", set()) or set())
        ]
        explicit_simple = str(explicit_main_class or "").rsplit(".", 1)[-1]
        if explicit_simple and explicit_simple in main_classes:
            runtime_simple = explicit_simple
        elif len(set(main_classes)) == 1:
            runtime_simple = main_classes[0]
        else:
            raise ValueError(f"Expected exactly one class containing static main, got {main_classes}")
        compile_simple = public_types[0] if public_types else runtime_simple
        if len(public_types) > 1:
            raise ValueError(f"Multiple public top-level Java types: {public_types}")
        qualified = f"{package}.{runtime_simple}" if package else runtime_simple
        return {
            "compile_class": compile_simple,
            "main_class": qualified,
            "package": package,
            "parse_status": "javalang",
        }
    except Exception as exc:
        package_match = re.search(r"(?m)^\s*package\s+([A-Za-z_$][\w$]*(?:\.[A-Za-z_$][\w$]*)*)\s*;", source)
        package = package_match.group(1) if package_match else ""
        public_match = re.search(r"\bpublic\s+(?:final\s+|abstract\s+)?class\s+([A-Za-z_$][\w$]*)", source)
        explicit_simple = str(explicit_main_class or "").rsplit(".", 1)[-1]
        runtime_simple = explicit_simple or (public_match.group(1) if public_match else "")
        if not runtime_simple:
            raise ValueError(f"Could not infer Java entry class ({type(exc).__name__}: {exc})") from exc
        compile_simple = public_match.group(1) if public_match else runtime_simple
        qualified = f"{package}.{runtime_simple}" if package and "." not in str(explicit_main_class or "") else (
            str(explicit_main_class) if explicit_main_class else runtime_simple
        )
        return {
            "compile_class": compile_simple,
            "main_class": qualified,
            "package": package,
            "parse_status": f"regex_fallback:{type(exc).__name__}",
        }


def decode_utf8(payload: bytes, label: str) -> str:
    try:
        return payload.decode("utf-8", "strict")
    except UnicodeDecodeError as exc:
        raise ValueError(f"{label} was not valid UTF-8") from exc


def run_java_suite(
    *,
    source: str,
    explicit_main_class: str | None,
    cases: Sequence[IOCase],
    javac: Path,
    java: Path,
    timeout_seconds: float,
    compile_timeout_seconds: float,
    scratch_root: Path,
) -> dict[str, Any]:
    entry = infer_java_entry(source, explicit_main_class)
    scratch_root = require_local_write_path(scratch_root, "Java compiler scratch root")
    scratch_root.mkdir(parents=True, exist_ok=True)
    with tempfile.TemporaryDirectory(prefix="jdk17-", dir=scratch_root) as temp_name:
        temp = Path(temp_name)
        env = clean_subprocess_env()
        env.update({"TMPDIR": str(temp), "TMP": str(temp), "TEMP": str(temp), "HOME": str(temp)})
        classes = temp / "classes"
        classes.mkdir()

        def recorded_command(parts: Sequence[str]) -> list[str]:
            rendered: list[str] = []
            for index, part in enumerate(parts):
                value = Path(part).name if index == 0 else str(part)
                value = value.replace(str(classes), "<classes>").replace(str(temp), "<scratch>")
                rendered.append(value)
            return rendered

        source_path = temp / f"{entry['compile_class']}.java"
        source_path.write_text(source, encoding="utf-8")
        compile_command = [
            str(javac),
            "-encoding",
            "UTF-8",
            f"-J-Djava.io.tmpdir={temp}",
            f"-J-Duser.home={temp}",
            "-J-XX:-UsePerfData",
            "-Xlint:none",
            "-nowarn",
            "-d",
            str(classes),
            str(source_path),
        ]
        try:
            compiled = subprocess.run(
                compile_command,
                cwd=temp,
                env=env,
                stdin=subprocess.DEVNULL,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                timeout=compile_timeout_seconds,
                check=False,
            )
            compile_timed_out = False
        except subprocess.TimeoutExpired as exc:
            compiled = None
            compile_timed_out = True
            compile_stdout = exc.stdout or b""
            compile_stderr = exc.stderr or b""
        else:
            compile_stdout = compiled.stdout
            compile_stderr = compiled.stderr
        compile_result = {
            "command": recorded_command(compile_command),
            "timed_out": compile_timed_out,
            "exit_code": compiled.returncode if compiled is not None else None,
            "stdout": decode_utf8(compile_stdout, "javac stdout"),
            "stderr": decode_utf8(compile_stderr, "javac stderr"),
            "raw_stdout_sha256": sha256_bytes(compile_stdout),
            "raw_stderr_sha256": sha256_bytes(compile_stderr),
        }
        compile_result["accepted"] = bool(
            not compile_result["timed_out"]
            and compile_result["exit_code"] == 0
            and not compile_result["stdout"]
            and not compile_result["stderr"]
        )
        result: dict[str, Any] = {
            "entry": entry,
            "compile": compile_result,
            "cases": [],
            "accepted": False,
        }
        if not compile_result["accepted"]:
            return result

        for case in cases:
            command = [
                str(java),
                "-Dfile.encoding=UTF-8",
                f"-Djava.io.tmpdir={temp}",
                f"-Duser.home={temp}",
                "-XX:-UsePerfData",
                "-cp",
                str(classes),
                entry["main_class"],
                *case.argv,
            ]
            start = time.monotonic()
            try:
                executed = subprocess.run(
                    command,
                    cwd=temp,
                    env=env,
                    input=case.stdin.encode("utf-8"),
                    stdout=subprocess.PIPE,
                    stderr=subprocess.PIPE,
                    timeout=timeout_seconds,
                    check=False,
                )
                timed_out = False
                stdout_bytes = executed.stdout
                stderr_bytes = executed.stderr
                exit_code = executed.returncode
            except subprocess.TimeoutExpired as exc:
                timed_out = True
                stdout_bytes = exc.stdout or b""
                stderr_bytes = exc.stderr or b""
                exit_code = None
            duration = time.monotonic() - start
            stdout = decode_utf8(stdout_bytes, f"{case.case_id} stdout")
            stderr = decode_utf8(stderr_bytes, f"{case.case_id} stderr")
            expected_trimmed = trim_stdout(case.expected_stdout)
            actual_trimmed = trim_stdout(stdout)
            accepted = bool(
                not timed_out
                and exit_code == 0
                and stderr == ""
                and actual_trimmed == expected_trimmed
            )
            result["cases"].append(
                {
                    "case_id": case.case_id,
                    "command": recorded_command(command),
                    "timed_out": timed_out,
                    "exit_code": exit_code,
                    "duration_seconds": round(duration, 6),
                    "stderr": stderr,
                    "raw_stderr_sha256": sha256_bytes(stderr_bytes),
                    "stdout": stdout,
                    "raw_stdout_sha256": sha256_bytes(stdout_bytes),
                    "raw_expected_stdout_sha256": sha256_text(case.expected_stdout),
                    "actual_trimmed": actual_trimmed,
                    "expected_trimmed": expected_trimmed,
                    "trimmed_exact_match": actual_trimmed == expected_trimmed,
                    "accepted": accepted,
                }
            )
        result["accepted"] = bool(result["cases"] and all(row["accepted"] for row in result["cases"]))
        return result


def rejection_reasons_for_execution(prefix: str, validation: Mapping[str, Any]) -> list[str]:
    reasons: list[str] = []
    compile_result = validation.get("compile", {})
    if compile_result.get("timed_out"):
        reasons.append(f"{prefix}_compile_timeout")
    elif compile_result.get("exit_code") != 0:
        reasons.append(f"{prefix}_compile_nonzero")
    if compile_result.get("stdout"):
        reasons.append(f"{prefix}_compile_stdout")
    if compile_result.get("stderr"):
        reasons.append(f"{prefix}_compile_stderr")
    for case in validation.get("cases", []) or []:
        suffix = str(case.get("case_id", "unknown"))
        if case.get("timed_out"):
            reasons.append(f"{prefix}_runtime_timeout:{suffix}")
        elif case.get("exit_code") != 0:
            reasons.append(f"{prefix}_runtime_nonzero:{suffix}")
        if case.get("stderr"):
            reasons.append(f"{prefix}_runtime_stderr:{suffix}")
        if not case.get("trimmed_exact_match"):
            reasons.append(f"{prefix}_trimmed_output_mismatch:{suffix}")
    return reasons


def relative_to_output(path: Path, output_root: Path) -> str:
    return str(path.resolve().relative_to(output_root.resolve()))


def case_manifest_rows(cases: Sequence[IOCase]) -> list[dict[str, Any]]:
    return [
        {
            "case_id": case.case_id,
            "stdin": case.stdin,
            "input": case.stdin,
            "input_sha256": sha256_text(case.stdin),
            "expected_stdout": case.expected_stdout,
            "expected_output": case.expected_stdout,
            "raw_expected_stdout_sha256": sha256_text(case.expected_stdout),
            "expected_stdout_trimmed": trim_stdout(case.expected_stdout),
            "argv": list(case.argv),
            "source_case_metadata": without_legacy_output_score_labels(case.metadata),
        }
        for case in cases
    ]


def write_jsonl(path: Path, rows: Iterable[Mapping[str, Any]]) -> None:
    rendered = "".join(
        json.dumps(row, ensure_ascii=False, sort_keys=True, default=json_default) + "\n" for row in rows
    )
    atomic_write_text(path, rendered)


def prepare(args: argparse.Namespace) -> int:
    manifest_path = args.manifest.expanduser().resolve()
    if not manifest_path.is_file():
        raise FileNotFoundError(f"Candidate manifest not found: {manifest_path}")
    output_root = require_local_write_path(args.output_root, "--output-root")
    if output_root == WORK_ROOT:
        raise ValueError("--output-root may not be the workspace root itself")
    if output_root.exists() and args.overwrite:
        shutil.rmtree(output_root)
    output_root.mkdir(parents=True, exist_ok=True)
    scratch_root = require_local_write_path(output_root / ".scratch", "Java compiler scratch root")

    techniques = [part.strip().upper() for part in args.techniques.split(",") if part.strip()]
    if not techniques:
        raise ValueError("At least one technique is required")
    unsupported = sorted(set(techniques) - set(SUPPORTED_TECHNIQUES))
    if unsupported:
        raise ValueError(f"Unsupported techniques {unsupported}; choose from {sorted(SUPPORTED_TECHNIQUES)}")
    techniques = list(dict.fromkeys(techniques))
    if args.seed != 1:
        raise ValueError("This protocol requires canonical seed 1")

    java_home = args.java_home.expanduser().resolve()
    javac, java, jdk_info = validate_jdk17(java_home, scratch_root)
    eyetracking_root = args.eyetracking_root.expanduser().resolve()
    obfuscator = import_obfuscator(eyetracking_root)
    selector_api = import_codesteer_selector()
    local_config_root, profile_hashes = copy_profile_snapshot(eyetracking_root, output_root)
    candidates, manifest_metadata = load_candidates(manifest_path)

    provenance = {
        "schema_version": SCHEMA_VERSION,
        "preparation_script": str(Path(__file__).resolve()),
        "preparation_script_sha256": sha256_file(Path(__file__).resolve()),
        "candidate_manifest": str(manifest_path),
        "candidate_manifest_sha256": sha256_file(manifest_path),
        "candidate_manifest_metadata": without_legacy_output_score_labels(manifest_metadata),
        "eyetracking_root_read_only": str(eyetracking_root),
        "eyetracking_git_revision": git_revision(eyetracking_root),
        "obfuscator_pipeline_path": str(obfuscator["pipeline_path"]),
        "obfuscator_pipeline_sha256": sha256_file(obfuscator["pipeline_path"]),
        "obfuscator_utils_path": str(obfuscator["utils_path"]),
        "obfuscator_utils_sha256": sha256_file(obfuscator["utils_path"]),
        "local_config_root": relative_to_output(local_config_root, output_root),
        "profile_hashes": profile_hashes,
        "codesteer_selector_source": str(selector_api["source_path"]),
        "codesteer_selector_file_sha256": sha256_file(selector_api["source_path"]),
        "codesteer_selector_function_sha256": selector_api["selector_sha256"],
        "jdk": jdk_info,
        "configuration": {
            "language": "java",
            "profile": "safe",
            "mode": "technique",
            "level_config": "level0",
            "difficulty": "easy",
            "seed": args.seed,
            "method_coverage_policy": "force_all",
            "techniques": techniques,
            "runtime_timeout_seconds": args.timeout_seconds,
            "compile_timeout_seconds": args.compile_timeout_seconds,
            "output_comparator": "trimmed_exact_match",
            "output_comparator_definition": "actual.replace(CRLF, LF).strip() == expected.replace(CRLF, LF).strip()",
            "internal_spaces_and_newlines_are_significant": True,
            "compile_requires_empty_stdout_stderr": True,
            "runtime_requires_exit_zero_no_timeout_empty_stderr": True,
            "temporary_write_policy": (
                "Python TemporaryDirectory, TMPDIR/TMP/TEMP/HOME, java.io.tmpdir, and JVM perf-data "
                "settings keep JDK version checks plus compiler/runtime scratch writes below "
                "prepared_variants/.scratch; "
                "external Python bytecode generation is disabled."
            ),
            "coverage_accounting_caveat": (
                "The canonical iter_method_blocks regex does not recognize declarations with a "
                "throws clause between ')' and '{'. Therefore main_touched is recorded as a warning, "
                "not an eligibility gate; the exact CodeSteer-selected target method must be verifiably changed."
            ),
        },
    }
    atomic_write_json(output_root / "provenance" / "preparation_provenance.json", provenance)

    eligible: list[dict[str, Any]] = []
    all_variants: list[dict[str, Any]] = []
    rejections: list[dict[str, Any]] = []
    original_cache: dict[str, dict[str, Any]] = {}

    for candidate_index, candidate in enumerate(candidates, start=1):
        print(
            f"[prepare] candidate {candidate_index}/{len(candidates)} {candidate.candidate_id}",
            flush=True,
        )
        candidate_root = output_root / "candidates" / candidate.candidate_id
        try:
            original_entry = infer_java_entry(candidate.source, candidate.main_class)
            original_source_path = candidate_root / "original" / f"{original_entry['compile_class']}.java"
            atomic_write_text(original_source_path, candidate.source)
            original_target = analyze_codesteer_target(candidate.source, selector_api)
            original_validation = run_java_suite(
                source=candidate.source,
                explicit_main_class=candidate.main_class,
                cases=candidate.cases,
                javac=javac,
                java=java,
                timeout_seconds=args.timeout_seconds,
                compile_timeout_seconds=args.compile_timeout_seconds,
                scratch_root=scratch_root,
            )
            original_record = {
                "source_path": relative_to_output(original_source_path, output_root),
                "source_sha256": sha256_text(candidate.source),
                "physical_loc": len(candidate.source.splitlines()),
                "entry": original_entry,
                "codesteer_target": original_target,
                "execution_validation": original_validation,
            }
            atomic_write_json(candidate_root / "original" / "validation.json", original_record)
            original_cache[candidate.candidate_id] = original_record
        except Exception as exc:
            rejection = {
                "candidate_id": candidate.candidate_id,
                "stage": "original_prevalidation",
                "reasons": [f"original_prevalidation_exception:{type(exc).__name__}"],
                "error": str(exc),
            }
            rejections.append(rejection)
            print(f"[prepare] reject {candidate.candidate_id}: {rejection['reasons'][0]} {exc}", flush=True)
            continue

        original_reasons = rejection_reasons_for_execution("original", original_validation)
        if not original_target["eligible_parameter_to_return_target"]:
            original_reasons.append("original_codesteer_target_not_parameter_to_return_main_call")
        if (
            candidate.manifest_target_method
            and original_target["selected_method"] != candidate.manifest_target_method
        ):
            original_reasons.append("manifest_target_differs_from_codesteer_selector")
        if original_reasons:
            rejections.append(
                {
                    "candidate_id": candidate.candidate_id,
                    "stage": "original_prevalidation",
                    "reasons": sorted(set(original_reasons)),
                    "manifest_target_method": candidate.manifest_target_method,
                    "codesteer_target_method": original_target["selected_method"],
                    "original_validation_path": relative_to_output(
                        candidate_root / "original" / "validation.json", output_root
                    ),
                }
            )
            print(
                f"[prepare] reject {candidate.candidate_id} original: {', '.join(sorted(set(original_reasons)))}",
                flush=True,
            )
            continue

        for technique in techniques:
            variant_id = f"{candidate.candidate_id}__{technique.lower()}_easy_seed{args.seed}"
            variant_root = (
                candidate_root
                / "variants"
                / f"{technique}_{SUPPORTED_TECHNIQUES[technique]}"
                / "easy"
                / f"seed_{args.seed}"
            )
            print(f"[prepare] obfuscate {variant_id}", flush=True)
            try:
                obfuscation_result = obfuscator["obfuscate_program"](
                    source=candidate.source,
                    language="java",
                    profile="safe",
                    seed=args.seed,
                    mode="technique",
                    level="level0",
                    technique=technique,
                    difficulty="easy",
                    program_id=candidate.candidate_id,
                    config_root=local_config_root,
                    method_coverage_policy="force_all",
                )
                obfuscated_source = str(obfuscation_result.source)
                coverage = obfuscator["method_coverage_stats"](
                    original_source=candidate.source,
                    transformed_source=obfuscated_source,
                )
                obfuscated_entry = infer_java_entry(obfuscated_source, None)
                obfuscated_source_path = variant_root / f"{obfuscated_entry['compile_class']}.java"
                atomic_write_text(obfuscated_source_path, obfuscated_source)
                obfuscated_target = analyze_codesteer_target(obfuscated_source, selector_api)
                target_touch = selected_target_touch_evidence(
                    original_source=candidate.source,
                    obfuscated_source=obfuscated_source,
                    original_target_method=original_target["selected_method"],
                    obfuscated_target_method=obfuscated_target["selected_method"],
                    original_target_line=original_target.get("selected_method_line"),
                    obfuscated_target_line=obfuscated_target.get("selected_method_line"),
                    iter_method_blocks=obfuscator["iter_method_blocks"],
                )
                obfuscated_validation = run_java_suite(
                    source=obfuscated_source,
                    explicit_main_class=obfuscated_entry["main_class"],
                    cases=candidate.cases,
                    javac=javac,
                    java=java,
                    timeout_seconds=args.timeout_seconds,
                    compile_timeout_seconds=args.compile_timeout_seconds,
                    scratch_root=scratch_root,
                )
                metadata = dataclasses.asdict(obfuscation_result.metadata)
                metadata.update(
                    {
                        "requested_seed": args.seed,
                        "requested_profile": "safe",
                        "requested_difficulty": "easy",
                        "requested_method_coverage_policy": "force_all",
                        "original_source_sha256": sha256_text(candidate.source),
                        "obfuscated_source_sha256": sha256_text(obfuscated_source),
                        "method_coverage": coverage,
                        "codesteer_target": obfuscated_target,
                        "selected_target_touch_evidence": target_touch,
                        "jdk17_execution_validation": obfuscated_validation,
                    }
                )
                metadata_path = obfuscated_source_path.with_suffix(".java.meta.json")
                atomic_write_json(metadata_path, metadata)
            except Exception as exc:
                rejection = {
                    "candidate_id": candidate.candidate_id,
                    "variant_id": variant_id,
                    "technique": technique,
                    "stage": "obfuscation_or_validation",
                    "reasons": [f"obfuscation_or_validation_exception:{type(exc).__name__}"],
                    "error": str(exc),
                }
                rejections.append(rejection)
                all_variants.append(dict(rejection, eligible=False))
                print(f"[prepare] reject {variant_id}: {rejection['reasons'][0]} {exc}", flush=True)
                continue

            coverage_total = int(coverage.get("method_coverage_total", 0) or 0)
            coverage_touched = int(coverage.get("method_coverage_touched", 0) or 0)
            main_touched = bool(coverage.get("main_touched", False))
            reasons = rejection_reasons_for_execution("obfuscated", obfuscated_validation)
            warnings: list[str] = []
            if obfuscated_source == candidate.source:
                reasons.append("obfuscated_source_unchanged")
            if coverage_total <= 0 or coverage_touched != coverage_total:
                reasons.append("force_all_method_coverage_incomplete")
            if not main_touched:
                warnings.append("canonical_main_touched_unobserved_regex_may_not_parse_throws_clause")
            if not target_touch.get("verifiable"):
                reasons.append("selected_target_touch_unverifiable")
            elif not target_touch.get("touched"):
                reasons.append("selected_target_method_unchanged")
            if (
                target_touch.get("verifiable")
                and not target_touch.get("obfuscated_name_matches_codesteer_target")
            ):
                reasons.append("transformed_target_block_differs_from_codesteer_selection")
            if not obfuscated_target["eligible_parameter_to_return_target"]:
                reasons.append("obfuscated_codesteer_target_not_parameter_to_return_main_call")

            pass_rows = metadata.get("passes_applied", []) or []
            selected_passes = [row for row in pass_rows if row.get("name") == technique]
            if not selected_passes or not any(row.get("applied") for row in selected_passes):
                reasons.append("selected_obfuscation_pass_not_applied")

            case_rows = case_manifest_rows(candidate.cases)
            first_case = case_rows[0]
            variant_record = {
                "id": variant_id,
                "variant_id": variant_id,
                "candidate_id": candidate.candidate_id,
                "technique": technique,
                "technique_name": SUPPORTED_TECHNIQUES[technique],
                "profile": "safe",
                "difficulty": "easy",
                "seed": args.seed,
                "method_coverage_policy": "force_all",
                "eligible": not reasons,
                "rejection_reasons": sorted(set(reasons)),
                "warnings": sorted(set(warnings)),
                "original_path": original_record["source_path"],
                "obfuscated_path": relative_to_output(obfuscated_source_path, output_root),
                "obfuscation_metadata_path": relative_to_output(metadata_path, output_root),
                "original_target_method": original_target["selected_method"],
                "obfuscated_target_method": obfuscated_target["selected_method"],
                "codesteer_target_method": obfuscated_target["selected_method"],
                "target_method": {
                    "original": original_target["selected_method"],
                    "obfuscated": obfuscated_target["selected_method"],
                },
                "main_class": original_record["entry"]["main_class"],
                "original_main_class": original_record["entry"]["main_class"],
                "obfuscated_main_class": obfuscated_entry["main_class"],
                "stdin": first_case["stdin"],
                "input": first_case["input"],
                "expected_stdout": first_case["expected_stdout"],
                "expected_output": first_case["expected_output"],
                "cases": case_rows,
                "original": {
                    "path": original_record["source_path"],
                    "sha256": original_record["source_sha256"],
                    "main_class": original_record["entry"]["main_class"],
                    "target_method": original_target["selected_method"],
                    "codesteer_target": original_target,
                    "execution_validation_path": relative_to_output(
                        candidate_root / "original" / "validation.json", output_root
                    ),
                },
                "obfuscated": {
                    "path": relative_to_output(obfuscated_source_path, output_root),
                    "sha256": sha256_text(obfuscated_source),
                    "main_class": obfuscated_entry["main_class"],
                    "target_method": obfuscated_target["selected_method"],
                    "codesteer_target": obfuscated_target,
                    "method_coverage": coverage,
                    "selected_target_touch_evidence": target_touch,
                    "execution_validation": obfuscated_validation,
                    "metadata_path": relative_to_output(metadata_path, output_root),
                },
                "candidate_metadata": without_legacy_output_score_labels(candidate.metadata),
            }
            atomic_write_json(variant_root / "variant_record.json", variant_record)
            all_variants.append(variant_record)
            if reasons:
                rejection = {
                    "candidate_id": candidate.candidate_id,
                    "variant_id": variant_id,
                    "technique": technique,
                    "stage": "variant_eligibility",
                    "reasons": sorted(set(reasons)),
                    "variant_record_path": relative_to_output(
                        variant_root / "variant_record.json", output_root
                    ),
                }
                rejections.append(rejection)
                print(f"[prepare] reject {variant_id}: {', '.join(sorted(set(reasons)))}", flush=True)
            else:
                eligible.append(variant_record)
                print(f"[prepare] eligible {variant_id}", flush=True)

    eligible_manifest = {
        "schema_version": SCHEMA_VERSION,
        "purpose": "JDK17-validated long-code obfuscation variants for paired model inference",
        "selection_stage": "static_and_execution_eligibility_only_no_model_outcomes",
        "coverage_accounting_caveat": (
            "The canonical main_touched field may be false when a valid main declaration contains "
            "a throws clause; eligibility instead requires direct before/after hashes proving that "
            "the exact CodeSteer-selected algorithm method changed."
        ),
        "provenance_path": "provenance/preparation_provenance.json",
        "variant_count": len(eligible),
        "variants": eligible,
    }
    atomic_write_json(output_root / "eligible_variants.json", eligible_manifest)
    atomic_write_json(
        output_root / "all_variant_attempts.json",
        {"schema_version": SCHEMA_VERSION, "variant_count": len(all_variants), "variants": all_variants},
    )
    write_jsonl(output_root / "rejections.jsonl", rejections)
    warning_counts: dict[str, int] = {}
    for variant in all_variants:
        for warning in variant.get("warnings", []) or []:
            warning_counts[str(warning)] = warning_counts.get(str(warning), 0) + 1
    summary = {
        "schema_version": SCHEMA_VERSION,
        "candidate_count": len(candidates),
        "requested_techniques": techniques,
        "possible_variant_count": len(candidates) * len(techniques),
        "attempted_variant_count": len(all_variants),
        "eligible_variant_count": len(eligible),
        "rejection_record_count": len(rejections),
        "warning_variant_count": sum(bool(variant.get("warnings")) for variant in all_variants),
        "warning_counts": warning_counts,
        "eligible_manifest": "eligible_variants.json",
        "all_variant_attempts": "all_variant_attempts.json",
        "rejection_log": "rejections.jsonl",
    }
    atomic_write_json(output_root / "summary.json", summary)
    if scratch_root.exists():
        shutil.rmtree(scratch_root)
    print(json.dumps(summary, indent=2, sort_keys=True), flush=True)
    return 0 if eligible else 2


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Prepare JDK17-validated safe/easy Java obfuscation variants without model inference."
    )
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT_ROOT)
    parser.add_argument("--eyetracking-root", type=Path, default=DEFAULT_EYETRACKING_ROOT)
    parser.add_argument("--java-home", type=Path, default=DEFAULT_JAVA_HOME)
    parser.add_argument(
        "--techniques",
        default="T5",
        help="Comma-separated subset of T1,T5,T6,T8 (default: T5 bogus control flow).",
    )
    parser.add_argument("--seed", type=int, default=1, help="Canonical protocol seed (must be 1).")
    parser.add_argument("--timeout-seconds", type=float, default=12.0)
    parser.add_argument("--compile-timeout-seconds", type=float, default=30.0)
    parser.add_argument("--overwrite", action="store_true")
    return parser


def main() -> None:
    raise SystemExit(prepare(build_parser().parse_args()))


if __name__ == "__main__":
    main()
