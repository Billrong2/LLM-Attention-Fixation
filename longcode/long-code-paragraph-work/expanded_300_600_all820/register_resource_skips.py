#!/usr/bin/env python3
"""Fail-closed registration of two user-authorized shard-0 resource skips.

This tool never runs a model and never creates a completion, score, record, or
canonical run directory.  It registers one observed CUDA OOM and one distinct
capacity-derived skip for the identical CodeSteer prefill, each scoped to one
exact program/condition/fingerprint/seed cell.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import stat
from pathlib import Path
from typing import Any, Mapping, Sequence


HERE = Path(__file__).resolve().parent
SHARD = HERE / "results" / "study" / "shard_0"
PROGRAM_ID = "cc-valid-r038-s0030__t5_easy_seed1"
SEED = 1006413233
PROMPT_SHA256 = "599020a12c92940d02d0336f0d943324f6f3c9a09674a005cea26bbe52b6a0d6"
PROMPT_TOKENS = 11025
MANIFEST_SHA256 = "93160336e3177a900594a016f27a41aa0946bf61c4f363e2bfaf502f48c8ca02"
PLAN_SHA256 = "41c7f61a5f1299fa6be1895700dff5f56a84512f4b809ce2261b3b0ef2279b25"
RUNNER_SHA256 = "5c3c83e2f81ba645174b7ae6ad580ee21cd490bb72f1efbfc75ced80584da6cb"
V2_SHA256 = "3c1cdd87a4d604763c9258e0654147c7a01f01521462c40a3522b70823f2cce5"
INDEX_SHA256 = "aaca481c901236498a08910dae18913e0ec057c3d61ad414e9b49e90f83ac320"
INCIDENT5_REL = (
    "recovery_evidence/"
    "shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93-incident5/recovery_audit.json"
)
INCIDENT5_SHA256 = "506c74f2bfc490463e40bb95c204f54dd004acfdc44cb4d3594398ba09e330f5"
PLAIN_FINGERPRINT = "2ddb4eac4d9392f224b04e739a140846a058b96ff51ec42ee4aa6cdab10949ca"
CODESTEER_FINGERPRINT = "dd52b8d2e28efccaa2f5c61fecfb7c2a80cd91c81e78f797499ab2ddfdef2ef5"
STEERING_CONFIG_SHA256 = "56bfbe60a24f1665d3951b4aa7adac3cb0242ecdb123d046a7e3e54662fffc2e"
MODEL_ID = "Qwen/Qwen2.5-Coder-7B-Instruct"
MODEL_COMMIT = "c03e6d358207e414f1eca0bb1891e29f1db0e242"
CHAT_TEMPLATE_SHA256 = "cd8e9439f0570856fd70470bf8889ebd8b5d1107207f67a5efb46e342330527f"
GENERATION = {
    "do_sample": True,
    "max_new_tokens": 192,
    "temperature": 1.3,
    "top_k": 50,
    "top_p": 0.95,
}
MODEL_OUTCOME_FILES = frozenset(
    {
        "generated_token_evidence.json",
        "model_output.json",
        "raw_completion.txt",
        "record.json",
        "score.json",
        "steering_debug.json",
    }
)


class RegistrationError(RuntimeError):
    pass


def require(condition: bool, message: str) -> None:
    if not condition:
        raise RegistrationError(message)


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def canonical_sha256(value: Any) -> str:
    encoded = json.dumps(
        value, ensure_ascii=False, sort_keys=True, separators=(",", ":"), default=str
    ).encode("utf-8")
    return hashlib.sha256(encoded).hexdigest()


def read_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise RegistrationError(f"invalid JSON {path}: {exc}") from exc


def atomic_text(path: Path, value: str) -> None:
    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    temporary.write_text(value, encoding="utf-8")
    os.replace(temporary, path)


def atomic_json(path: Path, value: Any) -> None:
    atomic_text(
        path,
        json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True, default=str) + "\n",
    )


def relative_run_dir(condition: str) -> str:
    return f"runs/{PROGRAM_ID}/trial_001/{condition}"


def relative_marker_dir(condition: str) -> str:
    return f"resource_skips/{PROGRAM_ID}/trial_001/{condition}"


def shared_payload(condition: str, fingerprint: str) -> dict[str, Any]:
    return {
        "schema_version": "expanded-java-300-600-resource-skip-v1",
        "status": "registered",
        "program_id": PROGRAM_ID,
        "condition": condition,
        "round": 1,
        "trial": 1,
        "paired_seed": SEED,
        "fingerprint": fingerprint,
        "prompt_sha256": PROMPT_SHA256,
        "prompt_token_count": PROMPT_TOKENS,
        "manifest_sha256": MANIFEST_SHA256,
        "plan_sha256": PLAN_SHA256,
        "run_shard_sha256": RUNNER_SHA256,
        "run_binary_v2_sha256": V2_SHA256,
        "model_id": MODEL_ID,
        "model_snapshot_commit": MODEL_COMMIT,
        "chat_template_sha256": CHAT_TEMPLATE_SHA256,
        "generation": GENERATION,
        "canonical_run_dir": relative_run_dir(condition),
        "canonical_run_dir_absent_at_registration": True,
        "observed_no_model_outcome": True,
        "model_outcome_files_present": [],
        "completion_record_created": False,
        "score_created": False,
        "completed_generation_count_before": 31,
        "completed_generation_count_after": 31,
        "completed_generation_count_unchanged": True,
        "results_index_sha256": INDEX_SHA256,
        "contributes_completion": False,
        "contributes_score": False,
        "included_in_condition_denominator": False,
        "statistical_treatment": "excluded_missing_due_to_resource_capacity",
        "authorization_basis": "user_explicitly_authorized_skipping_tasks_the_available_gpu_cannot_handle",
        "authorization_scope_condition_count": 1,
        "authorization_does_not_extend_to_other_program_condition_fingerprint_or_seed": True,
        "new_statistical_trial": False,
        "malformed_output_retry": False,
        "incident5_recovery_audit_path": INCIDENT5_REL,
        "incident5_recovery_audit_sha256": INCIDENT5_SHA256,
    }


def expected_payloads() -> dict[str, dict[str, Any]]:
    plain = shared_payload("obfuscated_plain", PLAIN_FINGERPRINT)
    plain.update(
        {
            "disposition": "resource_oom",
            "evidence_kind": "observed_cuda_oom",
            "attempt": 1,
            "attempt_directory_was_created": True,
            "attempt_setup_evidence_preserved_in_incident5": True,
            "resource_evidence": {
                "allocator_environment": {
                    "PYTORCH_CUDA_ALLOC_CONF": "max_split_size_mb:128"
                },
                "exception_type": "torch.cuda.OutOfMemoryError",
                "failure_operation": (
                    "torch.nn.functional.softmax(attn_weights, dim=-1, dtype=torch.float32)"
                ),
                "failed_allocation_gib": 12.68,
                "gpu_free_gib": 12.66,
                "process_memory_used_gib": 34.73,
                "pytorch_allocated_gib": 34.21,
                "pytorch_reserved_mib": 219.24,
                "allocator_fragmentation_eliminated": True,
                "physical_capacity_shortfall_observed": True,
            },
        }
    )
    codesteer = shared_payload("obfuscated_codesteer", CODESTEER_FINGERPRINT)
    codesteer.update(
        {
            "disposition": "resource_capacity_skip",
            "evidence_kind": "derived_same_prefill_resource_limit",
            "attempt": None,
            "attempt_directory_was_created": False,
            "attempt_setup_evidence_preserved_in_incident5": False,
            "steering_config_sha256": STEERING_CONFIG_SHA256,
            "resource_evidence": {
                "same_rendered_prompt_as_obfuscated_plain": True,
                "same_prompt_sha256": PROMPT_SHA256,
                "same_prompt_token_count": PROMPT_TOKENS,
                "split_prefill_enabled": True,
                "split_prefill_prefix_token_count": 11024,
                "decode_only_steering": True,
                "steering_not_applied_during_multi_token_prefix_prefill": True,
                "prefix_prefill_uses_same_full_eager_float32_attention_softmax": True,
                "observed_plain_failed_allocation_gib": 12.68,
                "observed_plain_gpu_free_gib": 12.66,
                "derived_capacity_limit": True,
                "model_execution_attempted_for_this_condition": False,
            },
        }
    )
    return {"obfuscated_plain": plain, "obfuscated_codesteer": codesteer}


def verify_payload(condition: str, payload: Mapping[str, Any]) -> None:
    expected = expected_payloads()
    require(condition in expected, f"unregistered resource-skip condition: {condition}")
    require(dict(payload) == expected[condition], f"marker payload differs: {condition}")


def verify_sources() -> None:
    pinned = {
        HERE / "frozen_model_eligible_t130" / "inference_manifest.json": MANIFEST_SHA256,
        HERE / "launch_plan_model_eligible_t130.json": PLAN_SHA256,
        HERE / "run_shard.py": RUNNER_SHA256,
        HERE.parent / "binary_task" / "v2" / "run_binary_v2.py": V2_SHA256,
        SHARD / "results_index.json": INDEX_SHA256,
        SHARD / INCIDENT5_REL: INCIDENT5_SHA256,
    }
    for path, expected in pinned.items():
        require(path.is_file() and not path.is_symlink(), f"missing pinned file: {path}")
        require(sha256_file(path) == expected, f"pinned SHA-256 differs: {path}")

    index = read_json(SHARD / "results_index.json")
    require(index.get("completed_generation_count") == 31, "completed count differs")
    require(len(index.get("runs", [])) == 31, "results-index row count differs")
    audit = read_json(SHARD / INCIDENT5_REL)
    require(audit.get("model_outcome_observed") is False, "incident5 observed an outcome")
    require(audit.get("completed_generation_count_after") == 31, "incident5 count differs")
    require(audit.get("root_observed_runtime_error", {}).get("failed_allocation_gib") == 12.68,
            "incident5 failed allocation differs")
    require(audit.get("root_observed_runtime_error", {}).get("gpu_free_gib") == 12.66,
            "incident5 free memory differs")

    preflight = read_json(SHARD / "programs" / PROGRAM_ID / "preflight.json")
    for condition in ("obfuscated_plain", "obfuscated_codesteer"):
        token = preflight["prompt_tokens_by_condition"][condition]
        require(token.get("prompt_sha256") == PROMPT_SHA256, f"{condition} prompt differs")
        require(token.get("prompt_token_count") == PROMPT_TOKENS, f"{condition} tokens differ")

    preserved = read_json(SHARD / INCIDENT5_REL).get("preserved_attempt_path")
    require(isinstance(preserved, str), "incident5 preserved path is absent")
    preserved_dir = Path(preserved).resolve(strict=True)
    require(preserved_dir == (SHARD / INCIDENT5_REL).parent / "interrupted_attempt",
            "incident5 preserved path differs")
    require(not (MODEL_OUTCOME_FILES & {path.name for path in preserved_dir.iterdir()}),
            "incident5 preserved attempt contains an outcome")
    plain_config = read_json(preserved_dir / "run_config.json")
    require(
        plain_config.get("program_id") == PROGRAM_ID
        and plain_config.get("condition") == "obfuscated_plain"
        and plain_config.get("paired_seed") == SEED
        and plain_config.get("prompt_sha256") == PROMPT_SHA256
        and plain_config.get("fingerprint") == PLAIN_FINGERPRINT,
        "preserved plain identity differs",
    )

    steering_payloads = []
    for path in sorted((SHARD / "runs").glob("*/trial_001/obfuscated_codesteer/run_config.json")):
        value = read_json(path)
        if value.get("status") != "complete":
            # Run configs do not contain status; the adjacent record is the
            # authoritative completion gate.
            record = read_json(path.parent / "record.json")
            require(record.get("status") == "complete", f"non-complete steering source: {path}")
        steering_payloads.append(value.get("steering"))
    require(steering_payloads, "no completed CodeSteer configuration is available")
    steering_hashes = {canonical_sha256(value) for value in steering_payloads}
    require(steering_hashes == {STEERING_CONFIG_SHA256}, "CodeSteer configuration differs")
    fingerprint_keys = (
        "protocol_version", "manifest_sha256", "plan_sha256", "program_id",
        "case_ids_in_prompt_order", "condition", "round", "paired_seed", "model_id",
        "model_snapshot_commit", "generation", "chat_template_sha256", "prompt_sha256",
        "steering",
    )
    codesteer_payload = {key: plain_config[key] for key in fingerprint_keys}
    codesteer_payload.update(
        {
            "condition": "obfuscated_codesteer",
            "prompt_sha256": PROMPT_SHA256,
            "steering": steering_payloads[0],
        }
    )
    require(
        canonical_sha256(codesteer_payload) == CODESTEER_FINGERPRINT,
        "CodeSteer fingerprint reconstruction differs",
    )

    for condition in ("obfuscated_plain", "obfuscated_codesteer"):
        require(not (SHARD / relative_run_dir(condition)).exists(),
                f"canonical skipped run directory exists: {condition}")


def verify_existing() -> dict[str, str]:
    expected = expected_payloads()
    hashes: dict[str, str] = {}
    for condition, payload in expected.items():
        directory = SHARD / relative_marker_dir(condition)
        marker = directory / "resource_skip.json"
        anchor = directory / "resource_skip.sha256"
        require(directory.is_dir() and not directory.is_symlink(), f"missing marker dir: {condition}")
        require({path.name for path in directory.iterdir()} == {marker.name, anchor.name},
                f"unregistered file in marker dir: {condition}")
        verify_payload(condition, read_json(marker))
        digest = sha256_file(marker)
        require(anchor.read_text(encoding="utf-8") == f"{digest}  resource_skip.json\n",
                f"marker anchor differs: {condition}")
        for path in (directory, marker, anchor):
            require(stat.S_IMODE(path.stat().st_mode) & 0o222 == 0,
                    f"marker evidence is writable: {path}")
        hashes[condition] = digest
    return hashes


def apply() -> dict[str, str]:
    verify_sources()
    expected = expected_payloads()
    for condition, payload in expected.items():
        directory = SHARD / relative_marker_dir(condition)
        require(not directory.exists(), f"marker already exists: {condition}")
        directory.mkdir(parents=True)
        marker = directory / "resource_skip.json"
        atomic_json(marker, payload)
        digest = sha256_file(marker)
        atomic_text(directory / "resource_skip.sha256", f"{digest}  resource_skip.json\n")
        for path in directory.iterdir():
            path.chmod(0o444)
        directory.chmod(0o555)
    return verify_existing()


def main(argv: Sequence[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--apply", action="store_true")
    mode.add_argument("--check", action="store_true")
    args = parser.parse_args(argv)
    if args.apply:
        hashes = apply()
    else:
        verify_sources()
        hashes = verify_existing()
    print(json.dumps({"status": "registered", "model_inference_performed": False,
                      "marker_sha256": hashes}, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RegistrationError as exc:
        print(f"REFUSED: {exc}", file=__import__("sys").stderr)
        raise SystemExit(2)
