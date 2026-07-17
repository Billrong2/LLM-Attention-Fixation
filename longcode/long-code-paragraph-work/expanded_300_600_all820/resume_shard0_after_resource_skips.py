#!/usr/bin/env python3
"""Resume pinned shard 0 while consuming two exact registered resource skips.

The frozen study runner is imported without modification.  Its
``record_complete`` predicate is wrapped only for the two read-only skip
markers registered for the 11,025-token r038 obfuscated prompt.  No record,
score, model output, or canonical run directory is created for either skip.
Every other cell delegates to the frozen predicate unchanged.
"""

from __future__ import annotations

import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
from types import ModuleType
from typing import Any, Callable, Sequence


HERE = Path(__file__).resolve().parent
RUNNER_PATH = HERE / "run_shard.py"
REGISTER_PATH = HERE / "register_resource_skips.py"
PLAN_PATH = HERE / "launch_plan_model_eligible_t130.json"
SHARD_ROOT = HERE / "results" / "study" / "shard_0"
PROGRAM_ID = "cc-valid-r038-s0030__t5_easy_seed1"

RUNNER_SHA256 = "5c3c83e2f81ba645174b7ae6ad580ee21cd490bb72f1efbfc75ced80584da6cb"
REGISTER_SHA256 = "6354344dd322e172dfdef5b71735e6388401e25f8bfdc2967528f6be85349ad4"
PLAN_SHA256 = "41c7f61a5f1299fa6be1895700dff5f56a84512f4b809ce2261b3b0ef2279b25"
MARKER_SHA256 = {
    "obfuscated_plain": "54fb6321ff2a769ffcba3f99702defaf6366314359879b4668e87491b345f492",
    "obfuscated_codesteer": "750ef716df42d6e5b3728224b6b30cdeeb960187b46ed5531b5624c89a477ea5",
}
FINGERPRINTS = {
    "obfuscated_plain": "2ddb4eac4d9392f224b04e739a140846a058b96ff51ec42ee4aa6cdab10949ca",
    "obfuscated_codesteer": "dd52b8d2e28efccaa2f5c61fecfb7c2a80cd91c81e78f797499ab2ddfdef2ef5",
}


class ResumeError(RuntimeError):
    pass


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ResumeError(message)


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def read_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise ResumeError(f"invalid JSON {path}: {exc}") from exc


def load_module(name: str, path: Path) -> ModuleType:
    spec = importlib.util.spec_from_file_location(name, path)
    require(spec is not None and spec.loader is not None, f"cannot import {path}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def marker_dir(condition: str) -> Path:
    return SHARD_ROOT / "resource_skips" / PROGRAM_ID / "trial_001" / condition


def canonical_record(condition: str) -> Path:
    return SHARD_ROOT / "runs" / PROGRAM_ID / "trial_001" / condition / "record.json"


def validate_registered_markers() -> dict[str, dict[str, Any]]:
    require(sha256_file(REGISTER_PATH) == REGISTER_SHA256, "skip registrar SHA-256 differs")
    registrar = load_module("_expanded_resource_skip_registrar", REGISTER_PATH)
    registrar.verify_sources()
    observed = registrar.verify_existing()
    require(observed == MARKER_SHA256, "registered marker SHA-256 set differs")

    payloads: dict[str, dict[str, Any]] = {}
    expected_payloads = registrar.expected_payloads()
    for condition, expected_hash in MARKER_SHA256.items():
        directory = marker_dir(condition)
        marker = directory / "resource_skip.json"
        anchor = directory / "resource_skip.sha256"
        require(marker.is_file() and not marker.is_symlink(), f"missing marker: {condition}")
        require(sha256_file(marker) == expected_hash, f"marker hash differs: {condition}")
        require(
            anchor.read_text(encoding="utf-8") == f"{expected_hash}  resource_skip.json\n",
            f"marker anchor differs: {condition}",
        )
        payload = read_json(marker)
        require(payload == expected_payloads[condition], f"marker payload differs: {condition}")
        require(payload.get("fingerprint") == FINGERPRINTS[condition],
                f"marker fingerprint differs: {condition}")
        require(payload.get("contributes_completion") is False,
                f"marker completion policy differs: {condition}")
        require(payload.get("contributes_score") is False,
                f"marker score policy differs: {condition}")
        require(not canonical_record(condition).parent.exists(),
                f"canonical skipped run directory exists: {condition}")
        payloads[condition] = payload
    return payloads


def registered_runner_argv() -> list[str]:
    require(sha256_file(PLAN_PATH) == PLAN_SHA256, "launch-plan SHA-256 differs")
    require(sha256_file(RUNNER_PATH) == RUNNER_SHA256, "frozen runner SHA-256 differs")
    plan = read_json(PLAN_PATH)
    shards = [item for item in plan.get("shards", []) if item.get("shard_index") == 0]
    require(len(shards) == 1, "launch plan does not contain exactly one shard 0")
    argv = shards[0].get("study_argv")
    require(isinstance(argv, list) and all(isinstance(item, str) for item in argv),
            "registered shard-0 argv is invalid")
    require(len(argv) >= 3 and argv[0] == "python3", "registered Python launcher differs")
    require(Path(argv[1]).resolve(strict=True) == RUNNER_PATH,
            "registered runner path differs")
    require("--gpu-id" in argv and argv[argv.index("--gpu-id") + 1] == "0",
            "registered GPU differs")
    require("--output-root" in argv, "registered output root is absent")
    output = Path(argv[argv.index("--output-root") + 1]).resolve(strict=True)
    require(output == SHARD_ROOT, "registered output root differs")
    return argv[2:]


def install_skip_predicate(
    runner: ModuleType,
    payloads: dict[str, dict[str, Any]],
) -> tuple[set[str], Callable[[Path, str], bool]]:
    original = runner.record_complete
    exact_paths = {canonical_record(condition).resolve(strict=False): condition
                   for condition in MARKER_SHA256}
    consumed: set[str] = set()

    def wrapped(path: Path, fingerprint: str) -> bool:
        candidate = path.resolve(strict=False)
        condition = exact_paths.get(candidate)
        if condition is None:
            return original(path, fingerprint)
        require(not path.exists(), f"skipped cell unexpectedly has a record: {condition}")
        require(not path.parent.exists(), f"skipped cell unexpectedly has a run directory: {condition}")
        payload = payloads[condition]
        require(fingerprint == FINGERPRINTS[condition],
                f"runtime fingerprint differs for skipped cell: {condition}")
        require(payload.get("fingerprint") == fingerprint,
                f"marker/runtime fingerprint mismatch: {condition}")
        require(payload.get("program_id") == PROGRAM_ID, "marker program differs")
        require(payload.get("condition") == condition, "marker condition differs")
        require(payload.get("paired_seed") == 1006413233, "marker seed differs")
        consumed.add(condition)
        print(
            f"[resource-skip] {PROGRAM_ID} {condition} "
            f"disposition={payload['disposition']} fingerprint={fingerprint[:12]}",
            flush=True,
        )
        return True

    runner.record_complete = wrapped
    return consumed, original


def validate_postcondition(consumed: set[str]) -> None:
    require(consumed == set(MARKER_SHA256),
            f"runner did not consume the exact registered skips: {sorted(consumed)}")
    for condition in MARKER_SHA256:
        require(not canonical_record(condition).parent.exists(),
                f"runner created a canonical directory for skipped cell: {condition}")
        require(sha256_file(marker_dir(condition) / "resource_skip.json") == MARKER_SHA256[condition],
                f"runner changed marker: {condition}")


def check_only() -> None:
    payloads = validate_registered_markers()
    registered_runner_argv()
    runner = load_module("_expanded_frozen_shard_runner_check", RUNNER_PATH)
    consumed, original = install_skip_predicate(runner, payloads)
    try:
        for condition, fingerprint in FINGERPRINTS.items():
            require(runner.record_complete(canonical_record(condition), fingerprint),
                    f"registered skip was not recognized: {condition}")
        unrelated = SHARD_ROOT / "runs" / "unrelated" / "trial_001" / "original_plain" / "record.json"
        require(runner.record_complete(unrelated, "0" * 64) is False,
                "unrelated missing record was incorrectly skipped")
        validate_postcondition(consumed)
    finally:
        runner.record_complete = original


def run() -> int:
    require(os.environ.get("PYTORCH_CUDA_ALLOC_CONF") in (None, ""),
            "unregistered PYTORCH_CUDA_ALLOC_CONF is active")
    payloads = validate_registered_markers()
    argv = registered_runner_argv()
    runner = load_module("_expanded_frozen_shard_runner_resume", RUNNER_PATH)
    consumed, original = install_skip_predicate(runner, payloads)
    try:
        status = int(runner.main(argv))
        require(status == 0, f"frozen runner returned {status}")
        validate_postcondition(consumed)
        return status
    finally:
        runner.record_complete = original


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--check", action="store_true", help="validate without model inference")
    mode.add_argument("--run", action="store_true", help="resume the registered shard-0 study")
    args = parser.parse_args(argv)
    if args.check:
        check_only()
        print(json.dumps({
            "status": "validated",
            "model_inference_performed": False,
            "registered_skip_conditions": sorted(MARKER_SHA256),
        }, indent=2, sort_keys=True))
        return 0
    return run()


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except ResumeError as exc:
        print(f"REFUSED: {exc}", file=__import__("sys").stderr)
        raise SystemExit(2)
