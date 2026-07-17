#!/usr/bin/env python3
"""Run one frozen expansion shard through the proven v2 chat-template engine.

The adapter generalizes only cohort membership and paths.  It retains the
Qwen chat template, six-key all-or-nothing parser, three paired conditions,
CodeSteer L2, pinned checkpoint, one attempt, and no automatic retry.  The
registered expansion policy is one paired round at T=1.30.
"""

from __future__ import annotations

import argparse
import dataclasses
import hashlib
import importlib.util
import json
import os
import sys
import time
from pathlib import Path
from types import ModuleType
from typing import Any, Mapping, Sequence


sys.dont_write_bytecode = True
HERE = Path(__file__).resolve().parent
V2_PATH = HERE.parent / "binary_task" / "v2" / "run_binary_v2.py"
V2_SHA256 = "3c1cdd87a4d604763c9258e0654147c7a01f01521462c40a3522b70823f2cce5"
ENGINE_LIVENESS_PATH = HERE.parent / "binary_task" / "v2" / "high_temp_t130" / "results" / "liveness" / "liveness_summary.json"
ENGINE_LIVENESS_SHA256 = "4ef00416219b1a986eaf269ef545979449a6148d320ffd5a1a3b75c90dc9e429"
DEFAULT_MANIFEST = HERE / "frozen" / "inference_manifest.json"
DEFAULT_PLAN = HERE / "launch_plan.json"
PROTOCOL_VERSION = "expanded-java-300-600-qwen25-chat-t130-one-round-v1"
COHORT_TAG = "expanded-java-300-600-all-static-eligible"
BASE_SEED = 20260715
CONDITIONS = ("original_plain", "obfuscated_plain", "obfuscated_codesteer")
GENERATION = {
    "do_sample": True,
    "temperature": 1.30,
    "top_p": 0.95,
    "top_k": 50,
    "max_new_tokens": 192,
}


class RunError(RuntimeError):
    pass


def sha256_bytes(value: bytes) -> str:
    return hashlib.sha256(value).hexdigest()


def sha256_text(value: str) -> str:
    return sha256_bytes(value.encode("utf-8"))


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def atomic_json(path: Path, value: Any) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    temporary.write_text(
        json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True, default=str) + "\n",
        encoding="utf-8",
    )
    os.replace(temporary, path)


def atomic_text(path: Path, value: str) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    temporary.write_text(value, encoding="utf-8")
    os.replace(temporary, path)


def load_v2() -> ModuleType:
    if not V2_PATH.is_file() or sha256_file(V2_PATH) != V2_SHA256:
        raise RunError("the proven v2 chat-template runner changed")
    spec = importlib.util.spec_from_file_location("_expanded_binary_v2", V2_PATH)
    if spec is None or spec.loader is None:
        raise RunError(f"cannot import {V2_PATH}")
    module = importlib.util.module_from_spec(spec)
    sys.modules[spec.name] = module
    spec.loader.exec_module(module)
    return module


V2 = load_v2()


def validate_engine_liveness() -> dict[str, Any]:
    if not ENGINE_LIVENESS_PATH.is_file() or sha256_file(ENGINE_LIVENESS_PATH) != ENGINE_LIVENESS_SHA256:
        raise RunError("pinned T=1.30 chat-template liveness evidence changed")
    value = json.loads(ENGINE_LIVENESS_PATH.read_text(encoding="utf-8"))
    required = {
        "status": "passed",
        "generation": GENERATION,
        "response_pack_valid": True,
        "decoded_completion_nonempty": True,
        "first_generated_token_is_eos": False,
        "more_than_one_non_special_token": True,
        "study_generation_count": 0,
    }
    failed = [key for key, expected in required.items() if value.get(key) != expected]
    if failed:
        raise RunError(f"pinned T=1.30 liveness evidence is invalid: {failed}")
    return value


def local(path: Path, label: str, *, existing: bool) -> Path:
    candidate = path.expanduser()
    candidate = candidate if candidate.is_absolute() else HERE / candidate
    resolved = candidate.resolve(strict=existing)
    try:
        resolved.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise RunError(f"{label} must remain below {HERE}: {resolved}") from exc
    return resolved


def resolve_source(value: Any, root: Path, label: str) -> Path:
    if not isinstance(value, str) or not value:
        raise RunError(f"missing {label}")
    candidate = (root / value).resolve(strict=True)
    try:
        candidate.relative_to(root.resolve(strict=True))
    except ValueError as exc:
        raise RunError(f"{label} escapes frozen root: {candidate}") from exc
    if not candidate.is_file():
        raise RunError(f"{label} is not a file")
    return candidate


def load_manifest(path: Path) -> tuple[Path, dict[str, Any], tuple[Any, ...], str]:
    manifest = local(path, "manifest", existing=True)
    digest = sha256_file(manifest)
    anchor = manifest.with_suffix(".sha256")
    if not anchor.is_file() or anchor.read_text(encoding="utf-8").strip().split() != [digest, manifest.name]:
        raise RunError("manifest SHA-256 anchor is missing or stale")
    payload = json.loads(manifest.read_text(encoding="utf-8"))
    if not isinstance(payload, dict) or payload.get("schema_version") != "expanded-java-300-600-binary-freeze-v1":
        raise RunError("manifest schema differs")
    if payload.get("conditions") != list(CONDITIONS) or payload.get("generation") != GENERATION:
        raise RunError("conditions/sampling differ from the T=1.30 one-round protocol")
    rows = payload.get("programs")
    if not isinstance(rows, list) or not rows or payload.get("program_count") != len(rows):
        raise RunError("manifest program count is invalid")
    packs: list[Any] = []
    seen_programs: set[str] = set()
    seen_case_ids: set[str] = set()
    for raw_any in rows:
        if not isinstance(raw_any, Mapping):
            raise RunError("program row is not an object")
        raw = raw_any
        program_id = str(raw.get("id") or "")
        if not program_id or program_id in seen_programs:
            raise RunError("program IDs are empty or duplicated")
        seen_programs.add(program_id)
        original = resolve_source(raw.get("original_path"), manifest.parent, f"{program_id}/original")
        obfuscated = resolve_source(raw.get("obfuscated_path"), manifest.parent, f"{program_id}/obfuscated")
        if sha256_file(original) != raw.get("original_sha256") or sha256_file(obfuscated) != raw.get("obfuscated_sha256"):
            raise RunError(f"{program_id} source hash differs")
        original_loc = len(original.read_text(encoding="utf-8").splitlines())
        obfuscated_loc = len(obfuscated.read_text(encoding="utf-8").splitlines())
        if not 300 <= original_loc <= 600 or raw.get("original_physical_loc") != original_loc or raw.get("obfuscated_physical_loc") != obfuscated_loc:
            raise RunError(f"{program_id} LOC binding differs")
        cases_raw = raw.get("cases")
        if not isinstance(cases_raw, list) or len(cases_raw) != 6:
            raise RunError(f"{program_id} must have six cases")
        cases: list[Any] = []
        input_hashes: set[str] = set()
        labels: list[bool] = []
        for position, case_any in enumerate(cases_raw, 1):
            if not isinstance(case_any, Mapping):
                raise RunError(f"{program_id} case is not an object")
            case_id = str(case_any.get("id") or "")
            stdin = case_any.get("stdin")
            candidate = case_any.get("candidate_stdout")
            label = case_any.get("label")
            if (
                not case_id
                or case_id in seen_case_ids
                or case_any.get("pack_position") != position
                or not isinstance(stdin, str)
                or not isinstance(candidate, str)
                or type(label) is not bool
                or case_any.get("stdin_sha256") != sha256_text(stdin)
                or case_any.get("candidate_stdout_sha256") != sha256_text(candidate)
            ):
                raise RunError(f"malformed case {program_id}/{case_id or position}")
            input_hash = sha256_text(stdin)
            if input_hash in input_hashes:
                raise RunError(f"{program_id} repeats stdin")
            input_hashes.add(input_hash)
            seen_case_ids.add(case_id)
            labels.append(label)
            cases.append(V2.CaseView(case_id, position, stdin, candidate, label))
        if sum(labels) != 3:
            raise RunError(f"{program_id} must contain exactly 3T/3F")
        original_target = str(raw.get("original_target_method") or "")
        obfuscated_target = str(raw.get("obfuscated_target_method") or "")
        if not original_target or not obfuscated_target:
            raise RunError(f"{program_id} target method is missing")
        packs.append(
            V2.Pack(
                program_id=program_id,
                original_path=original,
                obfuscated_path=obfuscated,
                original_target_method=original_target,
                obfuscated_target_method=obfuscated_target,
                cases=tuple(cases),
                is_study=True,
            )
        )
    return manifest, payload, tuple(packs), digest


def selected_packs(packs: Sequence[Any], raw: str) -> tuple[Any, ...]:
    requested = [value.strip() for value in raw.split(",") if value.strip()]
    if not requested:
        return tuple(packs)
    if len(requested) != len(set(requested)):
        raise RunError("--program-ids contains duplicates")
    known = {pack.program_id for pack in packs}
    missing = sorted(set(requested) - known)
    if missing:
        raise RunError(f"unknown program IDs: {missing}")
    wanted = set(requested)
    return tuple(pack for pack in packs if pack.program_id in wanted)


def load_plan(path: Path, manifest: Path, manifest_sha: str) -> tuple[Path, dict[str, Any], str]:
    plan_path = local(path, "launch plan", existing=True)
    plan = json.loads(plan_path.read_text(encoding="utf-8"))
    if (
        not isinstance(plan, dict)
        or plan.get("schema_version") != "expanded-java-300-600-launch-plan-v1"
        or plan.get("manifest_sha256") != manifest_sha
        or Path(str(plan.get("manifest_path"))).resolve(strict=True) != manifest
        or plan.get("generation") != GENERATION
    ):
        raise RunError("launch plan is stale or belongs to another manifest")
    return plan_path, plan, sha256_file(plan_path)


def shard_contract(
    plan: Mapping[str, Any], packs: Sequence[Any], output_root: Path, *, preflight: bool
) -> tuple[int, Mapping[str, Any]]:
    ids = {pack.program_id for pack in packs}
    matches = [row for row in plan.get("shards", []) if set(row.get("program_ids", [])) == ids]
    if len(matches) != 1:
        raise RunError("selected IDs are not one exact registered shard")
    shard = matches[0]
    key = "preflight_output_root" if preflight else "study_output_root"
    if output_root != Path(str(shard[key])).resolve(strict=False):
        raise RunError(f"output root differs from registered {key}")
    return int(shard["shard_index"]), shard


def configure_v2(manifest: Path, manifest_sha: str) -> None:
    V2.PROTOCOL_VERSION = PROTOCOL_VERSION
    V2.STUDY_MANIFEST_PATH = manifest
    V2.STUDY_MANIFEST_SHA256 = manifest_sha
    V2.GENERATION = dict(GENERATION)
    V2.BASE_SEED = BASE_SEED


def paired_seed(program_id: str) -> int:
    material = f"{PROTOCOL_VERSION}\0{COHORT_TAG}\0{BASE_SEED}\0{program_id}\0round-1".encode()
    return int.from_bytes(hashlib.sha256(material).digest()[:4], "big") & 0x7FFFFFFF


def code_provenance(manifest: Path, plan: Path) -> dict[str, str]:
    paths = (Path(__file__).resolve(), V2_PATH, manifest, plan)
    return {str(path): sha256_file(path) for path in paths}


def static_checks(packs: Sequence[Any], engine: ModuleType) -> dict[str, Any]:
    evidence: dict[str, Any] = {}
    for pack in packs:
        conditions = V2.prepare_conditions(pack, engine)
        evidence[pack.program_id] = V2.static_preflight(pack, conditions, engine)
    return evidence


def run_preflight(
    *,
    output: Path,
    gpu_id: int,
    packs: Sequence[Any],
    engine: ModuleType,
    manifest: Path,
    manifest_sha: str,
    plan_path: Path,
    plan_sha: str,
    shard_index: int,
) -> int:
    summary_path = output / "preflight_summary.json"
    if summary_path.is_file():
        summary = json.loads(summary_path.read_text(encoding="utf-8"))
        required = {
            "status": "passed",
            "manifest_sha256": manifest_sha,
            "plan_sha256": plan_sha,
            "program_ids": [pack.program_id for pack in packs],
            "generation": GENERATION,
            "study_generation_count": 0,
            "engine_liveness_sha256": ENGINE_LIVENESS_SHA256,
        }
        if all(summary.get(key) == value for key, value in required.items()):
            print(f"[preflight-skip-passed] {summary_path}")
            return 0
        raise RunError("stale preflight summary exists")
    if output.exists() and any(output.iterdir()):
        raise RunError("incomplete preflight directory exists; no automatic retry")
    output.mkdir(parents=True)
    static = static_checks(packs, engine)
    runner, _, environment = V2.load_runtime(output, gpu_id, engine)
    try:
        hashes: dict[str, str] = {}
        for pack in packs:
            conditions = V2.prepare_conditions(pack, engine)
            evidence = {**static[pack.program_id], **V2.model_preflight(runner, pack, conditions, engine)}
            path = output / "programs" / V2._safe_id(pack.program_id) / "preflight.json"
            atomic_json(path, evidence)
            hashes[pack.program_id] = sha256_file(path)
        environment["expansion_protocol_version"] = PROTOCOL_VERSION
        environment["registered_generation"] = GENERATION
        atomic_json(output / "environment.json", environment)
        summary = {
            "schema_version": "expanded-java-300-600-model-preflight-v1",
            "status": "passed",
            "protocol_version": PROTOCOL_VERSION,
            "manifest_sha256": manifest_sha,
            "plan_sha256": plan_sha,
            "program_ids": [pack.program_id for pack in packs],
            "program_count": len(packs),
            "shard_index": shard_index,
            "generation": GENERATION,
            "study_generation_count": 0,
            "program_preflight_sha256": hashes,
            "code_provenance": code_provenance(manifest, plan_path),
            "engine_liveness_sha256": ENGINE_LIVENESS_SHA256,
        }
        atomic_json(summary_path, summary)
        print(f"[preflight-passed] {summary_path}")
        return 0
    finally:
        runner.free()


def run_preflight_screen(
    *,
    output: Path,
    gpu_id: int,
    packs: Sequence[Any],
    engine: ModuleType,
    manifest: Path,
    manifest_sha: str,
    plan_path: Path,
    plan_sha: str,
    shard_index: int,
) -> int:
    """Outcome-free eligibility screen that records every terminal program.

    This is intentionally distinct from the final all-pass preflight.  A
    context or CodeSteer-prior protocol failure rejects that program before
    any study generation instead of aborting at the first failure.
    """
    summary_path = output / "preflight_screen_summary.json"
    if output.exists() and any(output.iterdir()):
        raise RunError("preflight-screen output already exists; preserve it and use a fresh root")
    output.mkdir(parents=True)
    static = static_checks(packs, engine)
    runner, _, environment = V2.load_runtime(output, gpu_id, engine)
    rows: list[dict[str, Any]] = []
    try:
        for ordinal, pack in enumerate(packs, 1):
            conditions = V2.prepare_conditions(pack, engine)
            try:
                model_evidence = V2.model_preflight(runner, pack, conditions, engine)
            except (V2.ProtocolError, ValueError, TypeError, AssertionError) as exc:
                row = {
                    "program_id": pack.program_id,
                    "status": "rejected",
                    "reason_type": type(exc).__name__,
                    "reason": str(exc),
                    "model_outcomes_generated": 0,
                }
                path = output / "programs" / V2._safe_id(pack.program_id) / "preflight_rejection.json"
                atomic_json(path, {**static[pack.program_id], **row})
            else:
                evidence = {**static[pack.program_id], **model_evidence}
                path = output / "programs" / V2._safe_id(pack.program_id) / "preflight.json"
                atomic_json(path, evidence)
                row = {
                    "program_id": pack.program_id,
                    "status": "eligible",
                    "evidence_sha256": sha256_file(path),
                    "model_outcomes_generated": 0,
                }
            rows.append(row)
            atomic_json(
                output / "preflight_screen_progress.json",
                {
                    "status": "running",
                    "completed": ordinal,
                    "total": len(packs),
                    "eligible": sum(item["status"] == "eligible" for item in rows),
                    "rejected": sum(item["status"] == "rejected" for item in rows),
                },
            )
        environment["expansion_protocol_version"] = PROTOCOL_VERSION
        environment["registered_generation"] = GENERATION
        environment["run_mode"] = "outcome_free_model_preflight_screen"
        atomic_json(output / "environment.json", environment)
        eligible = [row["program_id"] for row in rows if row["status"] == "eligible"]
        rejected = [row for row in rows if row["status"] == "rejected"]
        summary = {
            "schema_version": "expanded-java-300-600-model-preflight-screen-v1",
            "status": "screened_complete",
            "protocol_version": PROTOCOL_VERSION,
            "manifest_sha256": manifest_sha,
            "plan_sha256": plan_sha,
            "program_ids": [pack.program_id for pack in packs],
            "program_count": len(packs),
            "shard_index": shard_index,
            "generation": GENERATION,
            "eligible_program_count": len(eligible),
            "eligible_program_ids": eligible,
            "rejected_program_count": len(rejected),
            "rejections": rejected,
            "study_generation_count": 0,
            "model_outcomes_generated": 0,
            "rows": rows,
            "code_provenance": code_provenance(manifest, plan_path),
        }
        atomic_json(summary_path, summary)
        atomic_json(
            output / "preflight_screen_progress.json",
            {
                "status": "screened_complete",
                "completed": len(rows),
                "total": len(packs),
                "eligible": len(eligible),
                "rejected": len(rejected),
            },
        )
        print(f"[preflight-screen-complete] {summary_path}")
        return 0
    finally:
        runner.free()


def validate_preflight(summary_path: Path, packs: Sequence[Any], manifest_sha: str, plan_sha: str) -> dict[str, Any]:
    if not summary_path.is_file():
        raise RunError(f"registered shard preflight has not passed: {summary_path}")
    summary = json.loads(summary_path.read_text(encoding="utf-8"))
    required = {
        "status": "passed",
        "manifest_sha256": manifest_sha,
        "plan_sha256": plan_sha,
        "program_ids": [pack.program_id for pack in packs],
        "generation": GENERATION,
        "study_generation_count": 0,
        "engine_liveness_sha256": ENGINE_LIVENESS_SHA256,
    }
    failed = [key for key, value in required.items() if summary.get(key) != value]
    if failed:
        raise RunError(f"preflight summary is stale: {failed}")
    return summary


def record_complete(path: Path, fingerprint: str) -> bool:
    if not path.is_file():
        return False
    value = json.loads(path.read_text(encoding="utf-8"))
    return value.get("status") == "complete" and value.get("fingerprint") == fingerprint


def rebuild_index(output: Path) -> None:
    rows: list[dict[str, Any]] = []
    for path in sorted((output / "runs").glob("*/trial_001/*/record.json")):
        row = json.loads(path.read_text(encoding="utf-8"))
        rows.append(
            {
                "program_id": row["program_id"],
                "condition": row["condition"],
                "paired_seed": row["paired_seed"],
                "correct_label_count": row["score"]["correct_label_count"],
                "label_count": row["score"]["label_count"],
                "pack_valid": row["score"]["pack_valid"],
                "parse_status": row["score"]["parse_status"],
                "record_path": str(path.relative_to(output)),
            }
        )
    atomic_json(
        output / "results_index.json",
        {
            "protocol_version": PROTOCOL_VERSION,
            "completed_generation_count": len(rows),
            "completed_label_judgment_count": len(rows) * 6,
            "runs": rows,
        },
    )


def run_study(
    *,
    output: Path,
    gpu_id: int,
    packs: Sequence[Any],
    engine: ModuleType,
    manifest: Path,
    manifest_sha: str,
    plan_path: Path,
    plan_sha: str,
    shard: Mapping[str, Any],
    shard_index: int,
    manifest_payload: Mapping[str, Any],
) -> int:
    preflight_path = Path(str(shard["preflight_output_root"])).resolve(strict=False) / "preflight_summary.json"
    preflight = validate_preflight(preflight_path, packs, manifest_sha, plan_sha)
    conditions = {pack.program_id: V2.prepare_conditions(pack, engine) for pack in packs}
    static = {pack.program_id: V2.static_preflight(pack, conditions[pack.program_id], engine) for pack in packs}
    output.mkdir(parents=True, exist_ok=True)
    config = {
        "schema_version": "expanded-java-300-600-study-config-v1",
        "protocol_version": PROTOCOL_VERSION,
        "cohort_tag": COHORT_TAG,
        "manifest_path": str(manifest),
        "manifest_sha256": manifest_sha,
        "plan_path": str(plan_path),
        "plan_sha256": plan_sha,
        "shard_index": shard_index,
        "program_ids": [pack.program_id for pack in packs],
        "conditions": list(CONDITIONS),
        "rounds": [1],
        "generation": GENERATION,
        "source_preparation_policy": manifest_payload.get("source_preparation_policy"),
        "source_preparation_merge_audit_sha256": manifest_payload.get(
            "source_preparation_merge_audit_sha256"
        ),
        "cohort_construction_policy": manifest_payload.get("construction"),
        "expected_generation_count": len(packs) * 3,
        "labels_per_condition": len(packs) * 6,
        "model_id": V2.MODEL_NAME,
        "model_snapshot_commit": V2.MODEL_SNAPSHOT_COMMIT,
        "chat_template_sha256": V2.CHAT_TEMPLATE_SHA256,
        "code_provenance": code_provenance(manifest, plan_path),
        "preflight_summary_sha256": sha256_file(preflight_path),
        "preflight": preflight,
        "engine_liveness_sha256": ENGINE_LIVENESS_SHA256,
    }
    config_path = output / "experiment_config.json"
    if config_path.is_file() and json.loads(config_path.read_text(encoding="utf-8")) != config:
        raise RunError("study config differs from the existing resumable shard")
    atomic_json(config_path, config)
    for pack in packs:
        V2._write_pack_snapshot(output, pack)
    runner, steering, environment = V2.load_runtime(output, gpu_id, engine)
    environment["expansion_protocol_version"] = PROTOCOL_VERSION
    environment["registered_generation"] = GENERATION
    atomic_json(output / "environment.json", environment)
    try:
        local_preflight: dict[str, Any] = {}
        for pack in packs:
            evidence = {
                **static[pack.program_id],
                **V2.model_preflight(runner, pack, conditions[pack.program_id], engine),
            }
            local_preflight[pack.program_id] = evidence
            atomic_json(output / "programs" / V2._safe_id(pack.program_id) / "preflight.json", evidence)
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
                    "manifest_sha256": manifest_sha,
                    "plan_sha256": plan_sha,
                    "program_id": pack.program_id,
                    "case_ids_in_prompt_order": [case.case_id for case in pack.cases],
                    "condition": condition_name,
                    "round": 1,
                    "paired_seed": seed,
                    "model_id": V2.MODEL_NAME,
                    "model_snapshot_commit": V2.MODEL_SNAPSHOT_COMMIT,
                    "generation": GENERATION,
                    "chat_template_sha256": V2.CHAT_TEMPLATE_SHA256,
                    "prompt_sha256": sha256_text(prompt),
                    "steering": steering_payload if condition.activation_steering else None,
                }
                fingerprint = sha256_text(
                    json.dumps(fingerprint_payload, sort_keys=True, separators=(",", ":"), default=str)
                )
                run_dir = output / "runs" / V2._safe_id(pack.program_id) / "trial_001" / condition_name
                record_path = run_dir / "record.json"
                if record_complete(record_path, fingerprint):
                    print(f"[skip] {pack.program_id} {condition_name}", flush=True)
                    continue
                if run_dir.exists() and any(run_dir.iterdir()):
                    raise RunError(f"incomplete/stale attempt exists; no retry: {run_dir}")
                run_dir.mkdir(parents=True, exist_ok=True)
                run_config = {
                    **fingerprint_payload,
                    "fingerprint": fingerprint,
                    "source_kind": condition.source_kind,
                    "target_method": condition.target_method,
                    "activation_steering": condition.activation_steering,
                    "paired_design": "same program seed across all three conditions",
                    "token_preflight": local_preflight[pack.program_id]["prompt_tokens_by_condition"][condition_name],
                    "chat_template_evidence": local_preflight[pack.program_id]["chat_template_by_condition"][condition_name],
                    "codesteer_prior_preflight": local_preflight[pack.program_id]["codesteer_prior"] if condition.activation_steering else None,
                    "hidden_labels_in_prompt": False,
                    "attempt": 1,
                    "automatic_retry_allowed": False,
                }
                atomic_json(run_dir / "run_config.json", run_config)
                atomic_text(run_dir / "submitted_prompt.txt", prompt)
                atomic_text(run_dir / "source.java", condition.source_code)
                atomic_json(run_dir / "status.json", {"status": "running", "attempt": 1})
                runner.steering_config = steering if condition.activation_steering else None
                V2.seed_everything(engine, seed)
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
                score = V2.score_study_completion(pack, completion)
                tokens = V2.generated_token_evidence(result, runner)
                debug = result.get("steering_debug") or {}
                engine.validate_steering_debug(condition, debug)
                result["experiment"] = {
                    "program_id": pack.program_id,
                    "condition": condition_name,
                    "round": 1,
                    "paired_seed": seed,
                    "fingerprint": fingerprint,
                    "protocol_version": PROTOCOL_VERSION,
                }
                result["score"] = score
                result["generated_token_evidence"] = tokens
                result.pop("full_decode_head_tensors", None)
                atomic_text(run_dir / "raw_completion.txt", completion)
                atomic_json(run_dir / "score.json", score)
                atomic_json(run_dir / "generated_token_evidence.json", tokens)
                atomic_json(run_dir / "steering_debug.json", debug)
                atomic_json(run_dir / "model_output.json", result)
                record = {
                    "status": "complete",
                    "completed_at_unix": time.time(),
                    "attempt": 1,
                    "automatic_retry_used": False,
                    "fingerprint": fingerprint,
                    "program_id": pack.program_id,
                    "round": 1,
                    "condition": condition_name,
                    "paired_seed": seed,
                    "score": score,
                }
                atomic_json(record_path, record)
                atomic_json(run_dir / "status.json", record)
                rebuild_index(output)
                print(
                    f"[done] {pack.program_id} {condition_name} labels={score['correct_label_count']}/6 parse={score['parse_status']}",
                    flush=True,
                )
    finally:
        runner.free()
    rebuild_index(output)
    return 0


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--dry-run", action="store_true")
    mode.add_argument("--model-preflight-only", action="store_true")
    mode.add_argument("--model-preflight-screen", action="store_true")
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--plan", type=Path, default=DEFAULT_PLAN)
    parser.add_argument("--gpu-id", type=int, default=None)
    parser.add_argument("--program-ids", default="")
    parser.add_argument("--output-root", type=Path, default=None)
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    manifest, payload, all_packs, manifest_sha = load_manifest(args.manifest)
    configure_v2(manifest, manifest_sha)
    plan_path, plan, plan_sha = load_plan(args.plan, manifest, manifest_sha)
    packs = selected_packs(all_packs, args.program_ids)
    if not packs:
        raise RunError("no programs selected")
    V2.V1.validate_model_lock()
    V2.validate_runtime_dependencies()
    engine_liveness = validate_engine_liveness()
    engine = V2.V1.load_engine()
    static = static_checks(packs, engine)
    if args.dry_run:
        print(
            json.dumps(
                {
                    "status": "static_preflight_passed",
                    "protocol_version": PROTOCOL_VERSION,
                    "manifest_sha256": manifest_sha,
                    "plan_sha256": plan_sha,
                    "program_ids": [pack.program_id for pack in packs],
                    "program_count": len(packs),
                    "generation": GENERATION,
                    "generation_count": len(packs) * 3,
                    "labels_per_condition": len(packs) * 6,
                    "static_preflight_program_count": len(static),
                    "gpu_inference_performed": False,
                    "source_preparation_policy": payload.get("source_preparation_policy"),
                    "engine_liveness_sha256": ENGINE_LIVENESS_SHA256,
                    "engine_liveness_status": engine_liveness.get("status"),
                },
                indent=2,
                sort_keys=True,
            )
        )
        return 0
    if args.gpu_id is None or args.gpu_id < 0 or args.output_root is None:
        raise RunError("model modes require --gpu-id and --output-root")
    output = local(args.output_root, "output root", existing=False)
    preflight_mode = args.model_preflight_only or args.model_preflight_screen
    shard_index, shard = shard_contract(plan, packs, output, preflight=preflight_mode)
    if args.model_preflight_screen:
        return run_preflight_screen(
            output=output,
            gpu_id=args.gpu_id,
            packs=packs,
            engine=engine,
            manifest=manifest,
            manifest_sha=manifest_sha,
            plan_path=plan_path,
            plan_sha=plan_sha,
            shard_index=shard_index,
        )
    if args.model_preflight_only:
        return run_preflight(
            output=output,
            gpu_id=args.gpu_id,
            packs=packs,
            engine=engine,
            manifest=manifest,
            manifest_sha=manifest_sha,
            plan_path=plan_path,
            plan_sha=plan_sha,
            shard_index=shard_index,
        )
    return run_study(
        output=output,
        gpu_id=args.gpu_id,
        packs=packs,
        engine=engine,
        manifest=manifest,
        manifest_sha=manifest_sha,
        plan_path=plan_path,
        plan_sha=plan_sha,
        shard=shard,
        shard_index=shard_index,
        manifest_payload=payload,
    )


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except (RunError, ValueError, TypeError, FileNotFoundError) as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        raise SystemExit(2)
