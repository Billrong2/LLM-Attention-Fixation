#!/usr/bin/env python3
"""Prepare the frozen, control-only balanced Waves 4--5 extension.

This program reads only frozen source/manifests and the immutable CodeContests
parquet.  It never reads an inference result file, launches inference, or
creates an inference result root.  It reconstructs the deterministic ranking,
revalidates accepted ranks 1--10, and JDK-validates accepted ranks 11--19.
"""

from __future__ import annotations

import argparse
import copy
import json
import shutil
import sys
from collections import Counter
from pathlib import Path
from typing import Any, Mapping, Sequence

import pyarrow
import pyarrow.parquet as pq

import prepare_balanced_contingency as base
import prepare_balanced_extension_contingency as extension1
from prepare_long_code_variants import (
    atomic_write_json,
    atomic_write_text,
    sha256_file,
    sha256_text,
    validate_jdk17,
)
from prepare_supplemental_cases import (
    audit_jsonl,
    one_case_validation,
    validation_case,
    write_selected_case_files,
)


sys.dont_write_bytecode = True

WORK_ROOT = Path(__file__).resolve().parent
DEFAULT_CANDIDATE_MANIFEST = WORK_ROOT / "candidate_pool" / "candidate_manifest.json"
DEFAULT_PREPARED_MANIFEST = WORK_ROOT / "prepared_variants" / "eligible_variants.json"
DEFAULT_ELIGIBLE_MANIFEST = (
    WORK_ROOT / "tokenizer_preflight" / "inference_eligible_variants.json"
)
DEFAULT_SUPPLEMENTAL_MANIFEST = WORK_ROOT / "supplemental_cases" / "supplemental_manifest.json"
DEFAULT_WAVE_1_MANIFEST = (
    WORK_ROOT / "balanced_contingency" / "tokenizer_preflight" / "wave_1"
    / "inference_eligible_variants.json"
)
DEFAULT_WAVE_2_MANIFEST = (
    WORK_ROOT / "balanced_contingency" / "tokenizer_preflight" / "wave_2"
    / "inference_eligible_variants.json"
)
DEFAULT_WAVE_3_MANIFEST = (
    WORK_ROOT / "balanced_extension_contingency" / "tokenizer_preflight"
    / "inference_eligible_variants.json"
)
DEFAULT_DATASET = WORK_ROOT / "codecontests-valid-802411c3.parquet"
DEFAULT_PROTOCOL_MD = WORK_ROOT / "BALANCED_EXTENSION2_CONTINGENCY_PROTOCOL.md"
DEFAULT_PROTOCOL_JSON = WORK_ROOT / "balanced_extension2_contingency_protocol.json"
DEFAULT_OUTPUT_ROOT = WORK_ROOT / "balanced_extension2_contingency"
DEFAULT_FAILURE_ARCHIVE_ROOT = WORK_ROOT / "balanced_extension2_rank25_feasibility_failure"
DEFAULT_RANK20_FAILURE_ARCHIVE_ROOT = (
    WORK_ROOT / "balanced_extension2_rank20_feasibility_failure"
)
DEFAULT_JAVA_HOME = Path("/people/cs/x/xxr230000/jdks/jdk-17.0.11+9")

SCHEMA_VERSION = "long-code-balanced-extension2-contingency-v1"
EXPECTED_PROBLEMS = 19
EXPECTED_CASES_PER_PROBLEM = 5
EXPECTED_CASES_PER_WAVE = EXPECTED_PROBLEMS * EXPECTED_CASES_PER_PROBLEM
EXPECTED_CASES_PER_PROBLEM_BY_WAVE = {4: 5, 5: 4}
EXPECTED_CASES_BY_WAVE = {4: 95, 5: 76}
EXPECTED_TOTAL_CASES = sum(EXPECTED_CASES_BY_WAVE.values())
EXPECTED_PRIOR_ACCEPTED_PER_PROBLEM = 10
FINAL_ACCEPTED_RANK = 19
WAVE_SPECS: dict[int, dict[str, Any]] = {
    4: {
        "wave_id": "balanced_wave_4",
        "accepted_ranks": tuple(range(11, 16)),
        "trigger_after_wave": 3,
    },
    5: {
        "wave_id": "balanced_wave_5",
        "accepted_ranks": tuple(range(16, 20)),
        "trigger_after_wave": 4,
    },
}
WAVE_IDS = tuple(spec["wave_id"] for spec in WAVE_SPECS.values())

TIMING_DISCLOSURE = (
    "Specified and prospectively revised twice during live Wave 3, after the completed valid "
    "post-Wave-2 audit reported four distinct strict canonical CodeContests problems. The "
    "initial 19-by-5 Wave-6 proposal failed closed because an exhaustive frozen-rule "
    "static/JDK scan found canonical row 27 has 202 statically eligible candidates but only "
    "24 JDK-valid accepted ranks in total. The first revision also failed closed because row "
    "54 has 255 statically eligible candidates but only 19 JDK-valid accepted ranks, blocking "
    "rank 20 and every Wave-6 rank. No Wave-3 model output, result, score, completion, "
    "reasoning trace, or result file was inspected or used to specify or revise this contingency."
)
ADAPTIVE_STATUS_DISCLOSURE = (
    "This second extension is adaptive and outcome-aware from the Wave-2 aggregate result, "
    "is not preregistered, and is not outcome-blind in timing. Its case eligibility, "
    "deterministic rank key, accepted-rank continuation, and feasibility-driven prospective "
    "revisions are outcome-independent. The final design is the largest uniform two-wave "
    "continuation across the same 19 problems: Wave 4 ranks 11--15 and Wave 5 ranks 16--19; "
    "there is no Wave 6."
)
PREPARATION_READ_DISCLOSURE = (
    "Preparation, tokenizer gating, revision, and freezing read no inference result directory "
    "or file, perform no language-model inference, and create no inference result root. The "
    "completed post-Wave-2 count of four is an externally supplied trigger and timing fact "
    "only; no Wave-3 output or result was inspected. Both preserved failures are static/JDK "
    "feasibility evidence only."
)
FEASIBILITY_REVISION_DISCLOSURE = (
    "The original Wave-6 ranks 21--25 proposal failed closed at row 27 (202 eligible, 24 "
    "accepted). The first revision to Wave 6 ranks 21--24 then failed closed at row 54 (255 "
    "eligible, 19 accepted), which also blocks Wave-5 rank 20. Before inspecting any Wave-3 "
    "output or result, the final design was prospectively revised to Wave 4 ranks 11--15 and "
    "Wave 5 ranks 16--19 only, the largest uniform two-wave continuation for all 19 problems."
)
DENOMINATOR_DISCLOSURE = (
    "The source denominator remains 25 frozen source/obfuscation variants; the same 23 "
    "tokenizer-eligible sources spanning 19 canonical problems are reused. Waves 4--5 add "
    "only repeated concrete inputs."
)


def require_output_root(path: Path) -> Path:
    """Constrain generated artifacts to a new directory beneath this work root."""
    resolved = path.expanduser().resolve()
    try:
        resolved.relative_to(WORK_ROOT)
    except ValueError as exc:
        raise ValueError(f"Output must remain under {WORK_ROOT}: {resolved}") from exc
    protected = {
        WORK_ROOT.resolve(),
        (WORK_ROOT / "candidate_pool").resolve(),
        (WORK_ROOT / "prepared_variants").resolve(),
        (WORK_ROOT / "supplemental_cases").resolve(),
        (WORK_ROOT / "tokenizer_preflight").resolve(),
        (WORK_ROOT / "balanced_contingency").resolve(),
        (WORK_ROOT / "balanced_extension_contingency").resolve(),
        DEFAULT_FAILURE_ARCHIVE_ROOT.resolve(),
        DEFAULT_RANK20_FAILURE_ARCHIVE_ROOT.resolve(),
    }
    if resolved in protected or "inference" in resolved.name:
        raise ValueError(f"Refusing protected/non-control output root: {resolved}")
    return resolved


def _evidence_inventory(root: Path) -> list[dict[str, Any]]:
    rows: list[dict[str, Any]] = []
    for path in sorted(root.rglob("*")):
        if path.is_symlink():
            raise ValueError(f"Failure evidence contains a symlink: {path}")
        if not path.is_file():
            continue
        rows.append(
            {
                "path": str(path.relative_to(root)),
                "bytes": path.stat().st_size,
                "sha256": sha256_file(path),
            }
        )
    return rows


def _inventory_sha256(rows: Sequence[Mapping[str, Any]]) -> str:
    canonical = json.dumps(
        list(rows), sort_keys=True, ensure_ascii=False, separators=(",", ":")
    )
    return sha256_text(canonical)


def preserve_rank25_failure(
    *, output_root: Path, archive_root: Path, resume_after_failure: bool, overwrite: bool
) -> dict[str, Any]:
    """Preserve and bind the first exhaustive rank-25 failure before revision."""
    archive_root = archive_root.expanduser().resolve()
    if archive_root != DEFAULT_FAILURE_ARCHIVE_ROOT.resolve():
        raise ValueError(
            f"Failure archive root must be exactly {DEFAULT_FAILURE_ARCHIVE_ROOT.resolve()}"
        )
    if resume_after_failure:
        if archive_root.exists():
            raise FileExistsError(
                f"Failure archive already exists; do not repeat initial preservation: {archive_root}"
            )
        if not output_root.is_dir():
            raise FileNotFoundError(f"Partial rank-25 failure root is missing: {output_root}")
        forbidden = {
            "freeze_manifest.json",
            "FREEZE.sha256",
            "final_summary.json",
            "launch_plan_wave_4.json",
            "launch_plan_wave_5.json",
            "launch_plan_wave_6.json",
        }
        if any((output_root / name).exists() for name in forbidden):
            raise RuntimeError("Partial rank-25 failure root contains a freeze/launch artifact")
        output_root.rename(archive_root)
    elif not archive_root.is_dir():
        raise FileNotFoundError(
            "The preserved rank-25 feasibility archive is required; use "
            "--resume-after-rank25-failure exactly once for the original partial root"
        )
    elif output_root.exists():
        if not overwrite:
            raise FileExistsError(f"Output exists; pass --overwrite: {output_root}")
        shutil.rmtree(output_root)

    row27 = (
        archive_root
        / "validation"
        / "cc-valid-r027-s0184-1553-d-backspace__t5_easy_seed1"
    )
    validation_files = sorted(row27.glob("*.json"))
    if len(validation_files) != 202:
        raise RuntimeError(
            f"Rank-25 failure evidence has {len(validation_files)} row-27 validations, expected 202"
        )
    accepted_count = 0
    for path in validation_files:
        payload = base.read_json(path)
        if not isinstance(payload, Mapping) or not isinstance(payload.get("accepted"), bool):
            raise ValueError(f"Malformed rank-25 validation evidence: {path}")
        accepted_count += int(payload["accepted"])
    if accepted_count != 24:
        raise RuntimeError(
            f"Rank-25 failure evidence has {accepted_count} accepted row-27 cases, expected 24"
        )
    for required_dir in ("validation", "tests"):
        if not (archive_root / required_dir).is_dir():
            raise FileNotFoundError(f"Failure archive lacks {required_dir}/ evidence")

    output_root.mkdir(parents=True)
    evidence_root = output_root / "rank25_feasibility_failure"
    evidence_root.mkdir()
    for required_dir in ("validation", "tests"):
        shutil.copytree(archive_root / required_dir, evidence_root / required_dir)
    evidence_files = _evidence_inventory(evidence_root)
    if len(evidence_files) != 641:
        raise RuntimeError(
            f"Preserved failure evidence has {len(evidence_files)} files, expected 641"
        )
    audit = {
        "schema_version": "long-code-balanced-extension2-rank25-feasibility-failure-v1",
        "original_proposal": {
            "wave_6_accepted_ranks_per_problem": [21, 22, 23, 24, 25],
            "cases_per_problem": 5,
            "case_count": 95,
        },
        "failure": {
            "row_index": 27,
            "variant_id": "cc-valid-r027-s0184-1553-d-backspace__t5_easy_seed1",
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
        },
        "prospective_revision": {
            "wave_6_accepted_ranks_per_problem": [21, 22, 23, 24],
            "cases_per_problem": 4,
            "case_count": 76,
            "largest_uniform_block_across_same_19_problems": True,
            "specified_before_any_wave_3_output_or_result_inspection": True,
        },
        "evidence_root": "rank25_feasibility_failure",
        "external_preserved_archive": str(archive_root.relative_to(WORK_ROOT)),
        "evidence_file_count": len(evidence_files),
        "evidence_inventory_sha256": _inventory_sha256(evidence_files),
        "evidence_files": evidence_files,
        "model_result_files_read": 0,
        "wave_3_result_files_read": 0,
        "model_inference_calls": 0,
    }
    atomic_write_json(output_root / "rank25_feasibility_failure_audit.json", audit)
    return audit


def stage_rank20_failure_archive(
    *,
    output_root: Path,
    archive_root: Path,
    resume_after_failure: bool,
    overwrite: bool,
) -> Path:
    """Preserve the complete second partial attempt before the final redesign."""
    archive_root = archive_root.expanduser().resolve()
    if archive_root != DEFAULT_RANK20_FAILURE_ARCHIVE_ROOT.resolve():
        raise ValueError(
            f"Rank-20 failure archive must be exactly {DEFAULT_RANK20_FAILURE_ARCHIVE_ROOT.resolve()}"
        )
    if resume_after_failure:
        if archive_root.exists():
            raise FileExistsError(
                f"Rank-20 failure archive already exists; do not repeat preservation: {archive_root}"
            )
        if not output_root.is_dir():
            raise FileNotFoundError(f"Partial rank-20 failure root is missing: {output_root}")
        forbidden = {
            "freeze_manifest.json",
            "FREEZE.sha256",
            "final_summary.json",
            "launch_plan_wave_4.json",
            "launch_plan_wave_5.json",
            "launch_plan_wave_6.json",
            "wave_4_manifest_pre_tokenizer.json",
            "wave_5_manifest_pre_tokenizer.json",
            "wave_6_manifest_pre_tokenizer.json",
        }
        if any((output_root / name).exists() for name in forbidden):
            raise RuntimeError("Partial rank-20 failure root contains a manifest/freeze/launch artifact")
        output_root.rename(archive_root)
    elif not archive_root.is_dir():
        raise FileNotFoundError(
            "The preserved rank-20 feasibility archive is required; use "
            "--resume-after-rank20-failure exactly once for the second partial root"
        )
    elif output_root.exists():
        if not overwrite:
            raise FileExistsError(f"Output exists; pass --overwrite: {output_root}")
        shutil.rmtree(output_root)

    row54 = (
        archive_root
        / "validation"
        / "cc-valid-r054-s0229-1557-c-moamen-and-xor__t5_easy_seed1"
    )
    validation_files = sorted(row54.glob("*.json"))
    if len(validation_files) != 255:
        raise RuntimeError(
            f"Rank-20 failure archive has {len(validation_files)} row-54 validations, expected 255"
        )
    accepted_count = 0
    for path in validation_files:
        payload = base.read_json(path)
        if not isinstance(payload, Mapping) or not isinstance(payload.get("accepted"), bool):
            raise ValueError(f"Malformed rank-20 validation evidence: {path}")
        accepted_count += int(payload["accepted"])
    if accepted_count != 19:
        raise RuntimeError(
            f"Rank-20 failure archive has {accepted_count} accepted row-54 cases, expected 19"
        )
    for required_dir in ("validation", "tests"):
        if not (archive_root / required_dir).is_dir():
            raise FileNotFoundError(f"Rank-20 failure archive lacks {required_dir}/ evidence")
    return archive_root


def copy_rank20_failure_evidence(*, archive_root: Path, output_root: Path) -> dict[str, Any]:
    evidence_root = output_root / "rank20_feasibility_failure"
    evidence_root.mkdir()
    for required_dir in ("validation", "tests"):
        shutil.copytree(archive_root / required_dir, evidence_root / required_dir)
    evidence_files = _evidence_inventory(evidence_root)
    if len(evidence_files) != 1071:
        raise RuntimeError(
            f"Preserved rank-20 evidence has {len(evidence_files)} files, expected 1071"
        )
    audit = {
        "schema_version": "long-code-balanced-extension2-rank20-feasibility-failure-v1",
        "failed_design": {
            "wave_4_accepted_ranks_per_problem": [11, 12, 13, 14, 15],
            "wave_5_accepted_ranks_per_problem": [16, 17, 18, 19, 20],
            "wave_6_accepted_ranks_per_problem": [21, 22, 23, 24],
            "case_count_by_wave": {
                "balanced_wave_4": 95,
                "balanced_wave_5": 95,
                "balanced_wave_6": 76,
            },
        },
        "failure": {
            "row_index": 54,
            "variant_id": "cc-valid-r054-s0229-1557-c-moamen-and-xor__t5_easy_seed1",
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
        },
        "prospective_final_design": {
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
        },
        "evidence_root": "rank20_feasibility_failure",
        "external_preserved_archive": str(archive_root.relative_to(WORK_ROOT)),
        "evidence_file_count": len(evidence_files),
        "evidence_inventory_sha256": _inventory_sha256(evidence_files),
        "evidence_files": evidence_files,
        "model_result_files_read": 0,
        "wave_3_result_files_read": 0,
        "model_inference_calls": 0,
    }
    atomic_write_json(output_root / "rank20_feasibility_failure_audit.json", audit)
    return audit


def _case_rows(
    payload: Mapping[str, Any], label: str
) -> list[tuple[Mapping[str, Any], Mapping[str, Any]]]:
    rows: list[tuple[Mapping[str, Any], Mapping[str, Any]]] = []
    for variant in base.variant_rows(payload, label):
        cases = variant.get("cases")
        if not isinstance(cases, list):
            raise ValueError(f"{label}/{base.variant_id(variant)} lacks cases")
        for case in cases:
            if not isinstance(case, Mapping):
                raise ValueError(f"Malformed case in {label}/{base.variant_id(variant)}")
            rows.append((variant, case))
    return rows


def _canonical_case_key(
    variant: Mapping[str, Any], case: Mapping[str, Any]
) -> tuple[int, str, int]:
    provenance = base.provenance_for_variant(variant)
    row_index = base.validate_dataset_provenance(
        provenance, label=f"prior/{base.variant_id(variant)}"
    )
    metadata = case.get("source_case_metadata")
    if not isinstance(metadata, Mapping):
        raise ValueError(f"Prior case lacks source_case_metadata: {base.variant_id(variant)}")
    key = (
        metadata.get("row_index", row_index),
        metadata.get("suite"),
        metadata.get("dataset_test_index"),
    )
    if key[0] != row_index or key[1] not in base.SUITES or not isinstance(key[2], int):
        raise ValueError(f"Malformed prior canonical case key: {key}")
    if list(key) != case.get("canonical_case_key"):
        raise ValueError(f"Prior canonical case key disagreement: {key}")
    return int(key[0]), str(key[1]), int(key[2])


def validate_prior_balanced_waves(
    wave_1_payload: Mapping[str, Any],
    wave_2_payload: Mapping[str, Any],
    wave_3_payload: Mapping[str, Any],
) -> tuple[dict[int, dict[int, tuple[int, str, int]]], set[tuple[int, str, int]], set[str]]:
    """Validate frozen ranks 1--10 and return their exact keys by row/rank."""
    accepted, keys, source_ids = extension1.validate_prior_balanced_waves(
        wave_1_payload, wave_2_payload
    )
    if (
        wave_3_payload.get("schema_version") != extension1.SCHEMA_VERSION
        or wave_3_payload.get("wave_id") != extension1.WAVE_ID
        or wave_3_payload.get("state") != "exact_tokenizer_gate_passed"
    ):
        raise ValueError("Frozen Wave-3 manifest schema/state/wave mismatch")
    rows = _case_rows(wave_3_payload, "balanced_wave_3")
    if len(rows) != extension1.EXPECTED_CASES:
        raise ValueError("Frozen Wave-3 case count is not 114")
    wave_3_source_ids = {
        base.variant_id(row) for row in base.variant_rows(wave_3_payload, "balanced_wave_3")
    }
    if wave_3_source_ids != source_ids:
        raise ValueError("Frozen Wave 3 does not use the same 19 sources as Waves 1 and 2")
    rank_counts: Counter[int] = Counter()
    row_counts: Counter[int] = Counter()
    for variant, case in rows:
        key = _canonical_case_key(variant, case)
        rank = case.get("accepted_rank")
        metadata = case.get("source_case_metadata") or {}
        if rank not in range(5, 11) or metadata.get("wave_id") != extension1.WAVE_ID:
            raise ValueError(f"Frozen Wave-3 rank/wave metadata mismatch: {key}")
        row_index = key[0]
        if int(rank) in accepted.setdefault(row_index, {}):
            raise ValueError(f"Duplicate frozen accepted rank {rank} in row {row_index}")
        if key in keys:
            raise ValueError(f"Frozen Waves 1--3 overlap: {key}")
        accepted[row_index][int(rank)] = key
        keys.add(key)
        rank_counts[int(rank)] += 1
        row_counts[row_index] += 1
    if rank_counts != Counter({rank: EXPECTED_PROBLEMS for rank in range(5, 11)}):
        raise ValueError("Frozen Wave-3 rank counts are not exact")
    if len(row_counts) != EXPECTED_PROBLEMS or set(row_counts.values()) != {6}:
        raise ValueError("Frozen Wave 3 is not 19 by 6")
    if any(set(ranks) != set(range(1, 11)) for ranks in accepted.values()):
        raise ValueError("Frozen accepted ranks 1--10 are incomplete")
    return accepted, keys, source_ids


def _wave_number_for_rank(rank: int) -> int:
    for wave_number, spec in WAVE_SPECS.items():
        if rank in spec["accepted_ranks"]:
            return wave_number
    raise ValueError(f"Accepted rank is outside final Waves 4--5: {rank}")


def render_variant(
    *,
    frozen_variant: Mapping[str, Any],
    selected_cases: Sequence[Mapping[str, Any]],
    wave_number: int,
    output_root: Path,
    prepared_manifest: Path,
) -> dict[str, Any]:
    spec = WAVE_SPECS[wave_number]
    wave_id = str(spec["wave_id"])
    expected_ranks = set(spec["accepted_ranks"])
    rendered = copy.deepcopy(dict(frozen_variant))
    for key in base.PARENT_CASE_ALIASES:
        rendered.pop(key, None)
    original_path = base.resolve_manifest_path(
        frozen_variant.get("original_path"), prepared_manifest, "frozen original source"
    )
    obfuscated_path = base.resolve_manifest_path(
        frozen_variant.get("obfuscated_path"), prepared_manifest, "frozen obfuscated source"
    )
    rendered["original_path"] = base.relative_path(original_path, output_root)
    rendered["obfuscated_path"] = base.relative_path(obfuscated_path, output_root)
    if isinstance(rendered.get("original"), dict):
        rendered["original"]["path"] = rendered["original_path"]
    if isinstance(rendered.get("obfuscated"), dict):
        rendered["obfuscated"]["path"] = rendered["obfuscated_path"]
    cases: list[dict[str, Any]] = []
    for selected in selected_cases:
        if selected["wave_id"] != wave_id:
            continue
        case = {
            key: selected[key]
            for key in (
                "case_id", "canonical_case_key", "accepted_rank", "rank_key", "input_bytes",
                "expected_output_bytes", "expected_output_lines", "input_sha256",
                "raw_expected_stdout_sha256", "raw_original_stdout_sha256",
                "raw_original_stderr_sha256", "raw_obfuscated_stdout_sha256",
                "raw_obfuscated_stderr_sha256", "validation_path", "original_stdout_path",
                "original_stderr_path", "obfuscated_stdout_path", "obfuscated_stderr_path",
            )
        }
        case.update(
            {
                "stdin_path": selected["stdin_path"],
                "expected_output_path": selected["oracle_stdout_path"],
                "argv": [],
                "suite": selected["suite"],
                "dataset_test_index": selected["dataset_test_index"],
                "original_trimmed_exact_to_oracle": True,
                "obfuscated_trimmed_exact_to_oracle": True,
                "original_obfuscated_trimmed_agreement": True,
                "source_case_metadata": {
                    "dataset_id": base.DATASET_ID,
                    "dataset_revision": base.DATASET_REVISION,
                    "split": base.DATASET_SPLIT,
                    "row_index": selected["row_index"],
                    "suite": selected["suite"],
                    "dataset_test_index": selected["dataset_test_index"],
                    "selection_stage": (
                        "balanced_extension2_adaptive_outcome_independent_ranking"
                    ),
                    "wave_id": wave_id,
                },
            }
        )
        cases.append(case)
    expected_case_count = EXPECTED_CASES_PER_PROBLEM_BY_WAVE[wave_number]
    if len(cases) != expected_case_count:
        raise ValueError(
            f"{base.variant_id(frozen_variant)}/{wave_id} has {len(cases)} cases, "
            f"expected {expected_case_count}"
        )
    if {int(case["accepted_rank"]) for case in cases} != expected_ranks:
        raise ValueError(f"{base.variant_id(frozen_variant)}/{wave_id} ranks are not exact")
    rendered["cases"] = cases
    rendered["balanced_extension2_contingency_selection"] = {
        "schema_version": SCHEMA_VERSION,
        "protocol": "../BALANCED_EXTENSION2_CONTINGENCY_PROTOCOL.md",
        "wave_id": wave_id,
        "canonical_problem_identity": base.canonical_identity(
            int(cases[0]["source_case_metadata"]["row_index"])
        ),
        "selected_source_rule": (
            "same first tokenizer-eligible source used by frozen balanced Waves 1--3"
        ),
        "source_denominator_unchanged": True,
        "continued_accepted_ranks": list(spec["accepted_ranks"]),
    }
    return rendered


def manifest_payload(wave_number: int, variants: Sequence[Mapping[str, Any]]) -> dict[str, Any]:
    spec = WAVE_SPECS[wave_number]
    prior_wave = int(spec["trigger_after_wave"])
    return {
        "schema_version": SCHEMA_VERSION,
        "protocol_date": "2026-07-13",
        "purpose": f"pre-tokenizer runner manifest for conditional balanced Wave {wave_number}",
        "state": "model-free JDK validated; exact tokenizer gate pending",
        "timing_disclosure": TIMING_DISCLOSURE,
        "adaptive_status_disclosure": ADAPTIVE_STATUS_DISCLOSURE,
        "preparation_read_disclosure": PREPARATION_READ_DISCLOSURE,
        "feasibility_revision_disclosure": FEASIBILITY_REVISION_DISCLOSURE,
        "denominator_disclosure": DENOMINATOR_DISCLOSURE,
        "wave_id": spec["wave_id"],
        "conditional_trigger": (
            f"run only after a complete valid post-Wave-{prior_wave} audit has fewer than "
            "ten strict canonical problems; stop this and all later waves if threshold reached"
        ),
        "frozen_source_denominator": 25,
        "tokenizer_eligible_source_denominator": 23,
        "canonical_problem_count": EXPECTED_PROBLEMS,
        "cases_per_problem": EXPECTED_CASES_PER_PROBLEM_BY_WAVE[wave_number],
        "accepted_ranks_per_problem": list(spec["accepted_ranks"]),
        "variant_count": len(variants),
        "case_count": sum(len(row.get("cases", [])) for row in variants),
        "selection_unit": "canonical dataset row + suite + dataset test index",
        "variants": list(variants),
    }


def verify_loaded_manifest(
    manifest_path: Path,
    expected_by_sample: Mapping[str, Mapping[str, Any]],
    *,
    wave_number: int,
) -> dict[str, Any]:
    """Verify the runner expands exactly the intended child records and bytes."""
    import run_long_code_experiment as runner

    samples, _ = runner.load_manifest(manifest_path)
    if (
        len(samples) != EXPECTED_CASES_BY_WAVE[wave_number]
        or {sample.sample_id for sample in samples} != set(expected_by_sample)
    ):
        raise ValueError(f"Runner-expanded IDs/count differ for {manifest_path.name}")
    checks: list[dict[str, Any]] = []
    for sample in samples:
        expected = expected_by_sample[sample.sample_id]
        row = {
            "sample_id": sample.sample_id,
            "stdin_sha256_loaded": sha256_text(sample.stdin),
            "stdin_sha256_expected": expected["input_sha256"],
            "oracle_sha256_loaded": sha256_text(sample.expected_stdout or ""),
            "oracle_sha256_expected": expected["raw_expected_stdout_sha256"],
            "original_sha256_loaded": sha256_file(sample.original_path),
            "original_sha256_expected": expected["original_sha256"],
            "obfuscated_sha256_loaded": sha256_file(sample.obfuscated_path),
            "obfuscated_sha256_expected": expected["obfuscated_sha256"],
        }
        row["all_match"] = all(
            row[left] == row[right]
            for left, right in (
                ("stdin_sha256_loaded", "stdin_sha256_expected"),
                ("oracle_sha256_loaded", "oracle_sha256_expected"),
                ("original_sha256_loaded", "original_sha256_expected"),
                ("obfuscated_sha256_loaded", "obfuscated_sha256_expected"),
            )
        )
        checks.append(row)
    if not all(row["all_match"] for row in checks):
        raise RuntimeError(f"Runner-loaded child hash mismatch for {manifest_path.name}")
    return {
        "schema_version": SCHEMA_VERSION,
        "manifest": str(manifest_path.relative_to(WORK_ROOT)),
        "manifest_sha256": sha256_file(manifest_path),
        "expanded_case_count": len(samples),
        "parent_shadow_regression_checked": True,
        "all_loaded_hashes_match": True,
        "checks": checks,
    }


def prepare(args: argparse.Namespace) -> int:
    candidate_manifest = base.require_file(args.candidate_manifest, "candidate manifest")
    prepared_manifest = base.require_file(args.prepared_manifest, "prepared variant manifest")
    eligible_manifest = base.require_file(args.eligible_manifest, "tokenizer-eligible manifest")
    supplemental_manifest = base.require_file(args.supplemental_manifest, "supplemental manifest")
    wave_1_manifest = base.require_file(args.wave_1_manifest, "frozen Wave-1 manifest")
    wave_2_manifest = base.require_file(args.wave_2_manifest, "frozen Wave-2 manifest")
    wave_3_manifest = base.require_file(args.wave_3_manifest, "frozen Wave-3 manifest")
    dataset_path = base.require_file(args.dataset, "CodeContests parquet")
    protocol_md = base.require_file(args.protocol_md, "second extension protocol markdown")
    protocol_json = base.require_file(args.protocol_json, "second extension protocol JSON")
    output_root = require_output_root(args.output_root)
    rank20_archive = stage_rank20_failure_archive(
        output_root=output_root,
        archive_root=args.rank20_failure_archive_root,
        resume_after_failure=args.resume_after_rank20_failure,
        overwrite=args.overwrite,
    )
    rank25_failure_audit = preserve_rank25_failure(
        output_root=output_root,
        archive_root=args.failure_archive_root,
        resume_after_failure=False,
        overwrite=False,
    )
    rank20_failure_audit = copy_rank20_failure_evidence(
        archive_root=rank20_archive, output_root=output_root
    )
    scratch_root = output_root / "_scratch"

    input_paths = {
        "candidate_manifest": candidate_manifest,
        "prepared_manifest": prepared_manifest,
        "eligible_manifest": eligible_manifest,
        "supplemental_manifest": supplemental_manifest,
        "wave_1_manifest": wave_1_manifest,
        "wave_2_manifest": wave_2_manifest,
        "wave_3_manifest": wave_3_manifest,
        "dataset": dataset_path,
        "protocol_md": protocol_md,
        "protocol_json": protocol_json,
        "preparer": Path(__file__).resolve(),
    }
    input_hashes_before = {key: sha256_file(path) for key, path in input_paths.items()}
    if input_hashes_before["dataset"] != base.DATASET_SHA256:
        raise ValueError("Immutable CodeContests parquet hash mismatch")

    candidate_payload = base.read_json(candidate_manifest)
    prepared_payload = base.read_json(prepared_manifest)
    eligible_payload = base.read_json(eligible_manifest)
    supplemental_payload = base.read_json(supplemental_manifest)
    wave_1_payload = base.read_json(wave_1_manifest)
    wave_2_payload = base.read_json(wave_2_manifest)
    wave_3_payload = base.read_json(wave_3_manifest)
    protocol_payload = base.read_json(protocol_json)
    expected_status = {
        "adaptive": True,
        "outcome_aware_from_wave_2": True,
        "preregistered": False,
        "outcome_blind_in_timing": False,
        "specified_during_live_wave_3": True,
        "prospectively_revised_during_live_wave_3": True,
        "prospective_revision_count": 2,
        "wave_3_outputs_or_results_inspected": False,
        "case_eligibility_ranking_selection_outcome_independent": True,
        "revision_uses_model_outcomes": False,
    }
    if protocol_payload.get("schema_version") != SCHEMA_VERSION:
        raise ValueError("Second extension protocol schema mismatch")
    if protocol_payload.get("status") != expected_status:
        raise ValueError("Second extension protocol adaptive-status flags mismatch")

    candidate_list = base.candidate_rows(candidate_payload)
    prepared_list = base.variant_rows(prepared_payload, "prepared manifest")
    eligible_list = base.variant_rows(eligible_payload, "tokenizer-eligible manifest")
    if len(candidate_list) != 25 or len(prepared_list) != 25:
        raise ValueError("Frozen source denominator is not 25")
    eligible_ids = {base.variant_id(row) for row in eligible_list}
    if len(eligible_ids) != 23:
        raise ValueError("Frozen tokenizer-eligible source denominator is not 23")
    candidate_map = {str(row.get("id")): row for row in candidate_list}
    if len(candidate_map) != 25:
        raise ValueError("Candidate IDs are missing or duplicated")

    initial_keys, initial_records = base.collect_screened_keys(
        eligible_payload, label="initial_tokenizer_eligible_manifest", expected_case_count=23
    )
    supplemental_keys, supplemental_records = base.collect_screened_keys(
        supplemental_payload, label="supplemental_manifest", expected_case_count=60
    )
    accepted_prior, balanced_keys, balanced_source_ids = validate_prior_balanced_waves(
        wave_1_payload, wave_2_payload, wave_3_payload
    )
    wave_1_keys, wave_1_records = base.collect_screened_keys(
        wave_1_payload, label="balanced_wave_1_manifest", expected_case_count=38
    )
    wave_2_keys, wave_2_records = base.collect_screened_keys(
        wave_2_payload, label="balanced_wave_2_manifest", expected_case_count=38
    )
    wave_3_keys, wave_3_records = base.collect_screened_keys(
        wave_3_payload, label="balanced_wave_3_manifest", expected_case_count=114
    )
    if balanced_keys != wave_1_keys | wave_2_keys | wave_3_keys:
        raise ValueError("Frozen balanced key reconstruction disagrees across Waves 1--3")
    prior_static_keys = initial_keys | supplemental_keys
    all_previous_keys = prior_static_keys | balanced_keys

    chosen_sources = base.choose_sources(prepared_list, eligible_ids)
    chosen_source_ids = {base.variant_id(row) for row in chosen_sources}
    if chosen_source_ids != balanced_source_ids:
        raise ValueError("Second extension source choice differs from frozen Waves 1--3")

    # Public tests and every inference-result location are intentionally absent.
    columns = ["private_tests", "generated_tests", "solutions"]
    dataset_rows = pq.read_table(dataset_path, columns=columns).to_pylist()
    javac, java, jdk = validate_jdk17(args.java_home, scratch_root)
    all_audits: list[dict[str, Any]] = []
    problem_entries: list[dict[str, Any]] = []
    frozen_sources: list[dict[str, Any]] = []
    executed_total = 0
    validation_rejection_total = 0

    for source_order, frozen_variant in enumerate(chosen_sources):
        identity = base.variant_id(frozen_variant)
        provenance = base.provenance_for_variant(frozen_variant)
        row_index = base.validate_dataset_provenance(provenance, label=f"chosen/{identity}")
        candidate_id = str(frozen_variant.get("candidate_id"))
        candidate = candidate_map.get(candidate_id)
        if candidate is None:
            raise ValueError(f"Unknown candidate {candidate_id}")
        candidate_provenance = candidate.get("provenance")
        if not isinstance(candidate_provenance, Mapping):
            raise ValueError(f"Candidate lacks provenance: {candidate_id}")
        if base.validate_dataset_provenance(candidate_provenance, label=candidate_id) != row_index:
            raise ValueError(f"Candidate/variant row mismatch: {candidate_id}")
        solution_index = candidate_provenance.get("solution_index")
        if not isinstance(solution_index, int):
            raise ValueError(f"Invalid solution index: {candidate_id}")

        original_path = base.resolve_manifest_path(
            frozen_variant.get("original_path"), prepared_manifest, "original source"
        )
        obfuscated_path = base.resolve_manifest_path(
            frozen_variant.get("obfuscated_path"), prepared_manifest, "obfuscated source"
        )
        original_source = original_path.read_text(encoding="utf-8")
        obfuscated_source = obfuscated_path.read_text(encoding="utf-8")
        original_hash = sha256_text(original_source)
        obfuscated_hash = sha256_text(obfuscated_source)
        if (
            original_hash != candidate.get("source_sha256")
            or original_hash != (frozen_variant.get("original") or {}).get("sha256")
            or obfuscated_hash != (frozen_variant.get("obfuscated") or {}).get("sha256")
        ):
            raise ValueError(f"Frozen source hash mismatch: {identity}")
        dataset_row = dataset_rows[row_index]
        solutions = dataset_row.get("solutions")
        texts = solutions.get("solution") if isinstance(solutions, Mapping) else None
        if not isinstance(texts, list) or not 0 <= solution_index < len(texts):
            raise ValueError(f"Dataset solution binding unavailable: {candidate_id}")
        if sha256_text(texts[solution_index]) != original_hash:
            raise ValueError(f"Parquet source differs from frozen source: {identity}")

        audits_by_key: dict[tuple[int, str, int], dict[str, Any]] = {}
        ranked: list[base.BalancedCandidate] = []
        for suite in base.SUITES:
            tests = dataset_row.get(suite)
            if not isinstance(tests, Mapping):
                raise ValueError(f"Missing {suite} in row {row_index}")
            inputs = tests.get("input") or []
            outputs = tests.get("output") or []
            if len(inputs) != len(outputs):
                raise ValueError(f"Mismatched {suite} arrays in row {row_index}")
            for test_index, (stdin, expected_stdout) in enumerate(zip(inputs, outputs)):
                item, audit = base.assess_pair(
                    row_index=row_index,
                    suite=suite,
                    dataset_test_index=test_index,
                    stdin=stdin,
                    expected_stdout=expected_stdout,
                    previously_screened=prior_static_keys,
                    tokenizer_rejections=set(),
                )
                audit.update(
                    {
                        "schema_version": SCHEMA_VERSION,
                        "chosen_source_order": source_order,
                        "variant_id": identity,
                        "candidate_id": candidate_id,
                    }
                )
                audits_by_key[(row_index, suite, test_index)] = audit
                if item is not None:
                    ranked.append(item)
        ranked.sort(key=lambda item: item.rank_key)

        accepted_count = 0
        selected: list[dict[str, Any]] = []
        continuity_rows: list[dict[str, Any]] = []
        for tractable_rank, item in enumerate(ranked, start=1):
            audit = audits_by_key[item.canonical_key]
            audit["tractable_rank"] = tractable_rank
            if accepted_count >= FINAL_ACCEPTED_RANK:
                audit["selection_status"] = "not_executed_accepted_rank_19_reached"
                continue
            executed_total += 1
            audit["executed_jdk"] = True
            validation = one_case_validation(
                candidate=item,
                original_source=original_source,
                original_main_class=str(frozen_variant["original_main_class"]),
                obfuscated_source=obfuscated_source,
                obfuscated_main_class=str(frozen_variant["obfuscated_main_class"]),
                javac=javac,
                java=java,
                runtime_timeout=args.timeout_seconds,
                compile_timeout=args.compile_timeout_seconds,
                scratch_root=scratch_root,
            )
            validation_relpath = Path("validation") / identity / f"{item.case_id}.json"
            atomic_write_json(output_root / validation_relpath, validation)
            audit["validation_path"] = str(validation_relpath)
            audit["validation_accepted"] = bool(validation.get("accepted"))
            if not validation.get("accepted"):
                validation_rejection_total += 1
                audit["selection_status"] = "executed_rejected_by_jdk_validation"
                continue

            accepted_count += 1
            audit["accepted_rank"] = accepted_count
            if accepted_count <= EXPECTED_PRIOR_ACCEPTED_PER_PROBLEM:
                expected_key = accepted_prior[row_index][accepted_count]
                if item.canonical_key != expected_key:
                    raise RuntimeError(
                        f"Row {row_index} reconstructed rank {accepted_count} as "
                        f"{item.canonical_key}, not frozen {expected_key}"
                    )
                frozen_wave = 1 if accepted_count <= 2 else 2 if accepted_count <= 4 else 3
                audit.update(
                    {
                        "selected": False,
                        "selection_status": "continuity_verified_frozen_balanced_rank",
                        "frozen_wave": f"balanced_wave_{frozen_wave}",
                    }
                )
                continuity_rows.append(
                    {
                        "accepted_rank": accepted_count,
                        "canonical_case_key": list(item.canonical_key),
                        "validation_path": str(validation_relpath),
                        "jdk_revalidated": True,
                    }
                )
                continue

            if item.canonical_key in all_previous_keys:
                raise RuntimeError(f"New extension overlaps prior screen: {item.canonical_key}")
            wave_number = _wave_number_for_rank(accepted_count)
            wave_id = str(WAVE_SPECS[wave_number]["wave_id"])
            audit.update(
                {
                    "selected": True,
                    "selection_status": f"selected_wave_{wave_number}",
                    "wave_id": wave_id,
                }
            )
            files = write_selected_case_files(
                output_root=output_root,
                variant_id=identity,
                candidate=item,
                validation=validation,
            )
            original_case = validation_case(validation, "original")
            obfuscated_case = validation_case(validation, "obfuscated")
            selected.append(
                {
                    "case_id": item.case_id,
                    "canonical_case_key": list(item.canonical_key),
                    "canonical_problem_identity": base.canonical_identity(row_index),
                    "row_index": row_index,
                    "suite": item.suite,
                    "dataset_test_index": item.dataset_test_index,
                    "tractable_rank": tractable_rank,
                    "accepted_rank": accepted_count,
                    "wave_id": wave_id,
                    "rank_key": list(item.rank_key),
                    "input_bytes": item.input_bytes,
                    "expected_output_bytes": item.output_bytes,
                    "expected_output_lines": item.output_lines,
                    "input_sha256": sha256_text(item.stdin),
                    "raw_expected_stdout_sha256": sha256_text(item.expected_stdout),
                    "raw_original_stdout_sha256": original_case.get("raw_stdout_sha256"),
                    "raw_original_stderr_sha256": original_case.get("raw_stderr_sha256"),
                    "raw_obfuscated_stdout_sha256": obfuscated_case.get("raw_stdout_sha256"),
                    "raw_obfuscated_stderr_sha256": obfuscated_case.get("raw_stderr_sha256"),
                    "validation_path": str(validation_relpath),
                    **files,
                }
            )

        if accepted_count != FINAL_ACCEPTED_RANK or len(selected) != 9:
            raise RuntimeError(
                f"FAIL CLOSED: row {row_index} supplied accepted_count={accepted_count}, "
                f"new cases={len(selected)}; final exact ranks 11--19 are required"
            )
        if {row["accepted_rank"] for row in selected} != set(range(11, 20)):
            raise RuntimeError(f"FAIL CLOSED: row {row_index} ranks are not exactly 11--19")
        for wave_number, spec in WAVE_SPECS.items():
            wave_rows = [row for row in selected if row["wave_id"] == spec["wave_id"]]
            if (
                len(wave_rows) != EXPECTED_CASES_PER_PROBLEM_BY_WAVE[wave_number]
                or {row["accepted_rank"] for row in wave_rows} != set(spec["accepted_ranks"])
            ):
                raise RuntimeError(f"FAIL CLOSED: row {row_index}/Wave {wave_number} is incomplete")
        for suite in base.SUITES:
            tests = dataset_row[suite]
            for test_index in range(len(tests.get("input") or [])):
                all_audits.append(audits_by_key[(row_index, suite, test_index)])
        problem_entries.append(
            {
                "chosen_source_order": source_order,
                "canonical_problem_identity": base.canonical_identity(row_index),
                "row_index": row_index,
                "problem_key": candidate.get("problem_key"),
                "variant_id": identity,
                "candidate_id": candidate_id,
                "solution_index": solution_index,
                "physical_loc": candidate.get("physical_loc"),
                "original_path": str(original_path.relative_to(WORK_ROOT)),
                "original_sha256": original_hash,
                "obfuscated_path": str(obfuscated_path.relative_to(WORK_ROOT)),
                "obfuscated_sha256": obfuscated_hash,
                "eligible_pair_count_after_static_filters": len(ranked),
                "executed_jdk_count": sum(
                    bool(audits_by_key[item.canonical_key].get("executed_jdk"))
                    for item in ranked
                ),
                "continuity_verified_ranks_1_10": continuity_rows,
                "selected_cases": selected,
            }
        )
        frozen_sources.extend(
            [
                {
                    "variant_id": identity,
                    "role": "original",
                    "path": str(original_path.relative_to(WORK_ROOT)),
                    "sha256_before": original_hash,
                },
                {
                    "variant_id": identity,
                    "role": "obfuscated",
                    "path": str(obfuscated_path.relative_to(WORK_ROOT)),
                    "sha256_before": obfuscated_hash,
                },
            ]
        )

    selected_by_wave: dict[int, set[tuple[int, str, int]]] = {}
    for wave_number, spec in WAVE_SPECS.items():
        keys = {
            tuple(case["canonical_case_key"])
            for problem in problem_entries
            for case in problem["selected_cases"]
            if case["wave_id"] == spec["wave_id"]
        }
        if len(keys) != EXPECTED_CASES_BY_WAVE[wave_number]:
            raise RuntimeError(
                f"FAIL CLOSED: Wave {wave_number} has {len(keys)} unique keys, "
                f"expected {EXPECTED_CASES_BY_WAVE[wave_number]}"
            )
        if keys & all_previous_keys:
            raise RuntimeError(f"FAIL CLOSED: Wave {wave_number} overlaps a prior key")
        selected_by_wave[wave_number] = keys
    for left in WAVE_SPECS:
        for right in WAVE_SPECS:
            if left < right and selected_by_wave[left] & selected_by_wave[right]:
                raise RuntimeError(f"FAIL CLOSED: Waves {left} and {right} overlap")
    all_selected_keys = set().union(*selected_by_wave.values())
    if len(all_selected_keys) != EXPECTED_TOTAL_CASES:
        raise RuntimeError(
            f"FAIL CLOSED: Waves 4--5 are not {EXPECTED_TOTAL_CASES} unique cases"
        )

    chosen_map = {base.variant_id(row): row for row in chosen_sources}
    loader_audits: dict[str, dict[str, Any]] = {}
    manifest_paths: dict[int, Path] = {}
    for wave_number, spec in WAVE_SPECS.items():
        rendered_variants: list[dict[str, Any]] = []
        expected_by_sample: dict[str, dict[str, Any]] = {}
        for problem in problem_entries:
            identity = str(problem["variant_id"])
            rendered = render_variant(
                frozen_variant=chosen_map[identity],
                selected_cases=problem["selected_cases"],
                wave_number=wave_number,
                output_root=output_root,
                prepared_manifest=prepared_manifest,
            )
            rendered_variants.append(rendered)
            for case in rendered["cases"]:
                sample_id = f"{identity}__{case['case_id']}"
                expected_by_sample[sample_id] = {
                    **case,
                    "original_sha256": problem["original_sha256"],
                    "obfuscated_sha256": problem["obfuscated_sha256"],
                }
        manifest_path = output_root / f"wave_{wave_number}_manifest_pre_tokenizer.json"
        payload = manifest_payload(wave_number, rendered_variants)
        if (
            payload["variant_count"] != EXPECTED_PROBLEMS
            or payload["case_count"] != EXPECTED_CASES_BY_WAVE[wave_number]
        ):
            raise RuntimeError(f"FAIL CLOSED: Wave {wave_number} manifest counts are invalid")
        atomic_write_json(manifest_path, payload)
        loader_audit = verify_loaded_manifest(
            manifest_path, expected_by_sample, wave_number=wave_number
        )
        atomic_write_json(
            output_root / f"wave_{wave_number}_loader_hash_audit.json", loader_audit
        )
        manifest_paths[wave_number] = manifest_path
        loader_audits[str(spec["wave_id"])] = loader_audit

    input_hashes_after = {key: sha256_file(path) for key, path in input_paths.items()}
    if input_hashes_after != input_hashes_before:
        raise RuntimeError("A frozen input changed during Waves 4--5 preparation")
    for source in frozen_sources:
        source["sha256_after"] = sha256_file(WORK_ROOT / source["path"])
        source["unchanged"] = source["sha256_before"] == source["sha256_after"]
    if not all(source["unchanged"] for source in frozen_sources):
        raise RuntimeError("A frozen source changed during Waves 4--5 preparation")

    atomic_write_text(output_root / "selection_audit.jsonl", audit_jsonl(all_audits))
    previous_records = (
        initial_records
        + supplemental_records
        + wave_1_records
        + wave_2_records
        + wave_3_records
    )
    atomic_write_json(
        output_root / "previous_screened_case_audit.json",
        {
            "schema_version": SCHEMA_VERSION,
            "initial_case_record_count": len(initial_records),
            "supplemental_case_record_count": len(supplemental_records),
            "wave_1_case_record_count": len(wave_1_records),
            "wave_2_case_record_count": len(wave_2_records),
            "wave_3_case_record_count": len(wave_3_records),
            "combined_unique_canonical_case_count": len(all_previous_keys),
            "wave_4_overlap_count": len(selected_by_wave[4] & all_previous_keys),
            "wave_5_overlap_count": len(selected_by_wave[5] & all_previous_keys),
            "cross_new_wave_overlap_count": sum(
                len(selected_by_wave[left] & selected_by_wave[right])
                for left in WAVE_SPECS
                for right in WAVE_SPECS
                if left < right
            ),
            "records": previous_records,
        },
    )
    atomic_write_json(
        output_root / "source_denominator_audit.json",
        {
            "schema_version": SCHEMA_VERSION,
            "timing_disclosure": TIMING_DISCLOSURE,
            "adaptive_status_disclosure": ADAPTIVE_STATUS_DISCLOSURE,
            "preparation_read_disclosure": PREPARATION_READ_DISCLOSURE,
            "feasibility_revision_disclosure": FEASIBILITY_REVISION_DISCLOSURE,
            "denominator_disclosure": DENOMINATOR_DISCLOSURE,
            "frozen_source_denominator": 25,
            "tokenizer_eligible_source_count": 23,
            "canonical_problem_count": EXPECTED_PROBLEMS,
            "chosen_source_count": len(problem_entries),
            "cases_per_problem_by_wave": EXPECTED_CASES_PER_PROBLEM_BY_WAVE,
            "wave_case_counts": {
                str(WAVE_SPECS[wave]["wave_id"]): len(selected_by_wave[wave])
                for wave in WAVE_SPECS
            },
            "accepted_ranks_per_wave": {
                str(WAVE_SPECS[wave]["wave_id"]): list(
                    WAVE_SPECS[wave]["accepted_ranks"]
                )
                for wave in WAVE_SPECS
            },
            "wave_4_case_count": len(selected_by_wave[4]),
            "wave_5_case_count": len(selected_by_wave[5]),
            "prior_accepted_ranks_revalidated_per_problem": (
                EXPECTED_PRIOR_ACCEPTED_PER_PROBLEM
            ),
            "rank25_feasibility_failure_preserved": True,
            "rank20_feasibility_failure_preserved": True,
            "accepted_ranks_per_problem_by_wave": {
                f"wave_{wave}": list(WAVE_SPECS[wave]["accepted_ranks"])
                for wave in WAVE_SPECS
            },
            "sources": problem_entries,
        },
    )
    atomic_write_json(
        output_root / "loader_hash_audit.json",
        {
            "schema_version": SCHEMA_VERSION,
            "parent_shadow_regression_checked": True,
            "all_loaded_hashes_match": True,
            "waves": loader_audits,
        },
    )
    provenance = {
        "schema_version": SCHEMA_VERSION,
        "timing_disclosure": TIMING_DISCLOSURE,
        "adaptive_status_disclosure": ADAPTIVE_STATUS_DISCLOSURE,
        "preparation_read_disclosure": PREPARATION_READ_DISCLOSURE,
        "feasibility_revision_disclosure": FEASIBILITY_REVISION_DISCLOSURE,
        "denominator_disclosure": DENOMINATOR_DISCLOSURE,
        "specified_during_live_wave_3": True,
        "completed_wave_2_strict_canonical_problem_count": 4,
        "completed_wave_2_count_source": (
            "externally supplied aggregate timing/trigger fact; no result or audit file was read"
        ),
        "adaptive_outcome_aware_source": "completed Wave-2 aggregate unique count only",
        "wave_3_outputs_results_or_result_files_inspected": False,
        "case_ranking_outcome_independent": True,
        "prospectively_revised_during_live_wave_3": True,
        "prospective_revision_count": 2,
        "revision_completed_before_any_wave_3_output_or_result_inspection": True,
        "rank25_feasibility_failure_preserved": True,
        "rank20_feasibility_failure_preserved": True,
        "final_design_wave_count": 2,
        "wave_6_removed": True,
        "revision_uses_model_outcomes": False,
        "rank25_feasibility_failure": rank25_failure_audit,
        "rank20_feasibility_failure": rank20_failure_audit,
        "read_scope": [
            "frozen candidate, prepared-variant, initial, and supplemental manifests",
            "frozen tokenizer-gated Wave-1, Wave-2, and Wave-3 manifests",
            "frozen original and obfuscated Java source files",
            "immutable CodeContests private_tests/generated_tests/solutions columns",
            "second balanced extension protocol controls and JDK 17 tools",
        ],
        "explicitly_forbidden_read_scope": [
            "every Wave-1, Wave-2, and live Wave-3 inference result root",
            "all run records, model completions, predicted outputs, traces, and scores",
            "all post-Wave-3 audit/result files",
            "public_tests values",
        ],
        "model_result_directories_listed": 0,
        "model_result_files_read": 0,
        "wave_3_result_files_read": 0,
        "model_inference_calls": 0,
        "model_weights_loaded": False,
        "public_test_values_read": 0,
        "dataset": {
            "id": base.DATASET_ID,
            "revision": base.DATASET_REVISION,
            "split": base.DATASET_SPLIT,
            "file_sha256": base.DATASET_SHA256,
            "columns_loaded": columns,
            "columns_explicitly_not_loaded": ["public_tests"],
            "pyarrow_version": pyarrow.__version__,
        },
        "inputs": {
            key: {
                "path": str(path.relative_to(WORK_ROOT)),
                "sha256_before": input_hashes_before[key],
                "sha256_after": input_hashes_after[key],
            }
            for key, path in input_paths.items()
        },
        "jdk": jdk,
        "runtime_timeout_seconds": args.timeout_seconds,
        "compile_timeout_seconds": args.compile_timeout_seconds,
        "jdk_executed_candidate_count": executed_total,
        "jdk_validation_rejection_count": validation_rejection_total,
        "frozen_inputs_unchanged": True,
        "frozen_source_hash_audit": frozen_sources,
        "outputs": {
            "pre_tokenizer_manifests": {
                str(WAVE_SPECS[wave]["wave_id"]): manifest_paths[wave].name
                for wave in WAVE_SPECS
            },
            "selection_audit": "selection_audit.jsonl",
            "source_denominator_audit": "source_denominator_audit.json",
            "loader_hash_audit": "loader_hash_audit.json",
            "rank25_feasibility_failure_audit": (
                "rank25_feasibility_failure_audit.json"
            ),
            "rank20_feasibility_failure_audit": (
                "rank20_feasibility_failure_audit.json"
            ),
        },
    }
    atomic_write_json(output_root / "provenance.json", provenance)
    summary = {
        "schema_version": SCHEMA_VERSION,
        "state": "prepared_and_jdk_validated_tokenizer_gates_pending",
        "adaptive": True,
        "outcome_aware_from_completed_wave_2_aggregate": True,
        "preregistered": False,
        "outcome_blind_in_timing": False,
        "wave_3_outputs_or_results_inspected": False,
        "case_ranking_outcome_independent": True,
        "rank25_feasibility_failure_preserved": True,
        "rank20_feasibility_failure_preserved": True,
        "prospectively_revised_during_live_wave_3": True,
        "prospective_revision_count": 2,
        "revision_completed_before_any_wave_3_output_or_result_inspection": True,
        "revision_uses_model_outcomes": False,
        "final_design_wave_count": 2,
        "wave_6_removed": True,
        "source_denominator": 25,
        "tokenizer_eligible_source_count": 23,
        "canonical_problem_count": EXPECTED_PROBLEMS,
        "cases_per_problem_by_wave": {
            str(WAVE_SPECS[wave]["wave_id"]): EXPECTED_CASES_PER_PROBLEM_BY_WAVE[wave]
            for wave in WAVE_SPECS
        },
        "case_count_by_wave": {
            str(WAVE_SPECS[wave]["wave_id"]): EXPECTED_CASES_BY_WAVE[wave]
            for wave in WAVE_SPECS
        },
        "total_selected_case_count": len(all_selected_keys),
        "accepted_ranks_per_wave": {
            str(WAVE_SPECS[wave]["wave_id"]): list(WAVE_SPECS[wave]["accepted_ranks"])
            for wave in WAVE_SPECS
        },
        "prior_accepted_ranks_revalidated_per_problem": EXPECTED_PRIOR_ACCEPTED_PER_PROBLEM,
        "overlap_with_initial_supplemental_wave_1_wave_2_wave_3": 0,
        "cross_new_wave_overlap": 0,
        "jdk_executed_candidate_count": executed_total,
        "jdk_validation_rejection_count": validation_rejection_total,
        "model_result_files_read": 0,
        "model_inference_calls": 0,
        "public_test_values_read": 0,
        "parent_shadow_regression_checked": True,
        "all_loaded_hashes_match": True,
        "result_roots_created": False,
    }
    atomic_write_json(output_root / "summary.json", summary)
    atomic_write_text(
        output_root / "README.md",
        f"""# Frozen second balanced extension contingency (Waves 4--5)

{TIMING_DISCLOSURE}

{ADAPTIVE_STATUS_DISCLOSURE}

{PREPARATION_READ_DISCLOSURE}

{FEASIBILITY_REVISION_DISCLOSURE}

{DENOMINATOR_DISCLOSURE}

The Wave-4 manifest contains 95 JDK-validated cases (19 canonical problems by
5 cases), using accepted ranks 11--15. Wave 5 contains 76 cases (19 by 4),
using ranks 16--19. There is no Wave 6. Every initial, supplemental, Wave-1,
Wave-2, and Wave-3 canonical key is excluded, and the two new waves are
mutually disjoint. Both failed-design evidence trees are retained under
`rank25_feasibility_failure/` and `rank20_feasibility_failure/`, with exact
cryptographic inventories in their corresponding audit JSON files.

Exact tokenizer gates and immutable freezing are pending. No inference result
root was read, listed, or created.
""",
    )
    if scratch_root.exists():
        shutil.rmtree(scratch_root)
    print(json.dumps(summary, indent=2, sort_keys=True))
    return 0


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--candidate-manifest", type=Path, default=DEFAULT_CANDIDATE_MANIFEST)
    parser.add_argument("--prepared-manifest", type=Path, default=DEFAULT_PREPARED_MANIFEST)
    parser.add_argument("--eligible-manifest", type=Path, default=DEFAULT_ELIGIBLE_MANIFEST)
    parser.add_argument("--supplemental-manifest", type=Path, default=DEFAULT_SUPPLEMENTAL_MANIFEST)
    parser.add_argument("--wave-1-manifest", type=Path, default=DEFAULT_WAVE_1_MANIFEST)
    parser.add_argument("--wave-2-manifest", type=Path, default=DEFAULT_WAVE_2_MANIFEST)
    parser.add_argument("--wave-3-manifest", type=Path, default=DEFAULT_WAVE_3_MANIFEST)
    parser.add_argument("--dataset", type=Path, default=DEFAULT_DATASET)
    parser.add_argument("--protocol-md", type=Path, default=DEFAULT_PROTOCOL_MD)
    parser.add_argument("--protocol-json", type=Path, default=DEFAULT_PROTOCOL_JSON)
    parser.add_argument("--output-root", type=Path, default=DEFAULT_OUTPUT_ROOT)
    parser.add_argument(
        "--failure-archive-root", type=Path, default=DEFAULT_FAILURE_ARCHIVE_ROOT
    )
    parser.add_argument(
        "--rank20-failure-archive-root",
        type=Path,
        default=DEFAULT_RANK20_FAILURE_ARCHIVE_ROOT,
    )
    parser.add_argument("--java-home", type=Path, default=DEFAULT_JAVA_HOME)
    parser.add_argument("--timeout-seconds", type=float, default=12.0)
    parser.add_argument("--compile-timeout-seconds", type=float, default=30.0)
    parser.add_argument("--overwrite", action="store_true")
    parser.add_argument("--resume-after-rank20-failure", action="store_true")
    return parser


def main() -> None:
    raise SystemExit(prepare(build_parser().parse_args()))


if __name__ == "__main__":
    main()
