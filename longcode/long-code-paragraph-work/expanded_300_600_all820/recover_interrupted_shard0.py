#!/usr/bin/env python3
"""Fail-closed recovery for the one interrupted shard-0 infrastructure attempt.

This tool does not run a model.  It verifies the frozen experiment contract,
proves that the interrupted directory has no recorded model outcome, moves that
directory atomically into read-only recovery evidence, proves that every
completed artifact is unchanged, and prints the registered shard argv that may
then be relaunched manually.

The production contract is deliberately incident-specific.  A different
partial run, changed code, changed results index, or any model-output artifact
causes a refusal instead of a recovery.
"""

from __future__ import annotations

import argparse
import dataclasses
import hashlib
import json
import os
import shlex
import stat
import sys
import time
from pathlib import Path
from typing import Any, Mapping, Sequence


HERE = Path(__file__).resolve().parent
PROTOCOL_VERSION = "expanded-java-300-600-qwen25-chat-t130-one-round-v1"
COHORT_TAG = "expanded-java-300-600-all-static-eligible"
BASE_SEED = 20260715

COMPLETE_FILE_NAMES = frozenset(
    {
        "generated_token_evidence.json",
        "model_output.json",
        "raw_completion.txt",
        "record.json",
        "run_config.json",
        "score.json",
        "source.java",
        "status.json",
        "steering_debug.json",
        "submitted_prompt.txt",
    }
)
INTERRUPTED_FILE_NAMES = frozenset(
    {"run_config.json", "source.java", "status.json", "submitted_prompt.txt"}
)
MODEL_OUTCOME_FILE_NAMES = frozenset(
    {
        "generated_token_evidence.json",
        "model_output.json",
        "raw_completion.txt",
        "record.json",
        "score.json",
        "steering_debug.json",
    }
)


class RecoveryError(RuntimeError):
    """A failed safety invariant.  No recovery should proceed after this."""


def sha256_bytes(value: bytes) -> str:
    return hashlib.sha256(value).hexdigest()


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
    return sha256_bytes(encoded)


def read_json(path: Path) -> Any:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeError, json.JSONDecodeError) as exc:
        raise RecoveryError(f"cannot read valid JSON from {path}: {exc}") from exc


def atomic_json(path: Path, value: Any) -> None:
    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    temporary.write_text(
        json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True, default=str) + "\n",
        encoding="utf-8",
    )
    os.replace(temporary, path)


def atomic_text(path: Path, value: str) -> None:
    temporary = path.with_name(f".{path.name}.tmp-{os.getpid()}")
    temporary.write_text(value, encoding="utf-8")
    os.replace(temporary, path)


def require(condition: bool, message: str) -> None:
    if not condition:
        raise RecoveryError(message)


def require_regular_file(path: Path, label: str) -> None:
    require(path.exists(), f"missing {label}: {path}")
    require(path.is_file() and not path.is_symlink(), f"{label} is not a regular file: {path}")


def require_below(path: Path, root: Path, label: str, *, strict: bool) -> Path:
    resolved_root = root.resolve(strict=True)
    resolved = path.resolve(strict=strict)
    try:
        resolved.relative_to(resolved_root)
    except ValueError as exc:
        raise RecoveryError(f"{label} escapes scope {resolved_root}: {resolved}") from exc
    return resolved


def file_ledger(directory: Path) -> dict[str, dict[str, Any]]:
    require(directory.is_dir() and not directory.is_symlink(), f"not a real directory: {directory}")
    ledger: dict[str, dict[str, Any]] = {}
    for path in sorted(directory.rglob("*")):
        require(not path.is_symlink(), f"symlink is forbidden in evidence: {path}")
        if path.is_dir():
            continue
        require(path.is_file(), f"non-regular evidence entry: {path}")
        relative = path.relative_to(directory).as_posix()
        ledger[relative] = {"sha256": sha256_file(path), "size_bytes": path.stat().st_size}
    return ledger


def compact_hash_ledger(ledger: Mapping[str, Mapping[str, Any]]) -> dict[str, str]:
    return {path: str(row["sha256"]) for path, row in ledger.items()}


def paired_seed(program_id: str) -> int:
    material = (
        f"{PROTOCOL_VERSION}\0{COHORT_TAG}\0{BASE_SEED}\0{program_id}\0round-1".encode()
    )
    return int.from_bytes(hashlib.sha256(material).digest()[:4], "big") & 0x7FFFFFFF


FINGERPRINT_KEYS = (
    "protocol_version",
    "manifest_sha256",
    "plan_sha256",
    "program_id",
    "case_ids_in_prompt_order",
    "condition",
    "round",
    "paired_seed",
    "model_id",
    "model_snapshot_commit",
    "generation",
    "chat_template_sha256",
    "prompt_sha256",
    "steering",
)


def reconstruct_fingerprint(run_config: Mapping[str, Any]) -> str:
    missing = [key for key in FINGERPRINT_KEYS if key not in run_config]
    require(not missing, f"run config lacks fingerprint keys: {missing}")
    payload = {key: run_config[key] for key in FINGERPRINT_KEYS}
    return canonical_sha256(payload)


@dataclasses.dataclass(frozen=True)
class PriorRecoveryExpectation:
    audit_path: Path
    audit_sha256: str
    program_id: str
    condition: str
    fingerprint: str
    paired_seed: int
    resumed_record_relative_path: Path | None
    resumed_record_sha256: str | None
    resume_disposition: str = "completed_before_next_recovery"


@dataclasses.dataclass(frozen=True)
class AllocatorRecoveryAmendment:
    amendment_id: str
    environment_name: str
    environment_value: str
    root_observed_runtime_error: Mapping[str, Any]


@dataclasses.dataclass(frozen=True)
class RecoveryContract:
    scope_root: Path
    shard_root: Path
    plan_path: Path
    manifest_path: Path
    preflight_path: Path
    results_index_path: Path
    experiment_config_path: Path
    code_paths: tuple[Path, ...]
    expected_sha256: Mapping[str, str]
    interrupted_relative_path: Path
    evidence_relative_path: Path
    interrupted_program_id: str
    interrupted_condition: str
    interrupted_fingerprint: str
    interrupted_paired_seed: int
    interrupted_files: Mapping[str, Mapping[str, Any]]
    completed_generation_count: int
    completed_artifact_count: int
    completed_artifacts_canonical_sha256: str
    expected_shard_program_count: int
    source_kind: str = "original"
    manifest_source_path_key: str = "original_path"
    manifest_source_sha256_key: str = "original_sha256"
    recovery_ordinal: int = 1
    prior_recoveries: tuple[PriorRecoveryExpectation, ...] = ()
    allocator_amendment: AllocatorRecoveryAmendment | None = None
    runtime_failure_observation: Mapping[str, Any] | None = None
    check_process_table: bool = False


def production_contract_first() -> RecoveryContract:
    shard = HERE / "results" / "study" / "shard_0"
    return RecoveryContract(
        scope_root=HERE,
        shard_root=shard,
        plan_path=HERE / "launch_plan_model_eligible_t130.json",
        manifest_path=HERE / "frozen_model_eligible_t130" / "inference_manifest.json",
        preflight_path=HERE / "results" / "preflight" / "shard_0" / "preflight_summary.json",
        results_index_path=shard / "results_index.json",
        experiment_config_path=shard / "experiment_config.json",
        code_paths=(HERE / "run_shard.py", HERE.parent / "binary_task" / "v2" / "run_binary_v2.py"),
        expected_sha256={
            "plan": "41c7f61a5f1299fa6be1895700dff5f56a84512f4b809ce2261b3b0ef2279b25",
            "manifest": "93160336e3177a900594a016f27a41aa0946bf61c4f363e2bfaf502f48c8ca02",
            "preflight": "c72986b43296995efbdcec084926ee59c23c3f8fc7bc7afb081d8bc6b7eb612a",
            "results_index": "5a8b5e13d454fe72b729fe2b206ca696fcb68567480172004fc517df713b861d",
            "experiment_config": "f30126892e3089db44ae9b4652ae13a131fb9179ed709ca5d16e3e26c3905d19",
            "run_shard.py": "5c3c83e2f81ba645174b7ae6ad580ee21cd490bb72f1efbfc75ced80584da6cb",
            "run_binary_v2.py": "3c1cdd87a4d604763c9258e0654147c7a01f01521462c40a3522b70823f2cce5",
        },
        interrupted_relative_path=Path(
            "runs/cc-valid-r038-s0030__t5_easy_seed1/trial_001/original_plain"
        ),
        evidence_relative_path=Path(
            "recovery_evidence/shard0-r038-s0030-original_plain-a00777477544"
        ),
        interrupted_program_id="cc-valid-r038-s0030__t5_easy_seed1",
        interrupted_condition="original_plain",
        interrupted_fingerprint="a00777477544da5bfbc03f8578daac0851a9d2517429eb312cd35cdc2267fd03",
        interrupted_paired_seed=1006413233,
        interrupted_files={
            "run_config.json": {
                "sha256": "561eb9d1cf6291b363314ba5a503636eeab5b6b51ecbc27c8791b806c3da71fa",
                "size_bytes": 2365,
            },
            "source.java": {
                "sha256": "1703c08d28e453be67d6fcbfba730b41de6b384f69338c2c34ad1af38c3cbc74",
                "size_bytes": 24791,
            },
            "status.json": {
                "sha256": "a0b337f57c56b0a53e63003ddd56fbcad715f4e4b51e606facf1f22225e6635f",
                "size_bytes": 42,
            },
            "submitted_prompt.txt": {
                "sha256": "f8012425dbf2cde61e7f1025e4aa4c2f731271ae3c85acbd508076b04ea39079",
                "size_bytes": 26562,
            },
        },
        completed_generation_count=30,
        completed_artifact_count=300,
        completed_artifacts_canonical_sha256="8b44e9f2c67c93825287c1020f71a7227e29979b3b8d58a3b7b3ed5dbf53983f",
        expected_shard_program_count=38,
        check_process_table=True,
    )


def production_contract_second() -> RecoveryContract:
    """Strict contract for the second sequential shard-0 interruption."""
    shard = HERE / "results" / "study" / "shard_0"
    first_audit = (
        shard
        / "recovery_evidence"
        / "shard0-r038-s0030-original_plain-a00777477544"
        / "recovery_audit.json"
    )
    return RecoveryContract(
        scope_root=HERE,
        shard_root=shard,
        plan_path=HERE / "launch_plan_model_eligible_t130.json",
        manifest_path=HERE / "frozen_model_eligible_t130" / "inference_manifest.json",
        preflight_path=HERE / "results" / "preflight" / "shard_0" / "preflight_summary.json",
        results_index_path=shard / "results_index.json",
        experiment_config_path=shard / "experiment_config.json",
        code_paths=(HERE / "run_shard.py", HERE.parent / "binary_task" / "v2" / "run_binary_v2.py"),
        expected_sha256={
            "plan": "41c7f61a5f1299fa6be1895700dff5f56a84512f4b809ce2261b3b0ef2279b25",
            "manifest": "93160336e3177a900594a016f27a41aa0946bf61c4f363e2bfaf502f48c8ca02",
            "preflight": "c72986b43296995efbdcec084926ee59c23c3f8fc7bc7afb081d8bc6b7eb612a",
            "results_index": "aaca481c901236498a08910dae18913e0ec057c3d61ad414e9b49e90f83ac320",
            "experiment_config": "f30126892e3089db44ae9b4652ae13a131fb9179ed709ca5d16e3e26c3905d19",
            "run_shard.py": "5c3c83e2f81ba645174b7ae6ad580ee21cd490bb72f1efbfc75ced80584da6cb",
            "run_binary_v2.py": "3c1cdd87a4d604763c9258e0654147c7a01f01521462c40a3522b70823f2cce5",
        },
        interrupted_relative_path=Path(
            "runs/cc-valid-r038-s0030__t5_easy_seed1/trial_001/obfuscated_plain"
        ),
        evidence_relative_path=Path(
            "recovery_evidence/shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93"
        ),
        interrupted_program_id="cc-valid-r038-s0030__t5_easy_seed1",
        interrupted_condition="obfuscated_plain",
        interrupted_fingerprint="2ddb4eac4d9392f224b04e739a140846a058b96ff51ec42ee4aa6cdab10949ca",
        interrupted_paired_seed=1006413233,
        interrupted_files={
            "run_config.json": {
                "sha256": "6164df4a1392439fbed6af9c1dec7a4c19b18ea30aebe9368ff05cdc5fa0429f",
                "size_bytes": 2371,
            },
            "source.java": {
                "sha256": "2ee6abb26a0538939a5ac8f148d5cb9d7fea4edc80c4d762b13c08fa765ac91a",
                "size_bytes": 27017,
            },
            "status.json": {
                "sha256": "a0b337f57c56b0a53e63003ddd56fbcad715f4e4b51e606facf1f22225e6635f",
                "size_bytes": 42,
            },
            "submitted_prompt.txt": {
                "sha256": "599020a12c92940d02d0336f0d943324f6f3c9a09674a005cea26bbe52b6a0d6",
                "size_bytes": 28788,
            },
        },
        completed_generation_count=31,
        completed_artifact_count=310,
        completed_artifacts_canonical_sha256="85ddc6e0ba62050b3c70cb3704289a257174ef73115b5ccd4ba0fbfce33b3f57",
        expected_shard_program_count=38,
        source_kind="obfuscated",
        manifest_source_path_key="obfuscated_path",
        manifest_source_sha256_key="obfuscated_sha256",
        recovery_ordinal=2,
        prior_recoveries=(
            PriorRecoveryExpectation(
                audit_path=first_audit,
                audit_sha256="615e1c7f4c9f50053502b26ff2b4fd0d30d3684718c5d794834fdedbb1d2d733",
                program_id="cc-valid-r038-s0030__t5_easy_seed1",
                condition="original_plain",
                fingerprint="a00777477544da5bfbc03f8578daac0851a9d2517429eb312cd35cdc2267fd03",
                paired_seed=1006413233,
                resumed_record_relative_path=Path(
                    "runs/cc-valid-r038-s0030__t5_easy_seed1/trial_001/original_plain/record.json"
                ),
                resumed_record_sha256="c19d0f53c6e855b0a51c38dc59014684d767622c02f09baf457aaece78462c4d",
            ),
        ),
        check_process_table=True,
    )


def production_contract_third() -> RecoveryContract:
    """Strict contract for a second setup-only interruption of the same run."""
    second = production_contract_second()
    second_audit = (
        second.shard_root
        / "recovery_evidence"
        / "shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93"
        / "recovery_audit.json"
    )
    return dataclasses.replace(
        second,
        evidence_relative_path=Path(
            "recovery_evidence/shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93-incident3"
        ),
        recovery_ordinal=3,
        prior_recoveries=second.prior_recoveries
        + (
            PriorRecoveryExpectation(
                audit_path=second_audit,
                audit_sha256="799509beb03c25f1219b89a8979a87a0638aa0dd9790251def56bee20ba15921",
                program_id="cc-valid-r038-s0030__t5_easy_seed1",
                condition="obfuscated_plain",
                fingerprint="2ddb4eac4d9392f224b04e739a140846a058b96ff51ec42ee4aa6cdab10949ca",
                paired_seed=1006413233,
                resumed_record_relative_path=None,
                resumed_record_sha256=None,
                resume_disposition="reinterrupted_before_outcome",
            ),
        ),
    )


def production_contract_fourth() -> RecoveryContract:
    """Strict contract plus allocator-only amendment after captured CUDA OOM."""
    third = production_contract_third()
    third_audit = (
        third.shard_root
        / "recovery_evidence"
        / "shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93-incident3"
        / "recovery_audit.json"
    )
    runtime_error = {
        "evidence_class": "root_observed_runtime_error_not_persisted_log",
        "observed_by": "root agent through persistent captured execution",
        "persisted_runtime_log_available": False,
        "persisted_runtime_log_path": None,
        "exception_type": "torch.cuda.OutOfMemoryError",
        "call_path": [
            "steering/backends/qwen2_backend.py forward",
            "torch.nn.functional.softmax(attn_weights, dim=-1, dtype=torch.float32)",
        ],
        "failed_allocation_gib": 12.68,
        "gpu_capacity_gib": 47.40,
        "gpu_free_mib": 529.69,
        "process_memory_used_gib": 46.88,
        "pytorch_allocated_gib": 33.93,
        "pytorch_reserved_unallocated_gib": 12.63,
        "pytorch_message_recommendation": "set max_split_size_mb to avoid fragmentation",
        "diagnosis": "captured CUDA OOM is consistent with allocator fragmentation",
        "diagnosis_scope": "root-observed exception text; not independently reconstructed from a persisted log",
    }
    return dataclasses.replace(
        third,
        evidence_relative_path=Path(
            "recovery_evidence/shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93-incident4"
        ),
        recovery_ordinal=4,
        prior_recoveries=third.prior_recoveries
        + (
            PriorRecoveryExpectation(
                audit_path=third_audit,
                audit_sha256="88ae87e02e4dfe9858aecd2b470bf9cfdea7b2ee08b191aa6926c309e4e5accf",
                program_id="cc-valid-r038-s0030__t5_easy_seed1",
                condition="obfuscated_plain",
                fingerprint="2ddb4eac4d9392f224b04e739a140846a058b96ff51ec42ee4aa6cdab10949ca",
                paired_seed=1006413233,
                resumed_record_relative_path=None,
                resumed_record_sha256=None,
                resume_disposition="reinterrupted_before_outcome",
            ),
        ),
        allocator_amendment=AllocatorRecoveryAmendment(
            amendment_id="shard0-incident4-pytorch-cuda-allocator-fragmentation-v1",
            environment_name="PYTORCH_CUDA_ALLOC_CONF",
            environment_value="max_split_size_mb:128",
            root_observed_runtime_error=runtime_error,
        ),
    )


def production_contract_fifth() -> RecoveryContract:
    """Strict contract after the allocator-enabled run exposed a true peak OOM."""
    fourth = production_contract_fourth()
    fourth_audit = (
        fourth.shard_root
        / "recovery_evidence"
        / "shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93-incident4"
        / "recovery_audit.json"
    )
    observation = {
        "evidence_class": "root_observed_runtime_error_not_persisted_log",
        "observed_by": "root agent through persistent captured execution",
        "persisted_runtime_log_available": False,
        "persisted_runtime_log_path": None,
        "exception_type": "torch.cuda.OutOfMemoryError",
        "call_path": [
            "steering/backends/qwen2_backend.py forward",
            "torch.nn.functional.softmax(attn_weights, dim=-1, dtype=torch.float32)",
        ],
        "allocator_environment_active": {
            "PYTORCH_CUDA_ALLOC_CONF": "max_split_size_mb:128"
        },
        "allocator_amendment_source_audit_sha256": (
            "ed0a418580d3ad79b3705635fa4ecf37ac8f8d94dca6a7d9124a06c65d9d211f"
        ),
        "allocator_amendment_source_sha256": (
            "09e4d83e3a2bd761d5f9494fa9689dc424b5907a4cb35ddb9d6cdffcf2a427f6"
        ),
        "max_split_size_mb_128_eliminated_fragmentation": True,
        "failed_allocation_gib": 12.68,
        "gpu_free_gib": 12.66,
        "process_memory_used_gib": 34.73,
        "pytorch_allocated_gib": 34.21,
        "pytorch_reserved_mib": 219.24,
        "derived_free_memory_shortfall_gib": 0.02,
        "diagnosis": (
            "allocator fragmentation was eliminated, but the softmax allocation still exceeded "
            "the reported free GPU memory"
        ),
        "diagnosis_scope": "root-observed exception text; not independently reconstructed from a persisted log",
    }
    return dataclasses.replace(
        fourth,
        evidence_relative_path=Path(
            "recovery_evidence/shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93-incident5"
        ),
        recovery_ordinal=5,
        prior_recoveries=fourth.prior_recoveries
        + (
            PriorRecoveryExpectation(
                audit_path=fourth_audit,
                audit_sha256="ed0a418580d3ad79b3705635fa4ecf37ac8f8d94dca6a7d9124a06c65d9d211f",
                program_id="cc-valid-r038-s0030__t5_easy_seed1",
                condition="obfuscated_plain",
                fingerprint="2ddb4eac4d9392f224b04e739a140846a058b96ff51ec42ee4aa6cdab10949ca",
                paired_seed=1006413233,
                resumed_record_relative_path=None,
                resumed_record_sha256=None,
                resume_disposition="reinterrupted_before_outcome",
            ),
        ),
        allocator_amendment=None,
        runtime_failure_observation=observation,
    )


def verify_pinned_hashes(contract: RecoveryContract) -> dict[str, str]:
    named_paths = {
        "plan": contract.plan_path,
        "manifest": contract.manifest_path,
        "preflight": contract.preflight_path,
        "results_index": contract.results_index_path,
        "experiment_config": contract.experiment_config_path,
    }
    named_paths.update({path.name: path for path in contract.code_paths})
    require(set(named_paths) == set(contract.expected_sha256), "pinned hash key set differs")
    observed: dict[str, str] = {}
    for name, path in named_paths.items():
        require_regular_file(path, name)
        observed[name] = sha256_file(path)
        require(
            observed[name] == contract.expected_sha256[name],
            f"{name} SHA-256 differs: {observed[name]}",
        )
    return observed


def verify_contract_documents(
    contract: RecoveryContract, observed_hashes: Mapping[str, str]
) -> tuple[dict[str, Any], list[str], str, str]:
    plan = read_json(contract.plan_path)
    manifest = read_json(contract.manifest_path)
    preflight = read_json(contract.preflight_path)
    experiment = read_json(contract.experiment_config_path)

    require(plan.get("schema_version") == "expanded-java-300-600-launch-plan-v1", "plan schema differs")
    require(plan.get("manifest_sha256") == observed_hashes["manifest"], "plan manifest hash differs")
    require(plan.get("generation") == experiment.get("generation"), "plan generation differs")
    require(manifest.get("program_count") == plan.get("program_count"), "manifest/plan count differs")
    require(preflight.get("status") == "passed", "preflight did not pass")
    require(preflight.get("study_generation_count") == 0, "preflight contains study outcomes")
    require(preflight.get("manifest_sha256") == observed_hashes["manifest"], "preflight manifest differs")
    require(preflight.get("plan_sha256") == observed_hashes["plan"], "preflight plan differs")
    require(experiment.get("manifest_sha256") == observed_hashes["manifest"], "experiment manifest differs")
    require(experiment.get("plan_sha256") == observed_hashes["plan"], "experiment plan differs")
    require(
        experiment.get("preflight_summary_sha256") == observed_hashes["preflight"],
        "experiment preflight hash differs",
    )
    require(experiment.get("protocol_version") == PROTOCOL_VERSION, "protocol differs")

    shards = [row for row in plan.get("shards", []) if row.get("shard_index") == 0]
    require(len(shards) == 1, "plan does not contain exactly one shard 0")
    shard = shards[0]
    program_ids = shard.get("program_ids")
    require(isinstance(program_ids, list), "shard program IDs are invalid")
    require(len(program_ids) == contract.expected_shard_program_count, "shard program count differs")
    require(shard.get("program_count") == len(program_ids), "registered shard count differs")
    require(contract.interrupted_program_id in program_ids, "interrupted program is not in shard 0")
    require(shard.get("gpu_id") == 0, "registered shard GPU differs")
    require(
        Path(str(shard.get("study_output_root"))).resolve(strict=False)
        == contract.shard_root.resolve(strict=True),
        "registered study output root differs",
    )
    argv = shard.get("study_argv")
    require(isinstance(argv, list) and all(isinstance(x, str) for x in argv), "study argv invalid")
    require(shlex.join(argv) == shard.get("study_shell_command"), "registered shell/argv differ")
    require("--model-preflight-only" not in argv, "study argv is a preflight argv")
    require("--gpu-id" in argv and argv[argv.index("--gpu-id") + 1] == "0", "argv GPU differs")
    require(
        "--output-root" in argv
        and Path(argv[argv.index("--output-root") + 1]).resolve(strict=False)
        == contract.shard_root.resolve(strict=True),
        "argv output root differs",
    )
    require(
        "--program-ids" in argv
        and argv[argv.index("--program-ids") + 1].split(",") == program_ids,
        "argv program IDs differ",
    )

    provenance_expected = {
        str(contract.manifest_path.resolve(strict=True)): observed_hashes["manifest"],
        str(contract.plan_path.resolve(strict=True)): observed_hashes["plan"],
    }
    provenance_expected.update(
        {str(path.resolve(strict=True)): observed_hashes[path.name] for path in contract.code_paths}
    )
    require(experiment.get("code_provenance") == provenance_expected, "experiment code provenance differs")
    require(preflight.get("code_provenance") == provenance_expected, "preflight code provenance differs")
    require(experiment.get("program_ids") == program_ids, "experiment program IDs differ")
    require(preflight.get("program_ids") == program_ids, "preflight program IDs differ")

    return shard, program_ids, str(shard.get("study_tmux_session")), str(shard["study_shell_command"])


def verify_prior_recoveries(
    contract: RecoveryContract, registered_argv: Sequence[str]
) -> list[dict[str, Any]]:
    """Verify ordered immutable evidence and the record produced after it.

    A prior infrastructure restart is acceptable only when its preserved stub
    is still byte-identical and the subsequently completed record reuses that
    audit's exact program, condition, fingerprint, seed, prompt, source, and
    run configuration.
    """
    require(
        len(contract.prior_recoveries) == contract.recovery_ordinal - 1,
        "prior recovery count does not match recovery ordinal",
    )
    verified: list[dict[str, Any]] = []
    for ordinal, expected in enumerate(contract.prior_recoveries, 1):
        audit_path = require_below(
            expected.audit_path, contract.scope_root, f"prior recovery {ordinal}", strict=True
        )
        require_regular_file(audit_path, f"prior recovery {ordinal} audit")
        require(
            sha256_file(audit_path) == expected.audit_sha256,
            f"prior recovery {ordinal} audit SHA-256 differs",
        )
        anchor = audit_path.with_suffix(".sha256")
        require_regular_file(anchor, f"prior recovery {ordinal} audit anchor")
        require(
            anchor.read_text(encoding="utf-8")
            == f"{expected.audit_sha256}  {audit_path.name}\n",
            f"prior recovery {ordinal} audit anchor differs",
        )
        audit = read_json(audit_path)
        required = {
            "schema_version": "expanded-java-300-600-infrastructure-recovery-v1",
            "status": "recovery_prepared",
            "classification": "infrastructure_restart_before_any_recorded_or_observed_model_outcome",
            "program_id": expected.program_id,
            "condition": expected.condition,
            "fingerprint": expected.fingerprint,
            "paired_seed": expected.paired_seed,
            "malformed_output_retry": False,
            "automatic_retry": False,
            "model_outcome_observed": False,
            "model_outcome_files_present": [],
            "complete_artifacts_untouched": True,
            "results_index_untouched": True,
            "registered_study_argv": list(registered_argv),
        }
        failed = [key for key, value in required.items() if audit.get(key) != value]
        require(not failed, f"prior recovery {ordinal} audit fields differ: {failed}")
        if ordinal > 1:
            require(audit.get("recovery_ordinal") == ordinal, "prior recovery ordinal differs")
            require(audit.get("prior_recovery_count") == ordinal - 1, "prior recovery count differs")
            chained = audit.get("ordered_prior_recoveries")
            require(isinstance(chained, list), "ordered prior recovery chain is absent")
            require(
                [row.get("audit_sha256") for row in chained]
                == [row["audit_sha256"] for row in verified],
                f"prior recovery {ordinal} does not pin the preceding audits in order",
            )

        incident_dir = audit_path.parent
        for path in [incident_dir, *incident_dir.rglob("*")]:
            require(not path.is_symlink(), f"symlink in prior recovery {ordinal}: {path}")
            require(
                stat.S_IMODE(path.stat().st_mode) & 0o222 == 0,
                f"prior recovery {ordinal} is writable: {path}",
            )
        preserved = require_below(
            Path(str(audit.get("preserved_attempt_path"))),
            contract.scope_root,
            f"prior recovery {ordinal} preserved attempt",
            strict=True,
        )
        require(preserved == incident_dir / "interrupted_attempt", "prior preserved path differs")
        preserved_ledger = file_ledger(preserved)
        require(
            preserved_ledger == audit.get("interrupted_attempt_files"),
            f"prior recovery {ordinal} interrupted ledger differs",
        )

        require(
            expected.resume_disposition
            in {"completed_before_next_recovery", "reinterrupted_before_outcome"},
            f"unknown prior recovery disposition: {expected.resume_disposition}",
        )
        verified_row: dict[str, Any] = {
            "ordinal": ordinal,
            "audit_path": str(audit_path),
            "audit_sha256": expected.audit_sha256,
            "program_id": expected.program_id,
            "condition": expected.condition,
            "fingerprint": expected.fingerprint,
            "paired_seed": expected.paired_seed,
            "resume_disposition": expected.resume_disposition,
        }
        if expected.resume_disposition == "completed_before_next_recovery":
            require(
                expected.resumed_record_relative_path is not None
                and expected.resumed_record_sha256 is not None,
                "completed prior recovery lacks its resumed record binding",
            )
            record_path = require_below(
                contract.shard_root / expected.resumed_record_relative_path,
                contract.scope_root,
                f"prior recovery {ordinal} resumed record",
                strict=True,
            )
            require_regular_file(record_path, f"prior recovery {ordinal} resumed record")
            require(
                sha256_file(record_path) == expected.resumed_record_sha256,
                f"prior recovery {ordinal} resumed record SHA-256 differs",
            )
            record = read_json(record_path)
            run_config_path = record_path.parent / "run_config.json"
            run_config = read_json(run_config_path)
            require(
                record.get("status") == "complete"
                and record.get("program_id") == expected.program_id
                and record.get("condition") == expected.condition
                and record.get("fingerprint") == expected.fingerprint
                and record.get("paired_seed") == expected.paired_seed
                and record.get("attempt") == 1
                and record.get("automatic_retry_used") is False,
                f"prior recovery {ordinal} resumed record identity differs",
            )
            require(
                reconstruct_fingerprint(run_config) == expected.fingerprint,
                "resumed fingerprint invalid",
            )
            require(
                sha256_file(run_config_path) == audit.get("run_config_sha256")
                and sha256_file(record_path.parent / "submitted_prompt.txt")
                == audit.get("submitted_prompt_sha256")
                and sha256_file(record_path.parent / "source.java")
                == audit.get("submitted_source_sha256"),
                f"prior recovery {ordinal} resumed configuration differs from preserved attempt",
            )
            verified_row.update(
                {
                    "resumed_record_path": str(record_path),
                    "resumed_record_sha256": expected.resumed_record_sha256,
                    "resumed_record_matches_preserved_configuration": True,
                }
            )
        else:
            require(
                expected.resumed_record_relative_path is None
                and expected.resumed_record_sha256 is None,
                "reinterrupted recovery incorrectly claims a completed record",
            )
            verified_row.update(
                {
                    "resumed_record_path": None,
                    "resumed_record_sha256": None,
                    "resumed_record_matches_preserved_configuration": False,
                    "completed_model_outcome_claimed": False,
                }
            )
        verified.append(verified_row)
    return verified


def verify_reinterrupted_prior_matches_current_setup(
    contract: RecoveryContract,
    prior_rows: Sequence[Mapping[str, Any]],
    interrupted_ledger: Mapping[str, Mapping[str, Any]],
    interrupted_config: Mapping[str, Any],
) -> dict[str, Any] | None:
    unfinished = [
        (expected, row)
        for expected, row in zip(contract.prior_recoveries, prior_rows)
        if expected.resume_disposition == "reinterrupted_before_outcome"
    ]
    if not unfinished:
        return None
    unresolved_expectations = [item[0] for item in unfinished]
    require(
        tuple(unresolved_expectations)
        == contract.prior_recoveries[-len(unresolved_expectations) :],
        "unresolved recoveries are not one consecutive trailing chain",
    )
    chain_rows: list[dict[str, Any]] = []
    for expected, verified_row in unfinished:
        prior_audit = read_json(expected.audit_path)
        require(
            expected.program_id == contract.interrupted_program_id
            and expected.condition == contract.interrupted_condition
            and expected.fingerprint == contract.interrupted_fingerprint
            and expected.paired_seed == contract.interrupted_paired_seed,
            "current interruption identity differs within unresolved recovery chain",
        )
        require(
            interrupted_ledger == prior_audit.get("interrupted_attempt_files"),
            "current setup files differ within unresolved recovery chain",
        )
        require(
            interrupted_config.get("fingerprint") == prior_audit.get("fingerprint")
            and interrupted_config.get("paired_seed") == prior_audit.get("paired_seed")
            and interrupted_ledger["run_config.json"]["sha256"]
            == prior_audit.get("run_config_sha256")
            and interrupted_ledger["submitted_prompt.txt"]["sha256"]
            == prior_audit.get("submitted_prompt_sha256")
            and interrupted_ledger["source.java"]["sha256"]
            == prior_audit.get("submitted_source_sha256"),
            "current setup fingerprint/seed/config differs within unresolved recovery chain",
        )
        chain_rows.append(
            {
                "prior_audit_ordinal": verified_row["ordinal"],
                "prior_audit_path": verified_row["audit_path"],
                "prior_audit_sha256": verified_row["audit_sha256"],
                "preserved_setup_matches_current": True,
            }
        )
    latest = chain_rows[-1]
    return {
        "prior_audit_ordinal": latest["prior_audit_ordinal"],
        "prior_audit_path": latest["prior_audit_path"],
        "prior_audit_sha256": latest["prior_audit_sha256"],
        "disposition": "reinterrupted_before_outcome",
        "consecutive_reinterruption_count": len(chain_rows),
        "consecutive_reinterruption_chain": chain_rows,
        "current_setup_matches_prior_preserved_files": True,
        "current_setup_matches_prior_fingerprint_seed_and_config": True,
        "completed_model_outcome_between_incidents": False,
    }


def build_allocator_amendment(
    contract: RecoveryContract,
    registered_argv: Sequence[str],
    interrupted_config: Mapping[str, Any],
    observed_hashes: Mapping[str, str],
) -> dict[str, Any] | None:
    amendment = contract.allocator_amendment
    if amendment is None:
        return None
    require(
        amendment.environment_name == "PYTORCH_CUDA_ALLOC_CONF"
        and amendment.environment_value == "max_split_size_mb:128",
        "allocator amendment is not the one exact registered environment delta",
    )
    error = dict(amendment.root_observed_runtime_error)
    required_error = {
        "evidence_class": "root_observed_runtime_error_not_persisted_log",
        "persisted_runtime_log_available": False,
        "persisted_runtime_log_path": None,
        "exception_type": "torch.cuda.OutOfMemoryError",
        "failed_allocation_gib": 12.68,
        "gpu_capacity_gib": 47.40,
        "gpu_free_mib": 529.69,
        "process_memory_used_gib": 46.88,
        "pytorch_allocated_gib": 33.93,
        "pytorch_reserved_unallocated_gib": 12.63,
    }
    failed = [key for key, value in required_error.items() if error.get(key) != value]
    require(not failed, f"root-observed OOM description differs: {failed}")
    call_path = error.get("call_path")
    require(
        call_path
        == [
            "steering/backends/qwen2_backend.py forward",
            "torch.nn.functional.softmax(attn_weights, dim=-1, dtype=torch.float32)",
        ],
        "root-observed OOM call path differs",
    )
    return {
        "schema_version": "expanded-java-300-600-allocator-recovery-amendment-v1",
        "status": "registered",
        "amendment_id": amendment.amendment_id,
        "scope": "process environment allocator policy only",
        "approved_environment_delta": {
            amendment.environment_name: amendment.environment_value
        },
        "approved_environment_variable_count": 1,
        "all_other_environment_changes_authorized": False,
        "registered_study_argv": list(registered_argv),
        "registered_study_argv_sha256": canonical_sha256(list(registered_argv)),
        "python_argv_unchanged": True,
        "manifest_sha256": observed_hashes["manifest"],
        "plan_sha256": observed_hashes["plan"],
        "program_id": contract.interrupted_program_id,
        "condition": contract.interrupted_condition,
        "round": 1,
        "attempt": 1,
        "fingerprint": contract.interrupted_fingerprint,
        "paired_seed": contract.interrupted_paired_seed,
        "prompt_sha256": interrupted_config.get("prompt_sha256"),
        "model_id": interrupted_config.get("model_id"),
        "model_snapshot_commit": interrupted_config.get("model_snapshot_commit"),
        "generation": interrupted_config.get("generation"),
        "chat_template_sha256": interrupted_config.get("chat_template_sha256"),
        "steering": interrupted_config.get("steering"),
        "scientific_configuration_unchanged": True,
        "model_prompt_seed_generation_unchanged": True,
        "new_statistical_trial": False,
        "malformed_output_retry": False,
        "model_outcome_observed_before_amendment": False,
        "root_observed_runtime_error": error,
        "runtime_error_log_provenance_caveat": (
            "Recorded from the root agent's captured observation; no persisted runtime log is claimed."
        ),
        "authorization": (
            "Relaunch may add only PYTORCH_CUDA_ALLOC_CONF=max_split_size_mb:128 "
            "to the process environment while passing the registered Python argv byte-for-byte unchanged."
        ),
    }


def verify_runtime_failure_observation(
    contract: RecoveryContract,
) -> dict[str, Any] | None:
    """Validate a post-amendment runtime failure without overstating its source.

    The exception text was captured by the root agent but was not written to a
    durable process log.  This verifier therefore binds the exact reported
    values and the immutable allocator amendment that was active, while
    retaining that provenance limitation verbatim.
    """
    if contract.runtime_failure_observation is None:
        return None
    observation = dict(contract.runtime_failure_observation)
    required = {
        "evidence_class": "root_observed_runtime_error_not_persisted_log",
        "observed_by": "root agent through persistent captured execution",
        "persisted_runtime_log_available": False,
        "persisted_runtime_log_path": None,
        "exception_type": "torch.cuda.OutOfMemoryError",
        "allocator_environment_active": {
            "PYTORCH_CUDA_ALLOC_CONF": "max_split_size_mb:128"
        },
        "allocator_amendment_source_audit_sha256": (
            "ed0a418580d3ad79b3705635fa4ecf37ac8f8d94dca6a7d9124a06c65d9d211f"
        ),
        "allocator_amendment_source_sha256": (
            "09e4d83e3a2bd761d5f9494fa9689dc424b5907a4cb35ddb9d6cdffcf2a427f6"
        ),
        "max_split_size_mb_128_eliminated_fragmentation": True,
        "failed_allocation_gib": 12.68,
        "gpu_free_gib": 12.66,
        "process_memory_used_gib": 34.73,
        "pytorch_allocated_gib": 34.21,
        "pytorch_reserved_mib": 219.24,
        "derived_free_memory_shortfall_gib": 0.02,
        "diagnosis_scope": (
            "root-observed exception text; not independently reconstructed from a persisted log"
        ),
    }
    failed = [key for key, value in required.items() if observation.get(key) != value]
    require(not failed, f"post-allocator OOM description differs: {failed}")
    require(
        observation.get("call_path")
        == [
            "steering/backends/qwen2_backend.py forward",
            "torch.nn.functional.softmax(attn_weights, dim=-1, dtype=torch.float32)",
        ],
        "post-allocator OOM call path differs",
    )
    require(
        contract.allocator_amendment is None,
        "post-allocator failure must not register a second allocator amendment",
    )
    require(contract.prior_recoveries, "post-allocator failure lacks a prior recovery")
    latest = contract.prior_recoveries[-1]
    require(
        latest.audit_sha256 == observation["allocator_amendment_source_audit_sha256"],
        "post-allocator observation is not bound to the latest recovery audit",
    )
    latest_audit = read_json(latest.audit_path)
    amendment_path = latest.audit_path.parent / "allocator_amendment.json"
    require_regular_file(amendment_path, "prior allocator amendment")
    require(
        sha256_file(amendment_path)
        == observation["allocator_amendment_source_sha256"]
        == latest_audit.get("allocator_amendment_sha256"),
        "post-allocator observation is not bound to the prior allocator amendment",
    )
    require(
        latest_audit.get("approved_environment_delta")
        == observation["allocator_environment_active"],
        "post-allocator observation environment differs from its amendment",
    )
    return observation


def verify_complete_artifacts(
    contract: RecoveryContract,
) -> tuple[dict[str, dict[str, Any]], dict[str, str], set[Path]]:
    index = read_json(contract.results_index_path)
    rows = index.get("runs")
    require(isinstance(rows, list), "results index rows are invalid")
    require(
        index.get("completed_generation_count") == contract.completed_generation_count == len(rows),
        "completed generation count differs",
    )
    require(
        index.get("completed_label_judgment_count") == len(rows) * 6,
        "completed label count differs",
    )
    require(index.get("protocol_version") == PROTOCOL_VERSION, "results index protocol differs")

    all_files: dict[str, dict[str, Any]] = {}
    record_hashes: dict[str, str] = {}
    completed_dirs: set[Path] = set()
    for row in rows:
        require(isinstance(row, Mapping), "results index row is not an object")
        relative = Path(str(row.get("record_path") or ""))
        require(not relative.is_absolute() and ".." not in relative.parts, "record path escapes shard")
        require(
            len(relative.parts) == 5
            and relative.parts[0] == "runs"
            and relative.parts[2] == "trial_001"
            and relative.name == "record.json",
            f"record path shape differs: {relative}",
        )
        record_path = contract.shard_root / relative
        require_regular_file(record_path, "completed record")
        run_dir = record_path.parent
        require(run_dir not in completed_dirs, f"duplicate completed directory: {run_dir}")
        completed_dirs.add(run_dir)
        names = {entry.name for entry in run_dir.iterdir()}
        require(names == COMPLETE_FILE_NAMES, f"completed file set differs: {run_dir}: {sorted(names)}")
        ledger = file_ledger(run_dir)
        require(set(ledger) == COMPLETE_FILE_NAMES, f"nested/extra completed files: {run_dir}")

        record = read_json(record_path)
        status = read_json(run_dir / "status.json")
        run_config = read_json(run_dir / "run_config.json")
        require(record == status, f"record/status differ: {run_dir}")
        require(record.get("status") == "complete", f"record not complete: {record_path}")
        require(record.get("attempt") == 1 and record.get("automatic_retry_used") is False, "retry found")
        require(record.get("program_id") == row.get("program_id"), "index/record program differs")
        require(record.get("condition") == row.get("condition"), "index/record condition differs")
        require(record.get("paired_seed") == row.get("paired_seed"), "index/record seed differs")
        require(record.get("fingerprint") == run_config.get("fingerprint"), "record/config fingerprint differs")
        require(reconstruct_fingerprint(run_config) == record.get("fingerprint"), "completed fingerprint invalid")

        relative_dir = run_dir.relative_to(contract.shard_root)
        for name, evidence in ledger.items():
            all_files[(relative_dir / name).as_posix()] = evidence
        record_hashes[relative.as_posix()] = sha256_file(record_path)

    require(len(all_files) == contract.completed_artifact_count, "completed artifact count differs")
    require(
        canonical_sha256(compact_hash_ledger(all_files))
        == contract.completed_artifacts_canonical_sha256,
        "completed artifact ledger hash differs",
    )
    return all_files, record_hashes, completed_dirs


def verify_only_expected_live_attempts(
    contract: RecoveryContract, completed_dirs: set[Path], interrupted: Path
) -> None:
    runs = contract.shard_root / "runs"
    require(runs.is_dir() and not runs.is_symlink(), "runs directory is invalid")
    observed_condition_dirs: set[Path] = set()
    for path in runs.rglob("*"):
        require(not path.is_symlink(), f"symlink in live runs: {path}")
        relative = path.relative_to(runs)
        if path.is_file():
            require(len(relative.parts) == 4, f"file at unexpected live depth: {path}")
            observed_condition_dirs.add(path.parent)
        elif path.is_dir():
            require(len(relative.parts) <= 3, f"nested directory in condition attempt: {path}")
            if len(relative.parts) == 3:
                observed_condition_dirs.add(path)
        else:
            raise RecoveryError(f"non-file live entry: {path}")
    require(
        observed_condition_dirs == completed_dirs | {interrupted},
        "live condition directory set differs from 30 completed plus one interrupted attempt",
    )


def verify_interrupted_attempt(
    contract: RecoveryContract,
    interrupted: Path,
    observed_hashes: Mapping[str, str],
) -> tuple[dict[str, dict[str, Any]], dict[str, Any]]:
    ledger = file_ledger(interrupted)
    require(set(ledger) == INTERRUPTED_FILE_NAMES, f"interrupted allowlist differs: {sorted(ledger)}")
    require(ledger == dict(contract.interrupted_files), "interrupted file hashes or sizes differ")
    require(not (set(ledger) & MODEL_OUTCOME_FILE_NAMES), "interrupted attempt contains model outcome")

    status = read_json(interrupted / "status.json")
    require(status == {"attempt": 1, "status": "running"}, "interrupted status differs")
    config = read_json(interrupted / "run_config.json")
    require(config.get("program_id") == contract.interrupted_program_id, "interrupted program differs")
    require(config.get("condition") == contract.interrupted_condition, "interrupted condition differs")
    require(config.get("attempt") == 1, "interrupted attempt number differs")
    require(config.get("automatic_retry_allowed") is False, "automatic retry was allowed")
    require(config.get("manifest_sha256") == observed_hashes["manifest"], "run manifest differs")
    require(config.get("plan_sha256") == observed_hashes["plan"], "run plan differs")
    require(config.get("paired_seed") == contract.interrupted_paired_seed, "paired seed differs")
    require(paired_seed(contract.interrupted_program_id) == contract.interrupted_paired_seed, "seed derivation differs")
    require(config.get("fingerprint") == contract.interrupted_fingerprint, "fingerprint differs")
    require(reconstruct_fingerprint(config) == contract.interrupted_fingerprint, "fingerprint reconstruction differs")
    require(config.get("source_kind") == contract.source_kind, "interrupted source kind differs")
    require(config.get("activation_steering") is False and config.get("steering") is None, "steering differs")
    require(config.get("hidden_labels_in_prompt") is False, "hidden-label setting differs")
    require(
        sha256_file(interrupted / "submitted_prompt.txt") == config.get("prompt_sha256"),
        "submitted prompt/config hash differs",
    )
    require(
        config.get("chat_template_evidence", {}).get("rendered_prompt_sha256")
        == config.get("prompt_sha256"),
        "rendered prompt/config hash differs",
    )

    manifest = read_json(contract.manifest_path)
    rows = [row for row in manifest.get("programs", []) if row.get("id") == contract.interrupted_program_id]
    require(len(rows) == 1, "interrupted program manifest row differs")
    row = rows[0]
    source = (
        contract.manifest_path.parent / str(row.get(contract.manifest_source_path_key))
    ).resolve(strict=True)
    require_below(source, contract.manifest_path.parent, "frozen source", strict=True)
    require(
        row.get(contract.manifest_source_sha256_key) == sha256_file(source),
        "frozen source hash differs",
    )
    require((interrupted / "source.java").read_bytes() == source.read_bytes(), "submitted source differs")
    require(config.get("case_ids_in_prompt_order") == [x.get("id") for x in row.get("cases", [])], "case IDs differ")
    return ledger, config


def assert_no_live_runner(contract: RecoveryContract) -> None:
    if not contract.check_process_table:
        return
    needle_script = str((HERE / "run_shard.py").resolve(strict=True)).encode()
    needle_output = str(contract.shard_root.resolve(strict=True)).encode()
    for proc in Path("/proc").glob("[0-9]*"):
        if int(proc.name) == os.getpid():
            continue
        try:
            command = (proc / "cmdline").read_bytes()
        except (FileNotFoundError, PermissionError, ProcessLookupError, OSError):
            continue
        if needle_script in command and needle_output in command:
            raise RecoveryError(f"a shard-0 runner is still live (PID {proc.name})")


def make_read_only(directory: Path) -> None:
    for path in sorted(directory.rglob("*"), reverse=True):
        if path.is_file():
            path.chmod(stat.S_IRUSR | stat.S_IRGRP | stat.S_IROTH)
        elif path.is_dir():
            path.chmod(
                stat.S_IRUSR
                | stat.S_IXUSR
                | stat.S_IRGRP
                | stat.S_IXGRP
                | stat.S_IROTH
                | stat.S_IXOTH
            )
    directory.chmod(
        stat.S_IRUSR
        | stat.S_IXUSR
        | stat.S_IRGRP
        | stat.S_IXGRP
        | stat.S_IROTH
        | stat.S_IXOTH
    )


def inspect(contract: RecoveryContract) -> dict[str, Any]:
    scope = contract.scope_root.resolve(strict=True)
    shard_root = require_below(contract.shard_root, scope, "shard root", strict=True)
    require_below(contract.plan_path, scope, "plan", strict=True)
    require_below(contract.manifest_path, scope, "manifest", strict=True)
    require_below(contract.preflight_path, scope, "preflight", strict=True)
    require_below(contract.results_index_path, scope, "results index", strict=True)
    require_below(contract.experiment_config_path, scope, "experiment config", strict=True)
    for path in contract.code_paths:
        # Production dependencies are still below PromptSteering, the parent of
        # this incident work directory; they are read-only inputs here.
        require_regular_file(path, "code dependency")

    interrupted = require_below(
        shard_root / contract.interrupted_relative_path, scope, "interrupted attempt", strict=True
    )
    final_evidence = require_below(
        shard_root / contract.evidence_relative_path, scope, "recovery evidence", strict=False
    )
    require(not final_evidence.exists(), f"recovery evidence already exists: {final_evidence}")

    observed_hashes = verify_pinned_hashes(contract)
    shard, program_ids, session, shell_command = verify_contract_documents(contract, observed_hashes)
    prior_recoveries = verify_prior_recoveries(contract, shard["study_argv"])
    complete_ledger, record_hashes, completed_dirs = verify_complete_artifacts(contract)
    verify_only_expected_live_attempts(contract, completed_dirs, interrupted)
    interrupted_ledger, interrupted_config = verify_interrupted_attempt(
        contract, interrupted, observed_hashes
    )
    repeated_setup = verify_reinterrupted_prior_matches_current_setup(
        contract, prior_recoveries, interrupted_ledger, interrupted_config
    )
    allocator_amendment = build_allocator_amendment(
        contract, shard["study_argv"], interrupted_config, observed_hashes
    )
    runtime_failure_observation = verify_runtime_failure_observation(contract)
    assert_no_live_runner(contract)
    return {
        "scope": scope,
        "shard_root": shard_root,
        "interrupted": interrupted,
        "final_evidence": final_evidence,
        "observed_hashes": observed_hashes,
        "shard": shard,
        "program_ids": program_ids,
        "session": session,
        "shell_command": shell_command,
        "argv": list(shard["study_argv"]),
        "complete_ledger": complete_ledger,
        "record_hashes": record_hashes,
        "completed_dirs": completed_dirs,
        "interrupted_ledger": interrupted_ledger,
        "interrupted_config": interrupted_config,
        "prior_recoveries": prior_recoveries,
        "reinterrupted_prior_setup_match": repeated_setup,
        "allocator_amendment": allocator_amendment,
        "runtime_failure_observation": runtime_failure_observation,
    }


def recover(contract: RecoveryContract, *, apply: bool) -> dict[str, Any]:
    evidence = inspect(contract)
    if not apply:
        result = {
            "status": "recovery_check_passed",
            "model_inference_performed": False,
            "filesystem_mutation_performed": False,
            "registered_study_argv": evidence["argv"],
            "registered_study_shell_command": evidence["shell_command"],
            "registered_tmux_session": evidence["session"],
        }
        if evidence["allocator_amendment"] is not None:
            result["registered_allocator_environment_delta"] = evidence[
                "allocator_amendment"
            ]["approved_environment_delta"]
            result["python_argv_unchanged"] = True
        return result

    interrupted: Path = evidence["interrupted"]
    final_evidence: Path = evidence["final_evidence"]
    recovery_root = final_evidence.parent
    require_below(recovery_root, contract.scope_root, "recovery root", strict=False)
    recovery_root.mkdir(parents=True, exist_ok=True)
    require(not recovery_root.is_symlink(), "recovery root is a symlink")
    staging = recovery_root / f".{final_evidence.name}.staging-{os.getpid()}"
    require(not staging.exists() and not final_evidence.exists(), "recovery destination collision")
    staging.mkdir(mode=0o700)

    complete_ledger_path = staging / "complete_artifacts_before.json"
    interrupted_ledger_path = staging / "interrupted_attempt_files.json"
    atomic_json(complete_ledger_path, evidence["complete_ledger"])
    atomic_json(interrupted_ledger_path, evidence["interrupted_ledger"])
    allocator_path: Path | None = None
    allocator_sha: str | None = None
    if evidence["allocator_amendment"] is not None:
        allocator_path = staging / "allocator_amendment.json"
        atomic_json(allocator_path, evidence["allocator_amendment"])
        allocator_sha = sha256_file(allocator_path)
        atomic_text(
            staging / "allocator_amendment.sha256",
            f"{allocator_sha}  allocator_amendment.json\n",
        )

    # Recheck the volatile source immediately before the one operation that
    # removes it from the live tree.
    assert_no_live_runner(contract)
    require(
        file_ledger(interrupted) == evidence["interrupted_ledger"],
        "interrupted attempt changed before preservation",
    )
    source_stat = interrupted.stat()
    preserved_attempt = staging / "interrupted_attempt"
    os.replace(interrupted, preserved_attempt)  # same-filesystem atomic rename
    preserved_stat = preserved_attempt.stat()
    require(
        (source_stat.st_dev, source_stat.st_ino) == (preserved_stat.st_dev, preserved_stat.st_ino),
        "atomic rename did not preserve the directory inode",
    )
    require(not interrupted.exists(), "interrupted directory remains in live tree")
    require(
        file_ledger(preserved_attempt) == evidence["interrupted_ledger"],
        "preserved interrupted evidence differs",
    )

    complete_after, record_hashes_after, _ = verify_complete_artifacts(contract)
    require(complete_after == evidence["complete_ledger"], "completed artifacts changed during recovery")
    require(record_hashes_after == evidence["record_hashes"], "completed records changed during recovery")
    require(
        sha256_file(contract.results_index_path) == evidence["observed_hashes"]["results_index"],
        "results index changed during recovery",
    )

    interrupted_files_sha = sha256_file(interrupted_ledger_path)
    complete_ledger_file_sha = sha256_file(complete_ledger_path)
    audit = {
        "schema_version": "expanded-java-300-600-infrastructure-recovery-v1",
        "status": "recovery_prepared",
        "recovery_ordinal": contract.recovery_ordinal,
        "created_at_unix": time.time(),
        "classification": "infrastructure_restart_before_any_recorded_or_observed_model_outcome",
        "reason": (
            "allocator-enabled run hit a root-observed torch.cuda.OutOfMemoryError at the "
            "float32 attention softmax while the first-attempt directory still had setup "
            "evidence only"
            if evidence["runtime_failure_observation"] is not None
            else (
                "root-observed torch.cuda.OutOfMemoryError while the first-attempt directory "
                "still had setup evidence only"
                if evidence["allocator_amendment"] is not None
                else "shard process exited while the first-attempt directory had setup evidence only"
            )
        ),
        "shard_index": 0,
        "program_id": contract.interrupted_program_id,
        "condition": contract.interrupted_condition,
        "round": 1,
        "attempt": 1,
        "fingerprint": contract.interrupted_fingerprint,
        "paired_seed": contract.interrupted_paired_seed,
        "same_fingerprint_seed_and_config_required_on_relaunch": True,
        "new_statistical_trial": False,
        "malformed_output_retry": False,
        "automatic_retry": False,
        "model_outcome_observed": False,
        "model_outcome_files_present": [],
        "model_outcome_file_denylist": sorted(MODEL_OUTCOME_FILE_NAMES),
        "interrupted_file_allowlist": sorted(INTERRUPTED_FILE_NAMES),
        "interrupted_attempt_files": evidence["interrupted_ledger"],
        "interrupted_attempt_files_ledger": "interrupted_attempt_files.json",
        "interrupted_attempt_files_ledger_sha256": interrupted_files_sha,
        "live_interrupted_path_before": str(interrupted),
        "live_interrupted_path_absent_after": True,
        "preserved_attempt_path": str(final_evidence / "interrupted_attempt"),
        "preservation_method": "same-filesystem atomic directory rename (os.replace)",
        "preserved_directory_device": preserved_stat.st_dev,
        "preserved_directory_inode": preserved_stat.st_ino,
        "evidence_read_only_modes_applied": True,
        "recovery_tool_path": str(Path(__file__).resolve()),
        "recovery_tool_sha256": sha256_file(Path(__file__).resolve()),
        "pinned_sha256": evidence["observed_hashes"],
        "run_config_sha256": evidence["interrupted_ledger"]["run_config.json"]["sha256"],
        "submitted_prompt_sha256": evidence["interrupted_ledger"]["submitted_prompt.txt"]["sha256"],
        "submitted_source_sha256": evidence["interrupted_ledger"]["source.java"]["sha256"],
        "completed_generation_count_before": contract.completed_generation_count,
        "completed_generation_count_after": contract.completed_generation_count,
        "completed_record_sha256_before": evidence["record_hashes"],
        "completed_record_sha256_after_recovery": record_hashes_after,
        "complete_artifact_count": contract.completed_artifact_count,
        "complete_artifacts_content_ledger_sha256": contract.completed_artifacts_canonical_sha256,
        "complete_artifacts_ledger": "complete_artifacts_before.json",
        "complete_artifacts_ledger_file_sha256": complete_ledger_file_sha,
        "complete_artifacts_untouched": True,
        "results_index_untouched": True,
        "ordered_prior_recoveries": evidence["prior_recoveries"],
        "prior_recovery_count": len(evidence["prior_recoveries"]),
        "prior_completed_recovered_records_match_preserved_fingerprint_seed_and_config": True,
        "latest_reinterrupted_prior_setup_match": evidence["reinterrupted_prior_setup_match"],
        "completed_model_outcome_between_latest_recovery_incidents": (
            False if evidence["reinterrupted_prior_setup_match"] is not None else None
        ),
        "allocator_recovery_amendment_registered": evidence["allocator_amendment"] is not None,
        "allocator_amendment_path": (
            str(final_evidence / "allocator_amendment.json")
            if evidence["allocator_amendment"] is not None
            else None
        ),
        "allocator_amendment_sha256": allocator_sha,
        "approved_environment_delta": (
            evidence["allocator_amendment"]["approved_environment_delta"]
            if evidence["allocator_amendment"] is not None
            else None
        ),
        "registered_python_argv_unchanged_by_allocator_amendment": (
            True if evidence["allocator_amendment"] is not None else None
        ),
        "root_observed_runtime_error": (
            evidence["runtime_failure_observation"]
            if evidence["runtime_failure_observation"] is not None
            else (
                evidence["allocator_amendment"]["root_observed_runtime_error"]
                if evidence["allocator_amendment"] is not None
                else None
            )
        ),
        "post_allocator_runtime_failure_registered": (
            evidence["runtime_failure_observation"] is not None
        ),
        "runtime_error_persisted_log_claimed": False,
        "registered_study_argv": evidence["argv"],
        "registered_study_shell_command": evidence["shell_command"],
        "registered_tmux_session": evidence["session"],
        "manual_relaunch_required": True,
        "model_inference_performed_by_recovery": False,
    }
    audit_path = staging / "recovery_audit.json"
    atomic_json(audit_path, audit)
    audit_sha = sha256_file(audit_path)
    atomic_text(staging / "recovery_audit.sha256", f"{audit_sha}  recovery_audit.json\n")

    make_read_only(staging)
    os.replace(staging, final_evidence)
    require(final_evidence.is_dir() and not staging.exists(), "final evidence rename failed")
    require(sha256_file(final_evidence / "recovery_audit.json") == audit_sha, "final audit differs")
    if allocator_sha is not None:
        require(
            sha256_file(final_evidence / "allocator_amendment.json") == allocator_sha,
            "final allocator amendment differs",
        )
    require(
        file_ledger(final_evidence / "interrupted_attempt") == evidence["interrupted_ledger"],
        "final preserved attempt differs",
    )
    complete_final, records_final, _ = verify_complete_artifacts(contract)
    require(complete_final == evidence["complete_ledger"], "completed artifacts changed after finalization")
    require(records_final == evidence["record_hashes"], "completed records changed after finalization")

    result = {
        "status": "recovery_prepared",
        "recovery_audit": str(final_evidence / "recovery_audit.json"),
        "recovery_audit_sha256": audit_sha,
        "preserved_attempt": str(final_evidence / "interrupted_attempt"),
        "completed_generation_count_untouched": contract.completed_generation_count,
        "model_outcome_observed": False,
        "model_inference_performed": False,
        "registered_study_argv": evidence["argv"],
        "registered_study_shell_command": evidence["shell_command"],
        "registered_tmux_session": evidence["session"],
    }
    if allocator_sha is not None:
        result.update(
            {
                "allocator_amendment": str(final_evidence / "allocator_amendment.json"),
                "allocator_amendment_sha256": allocator_sha,
                "registered_allocator_environment_delta": evidence[
                    "allocator_amendment"
                ]["approved_environment_delta"],
                "python_argv_unchanged": True,
            }
        )
    return result


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    mode = parser.add_mutually_exclusive_group(required=True)
    mode.add_argument("--check", action="store_true", help="validate without writing")
    mode.add_argument("--apply", action="store_true", help="atomically prepare recovery evidence")
    parser.add_argument(
        "--incident",
        choices=("first", "second", "third", "fourth", "fifth"),
        default="fifth",
        help="exact pinned infrastructure incident (default: fifth)",
    )
    return parser.parse_args(argv)


def main(argv: Sequence[str] | None = None) -> int:
    args = parse_args(argv)
    contracts = {
        "first": production_contract_first,
        "second": production_contract_second,
        "third": production_contract_third,
        "fourth": production_contract_fourth,
        "fifth": production_contract_fifth,
    }
    contract = contracts[args.incident]()
    result = recover(contract, apply=args.apply)
    print(json.dumps(result, indent=2, sort_keys=True))
    return 0


if __name__ == "__main__":
    try:
        raise SystemExit(main())
    except RecoveryError as exc:
        print(f"REFUSED: {exc}", file=sys.stderr)
        raise SystemExit(2)
