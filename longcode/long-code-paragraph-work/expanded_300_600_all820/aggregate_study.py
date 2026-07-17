#!/usr/bin/env python3
"""Fail-closed verifier and deterministic aggregator for the 152-program study.

This auditor is deliberately independent of ``run_shard.py``: it does not
import the inference runner and never loads a model.  It validates the frozen
manifest, launch plan, outcome-free preflights, shard configuration, every
record and its supporting artifacts, reparses every raw completion, and
recomputes every score from the hidden labels in the frozen manifest.

No aggregate output is created unless the complete registered 152 x 3 record
set passes.  The output package is written by an atomic directory rename and
is never overwritten.
"""

from __future__ import annotations

import argparse
import dataclasses
import hashlib
import json
import os
import re
import shutil
import sys
import tempfile
from collections import Counter
from pathlib import Path
from typing import Any, Mapping, Optional, Sequence


sys.dont_write_bytecode = True

HERE = Path(__file__).resolve().parent
MANIFEST_PATH = HERE / "frozen_model_eligible_t130" / "inference_manifest.json"
PLAN_PATH = HERE / "launch_plan_model_eligible_t130.json"
RUNNER_PATH = HERE / "run_shard.py"
V2_PATH = HERE.parent / "binary_task" / "v2" / "run_binary_v2.py"
STUDY_ROOT = HERE / "results" / "study"
DEFAULT_OUTPUT = HERE / "results" / "aggregate" / "final_152_t130"

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
MODEL_NAME = "Qwen/Qwen2.5-Coder-7B-Instruct"
MODEL_COMMIT = "c03e6d358207e414f1eca0bb1891e29f1db0e242"
CHAT_TEMPLATE_SHA256 = "cd8e9439f0570856fd70470bf8889ebd8b5d1107207f67a5efb46e342330527f"
TOKENIZER_CONFIG_SHA256 = "959e7f1d9a1b7641a6d6ce05ca97b75c7894fcb66cbe5a040406458fb1128ee4"
ENGINE_LIVENESS_SHA256 = "4ef00416219b1a986eaf269ef545979449a6148d320ffd5a1a3b75c90dc9e429"
CHAT_SUFFIX = "<|im_start|>assistant\n"
CHAT_PREFIX = (
    "<|im_start|>system\nYou are Qwen, created by Alibaba Cloud. "
    "You are a helpful assistant.<|im_end|>\n<|im_start|>user\n"
)
SCORING_POLICY = (
    "Exactly one whole/fenced/embedded object must map exactly the six expected IDs to "
    "exact T/F strings. Any parse/schema/key/value error invalidates all six; no partial "
    "salvage, repair, retry, or drop."
)
MODEL_CONFIG = {
    "architectures": ["Qwen2ForCausalLM"],
    "model_type": "qwen2",
    "hidden_size": 3584,
    "num_hidden_layers": 28,
    "num_attention_heads": 28,
    "num_key_value_heads": 4,
    "vocab_size": 152064,
    "torch_dtype": "bfloat16",
}
CODESTEER_PROFILE = {
    "enabled_levels": [2],
    "prior": "slice_hybrid",
    "beta_post": 0.8,
    "beta_bias": 0,
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
    "decode_only": True,
    "split_prefill": True,
    "steer_layer_start": 20,
    "steer_layer_end": 27,
    "steering_enabled": True,
    "model_name": MODEL_NAME,
}
RUN_FILES = frozenset(
    {
        "record.json",
        "status.json",
        "run_config.json",
        "submitted_prompt.txt",
        "source.java",
        "raw_completion.txt",
        "score.json",
        "generated_token_evidence.json",
        "steering_debug.json",
        "model_output.json",
    }
)


class AuditError(RuntimeError):
    """A fail-closed protocol or artifact integrity violation."""


class JSONObject(list):
    """Preserve duplicate JSON object keys for independent parsing."""


@dataclasses.dataclass(frozen=True)
class RecoveryExpectation:
    evidence_relative_path: str
    audit_sha256: str
    tool_path: Path
    tool_sha256: str
    initial_results_index_sha256: str
    experiment_config_sha256: str
    shard_index: int
    program_id: str
    condition: str
    fingerprint: str
    paired_seed: int
    supplemental_files: tuple[tuple[str, str], ...] = ()
    reason: str = "shard process exited while the first-attempt directory had setup evidence only"
    allocator_audit_mode: str = "none"


@dataclasses.dataclass(frozen=True)
class ResourceOOMSkipExpectation:
    """One pre-registered, outcome-free cell excluded for a physical GPU limit."""

    marker_relative_path: str
    marker_sha256: str
    shard_index: int
    program_id: str
    condition: str
    fingerprint: str
    paired_seed: int
    evidence_kind: str
    observed_condition: str
    incident_recovery_evidence_relative_path: str
    incident_recovery_audit_sha256: str


@dataclasses.dataclass(frozen=True)
class ResourceSkipResumeExpectation:
    amendment_relative_path: str
    amendment_sha256: str
    shard_index: int
    registrar_path: Path
    registrar_sha256: str
    wrapper_path: Path
    wrapper_sha256: str
    test_path: Path
    test_sha256: str


@dataclasses.dataclass(frozen=True)
class AuditSpec:
    root: Path
    manifest_path: Path
    plan_path: Path
    runner_path: Path
    v2_path: Path
    study_root: Path
    expected_manifest_sha256: str
    expected_plan_sha256: str
    expected_runner_sha256: str
    expected_v2_sha256: str
    expected_preflight_sha256: tuple[str, ...]
    expected_program_count: int
    expected_gpu_ids: tuple[int, ...]
    recoveries: tuple[RecoveryExpectation, ...] = ()
    resource_oom_skips: tuple[ResourceOOMSkipExpectation, ...] = ()
    resource_skip_resume: Optional[ResourceSkipResumeExpectation] = None


PRODUCTION_SPEC = AuditSpec(
    root=HERE,
    manifest_path=MANIFEST_PATH,
    plan_path=PLAN_PATH,
    runner_path=RUNNER_PATH,
    v2_path=V2_PATH,
    study_root=STUDY_ROOT,
    expected_manifest_sha256="93160336e3177a900594a016f27a41aa0946bf61c4f363e2bfaf502f48c8ca02",
    expected_plan_sha256="41c7f61a5f1299fa6be1895700dff5f56a84512f4b809ce2261b3b0ef2279b25",
    expected_runner_sha256="5c3c83e2f81ba645174b7ae6ad580ee21cd490bb72f1efbfc75ced80584da6cb",
    expected_v2_sha256="3c1cdd87a4d604763c9258e0654147c7a01f01521462c40a3522b70823f2cce5",
    expected_preflight_sha256=(
        "c72986b43296995efbdcec084926ee59c23c3f8fc7bc7afb081d8bc6b7eb612a",
        "af21204fcfa2e94f3c7f19d46170980ae0843075f6f2c141ad97251cbc7bffb5",
        "4421f175eaebe0ee653598c59abc3be22a6f40440a979326ac875b32a9773449",
        "3b52b511c87f717a3dad6b1c7b9de5673a2c1c69e2bcc268f5dfef5c43659f4d",
    ),
    expected_program_count=152,
    expected_gpu_ids=(0, 1, 2, 3),
    recoveries=(
        RecoveryExpectation(
            evidence_relative_path=(
                "results/study/shard_0/recovery_evidence/"
                "shard0-r038-s0030-original_plain-a00777477544"
            ),
            audit_sha256="615e1c7f4c9f50053502b26ff2b4fd0d30d3684718c5d794834fdedbb1d2d733",
            tool_path=HERE / "recover_interrupted_shard0.py",
            tool_sha256="61767574cac30eceaff2b9a22fca03367f3de7f3ebee2d650dc04df5441320a6",
            initial_results_index_sha256="5a8b5e13d454fe72b729fe2b206ca696fcb68567480172004fc517df713b861d",
            experiment_config_sha256="f30126892e3089db44ae9b4652ae13a131fb9179ed709ca5d16e3e26c3905d19",
            shard_index=0,
            program_id="cc-valid-r038-s0030__t5_easy_seed1",
            condition="original_plain",
            fingerprint="a00777477544da5bfbc03f8578daac0851a9d2517429eb312cd35cdc2267fd03",
            paired_seed=1006413233,
        ),
        RecoveryExpectation(
            evidence_relative_path=(
                "results/study/shard_0/recovery_evidence/"
                "shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93"
            ),
            audit_sha256="799509beb03c25f1219b89a8979a87a0638aa0dd9790251def56bee20ba15921",
            tool_path=HERE / "recover_interrupted_shard0.py",
            tool_sha256="1a04d5f5015208c18bd5b2ac99729e37a6efc97ed328cccdef96833e42d5208f",
            initial_results_index_sha256="aaca481c901236498a08910dae18913e0ec057c3d61ad414e9b49e90f83ac320",
            experiment_config_sha256="f30126892e3089db44ae9b4652ae13a131fb9179ed709ca5d16e3e26c3905d19",
            shard_index=0,
            program_id="cc-valid-r038-s0030__t5_easy_seed1",
            condition="obfuscated_plain",
            fingerprint="2ddb4eac4d9392f224b04e739a140846a058b96ff51ec42ee4aa6cdab10949ca",
            paired_seed=1006413233,
        ),
        RecoveryExpectation(
            evidence_relative_path=(
                "results/study/shard_0/recovery_evidence/"
                "shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93-incident3"
            ),
            audit_sha256="88ae87e02e4dfe9858aecd2b470bf9cfdea7b2ee08b191aa6926c309e4e5accf",
            tool_path=HERE / "recover_interrupted_shard0.py",
            tool_sha256="4651535144773acc8112ffa65278b944d8b0bbc56d1d5cb85aeee4d24714e8b6",
            initial_results_index_sha256="aaca481c901236498a08910dae18913e0ec057c3d61ad414e9b49e90f83ac320",
            experiment_config_sha256="f30126892e3089db44ae9b4652ae13a131fb9179ed709ca5d16e3e26c3905d19",
            shard_index=0,
            program_id="cc-valid-r038-s0030__t5_easy_seed1",
            condition="obfuscated_plain",
            fingerprint="2ddb4eac4d9392f224b04e739a140846a058b96ff51ec42ee4aa6cdab10949ca",
            paired_seed=1006413233,
        ),
        RecoveryExpectation(
            evidence_relative_path=(
                "results/study/shard_0/recovery_evidence/"
                "shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93-incident4"
            ),
            audit_sha256="ed0a418580d3ad79b3705635fa4ecf37ac8f8d94dca6a7d9124a06c65d9d211f",
            tool_path=HERE / "recover_interrupted_shard0.py",
            tool_sha256="042b14636482b1a3542122f246661ed359a089b948d471d4bb8bffe591e21879",
            initial_results_index_sha256="aaca481c901236498a08910dae18913e0ec057c3d61ad414e9b49e90f83ac320",
            experiment_config_sha256="f30126892e3089db44ae9b4652ae13a131fb9179ed709ca5d16e3e26c3905d19",
            shard_index=0,
            program_id="cc-valid-r038-s0030__t5_easy_seed1",
            condition="obfuscated_plain",
            fingerprint="2ddb4eac4d9392f224b04e739a140846a058b96ff51ec42ee4aa6cdab10949ca",
            paired_seed=1006413233,
            supplemental_files=(
                (
                    "allocator_amendment.json",
                    "09e4d83e3a2bd761d5f9494fa9689dc424b5907a4cb35ddb9d6cdffcf2a427f6",
                ),
                (
                    "allocator_amendment.sha256",
                    "f168eff82009cda527b2bcb862fbbbe296d250c7ae4aae1933e86c6ca1a687c6",
                ),
            ),
            reason=(
                "root-observed torch.cuda.OutOfMemoryError while the first-attempt directory "
                "still had setup evidence only"
            ),
            allocator_audit_mode="registered_amendment",
        ),
        RecoveryExpectation(
            evidence_relative_path=(
                "results/study/shard_0/recovery_evidence/"
                "shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93-incident5"
            ),
            audit_sha256="506c74f2bfc490463e40bb95c204f54dd004acfdc44cb4d3594398ba09e330f5",
            tool_path=HERE / "recover_interrupted_shard0.py",
            tool_sha256="5454878b5ecd6d1af886ef8af9b78d34266af93ae32f1e0178f3cf4cedaa6ae3",
            initial_results_index_sha256="aaca481c901236498a08910dae18913e0ec057c3d61ad414e9b49e90f83ac320",
            experiment_config_sha256="f30126892e3089db44ae9b4652ae13a131fb9179ed709ca5d16e3e26c3905d19",
            shard_index=0,
            program_id="cc-valid-r038-s0030__t5_easy_seed1",
            condition="obfuscated_plain",
            fingerprint="2ddb4eac4d9392f224b04e739a140846a058b96ff51ec42ee4aa6cdab10949ca",
            paired_seed=1006413233,
            reason=(
                "allocator-enabled run hit a root-observed torch.cuda.OutOfMemoryError at the "
                "float32 attention softmax while the first-attempt directory still had setup "
                "evidence only"
            ),
            allocator_audit_mode="post_allocator_oom",
        ),
    ),
    resource_oom_skips=(
        ResourceOOMSkipExpectation(
            marker_relative_path=(
                "results/study/shard_0/resource_skips/"
                "cc-valid-r038-s0030__t5_easy_seed1/trial_001/"
                "obfuscated_plain/resource_skip.json"
            ),
            marker_sha256="54fb6321ff2a769ffcba3f99702defaf6366314359879b4668e87491b345f492",
            shard_index=0,
            program_id="cc-valid-r038-s0030__t5_easy_seed1",
            condition="obfuscated_plain",
            fingerprint="2ddb4eac4d9392f224b04e739a140846a058b96ff51ec42ee4aa6cdab10949ca",
            paired_seed=1006413233,
            evidence_kind="observed_cuda_oom",
            observed_condition="obfuscated_plain",
            incident_recovery_evidence_relative_path=(
                "results/study/shard_0/recovery_evidence/"
                "shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93-incident5"
            ),
            incident_recovery_audit_sha256=(
                "506c74f2bfc490463e40bb95c204f54dd004acfdc44cb4d3594398ba09e330f5"
            ),
        ),
        ResourceOOMSkipExpectation(
            marker_relative_path=(
                "results/study/shard_0/resource_skips/"
                "cc-valid-r038-s0030__t5_easy_seed1/trial_001/"
                "obfuscated_codesteer/resource_skip.json"
            ),
            marker_sha256="750ef716df42d6e5b3728224b6b30cdeeb960187b46ed5531b5624c89a477ea5",
            shard_index=0,
            program_id="cc-valid-r038-s0030__t5_easy_seed1",
            condition="obfuscated_codesteer",
            fingerprint="dd52b8d2e28efccaa2f5c61fecfb7c2a80cd91c81e78f797499ab2ddfdef2ef5",
            paired_seed=1006413233,
            evidence_kind="derived_same_prefill_resource_limit",
            observed_condition="obfuscated_plain",
            incident_recovery_evidence_relative_path=(
                "results/study/shard_0/recovery_evidence/"
                "shard0-r038-s0030-obfuscated_plain-2ddb4eac4d93-incident5"
            ),
            incident_recovery_audit_sha256=(
                "506c74f2bfc490463e40bb95c204f54dd004acfdc44cb4d3594398ba09e330f5"
            ),
        ),
    ),
    resource_skip_resume=ResourceSkipResumeExpectation(
        amendment_relative_path="results/study/shard_0/resource_skips/resume_amendment.json",
        amendment_sha256="beb678984caa2e33f1cea4f96d9ac5f5e42830f9c8e1d248aea46d4fda95d8bc",
        shard_index=0,
        registrar_path=HERE / "register_resource_skips.py",
        registrar_sha256="6354344dd322e172dfdef5b71735e6388401e25f8bfdc2967528f6be85349ad4",
        wrapper_path=HERE / "resume_shard0_after_resource_skips.py",
        wrapper_sha256="e82189791093c15e3a789fa104453edff596e5449458bad04b7445d54259b288",
        test_path=HERE / "test_resume_shard0_after_resource_skips.py",
        test_sha256="1c13d120a4b787cf4f883291712cc5ff532598ab34aa4e69861472ada41d9f08",
    ),
)


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


def stable_json(value: Any) -> str:
    return json.dumps(value, sort_keys=True, separators=(",", ":"), default=str)


def pretty_json(value: Any) -> str:
    return json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True) + "\n"


def load_object(path: Path, label: str) -> dict[str, Any]:
    try:
        value = json.loads(path.read_text(encoding="utf-8"))
    except Exception as exc:
        raise AuditError(f"cannot parse {label} {path}: {exc}") from exc
    if not isinstance(value, dict):
        raise AuditError(f"{label} must be an object: {path}")
    return value


def require_file(path: Path, containment_root: Path, label: str) -> Path:
    try:
        root = containment_root.resolve(strict=True)
        resolved = path.resolve(strict=True)
        resolved.relative_to(root)
    except Exception as exc:
        raise AuditError(f"{label} is missing or escapes {containment_root}: {path}") from exc
    if not resolved.is_file():
        raise AuditError(f"{label} is not a regular file: {resolved}")
    return resolved


def require_exact_hash(path: Path, expected: str, label: str) -> str:
    if not path.is_file():
        raise AuditError(f"missing {label}: {path}")
    observed = sha256_file(path)
    if observed != expected:
        raise AuditError(f"{label} SHA-256 differs: expected {expected}, observed {observed}")
    return observed


def safe_id(value: str) -> str:
    rendered = re.sub(r"[^A-Za-z0-9_.-]+", "_", value).strip("._")
    if not rendered:
        raise AuditError("unsafe empty program ID")
    return rendered


def expected_seed(program_id: str) -> int:
    material = (
        f"{PROTOCOL_VERSION}\0{COHORT_TAG}\0{BASE_SEED}\0{program_id}\0round-1"
    ).encode("utf-8")
    return int.from_bytes(hashlib.sha256(material).digest()[:4], "big") & 0x7FFFFFFF


def expected_code_provenance(spec: AuditSpec) -> dict[str, str]:
    return {
        str(spec.runner_path.resolve(strict=True)): spec.expected_runner_sha256,
        str(spec.v2_path.resolve(strict=True)): spec.expected_v2_sha256,
        str(spec.manifest_path.resolve(strict=True)): spec.expected_manifest_sha256,
        str(spec.plan_path.resolve(strict=True)): spec.expected_plan_sha256,
    }


def validate_fixed_provenance(spec: AuditSpec) -> None:
    require_exact_hash(spec.runner_path, spec.expected_runner_sha256, "registered shard runner")
    require_exact_hash(spec.v2_path, spec.expected_v2_sha256, "proven v2 runner")
    require_exact_hash(spec.manifest_path, spec.expected_manifest_sha256, "frozen manifest")
    require_exact_hash(spec.plan_path, spec.expected_plan_sha256, "registered launch plan")


def validate_manifest(spec: AuditSpec) -> dict[str, Any]:
    path = spec.manifest_path.resolve(strict=True)
    digest = sha256_file(path)
    if digest != spec.expected_manifest_sha256:
        raise AuditError("frozen manifest digest differs")
    anchor = path.with_suffix(".sha256")
    if not anchor.is_file() or anchor.read_text(encoding="utf-8").strip().split() != [
        digest,
        path.name,
    ]:
        raise AuditError("frozen manifest SHA-256 anchor is missing or stale")
    payload = load_object(path, "frozen manifest")
    required = {
        "schema_version": "expanded-java-300-600-binary-freeze-v1",
        "program_count": spec.expected_program_count,
        "cases_per_program": 6,
        "conditions": list(CONDITIONS),
        "generation": GENERATION,
        "codesteer_level": 2,
        "labels_per_condition": spec.expected_program_count * 6,
    }
    failed = [key for key, expected in required.items() if payload.get(key) != expected]
    if failed:
        raise AuditError(f"frozen manifest contract differs: {failed}")
    rows = payload.get("programs")
    if not isinstance(rows, list) or len(rows) != spec.expected_program_count:
        raise AuditError("frozen manifest program rows differ")
    programs: dict[str, Any] = {}
    seen_case_ids: set[str] = set()
    for raw in rows:
        if not isinstance(raw, Mapping):
            raise AuditError("manifest program row is not an object")
        program_id = str(raw.get("id") or "")
        if not program_id or program_id in programs or safe_id(program_id) != program_id:
            raise AuditError(f"empty, duplicate, or unsafe program ID: {program_id!r}")
        original = require_file(
            path.parent / str(raw.get("original_path") or ""), path.parent, f"{program_id}/original"
        )
        obfuscated = require_file(
            path.parent / str(raw.get("obfuscated_path") or ""), path.parent, f"{program_id}/obfuscated"
        )
        original_loc = len(original.read_text(encoding="utf-8").splitlines())
        obfuscated_loc = len(obfuscated.read_text(encoding="utf-8").splitlines())
        if any(
            (
                sha256_file(original) != raw.get("original_sha256"),
                sha256_file(obfuscated) != raw.get("obfuscated_sha256"),
                not 300 <= original_loc <= 600,
                raw.get("original_physical_loc") != original_loc,
                raw.get("obfuscated_physical_loc") != obfuscated_loc,
            )
        ):
            raise AuditError(f"source/LOC binding differs: {program_id}")
        cases = raw.get("cases")
        if not isinstance(cases, list) or len(cases) != 6:
            raise AuditError(f"{program_id} does not have exactly six cases")
        local_stdin: set[str] = set()
        labels: list[bool] = []
        normalized_cases: list[dict[str, Any]] = []
        for position, case in enumerate(cases, 1):
            if not isinstance(case, Mapping):
                raise AuditError(f"malformed case object: {program_id}/{position}")
            case_id = str(case.get("id") or "")
            stdin = case.get("stdin")
            candidate = case.get("candidate_stdout")
            label = case.get("label")
            if any(
                (
                    not case_id,
                    case_id in seen_case_ids,
                    case.get("pack_position") != position,
                    not isinstance(stdin, str),
                    not isinstance(candidate, str),
                    type(label) is not bool,
                )
            ):
                raise AuditError(f"malformed case: {program_id}/{case_id or position}")
            assert isinstance(stdin, str) and isinstance(candidate, str) and type(label) is bool
            if case.get("stdin_sha256") != sha256_text(stdin) or case.get(
                "candidate_stdout_sha256"
            ) != sha256_text(candidate):
                raise AuditError(f"case content hash differs: {program_id}/{case_id}")
            stdin_hash = sha256_text(stdin)
            if stdin_hash in local_stdin:
                raise AuditError(f"repeated stdin within {program_id}")
            local_stdin.add(stdin_hash)
            seen_case_ids.add(case_id)
            labels.append(label)
            normalized_cases.append(dict(case))
        if sum(labels) != 3:
            raise AuditError(f"{program_id} is not exactly 3T/3F")
        original_target = str(raw.get("original_target_method") or "")
        obfuscated_target = str(raw.get("obfuscated_target_method") or "")
        if not original_target or not obfuscated_target:
            raise AuditError(f"target method missing: {program_id}")
        programs[program_id] = {
            "id": program_id,
            "original_path": original,
            "obfuscated_path": obfuscated,
            "original_sha256": raw["original_sha256"],
            "obfuscated_sha256": raw["obfuscated_sha256"],
            "original_target_method": original_target,
            "obfuscated_target_method": obfuscated_target,
            "case_ids": [case["id"] for case in normalized_cases],
            "cases": normalized_cases,
        }
    return {"payload": payload, "programs": programs, "program_ids": list(programs)}


def validate_plan(spec: AuditSpec, manifest: Mapping[str, Any]) -> dict[str, Any]:
    path = spec.plan_path.resolve(strict=True)
    plan = load_object(path, "launch plan")
    required = {
        "schema_version": "expanded-java-300-600-launch-plan-v1",
        "manifest_path": str(spec.manifest_path.resolve(strict=True)),
        "manifest_sha256": spec.expected_manifest_sha256,
        "program_count": spec.expected_program_count,
        "conditions": list(CONDITIONS),
        "generation": GENERATION,
        "labels_per_condition": spec.expected_program_count * 6,
        "total_generation_count": spec.expected_program_count * 3,
        "total_label_judgments": spec.expected_program_count * 18,
        "gpu_ids": list(spec.expected_gpu_ids),
        "launches_performed_by_planner": False,
        "same_dataset_problem_confined_to_one_shard": True,
    }
    failed = [key for key, expected in required.items() if plan.get(key) != expected]
    if failed:
        raise AuditError(f"launch plan contract differs: {failed}")
    shards = plan.get("shards")
    if not isinstance(shards, list) or len(shards) != len(spec.expected_gpu_ids):
        raise AuditError("launch plan shard count differs")
    seen: set[str] = set()
    manifest_ids = list(manifest["program_ids"])
    for shard_index, (shard, gpu_id) in enumerate(zip(shards, spec.expected_gpu_ids)):
        if not isinstance(shard, Mapping):
            raise AuditError(f"shard {shard_index} is not an object")
        ids = shard.get("program_ids")
        if not isinstance(ids, list) or not ids or len(ids) != len(set(ids)):
            raise AuditError(f"shard {shard_index} IDs are empty or duplicated")
        expected_order = [program_id for program_id in manifest_ids if program_id in set(ids)]
        expected_preflight = (spec.root / "results" / "preflight" / f"shard_{shard_index}").resolve(
            strict=False
        )
        expected_study = (spec.study_root / f"shard_{shard_index}").resolve(strict=False)
        shard_required = {
            "shard_index": shard_index,
            "gpu_id": gpu_id,
            "program_ids": expected_order,
            "program_count": len(ids),
            "generation_count": len(ids) * 3,
            "labels_per_condition": len(ids) * 6,
            "preflight_output_root": str(expected_preflight),
            "study_output_root": str(expected_study),
        }
        shard_failed = [key for key, expected in shard_required.items() if shard.get(key) != expected]
        if shard_failed:
            raise AuditError(f"shard {shard_index} contract differs: {shard_failed}")
        overlap = seen.intersection(ids)
        if overlap:
            raise AuditError(f"programs assigned to multiple shards: {sorted(overlap)}")
        seen.update(ids)
    if seen != set(manifest_ids):
        raise AuditError("launch plan does not partition the frozen cohort exactly")
    return plan


def validate_program_preflight(
    program_id: str, evidence: Mapping[str, Any], program: Mapping[str, Any]
) -> None:
    required = {
        "program_id": program_id,
        "is_study": True,
        "case_ids": program["case_ids"],
        "hidden_answer_fields_rendered": False,
        "eligible_for_inference": True,
    }
    failed = [key for key, expected in required.items() if evidence.get(key) != expected]
    token = evidence.get("prompt_tokens_by_condition")
    chat = evidence.get("chat_template_by_condition")
    if not isinstance(token, Mapping) or set(token) != set(CONDITIONS):
        failed.append("prompt_tokens_by_condition")
    if not isinstance(chat, Mapping) or set(chat) != set(CONDITIONS):
        failed.append("chat_template_by_condition")
    if isinstance(token, Mapping) and isinstance(chat, Mapping):
        for condition in CONDITIONS:
            token_row = token.get(condition)
            chat_row = chat.get(condition)
            if not isinstance(token_row, Mapping) or not isinstance(chat_row, Mapping):
                failed.append(f"preflight.{condition}")
                continue
            prompt_sha = token_row.get("prompt_sha256")
            if any(
                (
                    token_row.get("fits_context") is not True,
                    token_row.get("max_new_tokens") != GENERATION["max_new_tokens"],
                    not isinstance(token_row.get("prompt_token_count"), int),
                    token_row.get("context_margin_tokens", -1) < 0,
                    prompt_sha != chat_row.get("rendered_prompt_sha256"),
                    chat_row.get("chat_template_sha256") != CHAT_TEMPLATE_SHA256,
                    chat_row.get("method") != "tokenizer.apply_chat_template",
                    chat_row.get("add_generation_prompt") is not True,
                    chat_row.get("assistant_generation_suffix") != CHAT_SUFFIX,
                    chat_row.get("assistant_generation_suffix_present") is not True,
                    chat_row.get("direct_template_ids_equal_runtime_ids") is not True,
                )
            ):
                failed.append(f"preflight.{condition}")
        if token.get("obfuscated_plain", {}).get("prompt_sha256") != token.get(
            "obfuscated_codesteer", {}
        ).get("prompt_sha256"):
            failed.append("paired obfuscated prompt SHA")
    prior = evidence.get("codesteer_prior")
    if not isinstance(prior, Mapping) or any(
        (
            prior.get("algorithm_fallback_detected") is not False,
            prior.get("case_signal_active") is not True,
            prior.get("case_vector_count") != 6,
            prior.get("parsed_case_ids") != [f"c{index:03d}" for index in range(1, 7)],
            prior.get("n_bins") != 12,
            prior.get("prompt_sha256")
            != (token or {}).get("obfuscated_codesteer", {}).get("prompt_sha256"),
        )
    ):
        failed.append("codesteer_prior")
    if failed:
        raise AuditError(f"model preflight evidence differs for {program_id}: {sorted(set(failed))}")


def validate_preflights(
    spec: AuditSpec, plan: Mapping[str, Any], manifest: Mapping[str, Any]
) -> tuple[list[dict[str, Any]], dict[str, dict[str, Any]]]:
    summaries: list[dict[str, Any]] = []
    evidence_by_program: dict[str, dict[str, Any]] = {}
    provenance = expected_code_provenance(spec)
    for shard_index, shard in enumerate(plan["shards"]):
        root = Path(str(shard["preflight_output_root"])).resolve(strict=True)
        summary_path = require_file(root / "preflight_summary.json", root, "preflight summary")
        require_exact_hash(
            summary_path, spec.expected_preflight_sha256[shard_index], f"shard {shard_index} preflight"
        )
        summary = load_object(summary_path, "preflight summary")
        required = {
            "schema_version": "expanded-java-300-600-model-preflight-v1",
            "status": "passed",
            "protocol_version": PROTOCOL_VERSION,
            "manifest_sha256": spec.expected_manifest_sha256,
            "plan_sha256": spec.expected_plan_sha256,
            "program_ids": shard["program_ids"],
            "program_count": shard["program_count"],
            "shard_index": shard_index,
            "generation": GENERATION,
            "study_generation_count": 0,
            "code_provenance": provenance,
            "engine_liveness_sha256": ENGINE_LIVENESS_SHA256,
        }
        failed = [key for key, expected in required.items() if summary.get(key) != expected]
        hashes = summary.get("program_preflight_sha256")
        if not isinstance(hashes, Mapping) or set(hashes) != set(shard["program_ids"]):
            failed.append("program_preflight_sha256")
        if failed:
            raise AuditError(f"shard {shard_index} preflight summary differs: {failed}")
        assert isinstance(hashes, Mapping)
        for program_id in shard["program_ids"]:
            evidence_path = require_file(
                root / "programs" / safe_id(program_id) / "preflight.json",
                root,
                f"{program_id} preflight",
            )
            if sha256_file(evidence_path) != hashes[program_id]:
                raise AuditError(f"preflight evidence hash differs: {program_id}")
            evidence = load_object(evidence_path, "program preflight")
            validate_program_preflight(program_id, evidence, manifest["programs"][program_id])
            if program_id in evidence_by_program:
                raise AuditError(f"duplicate program preflight: {program_id}")
            evidence_by_program[program_id] = evidence
        summaries.append(summary)
    if set(evidence_by_program) != set(manifest["program_ids"]):
        raise AuditError("preflight evidence does not cover the frozen cohort exactly")
    return summaries, evidence_by_program


def _object_blocks(text: str) -> tuple[list[str], bool]:
    blocks: list[str] = []
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
            else:
                depth -= 1
                if depth == 0 and start is not None:
                    blocks.append(text[start : index + 1])
                    start = None
    return blocks, depth != 0 or in_string or stray_close


def parse_response(completion: str, expected_ids: Sequence[str]) -> dict[str, Any]:
    expected = list(expected_ids)
    if len(expected) != 6 or len(set(expected)) != 6:
        raise AuditError("independent parser requires six distinct expected IDs")
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
    blocks, malformed = _object_blocks(completion)
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
    expected_set = set(expected)
    unexpected = sorted({str(key) for key, _ in root if str(key) not in expected_set})
    predictions: dict[str, Optional[str]] = {}
    valid: dict[str, bool] = {}
    missing: list[str] = []
    duplicates: list[str] = []
    invalid: list[str] = []
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
    pack_valid = not (missing or duplicates or unexpected or invalid) and len(root) == 6
    if not pack_valid:
        predictions = {case_id: None for case_id in expected}
        valid = {case_id: False for case_id in expected}
    return {
        **blank,
        "parse_status": "ok" if pack_valid else "pack_invalid",
        "pack_valid": pack_valid,
        "response_mode": "whole_json" if completion.strip() == raw else "embedded_or_fenced_json",
        "predictions": predictions,
        "valid_prediction": valid,
        "missing_ids": missing,
        "duplicate_ids": duplicates,
        "unexpected_ids": unexpected,
        "invalid_value_ids": invalid,
    }


def independent_score(cases: Sequence[Mapping[str, Any]], completion: str) -> dict[str, Any]:
    parsed = parse_response(completion, [str(case["id"]) for case in cases])
    rows: list[dict[str, Any]] = []
    for case in cases:
        case_id = str(case["id"])
        expected = "T" if case["label"] else "F"
        predicted = parsed["predictions"].get(case_id)
        valid = bool(parsed["valid_prediction"].get(case_id))
        rows.append(
            {
                "case_id": case_id,
                "pack_position": case["pack_position"],
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
        "label_count": 6,
        "label_accuracy": correct / 6,
        "scoring_policy": SCORING_POLICY,
    }


def validate_environment(
    spec: AuditSpec, root: Path, environment: Mapping[str, Any], gpu_id: int
) -> Mapping[str, Any]:
    required = {
        "protocol_version": PROTOCOL_VERSION,
        "expansion_protocol_version": PROTOCOL_VERSION,
        "registered_generation": GENERATION,
        "physical_gpu_id_requested": gpu_id,
        "visible_cuda_device_count": 1,
        "model_id": MODEL_NAME,
        "model_snapshot_commit": MODEL_COMMIT,
        "tokenizer_config_sha256": TOKENIZER_CONFIG_SHA256,
        "chat_template_sha256": CHAT_TEMPLATE_SHA256,
        "chat_render_method": "tokenizer.apply_chat_template",
        "add_generation_prompt": True,
        "codesteer_layer_start": 20,
        "codesteer_layer_end": 27,
    }
    failed = [key for key, expected in required.items() if environment.get(key) != expected]
    for key, expected in MODEL_CONFIG.items():
        if environment.get("model_config", {}).get(key) != expected:
            failed.append(f"model_config.{key}")
    snapshot = environment.get("model_snapshot_status")
    if not isinstance(snapshot, Mapping) or any(
        (
            snapshot.get("available") is not True,
            snapshot.get("expected_commit") != MODEL_COMMIT,
            snapshot.get("observed_main_ref") != MODEL_COMMIT,
            snapshot.get("weight_shard_count") != 4,
            snapshot.get("config_mismatches") not in ({}, None),
        )
    ):
        failed.append("model_snapshot_status")
    steering = environment.get("codesteer_config")
    if not isinstance(steering, Mapping):
        failed.append("codesteer_config")
    else:
        for key, expected in CODESTEER_PROFILE.items():
            if steering.get(key) != expected:
                failed.append(f"codesteer_config.{key}")
    cache = environment.get("static_prior_cache")
    if not isinstance(cache, Mapping) or cache.get("enabled") is not True or cache.get(
        "installed"
    ) is not True:
        failed.append("static_prior_cache")
    provenance = environment.get("code_provenance")
    if not isinstance(provenance, Mapping) or any(
        (
            provenance.get(str(spec.manifest_path.resolve(strict=True)))
            != spec.expected_manifest_sha256,
            provenance.get(str(spec.v2_path.resolve(strict=True))) != spec.expected_v2_sha256,
            any(
                not isinstance(path, str)
                or not Path(path).is_absolute()
                or not isinstance(digest, str)
                or re.fullmatch(r"[0-9a-f]{64}", digest) is None
                for path, digest in (provenance.items() if isinstance(provenance, Mapping) else ())
            ),
        )
    ):
        failed.append("environment code_provenance")
    mutable = environment.get("mutable_paths_inside_output_root")
    if not isinstance(mutable, Mapping) or not mutable:
        failed.append("mutable_paths_inside_output_root")
    else:
        for key, raw in mutable.items():
            try:
                Path(str(raw)).resolve(strict=True).relative_to(root.resolve(strict=True))
            except Exception:
                failed.append(f"mutable path:{key}")
    if failed:
        raise AuditError(f"shard environment differs at {root}: {sorted(set(failed))}")
    assert isinstance(steering, Mapping)
    return steering


def validate_prompt(
    prompt: str, cases: Sequence[Mapping[str, Any]], source: str, target_method: str, run_dir: Path
) -> None:
    if not prompt.startswith(CHAT_PREFIX) or not prompt.endswith(CHAT_SUFFIX):
        raise AuditError(f"Qwen chat envelope differs at {run_dir}")
    if f"```java\n{source}\n```" not in prompt:
        raise AuditError(f"prompt source payload differs at {run_dir}")
    if f"recorded algorithm method is `{target_method}`" not in prompt:
        raise AuditError(f"prompt target method differs at {run_dir}")
    forbidden = ("oracle_stdout", '"label"', "mutation_seed", "expected_label")
    if any(value in prompt for value in forbidden):
        raise AuditError(f"prompt exposes hidden answer metadata at {run_dir}")
    for position, case in enumerate(cases, 1):
        visible = {
            "case_id": case["id"],
            "stdin": case["stdin"],
            "candidate_stdout": case["candidate_stdout"],
        }
        rendered = json.dumps(visible, ensure_ascii=False, sort_keys=True, separators=(",", ":"))
        if rendered not in prompt or prompt.count(str(case["id"])) != 2:
            raise AuditError(f"prompt case payload differs at {run_dir}: c{position:03d}")
        if prompt.count(f"c{position:03d}:") != 1:
            raise AuditError(f"prompt case marker differs at {run_dir}: c{position:03d}")


def validate_token_evidence(
    stored: Mapping[str, Any], model_output: Mapping[str, Any], run_dir: Path
) -> dict[str, int]:
    all_ids = model_output.get("token_ids_all")
    all_tokens = model_output.get("tokens_all")
    prompt_length = model_output.get("prompt_length_tokens")
    if not isinstance(all_ids, list) or not isinstance(all_tokens, list) or type(prompt_length) is not int:
        raise AuditError(f"model token evidence missing at {run_dir}")
    if not 0 <= prompt_length <= len(all_ids) or len(all_tokens) != len(all_ids):
        raise AuditError(f"model token lengths differ at {run_dir}")
    generated = all_ids[prompt_length:]
    generated_tokens = all_tokens[prompt_length:]
    special = stored.get("special_token_ids")
    eos = stored.get("eos_token_ids")
    if not isinstance(special, list) or not isinstance(eos, list):
        raise AuditError(f"special-token evidence missing at {run_dir}")
    non_special = [value for value in generated if value not in set(special)]
    expected = {
        "generated_token_ids": generated,
        "generated_tokens": generated_tokens,
        "generated_token_count": len(generated),
        "generated_non_special_token_ids": non_special,
        "generated_non_special_token_count": len(non_special),
        "special_token_ids": special,
        "eos_token_ids": eos,
        "first_generated_token_id": generated[0] if generated else None,
        "first_generated_token_is_eos": bool(generated and generated[0] in set(eos)),
    }
    if dict(stored) != expected:
        raise AuditError(f"generated-token evidence differs at {run_dir}")
    if model_output.get("num_generated_tokens") != len(generated) or len(generated) > 192:
        raise AuditError(f"generated-token count differs at {run_dir}")
    return {
        "generated_token_count": len(generated),
        "generated_non_special_token_count": len(non_special),
    }


def validate_steering_debug(
    debug: Mapping[str, Any], *, steered: bool, prompt_tokens: int, run_dir: Path
) -> dict[str, Any]:
    calls = int(debug.get("steer_calls", 0) or 0)
    if debug.get("prompt_len") != prompt_tokens:
        raise AuditError(f"steering prompt length differs at {run_dir}")
    if not steered:
        if any(
            (
                debug.get("enabled") is not False,
                calls != 0,
                debug.get("level_call_counts") not in ({}, None),
                debug.get("level_event_trace") not in ([], None),
                debug.get("temporal_debug") not in ([], None),
            )
        ):
            raise AuditError(f"plain condition activated steering at {run_dir}")
        return {"enabled": False, "steer_calls": 0, "semantic_checks_passed": True}
    levels = debug.get("level_call_counts")
    events = debug.get("level_event_trace")
    temporal = debug.get("temporal_debug")
    checks = {
        "enabled": debug.get("enabled") is True,
        "decode_only": debug.get("decode_only") is True,
        "split_prefill_used": debug.get("split_prefill_used") is True,
        "steer_calls_positive": calls > 0,
        "recency_mix": debug.get("recency_mix") is True,
        "recency_rho": abs(float(debug.get("recency_rho", -1)) - 0.2) < 1e-12,
        "recency_window": debug.get("recency_window") == 64,
        "recency_after_prompt": debug.get("recency_apply_after_prompt") is True,
        "recency_scope": debug.get("recency_scope") == "prefer_generated",
        "head_subset_none": debug.get("head_subset_mode") == "none",
        "head_mask_both": debug.get("head_mask_apply_to") == "both",
        "no_head_mask": debug.get("head_mask_loaded") is False,
        "levels_object": isinstance(levels, Mapping),
        "events_nonempty": isinstance(events, list) and bool(events),
        "temporal_nonempty": isinstance(temporal, list) and bool(temporal),
    }
    if isinstance(levels, Mapping):
        checks.update(
            {
                "l2_calls_equal": int(levels.get("l2_calls", 0) or 0) == calls,
                "l2_active": int(levels.get("l2_active_steps", 0) or 0) > 0,
                "l1_zero": int(levels.get("l1_calls", 0) or 0) == 0,
                "l3_zero": int(levels.get("l3_active_steps", 0) or 0) == 0,
                "l4_zero": int(levels.get("l4_calls", 0) or 0) == 0,
                "l5_zero": int(levels.get("l5_calls", 0) or 0) == 0,
            }
        )
    if isinstance(events, list):
        checks["event_count"] = len(events) == calls
        checks["only_l2_events"] = all(
            isinstance(row, Mapping) and row.get("level") == 2 and int(row.get("step_index", -1)) >= 0
            for row in events
        )
    if isinstance(temporal, list):
        checks["temporal_semantics"] = all(
            isinstance(row, Mapping)
            and int(row.get("step_index", -1)) >= 0
            and float(row.get("rho_used", -1)) in (0.0, 0.2)
            and float(row.get("prompt_mass", -1)) >= 0.0
            and float(row.get("recent_mass", -1)) >= 0.0
            and float(row.get("generated_mass", -1)) >= 0.0
            for row in temporal
        )
    failed = [key for key, passed in checks.items() if not passed]
    if failed:
        raise AuditError(f"semantic steering evidence differs at {run_dir}: {failed}")
    assert isinstance(levels, Mapping) and isinstance(events, list) and isinstance(temporal, list)
    return {
        "enabled": True,
        "steer_calls": calls,
        "l2_active_steps": int(levels.get("l2_active_steps", 0)),
        "level_event_count": len(events),
        "temporal_debug_count": len(temporal),
        "semantic_checks_passed": True,
    }


def fingerprint_payload(config: Mapping[str, Any]) -> dict[str, Any]:
    keys = (
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
    return {key: config.get(key) for key in keys}


def expected_run_config(
    spec: AuditSpec,
    program_id: str,
    condition: str,
    program: Mapping[str, Any],
    preflight: Mapping[str, Any],
    steering_config: Mapping[str, Any],
    prompt: Optional[str] = None,
    prompt_sha256: Optional[str] = None,
) -> dict[str, Any]:
    """Reconstruct the registered first-attempt configuration for one cell."""

    steered = condition == "obfuscated_codesteer"
    kind = "original" if condition == "original_plain" else "obfuscated"
    token = preflight["prompt_tokens_by_condition"][condition]
    chat = preflight["chat_template_by_condition"][condition]
    prior = preflight["codesteer_prior"] if steered else None
    config: dict[str, Any] = {
        "protocol_version": PROTOCOL_VERSION,
        "manifest_sha256": spec.expected_manifest_sha256,
        "plan_sha256": spec.expected_plan_sha256,
        "program_id": program_id,
        "case_ids_in_prompt_order": program["case_ids"],
        "condition": condition,
        "round": 1,
        "paired_seed": expected_seed(program_id),
        "model_id": MODEL_NAME,
        "model_snapshot_commit": MODEL_COMMIT,
        "generation": GENERATION,
        "chat_template_sha256": CHAT_TEMPLATE_SHA256,
        "prompt_sha256": prompt_sha256 if prompt_sha256 is not None else sha256_text(prompt or ""),
        "steering": dict(steering_config) if steered else None,
        "fingerprint": None,
        "source_kind": kind,
        "target_method": program[f"{kind}_target_method"],
        "activation_steering": steered,
        "paired_design": "same program seed across all three conditions",
        "token_preflight": token,
        "chat_template_evidence": chat,
        "codesteer_prior_preflight": prior,
        "hidden_labels_in_prompt": False,
        "attempt": 1,
        "automatic_retry_allowed": False,
    }
    config["fingerprint"] = sha256_text(stable_json(fingerprint_payload(config)))
    return config


RESOURCE_SKIP_COMMON_KEYS = frozenset(
    {
        "attempt",
        "attempt_directory_was_created",
        "attempt_setup_evidence_preserved_in_incident5",
        "authorization_basis",
        "authorization_does_not_extend_to_other_program_condition_fingerprint_or_seed",
        "authorization_scope_condition_count",
        "canonical_run_dir",
        "canonical_run_dir_absent_at_registration",
        "chat_template_sha256",
        "completed_generation_count_after",
        "completed_generation_count_before",
        "completed_generation_count_unchanged",
        "completion_record_created",
        "condition",
        "contributes_completion",
        "contributes_score",
        "disposition",
        "evidence_kind",
        "fingerprint",
        "generation",
        "incident5_recovery_audit_path",
        "incident5_recovery_audit_sha256",
        "included_in_condition_denominator",
        "malformed_output_retry",
        "manifest_sha256",
        "model_id",
        "model_outcome_files_present",
        "model_snapshot_commit",
        "new_statistical_trial",
        "observed_no_model_outcome",
        "paired_seed",
        "plan_sha256",
        "program_id",
        "prompt_sha256",
        "prompt_token_count",
        "resource_evidence",
        "results_index_sha256",
        "round",
        "run_binary_v2_sha256",
        "run_shard_sha256",
        "schema_version",
        "score_created",
        "statistical_treatment",
        "status",
        "trial",
    }
)


def validate_resource_skip_registration_tree(
    spec: AuditSpec, plan: Mapping[str, Any]
) -> dict[str, Any]:
    """Reject every unregistered marker, anchor, directory, and cell identity."""

    expectations = spec.resource_oom_skips
    resume = spec.resource_skip_resume
    if resume is not None and not expectations:
        raise AuditError("resource-skip resume amendment exists without registered skips")
    keys = [(row.shard_index, row.program_id, row.condition) for row in expectations]
    paths = [row.marker_relative_path for row in expectations]
    if len(keys) != len(set(keys)) or len(paths) != len(set(paths)):
        raise AuditError("registered resource-skip identities or paths are duplicated")
    for row in expectations:
        if row.condition not in CONDITIONS or row.observed_condition not in CONDITIONS:
            raise AuditError("registered resource skip has an unknown condition")
        if row.shard_index < 0 or row.shard_index >= len(plan["shards"]):
            raise AuditError("registered resource skip has an unknown shard")
        if row.program_id not in plan["shards"][row.shard_index]["program_ids"]:
            raise AuditError("registered resource skip is outside its shard cohort")
        expected_parent = (
            spec.study_root
            / f"shard_{row.shard_index}"
            / "resource_skips"
            / safe_id(row.program_id)
            / "trial_001"
            / row.condition
        ).resolve(strict=False)
        marker = (spec.root / row.marker_relative_path).resolve(strict=False)
        if marker != expected_parent / "resource_skip.json":
            raise AuditError("registered resource-skip path shape differs")

    for shard_index in range(len(plan["shards"])):
        root = spec.study_root / f"shard_{shard_index}" / "resource_skips"
        registered = [row for row in expectations if row.shard_index == shard_index]
        registered_resume = resume is not None and resume.shard_index == shard_index
        if not registered and not registered_resume:
            if root.exists():
                raise AuditError(f"unregistered resource-skip tree exists in shard {shard_index}")
            continue
        if not root.is_dir() or root.is_symlink():
            raise AuditError(f"registered resource-skip root is invalid in shard {shard_index}")
        expected_files: set[Path] = set()
        expected_dirs = {root.resolve(strict=True)}
        for row in registered:
            marker = (spec.root / row.marker_relative_path).resolve(strict=True)
            anchor = marker.with_suffix(".sha256").resolve(strict=True)
            expected_files.update({marker, anchor})
            current = marker.parent
            while current.resolve(strict=True) != root.resolve(strict=True):
                expected_dirs.add(current.resolve(strict=True))
                current = current.parent
        if registered_resume:
            assert resume is not None
            amendment = (spec.root / resume.amendment_relative_path).resolve(strict=True)
            amendment_anchor = amendment.with_suffix(".sha256").resolve(strict=True)
            if amendment.parent != root.resolve(strict=True):
                raise AuditError("resource-skip resume amendment path shape differs")
            expected_files.update({amendment, amendment_anchor})
        observed_files: set[Path] = set()
        observed_dirs = {root.resolve(strict=True)}
        for path in root.rglob("*"):
            if path.is_symlink():
                raise AuditError(f"symlink is forbidden in resource-skip evidence: {path}")
            if path.is_file():
                observed_files.add(path.resolve(strict=True))
            elif path.is_dir():
                observed_dirs.add(path.resolve(strict=True))
            else:
                raise AuditError(f"non-regular resource-skip entry exists: {path}")
        if observed_files != expected_files or observed_dirs != expected_dirs:
            raise AuditError(f"missing or unregistered resource-skip evidence in shard {shard_index}")
    return validate_resource_skip_resume_amendment(spec, plan)


def validate_resource_skip_resume_amendment(
    spec: AuditSpec, plan: Mapping[str, Any]
) -> dict[str, Any]:
    expected = spec.resource_skip_resume
    if expected is None:
        return {"registered": False}
    if expected.shard_index < 0 or expected.shard_index >= len(plan["shards"]):
        raise AuditError("resource-skip resume amendment has an unknown shard")
    shard = plan["shards"][expected.shard_index]
    shard_root = Path(str(shard["study_output_root"])).resolve(strict=True)
    amendment = require_file(
        (spec.root / expected.amendment_relative_path).resolve(strict=True),
        shard_root,
        "resource-skip resume amendment",
    )
    require_exact_hash(amendment, expected.amendment_sha256, "resource-skip resume amendment")
    anchor = require_file(
        amendment.with_suffix(".sha256"), shard_root, "resource-skip resume amendment anchor"
    )
    if anchor.read_text(encoding="utf-8").strip().split() != [
        expected.amendment_sha256,
        amendment.name,
    ]:
        raise AuditError("resource-skip resume amendment anchor differs")
    if any(path.stat().st_mode & 0o222 for path in (amendment, anchor)):
        raise AuditError("resource-skip resume amendment is not read-only")
    require_exact_hash(expected.registrar_path, expected.registrar_sha256, "resource-skip registrar")
    require_exact_hash(expected.wrapper_path, expected.wrapper_sha256, "resource-skip resume wrapper")
    require_exact_hash(expected.test_path, expected.test_sha256, "resource-skip resume tests")
    payload = load_object(amendment, "resource-skip resume amendment")
    expected_keys = {
        "allowed_behavior",
        "completed_generation_count_before",
        "expected_completed_generation_count_after",
        "expected_feasible_completions_added",
        "expected_global_completed_generation_count_after",
        "expected_resource_skip_count",
        "forbidden_behavior",
        "manifest_sha256",
        "model_id",
        "model_snapshot_commit",
        "plan_sha256",
        "registered_at",
        "register_resource_skips_sha256",
        "registered_skip_marker_sha256",
        "resume_wrapper_sha256",
        "run_binary_v2_sha256",
        "run_shard_sha256",
        "schema_version",
        "statistical_policy",
        "status",
        "test_resume_wrapper_sha256",
        "user_authorization",
        "user_scope",
        "validation",
    }
    if set(payload) != expected_keys:
        raise AuditError("resource-skip resume amendment schema keys differ")
    skips = [row for row in spec.resource_oom_skips if row.shard_index == expected.shard_index]
    marker_hashes = {row.condition: row.marker_sha256 for row in skips}
    planned_global = spec.expected_program_count * len(CONDITIONS)
    final_global = planned_global - len(spec.resource_oom_skips)
    final_shard = int(shard["generation_count"]) - len(skips)
    before = int(payload.get("completed_generation_count_before", -1))
    exact = {
        "schema_version": "expanded-java-300-600-resource-skip-resume-amendment-v1",
        "status": "registered_before_resume",
        "manifest_sha256": spec.expected_manifest_sha256,
        "plan_sha256": spec.expected_plan_sha256,
        "run_shard_sha256": spec.expected_runner_sha256,
        "run_binary_v2_sha256": spec.expected_v2_sha256,
        "model_id": MODEL_NAME,
        "model_snapshot_commit": MODEL_COMMIT,
        "register_resource_skips_sha256": expected.registrar_sha256,
        "resume_wrapper_sha256": expected.wrapper_sha256,
        "test_resume_wrapper_sha256": expected.test_sha256,
        "registered_skip_marker_sha256": marker_hashes,
        "expected_resource_skip_count": len(skips),
        "expected_completed_generation_count_after": final_shard,
        "expected_feasible_completions_added": final_shard - before,
        "expected_global_completed_generation_count_after": final_global,
        "allowed_behavior": [
            "validate two exact read-only resource-skip markers",
            "treat only the two exact registered record paths and fingerprints as already handled",
            "delegate every other completion check and all model execution to the frozen runner",
            "leave skipped canonical run directories absent",
        ],
        "forbidden_behavior": [
            "create a record, score, completion, or model output for a skipped cell",
            "count a skipped cell as correct or incorrect",
            (
                "change model, model commit, prompt, seed, sampling, steering, manifest, plan, "
                "frozen runner, or completed artifact"
            ),
            "skip any unregistered program, condition, fingerprint, or seed",
        ],
        "statistical_policy": {
            "complete_three_condition_programs": spec.expected_program_count - 1,
            "obfuscated_codesteer_programs": spec.expected_program_count - 1,
            "obfuscated_plain_programs": spec.expected_program_count - 1,
            "original_plain_programs": spec.expected_program_count,
            "restoration_ratio_policy": "complete_case_three_condition_programs_only",
            "skips_are_missing_not_failures": True,
        },
        "validation": {
            "combined_recovery_registration_resume_tests_passed": 12,
            "model_inference_performed_by_validation": False,
        },
        "user_authorization": (
            "User explicitly authorized marking and skipping tasks that the available GPU "
            "physically cannot handle."
        ),
        "user_scope": (
            "the two r038 obfuscated cells sharing the demonstrated 11,025-token "
            "full-eager-prefill capacity limit"
        ),
    }
    failed = [key for key, value in exact.items() if payload.get(key) != value]
    if not isinstance(payload.get("registered_at"), str) or not payload["registered_at"]:
        failed.append("registered_at")
    if failed:
        raise AuditError(f"resource-skip resume amendment differs: {sorted(set(failed))}")
    return {
        "registered": True,
        "shard_index": expected.shard_index,
        "amendment_path": expected.amendment_relative_path,
        "amendment_sha256": expected.amendment_sha256,
        "registrar_sha256": expected.registrar_sha256,
        "wrapper_sha256": expected.wrapper_sha256,
        "test_sha256": expected.test_sha256,
        "validated_test_count": 12,
        "expected_shard_completion_count": final_shard,
        "expected_global_completion_count": final_global,
        "changes_model_or_treatment": False,
    }


def validate_resource_skip(
    spec: AuditSpec,
    shard_root: Path,
    expected: ResourceOOMSkipExpectation,
    program: Mapping[str, Any],
    preflight: Mapping[str, Any],
    steering_config: Mapping[str, Any],
) -> dict[str, Any]:
    marker = require_file(
        (spec.root / expected.marker_relative_path).resolve(strict=True),
        shard_root,
        "registered resource-skip marker",
    )
    require_exact_hash(marker, expected.marker_sha256, "registered resource-skip marker")
    anchor = require_file(marker.with_suffix(".sha256"), shard_root, "resource-skip hash anchor")
    if anchor.read_text(encoding="utf-8").strip().split() != [
        expected.marker_sha256,
        marker.name,
    ]:
        raise AuditError("resource-skip SHA-256 anchor differs")
    if any(path.stat().st_mode & 0o222 for path in (marker.parent, marker, anchor)):
        raise AuditError("resource-skip marker package is not read-only")
    if {path.name for path in marker.parent.iterdir()} != {
        "resource_skip.json",
        "resource_skip.sha256",
    }:
        raise AuditError("resource-skip marker package file set differs")
    payload = load_object(marker, "resource-skip marker")
    expected_keys = RESOURCE_SKIP_COMMON_KEYS | (
        {"steering_config_sha256"} if expected.condition == "obfuscated_codesteer" else set()
    )
    if set(payload) != expected_keys:
        raise AuditError("resource-skip marker schema keys differ")

    token = preflight["prompt_tokens_by_condition"][expected.condition]
    incident_root = (
        spec.root / expected.incident_recovery_evidence_relative_path
    ).resolve(strict=True)
    incident_audit = require_file(
        incident_root / "recovery_audit.json", incident_root, "resource-skip incident audit"
    )
    require_exact_hash(
        incident_audit,
        expected.incident_recovery_audit_sha256,
        "resource-skip incident audit",
    )
    incident_relative = incident_audit.relative_to(shard_root).as_posix()
    canonical_relative = (
        Path("runs")
        / safe_id(expected.program_id)
        / "trial_001"
        / expected.condition
    ).as_posix()
    canonical = shard_root / canonical_relative
    config = expected_run_config(
        spec,
        expected.program_id,
        expected.condition,
        program,
        preflight,
        steering_config,
        prompt_sha256=str(token["prompt_sha256"]),
    )
    disposition = (
        "resource_oom" if expected.evidence_kind == "observed_cuda_oom" else "resource_capacity_skip"
    )
    exact = {
        "schema_version": "expanded-java-300-600-resource-skip-v1",
        "status": "registered",
        "authorization_basis": (
            "user_explicitly_authorized_skipping_tasks_the_available_gpu_cannot_handle"
        ),
        "authorization_does_not_extend_to_other_program_condition_fingerprint_or_seed": True,
        "authorization_scope_condition_count": 1,
        "manifest_sha256": spec.expected_manifest_sha256,
        "plan_sha256": spec.expected_plan_sha256,
        "run_shard_sha256": spec.expected_runner_sha256,
        "run_binary_v2_sha256": spec.expected_v2_sha256,
        "model_id": MODEL_NAME,
        "model_snapshot_commit": MODEL_COMMIT,
        "chat_template_sha256": CHAT_TEMPLATE_SHA256,
        "generation": GENERATION,
        "program_id": expected.program_id,
        "condition": expected.condition,
        "round": 1,
        "trial": 1,
        "paired_seed": expected.paired_seed,
        "fingerprint": expected.fingerprint,
        "prompt_sha256": token["prompt_sha256"],
        "prompt_token_count": token["prompt_token_count"],
        "canonical_run_dir": canonical_relative,
        "canonical_run_dir_absent_at_registration": True,
        "incident5_recovery_audit_path": incident_relative,
        "incident5_recovery_audit_sha256": expected.incident_recovery_audit_sha256,
        "completed_generation_count_unchanged": True,
        "completion_record_created": False,
        "score_created": False,
        "contributes_completion": False,
        "contributes_score": False,
        "included_in_condition_denominator": False,
        "observed_no_model_outcome": True,
        "model_outcome_files_present": [],
        "new_statistical_trial": False,
        "malformed_output_retry": False,
        "disposition": disposition,
        "evidence_kind": expected.evidence_kind,
        "statistical_treatment": "excluded_missing_due_to_resource_capacity",
    }
    failed = [key for key, value in exact.items() if payload.get(key) != value]
    if any(
        (
            expected_seed(expected.program_id) != expected.paired_seed,
            config["fingerprint"] != expected.fingerprint,
            canonical.exists(),
            payload.get("completed_generation_count_before")
            != payload.get("completed_generation_count_after"),
        )
    ):
        failed.append("identity/fingerprint/canonical-run/completion-count binding")
    matching_recoveries = [
        row
        for row in spec.recoveries
        if row.evidence_relative_path == expected.incident_recovery_evidence_relative_path
        and row.audit_sha256 == expected.incident_recovery_audit_sha256
    ]
    if len(matching_recoveries) != 1:
        failed.append("registered incident recovery binding")
    else:
        recovery_expectation = matching_recoveries[0]
        incident_payload = load_object(incident_audit, "resource-skip incident audit")
        if any(
            (
                payload.get("results_index_sha256")
                != recovery_expectation.initial_results_index_sha256,
                incident_payload.get("pinned_sha256", {}).get("results_index")
                != recovery_expectation.initial_results_index_sha256,
                payload.get("completed_generation_count_before")
                != incident_payload.get("completed_generation_count_before"),
                payload.get("completed_generation_count_after")
                != incident_payload.get("completed_generation_count_after"),
            )
        ):
            failed.append("resource-skip recovery/index/count binding")

    evidence = payload.get("resource_evidence")
    if not isinstance(evidence, Mapping):
        failed.append("resource_evidence")
    elif expected.evidence_kind == "observed_cuda_oom":
        evidence_exact = {
            "allocator_environment": {"PYTORCH_CUDA_ALLOC_CONF": "max_split_size_mb:128"},
            "allocator_fragmentation_eliminated": True,
            "exception_type": "torch.cuda.OutOfMemoryError",
            "failure_operation": (
                "torch.nn.functional.softmax(attn_weights, dim=-1, dtype=torch.float32)"
            ),
            "physical_capacity_shortfall_observed": True,
        }
        if any(evidence.get(key) != value for key, value in evidence_exact.items()) or not (
            float(evidence.get("failed_allocation_gib", 0))
            > float(evidence.get("gpu_free_gib", 0))
            > 0
        ):
            failed.append("observed CUDA OOM evidence")
        if any(
            (
                payload.get("attempt") != 1,
                payload.get("attempt_directory_was_created") is not True,
                payload.get("attempt_setup_evidence_preserved_in_incident5") is not True,
                expected.observed_condition != expected.condition,
            )
        ):
            failed.append("observed CUDA OOM attempt binding")
    elif expected.evidence_kind == "derived_same_prefill_resource_limit":
        evidence_exact = {
            "decode_only_steering": True,
            "derived_capacity_limit": True,
            "model_execution_attempted_for_this_condition": False,
            "prefix_prefill_uses_same_full_eager_float32_attention_softmax": True,
            "same_prompt_sha256": token["prompt_sha256"],
            "same_prompt_token_count": token["prompt_token_count"],
            "same_rendered_prompt_as_obfuscated_plain": True,
            "split_prefill_enabled": True,
            "split_prefill_prefix_token_count": int(token["prompt_token_count"]) - 1,
            "steering_not_applied_during_multi_token_prefix_prefill": True,
        }
        observed_token = preflight["prompt_tokens_by_condition"][expected.observed_condition]
        if any(evidence.get(key) != value for key, value in evidence_exact.items()) or any(
            (
                token["prompt_sha256"] != observed_token["prompt_sha256"],
                token["prompt_token_count"] != observed_token["prompt_token_count"],
                float(evidence.get("observed_plain_failed_allocation_gib", 0))
                <= float(evidence.get("observed_plain_gpu_free_gib", 0)),
                payload.get("attempt") is not None,
                payload.get("attempt_directory_was_created") is not False,
                payload.get("attempt_setup_evidence_preserved_in_incident5") is not False,
                payload.get("steering_config_sha256")
                != sha256_text(stable_json(dict(steering_config))),
            )
        ):
            failed.append("derived same-prefill resource evidence")
    else:
        failed.append("unrecognized resource-skip evidence kind")
    if failed:
        raise AuditError(f"registered resource-skip marker differs: {sorted(set(failed))}")
    return {
        "shard_index": expected.shard_index,
        "program_id": expected.program_id,
        "condition": expected.condition,
        "round": 1,
        "paired_seed": expected.paired_seed,
        "fingerprint": expected.fingerprint,
        "disposition": disposition,
        "evidence_kind": expected.evidence_kind,
        "marker_path": expected.marker_relative_path,
        "marker_sha256": expected.marker_sha256,
        "incident_recovery_audit_sha256": expected.incident_recovery_audit_sha256,
        "prompt_token_count": token["prompt_token_count"],
        "model_outcome_observed": False,
        "score_created": False,
        "included_in_condition_denominator": False,
    }


def validate_record(
    spec: AuditSpec,
    shard_root: Path,
    run_dir: Path,
    program_id: str,
    condition: str,
    program: Mapping[str, Any],
    preflight: Mapping[str, Any],
    steering_config: Mapping[str, Any],
) -> dict[str, Any]:
    actual_names = {path.name for path in run_dir.iterdir() if path.is_file()}
    actual_dirs = {path.name for path in run_dir.iterdir() if path.is_dir()}
    if actual_names != RUN_FILES or actual_dirs:
        raise AuditError(
            f"run artifact set differs at {run_dir}: files={sorted(actual_names)}, dirs={sorted(actual_dirs)}"
        )
    files = {name: require_file(run_dir / name, shard_root, name) for name in RUN_FILES}
    record = load_object(files["record.json"], "record")
    status = load_object(files["status.json"], "status")
    config = load_object(files["run_config.json"], "run config")
    score = load_object(files["score.json"], "score")
    token_evidence = load_object(files["generated_token_evidence.json"], "token evidence")
    debug = load_object(files["steering_debug.json"], "steering debug")
    model_output = load_object(files["model_output.json"], "model output")
    seed = expected_seed(program_id)
    steered = condition == "obfuscated_codesteer"
    kind = "original" if condition == "original_plain" else "obfuscated"
    prompt = files["submitted_prompt.txt"].read_text(encoding="utf-8")
    source = files["source.java"].read_text(encoding="utf-8")
    token = preflight["prompt_tokens_by_condition"][condition]
    expected_config = expected_run_config(
        spec,
        program_id,
        condition,
        program,
        preflight,
        steering_config,
        prompt,
    )
    fingerprint = str(expected_config["fingerprint"])
    differing = sorted(
        key for key in set(config) | set(expected_config) if config.get(key) != expected_config.get(key)
    )
    if differing:
        raise AuditError(f"run configuration differs at {run_dir}: {differing}")
    expected_source = program[f"{kind}_path"]
    if files["source.java"].read_bytes() != expected_source.read_bytes():
        raise AuditError(f"run source differs at {run_dir}")
    validate_prompt(prompt, program["cases"], source, program[f"{kind}_target_method"], run_dir)
    identity = {
        "program_id": program_id,
        "condition": condition,
        "round": 1,
        "paired_seed": seed,
    }
    expected_record_keys = {
        "status",
        "completed_at_unix",
        "attempt",
        "automatic_retry_used",
        "fingerprint",
        "program_id",
        "round",
        "condition",
        "paired_seed",
        "score",
    }
    if set(record) != expected_record_keys or any(
        (
            record.get("status") != "complete",
            record.get("attempt") != 1,
            record.get("automatic_retry_used") is not False,
            not isinstance(record.get("completed_at_unix"), (int, float)),
            record.get("fingerprint") != fingerprint,
            any(record.get(key) != value for key, value in identity.items()),
            status != record,
            record.get("score") != score,
            model_output.get("score") != score,
            model_output.get("generated_token_evidence") != token_evidence,
            model_output.get("steering_debug") != debug,
            model_output.get("experiment")
            != {
                **identity,
                "fingerprint": fingerprint,
                "protocol_version": PROTOCOL_VERSION,
            },
        )
    ):
        raise AuditError(f"record/artifact binding differs at {run_dir}")
    semantic = validate_steering_debug(
        debug, steered=steered, prompt_tokens=int(token["prompt_token_count"]), run_dir=run_dir
    )
    token_summary = validate_token_evidence(token_evidence, model_output, run_dir)
    completion = files["raw_completion.txt"].read_text(encoding="utf-8")
    if model_output.get("generated_completion") != completion:
        raise AuditError(f"raw/model completion differs at {run_dir}")
    computed = independent_score(program["cases"], completion)
    if score != computed:
        differing_score = sorted(
            key for key in set(score) | set(computed) if score.get(key) != computed.get(key)
        )
        raise AuditError(f"stored score differs from independent rescore at {run_dir}: {differing_score}")
    return {
        **identity,
        "fingerprint": fingerprint,
        "record_path": str(files["record.json"].relative_to(shard_root)),
        "record_sha256": sha256_file(files["record.json"]),
        "parse_status": computed["parse_status"],
        "response_mode": computed["response_mode"],
        "pack_valid": computed["pack_valid"],
        "label_scores": computed["label_scores"],
        "correct_label_count": computed["correct_label_count"],
        "label_count": 6,
        "generated_tokens": token_summary,
        "steering_semantics": semantic,
    }


def expected_study_config(
    spec: AuditSpec,
    shard: Mapping[str, Any],
    preflight: Mapping[str, Any],
    manifest_payload: Mapping[str, Any],
) -> dict[str, Any]:
    preflight_path = (
        Path(str(shard["preflight_output_root"])).resolve(strict=True) / "preflight_summary.json"
    )
    return {
        "schema_version": "expanded-java-300-600-study-config-v1",
        "protocol_version": PROTOCOL_VERSION,
        "cohort_tag": COHORT_TAG,
        "manifest_path": str(spec.manifest_path.resolve(strict=True)),
        "manifest_sha256": spec.expected_manifest_sha256,
        "plan_path": str(spec.plan_path.resolve(strict=True)),
        "plan_sha256": spec.expected_plan_sha256,
        "shard_index": shard["shard_index"],
        "program_ids": shard["program_ids"],
        "conditions": list(CONDITIONS),
        "rounds": [1],
        "generation": GENERATION,
        "source_preparation_policy": manifest_payload.get("source_preparation_policy"),
        "source_preparation_merge_audit_sha256": manifest_payload.get(
            "source_preparation_merge_audit_sha256"
        ),
        "cohort_construction_policy": manifest_payload.get("construction"),
        "expected_generation_count": shard["program_count"] * 3,
        "labels_per_condition": shard["program_count"] * 6,
        "model_id": MODEL_NAME,
        "model_snapshot_commit": MODEL_COMMIT,
        "chat_template_sha256": CHAT_TEMPLATE_SHA256,
        "code_provenance": expected_code_provenance(spec),
        "preflight_summary_sha256": sha256_file(preflight_path),
        "preflight": dict(preflight),
        "engine_liveness_sha256": ENGINE_LIVENESS_SHA256,
    }


def validate_snapshot(
    shard_root: Path,
    program_id: str,
    program: Mapping[str, Any],
    expected_preflight: Mapping[str, Any],
) -> None:
    snapshot = shard_root / "programs" / safe_id(program_id)
    original = require_file(snapshot / "original.java", shard_root, "snapshot original")
    obfuscated = require_file(snapshot / "obfuscated.java", shard_root, "snapshot obfuscated")
    if original.read_bytes() != program["original_path"].read_bytes():
        raise AuditError(f"original snapshot differs: {program_id}")
    if obfuscated.read_bytes() != program["obfuscated_path"].read_bytes():
        raise AuditError(f"obfuscated snapshot differs: {program_id}")
    pack = load_object(require_file(snapshot / "pack.json", shard_root, "pack snapshot"), "pack snapshot")
    expected_pack = {
        "program_id": program_id,
        "case_ids": program["case_ids"],
        "original_sha256": program["original_sha256"],
        "obfuscated_sha256": program["obfuscated_sha256"],
        "original_target_method": program["original_target_method"],
        "obfuscated_target_method": program["obfuscated_target_method"],
    }
    if pack != expected_pack:
        raise AuditError(f"pack snapshot differs: {program_id}")
    local_preflight = load_object(
        require_file(snapshot / "preflight.json", shard_root, "local preflight"), "local preflight"
    )
    if local_preflight != expected_preflight:
        raise AuditError(f"study/preflight evidence differs: {program_id}")


def validate_shard(
    spec: AuditSpec,
    shard: Mapping[str, Any],
    preflight_summary: Mapping[str, Any],
    preflight_by_program: Mapping[str, Mapping[str, Any]],
    manifest: Mapping[str, Any],
) -> dict[str, Any]:
    shard_index = int(shard["shard_index"])
    root = Path(str(shard["study_output_root"])).resolve(strict=True)
    expected_root = (spec.study_root / f"shard_{shard_index}").resolve(strict=True)
    if root != expected_root:
        raise AuditError(f"study root differs for shard {shard_index}")
    temp_artifacts = [path for path in root.rglob(".*.tmp-*")]
    if temp_artifacts:
        raise AuditError(f"temporary/incomplete artifacts remain in shard {shard_index}")
    config_path = require_file(root / "experiment_config.json", root, "experiment config")
    config = load_object(config_path, "experiment config")
    expected_config = expected_study_config(spec, shard, preflight_summary, manifest["payload"])
    if config != expected_config:
        differing = sorted(
            key for key in set(config) | set(expected_config) if config.get(key) != expected_config.get(key)
        )
        raise AuditError(f"study config differs in shard {shard_index}: {differing}")
    environment_path = require_file(root / "environment.json", root, "environment")
    environment = load_object(environment_path, "environment")
    steering_config = validate_environment(spec, root, environment, int(shard["gpu_id"]))
    program_snapshot_root = root / "programs"
    actual_snapshots = {path.name for path in program_snapshot_root.iterdir() if path.is_dir()}
    expected_snapshots = {safe_id(program_id) for program_id in shard["program_ids"]}
    if actual_snapshots != expected_snapshots:
        raise AuditError(f"program snapshot set differs in shard {shard_index}")
    for program_id in shard["program_ids"]:
        validate_snapshot(
            root,
            program_id,
            manifest["programs"][program_id],
            preflight_by_program[program_id],
        )
    runs_root = root / "runs"
    if not runs_root.is_dir():
        raise AuditError(f"runs directory missing in shard {shard_index}")
    if any(not path.is_dir() for path in runs_root.iterdir()):
        raise AuditError(f"unexpected non-directory artifact at shard {shard_index} runs root")
    actual_program_dirs = {path.name for path in runs_root.iterdir() if path.is_dir()}
    expected_program_dirs = {safe_id(program_id) for program_id in shard["program_ids"]}
    if actual_program_dirs != expected_program_dirs:
        raise AuditError(f"partial or extra program run directories in shard {shard_index}")
    records: list[dict[str, Any]] = []
    resource_skips: list[dict[str, Any]] = []
    shard_skip_expectations = [
        row for row in spec.resource_oom_skips if row.shard_index == shard_index
    ]
    skip_by_key = {(row.program_id, row.condition): row for row in shard_skip_expectations}
    if len(skip_by_key) != len(shard_skip_expectations):
        raise AuditError(f"duplicate registered resource-skip key in shard {shard_index}")
    prompts: dict[tuple[str, str], str] = {}
    for program_id in shard["program_ids"]:
        program_dir = runs_root / safe_id(program_id)
        if any(not path.is_dir() for path in program_dir.iterdir()):
            raise AuditError(f"unexpected artifact outside trial directory for {program_id}")
        trial_dirs = {path.name for path in program_dir.iterdir() if path.is_dir()}
        if trial_dirs != {"trial_001"}:
            raise AuditError(f"missing/extra trial (retry) for {program_id}: {sorted(trial_dirs)}")
        trial_root = program_dir / "trial_001"
        if any(not path.is_dir() for path in trial_root.iterdir()):
            raise AuditError(f"unexpected artifact outside condition directories for {program_id}")
        condition_dirs = {path.name for path in trial_root.iterdir() if path.is_dir()}
        skipped_conditions = {
            condition for condition in CONDITIONS if (program_id, condition) in skip_by_key
        }
        expected_conditions = set(CONDITIONS) - skipped_conditions
        if condition_dirs != expected_conditions:
            raise AuditError(f"partial/extra condition set for {program_id}: {sorted(condition_dirs)}")
        for condition in CONDITIONS:
            skip = skip_by_key.get((program_id, condition))
            if skip is not None:
                resource_skips.append(
                    validate_resource_skip(
                        spec,
                        root,
                        skip,
                        manifest["programs"][program_id],
                        preflight_by_program[program_id],
                        steering_config,
                    )
                )
                continue
            run_dir = trial_root / condition
            record = validate_record(
                spec,
                root,
                run_dir,
                program_id,
                condition,
                manifest["programs"][program_id],
                preflight_by_program[program_id],
                steering_config,
            )
            records.append(record)
            prompts[(program_id, condition)] = (run_dir / "submitted_prompt.txt").read_text(
                encoding="utf-8"
            )
        if (
            (program_id, "obfuscated_plain") in prompts
            and (program_id, "obfuscated_codesteer") in prompts
            and prompts[(program_id, "obfuscated_plain")]
            != prompts[(program_id, "obfuscated_codesteer")]
        ):
            raise AuditError(f"paired obfuscated prompts differ: {program_id}")
    if len(resource_skips) != len(shard_skip_expectations):
        raise AuditError(f"registered resource-skip coverage differs in shard {shard_index}")
    all_record_paths = {
        path.resolve(strict=True) for path in runs_root.glob("*/trial_*/*/record.json") if path.is_file()
    }
    expected_record_paths = {
        (root / record["record_path"]).resolve(strict=True) for record in records
    }
    if all_record_paths != expected_record_paths:
        raise AuditError(f"record set is partial or contains extras in shard {shard_index}")
    records.sort(key=lambda row: row["record_path"])
    expected_index_rows = [
        {
            "program_id": record["program_id"],
            "condition": record["condition"],
            "paired_seed": record["paired_seed"],
            "correct_label_count": record["correct_label_count"],
            "label_count": 6,
            "pack_valid": record["pack_valid"],
            "parse_status": record["parse_status"],
            "record_path": record["record_path"],
        }
        for record in records
    ]
    expected_index = {
        "protocol_version": PROTOCOL_VERSION,
        "completed_generation_count": len(records),
        "completed_label_judgment_count": len(records) * 6,
        "runs": expected_index_rows,
    }
    index_path = require_file(root / "results_index.json", root, "terminal results index")
    index = load_object(index_path, "terminal results index")
    if index != expected_index:
        raise AuditError(f"results index is partial, stale, or inconsistent in shard {shard_index}")
    record_set = [
        {
            "record_path": row["record_path"],
            "record_sha256": row["record_sha256"],
            "fingerprint": row["fingerprint"],
        }
        for row in records
    ]
    return {
        "shard_index": shard_index,
        "gpu_id": shard["gpu_id"],
        "artifact_terminal": True,
        "program_ids": shard["program_ids"],
        "program_count": shard["program_count"],
        "generation_record_count": len(records),
        "label_judgment_count": len(records) * 6,
        "planned_generation_count": shard["program_count"] * 3,
        "resource_skip_count": len(resource_skips),
        "experiment_config_sha256": sha256_file(config_path),
        "environment_sha256": sha256_file(environment_path),
        "preflight_summary_sha256": sha256_file(
            Path(str(shard["preflight_output_root"])) / "preflight_summary.json"
        ),
        "results_index_sha256": sha256_file(index_path),
        "record_set_sha256": sha256_text(stable_json(record_set)),
        "records": records,
        "resource_skips": resource_skips,
    }


RECOVERY_OUTCOME_FILES = frozenset(
    {
        "generated_token_evidence.json",
        "model_output.json",
        "raw_completion.txt",
        "record.json",
        "score.json",
        "steering_debug.json",
    }
)
RECOVERY_INTERRUPTED_FILES = frozenset(
    {"run_config.json", "source.java", "status.json", "submitted_prompt.txt"}
)
RECOVERY_PACKAGE_FILES = frozenset(
    {
        "complete_artifacts_before.json",
        "interrupted_attempt_files.json",
        "recovery_audit.json",
        "recovery_audit.sha256",
    }
)
RECOVERY_AUDIT_KEYS = frozenset(
    {
        "schema_version",
        "status",
        "created_at_unix",
        "classification",
        "reason",
        "shard_index",
        "program_id",
        "condition",
        "round",
        "attempt",
        "fingerprint",
        "paired_seed",
        "same_fingerprint_seed_and_config_required_on_relaunch",
        "new_statistical_trial",
        "malformed_output_retry",
        "automatic_retry",
        "model_outcome_observed",
        "model_outcome_files_present",
        "model_outcome_file_denylist",
        "interrupted_file_allowlist",
        "interrupted_attempt_files",
        "interrupted_attempt_files_ledger",
        "interrupted_attempt_files_ledger_sha256",
        "live_interrupted_path_before",
        "live_interrupted_path_absent_after",
        "preserved_attempt_path",
        "preservation_method",
        "preserved_directory_device",
        "preserved_directory_inode",
        "evidence_read_only_modes_applied",
        "pinned_sha256",
        "run_config_sha256",
        "submitted_prompt_sha256",
        "submitted_source_sha256",
        "completed_generation_count_before",
        "completed_generation_count_after",
        "completed_record_sha256_before",
        "completed_record_sha256_after_recovery",
        "complete_artifact_count",
        "complete_artifacts_content_ledger_sha256",
        "complete_artifacts_ledger",
        "complete_artifacts_ledger_file_sha256",
        "complete_artifacts_untouched",
        "results_index_untouched",
        "registered_study_argv",
        "registered_study_shell_command",
        "registered_tmux_session",
        "manual_relaunch_required",
        "model_inference_performed_by_recovery",
    }
)
RECOVERY_CHAIN_COMMON_AUDIT_KEYS = frozenset(
    {
        "recovery_ordinal",
        "prior_recovery_count",
        "ordered_prior_recoveries",
        "recovery_tool_path",
        "recovery_tool_sha256",
    }
)
RECOVERY_LEGACY_CHAIN_AUDIT_KEYS = RECOVERY_CHAIN_COMMON_AUDIT_KEYS | frozenset(
    {"prior_recovered_records_match_preserved_fingerprint_seed_and_config"}
)
RECOVERY_REPEAT_AWARE_CHAIN_AUDIT_KEYS = RECOVERY_CHAIN_COMMON_AUDIT_KEYS | frozenset(
    {
        "prior_completed_recovered_records_match_preserved_fingerprint_seed_and_config",
        "latest_reinterrupted_prior_setup_match",
        "completed_model_outcome_between_latest_recovery_incidents",
    }
)
RECOVERY_ALLOCATOR_AMENDMENT_AUDIT_KEYS = frozenset(
    {
        "allocator_amendment_path",
        "allocator_amendment_sha256",
        "allocator_recovery_amendment_registered",
        "approved_environment_delta",
        "registered_python_argv_unchanged_by_allocator_amendment",
        "root_observed_runtime_error",
        "runtime_error_persisted_log_claimed",
    }
)
RECOVERY_POST_ALLOCATOR_OOM_AUDIT_KEYS = frozenset(
    {"post_allocator_runtime_failure_registered"}
)


def evidence_file_ledger(directory: Path) -> dict[str, dict[str, Any]]:
    if not directory.is_dir() or directory.is_symlink():
        raise AuditError(f"recovery evidence is not a real directory: {directory}")
    ledger: dict[str, dict[str, Any]] = {}
    for path in sorted(directory.rglob("*")):
        if path.is_symlink():
            raise AuditError(f"symlink is forbidden in recovery evidence: {path}")
        if path.is_dir():
            continue
        if not path.is_file():
            raise AuditError(f"non-regular recovery evidence entry: {path}")
        ledger[path.relative_to(directory).as_posix()] = {
            "sha256": sha256_file(path),
            "size_bytes": path.stat().st_size,
        }
    return ledger


def validate_ledger_shape(ledger: Mapping[str, Any], label: str) -> None:
    for relative, row in ledger.items():
        if (
            not isinstance(relative, str)
            or not relative
            or Path(relative).is_absolute()
            or ".." in Path(relative).parts
            or not isinstance(row, Mapping)
            or re.fullmatch(r"[0-9a-f]{64}", str(row.get("sha256") or "")) is None
            or type(row.get("size_bytes")) is not int
            or row.get("size_bytes", -1) < 0
        ):
            raise AuditError(f"malformed {label} ledger row: {relative!r}")


def validate_no_unregistered_recovery(spec: AuditSpec) -> None:
    observed = list(spec.study_root.glob("shard_*/recovery_evidence"))
    if observed:
        raise AuditError(f"unregistered infrastructure recovery evidence exists: {observed}")


def validate_one_recovery_evidence(
    spec: AuditSpec,
    plan: Mapping[str, Any],
    shards: Sequence[Mapping[str, Any]],
    expected: RecoveryExpectation,
    ordinal: int,
    prior_expectations: Sequence[RecoveryExpectation],
    terminal_resource_skip_keys: set[tuple[int, str, str]],
) -> dict[str, Any]:
    if expected.audit_sha256.startswith("PENDING_"):
        raise AuditError("registered recovery audit hash has not been frozen")
    evidence_root = (spec.root / expected.evidence_relative_path).resolve(strict=True)
    try:
        evidence_root.relative_to(spec.root.resolve(strict=True))
    except ValueError as exc:
        raise AuditError("registered recovery evidence escapes the experiment root") from exc
    if evidence_root.parent.name != "recovery_evidence":
        raise AuditError("registered recovery evidence path shape differs")
    actual_files = {path.name for path in evidence_root.iterdir() if path.is_file()}
    actual_dirs = {path.name for path in evidence_root.iterdir() if path.is_dir()}
    supplemental = dict(expected.supplemental_files)
    if len(supplemental) != len(expected.supplemental_files) or set(supplemental) & RECOVERY_PACKAGE_FILES:
        raise AuditError("registered recovery supplemental-file specification is invalid")
    expected_files = RECOVERY_PACKAGE_FILES | set(supplemental)
    if actual_files != expected_files or actual_dirs != {"interrupted_attempt"}:
        raise AuditError("recovery evidence package file set differs")
    for name, digest in supplemental.items():
        require_exact_hash(evidence_root / name, digest, "registered recovery supplemental evidence")
    audit_path = require_file(evidence_root / "recovery_audit.json", evidence_root, "recovery audit")
    require_exact_hash(audit_path, expected.audit_sha256, "registered recovery audit")
    anchor = require_file(
        evidence_root / "recovery_audit.sha256", evidence_root, "recovery audit SHA-256 anchor"
    )
    if anchor.read_text(encoding="utf-8").strip().split() != [
        expected.audit_sha256,
        "recovery_audit.json",
    ]:
        raise AuditError("recovery audit SHA-256 anchor differs")
    audit = load_object(audit_path, "recovery audit")
    if ordinal == 1:
        expected_audit_keys = RECOVERY_AUDIT_KEYS
    elif ordinal == 2:
        expected_audit_keys = RECOVERY_AUDIT_KEYS | RECOVERY_LEGACY_CHAIN_AUDIT_KEYS
    else:
        expected_audit_keys = RECOVERY_AUDIT_KEYS | RECOVERY_REPEAT_AWARE_CHAIN_AUDIT_KEYS
    if expected.allocator_audit_mode != "none":
        expected_audit_keys |= RECOVERY_ALLOCATOR_AMENDMENT_AUDIT_KEYS
    if expected.allocator_audit_mode == "post_allocator_oom":
        expected_audit_keys |= RECOVERY_POST_ALLOCATOR_OOM_AUDIT_KEYS
    if set(audit) != expected_audit_keys:
        raise AuditError(
            f"recovery audit schema keys differ: missing={sorted(expected_audit_keys-set(audit))}, "
            f"extra={sorted(set(audit)-expected_audit_keys)}"
        )
    shard = plan["shards"][expected.shard_index]
    terminal_resource_skip = (
        expected.shard_index,
        expected.program_id,
        expected.condition,
    ) in terminal_resource_skip_keys
    live_run_dir = (
        Path(str(shard["study_output_root"]))
        / "runs"
        / safe_id(expected.program_id)
        / "trial_001"
        / expected.condition
    ).resolve(strict=not terminal_resource_skip)
    preserved = (evidence_root / "interrupted_attempt").resolve(strict=True)
    exact = {
        "schema_version": "expanded-java-300-600-infrastructure-recovery-v1",
        "status": "recovery_prepared",
        "classification": "infrastructure_restart_before_any_recorded_or_observed_model_outcome",
        "reason": expected.reason,
        "shard_index": expected.shard_index,
        "program_id": expected.program_id,
        "condition": expected.condition,
        "round": 1,
        "attempt": 1,
        "fingerprint": expected.fingerprint,
        "paired_seed": expected.paired_seed,
        "same_fingerprint_seed_and_config_required_on_relaunch": True,
        "new_statistical_trial": False,
        "malformed_output_retry": False,
        "automatic_retry": False,
        "model_outcome_observed": False,
        "model_outcome_files_present": [],
        "model_outcome_file_denylist": sorted(RECOVERY_OUTCOME_FILES),
        "interrupted_file_allowlist": sorted(RECOVERY_INTERRUPTED_FILES),
        "interrupted_attempt_files_ledger": "interrupted_attempt_files.json",
        "live_interrupted_path_before": str(live_run_dir),
        "live_interrupted_path_absent_after": True,
        "preserved_attempt_path": str(preserved),
        "preservation_method": "same-filesystem atomic directory rename (os.replace)",
        "evidence_read_only_modes_applied": True,
        "complete_artifacts_ledger": "complete_artifacts_before.json",
        "complete_artifacts_untouched": True,
        "results_index_untouched": True,
        "registered_study_argv": shard["study_argv"],
        "registered_study_shell_command": shard["study_shell_command"],
        "registered_tmux_session": shard["study_tmux_session"],
        "manual_relaunch_required": True,
        "model_inference_performed_by_recovery": False,
    }
    failed = [key for key, value in exact.items() if audit.get(key) != value]
    if type(audit.get("created_at_unix")) not in (int, float) or audit.get("created_at_unix", 0) <= 0:
        failed.append("created_at_unix")
    if (
        type(audit.get("preserved_directory_device")) is not int
        or type(audit.get("preserved_directory_inode")) is not int
        or audit.get("preserved_directory_device") != preserved.stat().st_dev
        or audit.get("preserved_directory_inode") != preserved.stat().st_ino
    ):
        failed.append("preserved_directory_device/inode")
    if failed:
        raise AuditError(f"registered recovery audit differs: {sorted(set(failed))}")
    if expected.allocator_audit_mode == "registered_amendment":
        amendment_path = evidence_root / "allocator_amendment.json"
        allocator_exact = {
            "allocator_amendment_path": str(amendment_path.resolve(strict=True)),
            "allocator_amendment_sha256": supplemental["allocator_amendment.json"],
            "allocator_recovery_amendment_registered": True,
            "approved_environment_delta": {
                "PYTORCH_CUDA_ALLOC_CONF": "max_split_size_mb:128"
            },
            "registered_python_argv_unchanged_by_allocator_amendment": True,
            "runtime_error_persisted_log_claimed": False,
        }
        runtime_error = audit.get("root_observed_runtime_error")
        allocator_failed = [
            key for key, value in allocator_exact.items() if audit.get(key) != value
        ]
        if not isinstance(runtime_error, Mapping) or any(
            (
                runtime_error.get("exception_type") != "torch.cuda.OutOfMemoryError",
                runtime_error.get("persisted_runtime_log_available") is not False,
                runtime_error.get("persisted_runtime_log_path") is not None,
                float(runtime_error.get("failed_allocation_gib", 0)) <= 0,
            )
        ):
            allocator_failed.append("root_observed_runtime_error")
        if allocator_failed:
            raise AuditError(
                f"registered allocator amendment differs: {sorted(set(allocator_failed))}"
            )
    elif expected.allocator_audit_mode == "post_allocator_oom":
        post_exact = {
            "allocator_amendment_path": None,
            "allocator_amendment_sha256": None,
            "allocator_recovery_amendment_registered": False,
            "approved_environment_delta": None,
            "registered_python_argv_unchanged_by_allocator_amendment": None,
            "runtime_error_persisted_log_claimed": False,
            "post_allocator_runtime_failure_registered": True,
        }
        runtime_error = audit.get("root_observed_runtime_error")
        post_failed = [key for key, value in post_exact.items() if audit.get(key) != value]
        if not isinstance(runtime_error, Mapping) or any(
            (
                runtime_error.get("exception_type") != "torch.cuda.OutOfMemoryError",
                runtime_error.get("allocator_environment_active")
                != {"PYTORCH_CUDA_ALLOC_CONF": "max_split_size_mb:128"},
                runtime_error.get("max_split_size_mb_128_eliminated_fragmentation") is not True,
                float(runtime_error.get("failed_allocation_gib", 0))
                <= float(runtime_error.get("gpu_free_gib", 0)),
                runtime_error.get("persisted_runtime_log_available") is not False,
                runtime_error.get("persisted_runtime_log_path") is not None,
            )
        ):
            post_failed.append("root_observed_runtime_error")
        if post_failed:
            raise AuditError(
                f"registered post-allocator OOM evidence differs: {sorted(set(post_failed))}"
            )
    elif expected.allocator_audit_mode != "none":
        raise AuditError("unknown registered recovery allocator audit mode")
    if ordinal > 1:
        if len(prior_expectations) != ordinal - 1:
            raise AuditError("registered recovery prefix length differs from its ordinal")
        expected_prior_recoveries = []
        all_through_current = [*prior_expectations, expected]
        for prior_ordinal, prior in enumerate(prior_expectations, start=1):
            prior_audit = require_file(
                (spec.root / prior.evidence_relative_path / "recovery_audit.json").resolve(
                    strict=True
                ),
                spec.root,
                "prior recovery audit",
            )
            require_exact_hash(prior_audit, prior.audit_sha256, "prior recovery audit")
            prior_audit_data = load_object(prior_audit, "prior recovery audit")
            prior_shard = plan["shards"][prior.shard_index]
            prior_run_dir = (
                Path(str(prior_shard["study_output_root"]))
                / "runs"
                / safe_id(prior.program_id)
                / "trial_001"
                / prior.condition
            )
            prior_record = prior_run_dir / "record.json"
            base_row = {
                "ordinal": prior_ordinal,
                "audit_path": str(prior_audit),
                "audit_sha256": prior.audit_sha256,
                "program_id": prior.program_id,
                "condition": prior.condition,
                "fingerprint": prior.fingerprint,
                "paired_seed": prior.paired_seed,
            }
            if ordinal == 2:
                prior_record = require_file(
                    prior_record.resolve(strict=True), prior_run_dir, "prior recovered record"
                )
                base_row.update(
                    {
                        "resumed_record_path": str(prior_record),
                        "resumed_record_sha256": sha256_file(prior_record),
                        "resumed_record_matches_preserved_configuration": True,
                    }
                )
                expected_prior_recoveries.append(base_row)
                continue

            next_expectation = all_through_current[prior_ordinal]
            if next_expectation is expected:
                next_audit_data = audit
            else:
                next_audit_path = require_file(
                    (
                        spec.root
                        / next_expectation.evidence_relative_path
                        / "recovery_audit.json"
                    ).resolve(strict=True),
                    spec.root,
                    "next recovery audit",
                )
                require_exact_hash(
                    next_audit_path, next_expectation.audit_sha256, "next recovery audit"
                )
                next_audit_data = load_object(next_audit_path, "next recovery audit")
            next_records = next_audit_data.get("completed_record_sha256_before")
            if not isinstance(next_records, Mapping):
                raise AuditError("next recovery completed-record ledger is malformed")
            prior_record_relative = prior_record.relative_to(
                Path(str(prior_shard["study_output_root"]))
            ).as_posix()
            if prior_record_relative in next_records:
                prior_record = require_file(
                    prior_record.resolve(strict=True), prior_run_dir, "prior recovered record"
                )
                resumed_sha = str(next_records[prior_record_relative])
                if sha256_file(prior_record) != resumed_sha:
                    raise AuditError("prior recovered record differs from the next recovery ledger")
                base_row.update(
                    {
                        "resume_disposition": "completed_before_next_recovery",
                        "resumed_record_path": str(prior_record),
                        "resumed_record_sha256": resumed_sha,
                        "resumed_record_matches_preserved_configuration": True,
                    }
                )
            else:
                same_identity = all(
                    (
                        next_expectation.shard_index == prior.shard_index,
                        next_expectation.program_id == prior.program_id,
                        next_expectation.condition == prior.condition,
                        next_expectation.fingerprint == prior.fingerprint,
                        next_expectation.paired_seed == prior.paired_seed,
                    )
                )
                if (
                    not same_identity
                    or prior_audit_data.get("interrupted_attempt_files")
                    != next_audit_data.get("interrupted_attempt_files")
                ):
                    raise AuditError(
                        "reinterrupted recovery does not preserve the identical setup identity"
                    )
                base_row.update(
                    {
                        "resume_disposition": "reinterrupted_before_outcome",
                        "resumed_record_path": None,
                        "resumed_record_sha256": None,
                        "resumed_record_matches_preserved_configuration": False,
                        "completed_model_outcome_claimed": False,
                    }
                )
            expected_prior_recoveries.append(base_row)

        chain_exact = {
            "recovery_ordinal": ordinal,
            "prior_recovery_count": ordinal - 1,
            "ordered_prior_recoveries": expected_prior_recoveries,
            "recovery_tool_path": str(expected.tool_path.resolve(strict=True)),
            "recovery_tool_sha256": expected.tool_sha256,
        }
        if ordinal == 2:
            chain_exact[
                "prior_recovered_records_match_preserved_fingerprint_seed_and_config"
            ] = True
        else:
            latest = expected_prior_recoveries[-1]
            repeated = latest.get("resume_disposition") == "reinterrupted_before_outcome"
            latest_match = None
            if repeated:
                latest_match = {
                    "prior_audit_ordinal": latest["ordinal"],
                    "prior_audit_path": latest["audit_path"],
                    "prior_audit_sha256": latest["audit_sha256"],
                    "disposition": "reinterrupted_before_outcome",
                    "current_setup_matches_prior_preserved_files": True,
                    "current_setup_matches_prior_fingerprint_seed_and_config": True,
                    "completed_model_outcome_between_incidents": False,
                }
                consecutive = [
                    row
                    for row in expected_prior_recoveries
                    if row.get("resume_disposition") == "reinterrupted_before_outcome"
                ]
                if len(consecutive) > 1:
                    latest_match.update(
                        {
                            "consecutive_reinterruption_count": len(consecutive),
                            "consecutive_reinterruption_chain": [
                                {
                                    "prior_audit_ordinal": row["ordinal"],
                                    "prior_audit_path": row["audit_path"],
                                    "prior_audit_sha256": row["audit_sha256"],
                                    "preserved_setup_matches_current": True,
                                }
                                for row in consecutive
                            ],
                        }
                    )
            chain_exact.update(
                {
                    "prior_completed_recovered_records_match_preserved_fingerprint_seed_and_config": True,
                    "latest_reinterrupted_prior_setup_match": latest_match,
                    "completed_model_outcome_between_latest_recovery_incidents": (
                        False if repeated else None
                    ),
                }
            )
        chain_failed = [key for key, value in chain_exact.items() if audit.get(key) != value]
        if chain_failed:
            raise AuditError(
                f"registered recovery chain binding differs: {sorted(chain_failed)}"
            )
    for path in [evidence_root, *evidence_root.rglob("*")]:
        if path.stat().st_mode & 0o222:
            raise AuditError(f"recovery evidence is not read-only: {path}")
    interrupted_ledger_path = require_file(
        evidence_root / "interrupted_attempt_files.json", evidence_root, "interrupted file ledger"
    )
    interrupted_ledger = load_object(interrupted_ledger_path, "interrupted file ledger")
    validate_ledger_shape(interrupted_ledger, "interrupted attempt")
    if any(
        (
            set(interrupted_ledger) != RECOVERY_INTERRUPTED_FILES,
            interrupted_ledger != audit.get("interrupted_attempt_files"),
            sha256_file(interrupted_ledger_path)
            != audit.get("interrupted_attempt_files_ledger_sha256"),
            evidence_file_ledger(preserved) != interrupted_ledger,
            bool(set(interrupted_ledger) & RECOVERY_OUTCOME_FILES),
        )
    ):
        raise AuditError("preserved pre-outcome attempt ledger differs")
    preserved_status = load_object(preserved / "status.json", "preserved interrupted status")
    if preserved_status != {"attempt": 1, "status": "running"}:
        raise AuditError("preserved interrupted status differs")
    preserved_config = load_object(preserved / "run_config.json", "preserved run config")
    reconstructed = sha256_text(stable_json(fingerprint_payload(preserved_config)))
    if any(
        (
            preserved_config.get("program_id") != expected.program_id,
            preserved_config.get("condition") != expected.condition,
            preserved_config.get("round") != 1,
            preserved_config.get("attempt") != 1,
            preserved_config.get("automatic_retry_allowed") is not False,
            preserved_config.get("paired_seed") != expected.paired_seed,
            expected_seed(expected.program_id) != expected.paired_seed,
            preserved_config.get("fingerprint") != expected.fingerprint,
            reconstructed != expected.fingerprint,
            sha256_file(preserved / "run_config.json") != audit.get("run_config_sha256"),
            sha256_file(preserved / "submitted_prompt.txt")
            != audit.get("submitted_prompt_sha256"),
            sha256_file(preserved / "source.java") != audit.get("submitted_source_sha256"),
        )
    ):
        raise AuditError("preserved interrupted run identity/config differs")
    for filename in RECOVERY_OUTCOME_FILES:
        if (preserved / filename).exists():
            raise AuditError(f"preserved attempt contains forbidden outcome artifact: {filename}")
    final_record: Optional[dict[str, Any]] = None
    if terminal_resource_skip:
        if live_run_dir.exists():
            raise AuditError("resource-skipped recovery unexpectedly has a canonical run directory")
    else:
        for filename in ("run_config.json", "submitted_prompt.txt", "source.java"):
            if (preserved / filename).read_bytes() != (live_run_dir / filename).read_bytes():
                raise AuditError(f"resumed completion changed preserved {filename}")
        final_record = load_object(live_run_dir / "record.json", "recovered final record")
        if any(
            (
                final_record.get("status") != "complete",
                final_record.get("attempt") != 1,
                final_record.get("automatic_retry_used") is not False,
                final_record.get("program_id") != expected.program_id,
                final_record.get("condition") != expected.condition,
                final_record.get("paired_seed") != expected.paired_seed,
                final_record.get("fingerprint") != expected.fingerprint,
            )
        ):
            raise AuditError("resumed canonical record identity differs")
    complete_ledger_path = require_file(
        evidence_root / "complete_artifacts_before.json", evidence_root, "complete artifact ledger"
    )
    complete_ledger = load_object(complete_ledger_path, "complete artifact ledger")
    validate_ledger_shape(complete_ledger, "complete artifact")
    if sha256_file(complete_ledger_path) != audit.get("complete_artifacts_ledger_file_sha256"):
        raise AuditError("complete artifact ledger file hash differs")
    compact = {path: row["sha256"] for path, row in complete_ledger.items()}
    compact_sha = sha256_text(
        json.dumps(compact, ensure_ascii=False, sort_keys=True, separators=(",", ":"))
    )
    if any(
        (
            len(complete_ledger) != audit.get("complete_artifact_count"),
            len(complete_ledger) != audit.get("completed_generation_count_before") * len(RUN_FILES),
            compact_sha != audit.get("complete_artifacts_content_ledger_sha256"),
        )
    ):
        raise AuditError("complete pre-restart artifact ledger summary differs")
    grouped: dict[Path, set[str]] = {}
    for relative, row in complete_ledger.items():
        path = Path(str(shard["study_output_root"])) / relative
        path = require_file(path, Path(str(shard["study_output_root"])), "preexisting complete artifact")
        if sha256_file(path) != row["sha256"] or path.stat().st_size != row["size_bytes"]:
            raise AuditError(f"preexisting completed artifact was regenerated or changed: {relative}")
        relative_path = Path(relative)
        if len(relative_path.parts) != 5 or relative_path.parts[0] != "runs":
            raise AuditError(f"preexisting complete artifact path shape differs: {relative}")
        grouped.setdefault(relative_path.parent, set()).add(relative_path.name)
    if any(names != RUN_FILES for names in grouped.values()):
        raise AuditError("pre-restart complete run file set differs")
    before_records = audit.get("completed_record_sha256_before")
    after_records = audit.get("completed_record_sha256_after_recovery")
    if not isinstance(before_records, Mapping) or before_records != after_records:
        raise AuditError("pre/post recovery completed-record ledger differs")
    ledger_record_hashes = {
        relative: row["sha256"]
        for relative, row in complete_ledger.items()
        if Path(relative).name == "record.json"
    }
    if any(
        (
            dict(before_records) != ledger_record_hashes,
            len(before_records) != audit.get("completed_generation_count_before"),
            audit.get("completed_generation_count_before")
            != audit.get("completed_generation_count_after"),
        )
    ):
        raise AuditError("completed record counts/hashes differ around recovery")
    current_index_path = Path(str(shard["study_output_root"])) / "results_index.json"
    current_index = load_object(current_index_path, "final results index")
    before_rows = [
        row for row in current_index.get("runs", []) if row.get("record_path") in before_records
    ]
    reconstructed_before_index = {
        "protocol_version": PROTOCOL_VERSION,
        "completed_generation_count": len(before_rows),
        "completed_label_judgment_count": len(before_rows) * 6,
        "runs": before_rows,
    }
    reconstructed_before_sha = sha256_text(pretty_json(reconstructed_before_index))
    pinned = audit.get("pinned_sha256")
    expected_pinned = {
        "plan": spec.expected_plan_sha256,
        "manifest": spec.expected_manifest_sha256,
        "preflight": spec.expected_preflight_sha256[expected.shard_index],
        "results_index": expected.initial_results_index_sha256,
        "experiment_config": expected.experiment_config_sha256,
        "run_shard.py": spec.expected_runner_sha256,
        "run_binary_v2.py": spec.expected_v2_sha256,
    }
    experiment_config_path = Path(str(shard["study_output_root"])) / "experiment_config.json"
    if any(
        (
            pinned != expected_pinned,
            reconstructed_before_sha != expected.initial_results_index_sha256,
            sha256_file(experiment_config_path) != expected.experiment_config_sha256,
        )
    ):
        raise AuditError("recovery pinned provenance or reconstructed initial index differs")
    recovered_rows = [
        row
        for shard_summary in shards
        for row in shard_summary["records"]
        if row["program_id"] == expected.program_id and row["condition"] == expected.condition
    ]
    matching_skips = [
        row
        for shard_summary in shards
        for row in shard_summary.get("resource_skips", [])
        if row["program_id"] == expected.program_id and row["condition"] == expected.condition
    ]
    if terminal_resource_skip:
        if recovered_rows or len(matching_skips) != 1 or matching_skips[0]["fingerprint"] != expected.fingerprint:
            raise AuditError("terminal recovery is not bound to exactly one registered resource skip")
    elif len(recovered_rows) != 1 or recovered_rows[0]["fingerprint"] != expected.fingerprint:
        raise AuditError("recovered record is absent or duplicated in validated results")
    resumed_record_relative = str(
        (live_run_dir / "record.json").relative_to(Path(str(shard["study_output_root"])))
    )
    resumed_record_sha = (
        None if terminal_resource_skip else sha256_file(live_run_dir / "record.json")
    )
    return {
        "classification": audit["classification"],
        "recovery_ordinal": ordinal,
        "prior_recovery_count": ordinal - 1,
        "shard_index": expected.shard_index,
        "program_id": expected.program_id,
        "condition": expected.condition,
        "round": 1,
        "paired_seed": expected.paired_seed,
        "fingerprint": expected.fingerprint,
        "recovery_audit_sha256": expected.audit_sha256,
        "recovery_tool_sha256": expected.tool_sha256,
        "recovery_tool_audit_pinned": ordinal > 1,
        "ordered_prior_recoveries_audit_pinned": ordinal > 1,
        "preserved_attempt_file_count": len(interrupted_ledger),
        "preserved_model_outcome_artifact_count": 0,
        "preexisting_completed_record_count": len(before_records),
        "preexisting_completed_artifact_count": len(complete_ledger),
        "same_config_prompt_source_seed_and_fingerprint": True,
        "preexisting_completed_artifacts_unchanged": True,
        "new_statistical_trial": False,
        "malformed_output_retry": False,
        "automatic_retry": False,
        "model_inference_performed_by_recovery": False,
        "terminal_disposition": (
            "registered_resource_skip_without_model_outcome"
            if terminal_resource_skip
            else "completed_canonical_first_attempt"
        ),
        "_created_at_unix": audit["created_at_unix"],
        "_preexisting_record_hashes": dict(before_records),
        "_preexisting_artifact_ledger": complete_ledger,
        "_interrupted_attempt_ledger": interrupted_ledger,
        "_resumed_record_relative_path": resumed_record_relative,
        "_resumed_record_sha256": resumed_record_sha,
        "disclosure": (
            "one infrastructure restart occurred before any model-outcome artifact was recorded; "
            "the identical registered program-condition, seed, prompt, source, config, and fingerprint "
            + (
                "were ultimately excluded by an exact user-authorized physical-resource marker"
                if terminal_resource_skip
                else "were resumed in the canonical first-attempt path"
            )
        ),
    }


def validate_recovery_evidence(
    spec: AuditSpec,
    plan: Mapping[str, Any],
    shards: Sequence[Mapping[str, Any]],
) -> dict[str, Any]:
    expectations = spec.recoveries
    terminal_resource_skip_keys = {
        (row.shard_index, row.program_id, row.condition) for row in spec.resource_oom_skips
    }
    if not expectations:
        validate_no_unregistered_recovery(spec)
        return {
            "count": 0,
            "registered": False,
            "classification": None,
            "conditions": [],
            "incidents": [],
            "disclosure": "no infrastructure restart is registered for this audit specification",
        }
    if len(expectations) != len({item.evidence_relative_path for item in expectations}):
        raise AuditError("registered recovery evidence paths are duplicated")
    tool_versions: dict[Path, RecoveryExpectation] = {}
    for item in expectations:
        if item.tool_sha256.startswith("PENDING_"):
            raise AuditError("registered recovery tool hash has not been frozen")
        tool_versions[item.tool_path.resolve(strict=True)] = item
    for path, latest in tool_versions.items():
        require_exact_hash(path, latest.tool_sha256, "latest registered incident recovery tool")
    expected_by_shard: dict[int, set[Path]] = {}
    for item in expectations:
        evidence = (spec.root / item.evidence_relative_path).resolve(strict=True)
        expected_by_shard.setdefault(item.shard_index, set()).add(evidence)
    for shard_index in range(len(plan["shards"])):
        parent = spec.study_root / f"shard_{shard_index}" / "recovery_evidence"
        registered = expected_by_shard.get(shard_index, set())
        if not registered:
            if parent.exists():
                raise AuditError(f"unregistered recovery evidence exists in shard {shard_index}")
            continue
        if not parent.is_dir() or parent.is_symlink():
            raise AuditError(f"registered recovery parent is invalid in shard {shard_index}")
        entries = list(parent.iterdir())
        if any(not entry.is_dir() or entry.is_symlink() for entry in entries):
            raise AuditError(f"unexpected entry in shard {shard_index} recovery parent")
        observed = {entry.resolve(strict=True) for entry in entries}
        if observed != registered:
            raise AuditError(f"missing or unregistered recovery package in shard {shard_index}")
    internal = [
        validate_one_recovery_evidence(
            spec,
            plan,
            shards,
            expected,
            ordinal,
            expectations[: ordinal - 1],
            terminal_resource_skip_keys,
        )
        for ordinal, expected in enumerate(expectations, start=1)
    ]
    transitions: list[dict[str, Any]] = []
    for index, incident in enumerate(internal):
        if index == 0:
            continue
        previous = internal[index - 1]
        if incident["_created_at_unix"] <= previous["_created_at_unix"]:
            raise AuditError("registered infrastructure recoveries are not chronologically ordered")
        previous_records = previous["_preexisting_record_hashes"]
        current_records = incident["_preexisting_record_hashes"]
        if not set(previous_records).issubset(current_records) or any(
            current_records[path] != digest for path, digest in previous_records.items()
        ):
            raise AuditError("later recovery does not preserve the prior completed-record ledger")
        previous_artifacts = previous["_preexisting_artifact_ledger"]
        current_artifacts = incident["_preexisting_artifact_ledger"]
        if not set(previous_artifacts).issubset(current_artifacts) or any(
            current_artifacts[path] != row for path, row in previous_artifacts.items()
        ):
            raise AuditError("later recovery does not preserve the prior complete-artifact ledger")
        resumed_path = previous["_resumed_record_relative_path"]
        if len(current_records) > len(previous_records):
            if (
                previous["_resumed_record_sha256"] is None
                or current_records.get(resumed_path) != previous["_resumed_record_sha256"]
            ):
                raise AuditError("later recovery does not bind the prior resumed completion")
            disposition = "completed_before_next_recovery"
        elif len(current_records) == len(previous_records):
            identity_keys = ("shard_index", "program_id", "condition", "fingerprint", "paired_seed")
            if any(previous[key] != incident[key] for key in identity_keys):
                raise AuditError(
                    "unchanged recovery ledger is not an identical pre-outcome reinterruption"
                )
            if previous["_interrupted_attempt_ledger"] != incident["_interrupted_attempt_ledger"]:
                raise AuditError("reinterrupted recovery setup files differ")
            if current_artifacts != previous_artifacts:
                raise AuditError("unchanged record ledger has a changed complete-artifact ledger")
            if resumed_path in current_records:
                raise AuditError("reinterrupted recovery ledger unexpectedly claims a model outcome")
            disposition = "reinterrupted_before_outcome"
        else:
            raise AuditError("later recovery loses completed records")
        transitions.append(
            {
                "from_ordinal": previous["recovery_ordinal"],
                "to_ordinal": incident["recovery_ordinal"],
                "disposition": disposition,
                "completed_record_count_before": len(previous_records),
                "completed_record_count_after": len(current_records),
                "completed_artifact_count_before": len(previous_artifacts),
                "completed_artifact_count_after": len(current_artifacts),
            }
        )
    private = {
        "_created_at_unix",
        "_preexisting_record_hashes",
        "_preexisting_artifact_ledger",
        "_interrupted_attempt_ledger",
        "_resumed_record_relative_path",
        "_resumed_record_sha256",
    }
    incidents = [{key: value for key, value in row.items() if key not in private} for row in internal]
    return {
        "count": len(incidents),
        "registered": True,
        "classification": "ordered_finite_pre_outcome_infrastructure_restarts",
        "conditions": [row["condition"] for row in incidents],
        "incidents": incidents,
        "transitions": transitions,
        "completed_before_next_recovery_transition_count": sum(
            row["disposition"] == "completed_before_next_recovery" for row in transitions
        ),
        "reinterrupted_before_outcome_transition_count": sum(
            row["disposition"] == "reinterrupted_before_outcome" for row in transitions
        ),
        "additional_statistical_trial_count": 0,
        "preserved_setup_only_attempts_counted_as_model_outputs": 0,
        "all_preserved_model_outcome_artifact_counts_zero": all(
            row["preserved_model_outcome_artifact_count"] == 0 for row in incidents
        ),
        "all_prior_completed_artifacts_unchanged": True,
        "ordered_cumulative_record_ledgers_verified": True,
        "terminal_resource_skip_incident_count": sum(
            row["terminal_disposition"] == "registered_resource_skip_without_model_outcome"
            for row in incidents
        ),
        "disclosure": (
            f"{len(incidents)} ordered infrastructure restarts occurred before any model-outcome "
            "artifact was recorded; every setup-only attempt was preserved and each identical "
            "registered first-attempt identity either completed or ended in an exact registered "
            "physical-resource skip"
        ),
    }


def condition_summary(
    records: Sequence[Mapping[str, Any]],
    condition: str,
    planned_program_count: int,
    expected_available_count: int,
) -> dict[str, Any]:
    runs = [record for record in records if record["condition"] == condition]
    labels = [label for record in runs for label in record["label_scores"]]
    expected_labels = expected_available_count * 6
    if len(runs) != expected_available_count or len(labels) != expected_labels:
        raise AuditError(f"condition denominator differs: {condition}")
    true_rows = [row for row in labels if row["expected_label"] == "T"]
    false_rows = [row for row in labels if row["expected_label"] == "F"]
    if (
        len(true_rows) != expected_available_count * 3
        or len(false_rows) != expected_available_count * 3
    ):
        raise AuditError(f"condition class balance differs: {condition}")
    correct = sum(int(row["correct"]) for row in labels)
    true_correct = sum(int(row["correct"]) for row in true_rows)
    false_correct = sum(int(row["correct"]) for row in false_rows)
    exact_six = sum(int(record["correct_label_count"] == 6) for record in runs)
    valid = sum(int(record["pack_valid"]) for record in runs)
    parse_counts = dict(sorted(Counter(str(record["parse_status"]) for record in runs).items()))
    return {
        "planned_program_count": planned_program_count,
        "program_prompt_count": expected_available_count,
        "available_program_count": expected_available_count,
        "resource_skip_count": planned_program_count - expected_available_count,
        "label_count": expected_labels,
        "correct_label_count": correct,
        "pass_at_1": correct / expected_labels if expected_labels else None,
        "pass_at_1_percent": correct / expected_labels * 100 if expected_labels else None,
        "metric_definition": "label-level case accuracy over all six judgments per program",
        "exact_six_correct_pack_count": exact_six,
        "exact_six_pack_accuracy": (
            exact_six / expected_available_count if expected_available_count else None
        ),
        "exact_six_pack_accuracy_percent": (
            exact_six / expected_available_count * 100 if expected_available_count else None
        ),
        "valid_parse_count": valid,
        "valid_parse_rate": valid / expected_available_count if expected_available_count else None,
        "valid_parse_rate_percent": (
            valid / expected_available_count * 100 if expected_available_count else None
        ),
        "parse_status_counts": parse_counts,
        "true_label_count": len(true_rows),
        "true_correct_count": true_correct,
        "true_accuracy": true_correct / len(true_rows) if true_rows else None,
        "false_label_count": len(false_rows),
        "false_correct_count": false_correct,
        "false_accuracy": false_correct / len(false_rows) if false_rows else None,
        "balanced_accuracy": (
            ((true_correct / len(true_rows)) + (false_correct / len(false_rows))) / 2
            if true_rows and false_rows
            else None
        ),
        "semantic_steering_record_count": sum(
            int(record["steering_semantics"]["enabled"]) for record in runs
        ),
    }


def build_aggregate(
    spec: AuditSpec,
    manifest: Mapping[str, Any],
    plan: Mapping[str, Any],
    preflight_summaries: Sequence[Mapping[str, Any]],
    shards: Sequence[Mapping[str, Any]],
    recovery: Mapping[str, Any],
    resume_amendment: Mapping[str, Any],
) -> dict[str, Any]:
    records = [record for shard in shards for record in shard["records"]]
    resource_skips = [skip for shard in shards for skip in shard.get("resource_skips", [])]
    expected_keys = {
        (program_id, 1, condition)
        for program_id in manifest["program_ids"]
        for condition in CONDITIONS
    }
    observed_keys = [
        (record["program_id"], record["round"], record["condition"]) for record in records
    ]
    skip_keys = [
        (skip["program_id"], skip["round"], skip["condition"])
        for skip in resource_skips
    ]
    expected_records = spec.expected_program_count * 3 - len(resource_skips)
    if any(
        (
            len(records) != expected_records,
            len(set(observed_keys)) != expected_records,
            len(set(skip_keys)) != len(resource_skips),
            bool(set(observed_keys) & set(skip_keys)),
            set(observed_keys) | set(skip_keys) != expected_keys,
            len(records) * 6 != expected_records * 6,
        )
    ):
        raise AuditError(
            "global outcome/registered-resource-skip set does not partition programs x 3 conditions"
        )
    for program_id in manifest["program_ids"]:
        selected = [row for row in records if row["program_id"] == program_id]
        skipped = [row for row in resource_skips if row["program_id"] == program_id]
        seeds = {row["paired_seed"] for row in [*selected, *skipped]}
        if seeds != {expected_seed(program_id)} or len(selected) + len(skipped) != 3:
            raise AuditError(f"paired seed/record count differs: {program_id}")
    available_by_condition = {
        condition: spec.expected_program_count
        - sum(skip["condition"] == condition for skip in resource_skips)
        for condition in CONDITIONS
    }
    summaries = {
        condition: condition_summary(
            records,
            condition,
            spec.expected_program_count,
            available_by_condition[condition],
        )
        for condition in CONDITIONS
    }
    if (
        summaries["obfuscated_codesteer"]["semantic_steering_record_count"]
        != available_by_condition["obfuscated_codesteer"]
    ):
        raise AuditError("not every steered record has semantic CodeSteer L2 evidence")
    if any(
        summaries[condition]["semantic_steering_record_count"] != 0
        for condition in ("original_plain", "obfuscated_plain")
    ):
        raise AuditError("a plain condition contains semantic steering evidence")
    clusters: dict[str, Any] = {}
    complete_program_ids: list[str] = []
    for program_id in manifest["program_ids"]:
        cluster: dict[str, Any] = {}
        selected: dict[str, Mapping[str, Any]] = {}
        missing_conditions: list[str] = []
        for condition in CONDITIONS:
            matches = [
                row
                for row in records
                if row["program_id"] == program_id and row["condition"] == condition
            ]
            skipped = [
                row
                for row in resource_skips
                if row["program_id"] == program_id and row["condition"] == condition
            ]
            if len(matches) + len(skipped) != 1:
                raise AuditError(f"paired cluster differs: {program_id}/{condition}")
            if skipped:
                skip = skipped[0]
                missing_conditions.append(condition)
                cluster[condition] = {
                    "availability": "resource_skip",
                    "disposition": skip["disposition"],
                    "evidence_kind": skip["evidence_kind"],
                    "model_outcome_observed": False,
                    "score_created": False,
                    "denominator_included": False,
                    "marker_sha256": skip["marker_sha256"],
                    "fingerprint": skip["fingerprint"],
                }
                continue
            record = matches[0]
            selected[condition] = record
            cluster[condition] = {
                "availability": "observed",
                "correct_label_count": record["correct_label_count"],
                "label_count": 6,
                "pass_at_1": record["correct_label_count"] / 6,
                "parse_status": record["parse_status"],
                "pack_valid": record["pack_valid"],
                "exact_six_correct": record["correct_label_count"] == 6,
                "generated_token_count": record["generated_tokens"]["generated_token_count"],
                "fingerprint": record["fingerprint"],
            }
        if not missing_conditions:
            complete_program_ids.append(program_id)
            original = selected["original_plain"]["correct_label_count"]
            obfuscated = selected["obfuscated_plain"]["correct_label_count"]
            steered = selected["obfuscated_codesteer"]["correct_label_count"]
            denominator = original - obfuscated
            cluster["paired_differences"] = {
                "complete_case": True,
                "obfuscation_delta_correct_labels": obfuscated - original,
                "steering_gain_correct_labels": steered - obfuscated,
                "restoration_denominator_correct_labels": denominator,
                "restoration_ratio": (steered - obfuscated) / denominator if denominator else None,
                "restoration_defined": denominator != 0,
                "restoration_interpretable_as_recovery": denominator > 0,
            }
        else:
            cluster["paired_differences"] = {
                "complete_case": False,
                "missing_conditions": missing_conditions,
                "excluded_from_paired_metrics": True,
                "exclusion_reason": "registered_physical_resource_limit",
                "restoration_ratio": None,
                "restoration_defined": False,
                "restoration_interpretable_as_recovery": False,
            }
        clusters[program_id] = cluster
    complete_records = [
        record for record in records if record["program_id"] in set(complete_program_ids)
    ]
    complete_count = len(complete_program_ids)
    complete_summaries = {
        condition: condition_summary(
            complete_records,
            condition,
            complete_count,
            complete_count,
        )
        for condition in CONDITIONS
    }
    original_correct = complete_summaries["original_plain"]["correct_label_count"]
    obfuscated_correct = complete_summaries["obfuscated_plain"]["correct_label_count"]
    steered_correct = complete_summaries["obfuscated_codesteer"]["correct_label_count"]
    denominator = original_correct - obfuscated_correct
    numerator = steered_correct - obfuscated_correct
    ratio = numerator / denominator if denominator else None
    shard_public = [{key: value for key, value in shard.items() if key != "records"} for shard in shards]
    return {
        "schema_version": "expanded-java-300-600-independent-study-aggregate-v2",
        "audit_status": "passed",
        "artifact_terminal": True,
        "protocol_version": PROTOCOL_VERSION,
        "auditor_sha256": sha256_file(Path(__file__).resolve()),
        "runner_sha256": spec.expected_runner_sha256,
        "v2_runner_sha256": spec.expected_v2_sha256,
        "manifest_sha256": spec.expected_manifest_sha256,
        "plan_sha256": spec.expected_plan_sha256,
        "preflight_summary_sha256": list(spec.expected_preflight_sha256),
        "model_id": MODEL_NAME,
        "model_snapshot_commit": MODEL_COMMIT,
        "generation": GENERATION,
        "program_count": spec.expected_program_count,
        "condition_count": 3,
        "planned_generation_count": spec.expected_program_count * 3,
        "generation_record_count": len(records),
        "resource_skip_count": len(resource_skips),
        "labels_per_record": 6,
        "planned_labels_per_condition": spec.expected_program_count * 6,
        "labels_per_condition": {
            condition: summaries[condition]["label_count"] for condition in CONDITIONS
        },
        "labels_across_all_conditions": len(records) * 6,
        "conditions": summaries,
        "resource_skips": resource_skips,
        "paired_program_summaries": clusters,
        "complete_case_analysis": {
            "selection_rule": (
                "programs with one independently verified outcome in every one of the three "
                "conditions; registered physical-resource skips are excluded as whole clusters"
            ),
            "program_count": complete_count,
            "excluded_program_count": spec.expected_program_count - complete_count,
            "excluded_program_ids": [
                program_id
                for program_id in manifest["program_ids"]
                if program_id not in set(complete_program_ids)
            ],
            "labels_per_condition": complete_count * 6,
            "conditions": complete_summaries,
        },
        "steering_gain_over_obfuscated_percentage_points": (
            complete_summaries["obfuscated_codesteer"]["pass_at_1_percent"]
            - complete_summaries["obfuscated_plain"]["pass_at_1_percent"]
            if complete_count
            else None
        ),
        "restoration": {
            "formula": "(steered_obfuscated - obfuscated) / (original - obfuscated)",
            "analysis_set": "complete three-condition program clusters only",
            "complete_program_count": complete_count,
            "excluded_program_count": spec.expected_program_count - complete_count,
            "numerator_correct_labels": numerator,
            "denominator_correct_labels": denominator,
            "ratio": ratio,
            "ratio_percent": ratio * 100 if ratio is not None else None,
            "defined": ratio is not None,
            "interpretable_as_recovery": denominator > 0,
            "denominator_handling": (
                "undefined (null) when original and obfuscated have equal pooled correct-label counts; "
                "a nonpositive denominator is not interpreted as recovery"
            ),
        },
        "infrastructure_recovery": dict(recovery),
        "resource_skip_resume_amendment": dict(resume_amendment),
        "shards": shard_public,
        "provenance_gates": {
            "exact_planned_cell_partition_into_outcomes_or_registered_resource_skips": "passed",
            "resource_skips_never_scored_or_counted_as_failures": (
                "passed" if resource_skips else "not_applicable"
            ),
            "paired_metrics_use_complete_cases_only": "passed",
            "six_hidden_labels_per_record": "passed",
            "manifest_plan_preflight_bindings": "passed",
            "paired_seed_equality": "passed",
            "one_attempt_no_retry_tree": "passed",
            "pinned_qwen25_coder_7b_revision": "passed",
            "temperature_1_30_sampling": "passed",
            "plain_conditions_unsteered": "passed",
            "codesteer_l2_semantically_active": "passed",
            "independent_raw_completion_rescore": "passed",
            "fingerprint_and_artifact_integrity": "passed",
            "terminal_results_indexes": "passed",
            "registered_pre_outcome_infrastructure_recovery": (
                "passed" if recovery.get("count", 0) > 0 else "not_applicable"
            ),
            "ordered_recovery_chain_and_repeat_interruption_semantics": (
                "passed" if recovery.get("count", 0) > 0 else "not_applicable"
            ),
            "registered_resource_skip_resume_amendment": (
                "passed" if resume_amendment.get("registered") else "not_applicable"
            ),
        },
    }


def audit_study(spec: AuditSpec = PRODUCTION_SPEC) -> dict[str, Any]:
    validate_fixed_provenance(spec)
    manifest = validate_manifest(spec)
    plan = validate_plan(spec, manifest)
    preflight_summaries, preflight_by_program = validate_preflights(spec, plan, manifest)
    resume_amendment = validate_resource_skip_registration_tree(spec, plan)
    shards = [
        validate_shard(
            spec,
            shard,
            preflight_summaries[index],
            preflight_by_program,
            manifest,
        )
        for index, shard in enumerate(plan["shards"])
    ]
    recovery = validate_recovery_evidence(spec, plan, shards)
    return build_aggregate(
        spec,
        manifest,
        plan,
        preflight_summaries,
        shards,
        recovery,
        resume_amendment,
    )


def render_markdown(summary: Mapping[str, Any]) -> str:
    skip_count = int(summary.get("resource_skip_count", 0))
    complete_count = int(summary.get("complete_case_analysis", {}).get("program_count", 0))
    lines = [
        "# Qwen2.5-Coder-7B 152-program study",
        "",
        "Independent verification passed for the 152-program plan, with every planned cell "
        "partitioned into either one verified model outcome or one exact registered physical-"
        "resource skip. Every observed outcome contains six case labels.",
        "",
        "| Condition | Program N | Correct / labels | Label Pass@1 | Exact-six packs | Valid parses |",
        "|---|---:|---:|---:|---:|---:|",
    ]
    labels = {
        "original_plain": "Original",
        "obfuscated_plain": "Obfuscated",
        "obfuscated_codesteer": "Obfuscated + CodeSteer L2",
    }
    for condition in CONDITIONS:
        row = summary["conditions"][condition]
        pass_at_1 = (
            f"{row['pass_at_1_percent']:.6f}%"
            if row["pass_at_1_percent"] is not None
            else "N/A"
        )
        exact_six = (
            f"{row['exact_six_pack_accuracy_percent']:.6f}%"
            if row["exact_six_pack_accuracy_percent"] is not None
            else "N/A"
        )
        parse_rate = (
            f"{row['valid_parse_rate_percent']:.6f}%"
            if row["valid_parse_rate_percent"] is not None
            else "N/A"
        )
        lines.append(
            f"| {labels[condition]} | {row['available_program_count']} | "
            f"{row['correct_label_count']} / {row['label_count']} | "
            f"{pass_at_1} | "
            f"{row['exact_six_correct_pack_count']} / {row['program_prompt_count']} "
            f"({exact_six}) | "
            f"{row['valid_parse_count']} / {row['program_prompt_count']} "
            f"({parse_rate}) |"
        )
    restoration = summary["restoration"]
    recovery = summary["infrastructure_recovery"]
    lines.extend(
        [
            "",
            "Label Pass@1 is pooled case-level accuracy over the available, independently verified "
            "outcomes in that condition. A registered resource skip contributes neither a label "
            "nor an incorrect prediction. Exact-six accuracy requires all six labels in an observed "
            "program prompt to be correct.",
            "",
            (
                f"Steering gain over obfuscated on the {complete_count} complete program clusters: "
                f"{summary['steering_gain_over_obfuscated_percentage_points']:.6f} percentage points."
                if summary["steering_gain_over_obfuscated_percentage_points"] is not None
                else "Steering gain over obfuscated is undefined because there are no complete clusters."
            ),
            "",
        ]
    )
    if restoration["defined"]:
        lines.append(
            f"Restoration ratio: {restoration['numerator_correct_labels']} / "
            f"{restoration['denominator_correct_labels']} = {restoration['ratio_percent']:.6f}% "
            f"over {restoration['complete_program_count']} complete three-condition programs."
        )
    else:
        lines.append(
            "Restoration ratio: undefined because original and obfuscated have the same pooled "
            "correct-label count."
        )
    if skip_count:
        skip_descriptions = ", ".join(
            f"{row['program_id']}/{row['condition']} ({row['evidence_kind']}, "
            f"marker `{row['marker_sha256']}`)"
            for row in summary["resource_skips"]
        )
        lines.extend(
            [
                "",
                f"Physical-resource disclosure: {skip_count} planned cells were not executed or "
                "scored: " + skip_descriptions + ". The observed OOM occurred before any model "
                "outcome at the 11,025-token eager float32-attention prefill; the CodeSteer cell "
                "uses the identical multi-token prefill and was excluded under the same verified "
                "capacity limit. These cells are missing data, not failures. Condition-specific "
                "metrics retain all other available outcomes, while paired gain and restoration "
                f"use the {complete_count} complete program clusters only.",
            ]
        )
    if recovery["count"]:
        count = recovery["count"]
        repeated = recovery["reinterrupted_before_outcome_transition_count"]
        conditions = ", ".join(recovery["conditions"])
        hashes = ", ".join(
            f"`{row['recovery_audit_sha256']}`" for row in recovery["incidents"]
        )
        lines.extend(
            [
                "",
                f"Infrastructure disclosure: {count} ordered shard-0 process interruptions occurred "
                f"before any model-outcome artifact was recorded (conditions: {conditions}). Each "
                "setup-only attempt was preserved read-only with the identical program-condition, "
                "seed, prompt, source, config, and fingerprint. Each identity either completed in "
                "its canonical first-attempt path or ended in an exact registered resource skip. "
                "Every cumulative set of preexisting completed artifacts remained byte-identical. "
                f"{repeated} transition(s) were repeated setup-only interruptions with no completed "
                "model outcome between incidents. These were neither malformed-output retries nor "
                "new statistical trials, and no preserved setup-only attempt contributes to any "
                "reported denominator.",
                "",
                f"Recovery audit SHA-256 values, in order: {hashes}.",
            ]
        )
    lines.extend(
        [
            "",
            "The JSON artifact contains all 152 program summaries, condition-specific Ns, the "
            "complete-case analysis set, resource-skip evidence, shard fingerprints, preflight "
            "bindings, parse rates, and denominator metadata.",
            "",
            "Integrity gates: exact outcome-or-skip partition, one attempt/no retries, paired seeds, pinned model "
            "revision and sampling, plain-versus-CodeSteer treatment, independent rescoring, "
            "fingerprint binding, and terminal per-shard indexes all passed.",
            "",
        ]
    )
    return "\n".join(lines)


def write_immutable_package(output: Path, summary: Mapping[str, Any]) -> Path:
    output = output.resolve(strict=False)
    try:
        output.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise AuditError(f"aggregate output must remain below {HERE}: {output}") from exc
    if output.exists():
        raise AuditError(f"immutable aggregate output already exists; refusing overwrite: {output}")
    parent = output.parent
    parent.mkdir(parents=True, exist_ok=True)
    temporary = Path(tempfile.mkdtemp(prefix=f".{output.name}.tmp-", dir=parent))
    try:
        json_path = temporary / "aggregate_study.json"
        markdown_path = temporary / "aggregate_study.md"
        json_path.write_text(pretty_json(summary), encoding="utf-8")
        markdown_path.write_text(render_markdown(summary), encoding="utf-8")
        sums = (
            f"{sha256_file(json_path)}  {json_path.name}\n"
            f"{sha256_file(markdown_path)}  {markdown_path.name}\n"
        )
        (temporary / "SHA256SUMS").write_text(sums, encoding="utf-8")
        os.rename(temporary, output)
    except Exception:
        shutil.rmtree(temporary, ignore_errors=True)
        raise
    return output


def parse_args(argv: Optional[Sequence[str]] = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check-only", action="store_true", help="verify without writing aggregate files")
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    return parser.parse_args(argv)


def main(argv: Optional[Sequence[str]] = None) -> int:
    args = parse_args(argv)
    try:
        summary = audit_study()
        if args.check_only:
            print(pretty_json(summary), end="")
        else:
            output = write_immutable_package(args.output, summary)
            print(f"[aggregate-complete] {output}")
        return 0
    except AuditError as exc:
        print(f"[aggregate-refused] {exc}", file=sys.stderr)
        return 2


if __name__ == "__main__":
    raise SystemExit(main())
