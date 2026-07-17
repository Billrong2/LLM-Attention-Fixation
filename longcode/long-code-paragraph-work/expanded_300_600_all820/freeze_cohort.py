#!/usr/bin/env python3
"""Freeze every statically eligible T5 variant into six-case binary packs."""

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import shutil
from pathlib import Path
from typing import Any, Mapping, Sequence


HERE = Path(__file__).resolve().parent
PROMPT_ROOT = HERE.parents[1]
DEFAULT_PREPARED = HERE / "prepared_variants" / "eligible_variants.json"
DEFAULT_OUTPUT = HERE / "frozen"
SEED = 20260715
INTEGER = re.compile(r"(?<![\w.])[+-]?\d+(?![\w.])")
BOOLEAN = re.compile(r"(?<![A-Za-z])(?:YES|NO)(?![A-Za-z])")


class FreezeError(RuntimeError):
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
    temporary.write_text(json.dumps(value, indent=2, sort_keys=True, ensure_ascii=False) + "\n", encoding="utf-8")
    os.replace(temporary, path)


def resolve_read(path: Path, label: str) -> Path:
    resolved = path.expanduser().resolve(strict=True)
    try:
        resolved.relative_to(PROMPT_ROOT.resolve(strict=True))
    except ValueError as exc:
        raise FreezeError(f"{label} must be inside PromptSteering: {resolved}") from exc
    if not resolved.is_file():
        raise FreezeError(f"{label} is not a file: {resolved}")
    return resolved


def resolve_relative(value: Any, root: Path, label: str) -> Path:
    if not isinstance(value, str) or not value:
        raise FreezeError(f"missing {label}")
    candidate = Path(value).expanduser()
    candidate = candidate if candidate.is_absolute() else root / candidate
    return resolve_read(candidate, label)


def normalize(value: str) -> str:
    return value.replace("\r\n", "\n").replace("\r", "\n").strip()


def false_output(oracle: str, program_id: str, case_id: str) -> tuple[str, dict[str, Any]]:
    digest = hashlib.sha256(f"expanded-false-v1\0{SEED}\0{program_id}\0{case_id}".encode()).digest()
    integer = list(INTEGER.finditer(oracle))
    if integer:
        index = int.from_bytes(digest[:8], "big") % len(integer)
        match = integer[index]
        old = match.group(0)
        new = str(int(old) + (1 if digest[8] % 2 == 0 else -1))
        algorithm = "one_integer_plus_or_minus_one"
    else:
        boolean = list(BOOLEAN.finditer(oracle))
        if boolean:
            index = int.from_bytes(digest[:8], "big") % len(boolean)
            match = boolean[index]
            old = match.group(0)
            new = "NO" if old == "YES" else "YES"
            algorithm = "one_yes_no_flip"
        else:
            symbols = list(re.finditer(r"\S", oracle))
            if not symbols:
                # Empty stdout is a valid deterministic program behavior.  A
                # visible token is the minimal false candidate under the
                # registered outer-whitespace normalization.
                index = 0
                old = oracle
                new = "X"
                algorithm = "empty_or_whitespace_stdout_to_visible_X"
                result = new
            else:
                index = int.from_bytes(digest[:8], "big") % len(symbols)
                match = symbols[index]
                old = match.group(0)
                new = "X" if old != "X" else "Y"
                algorithm = "one_nonwhitespace_character_replacement"
                result = oracle[: match.start()] + new + oracle[match.end() :]
    if integer or boolean:
        result = oracle[: match.start()] + new + oracle[match.end() :]
    if normalize(result) == normalize(oracle):
        raise FreezeError(f"false mutation did not change output: {program_id}/{case_id}")
    return result, {"algorithm": algorithm, "token_index": index, "old": old, "new": new}


def false_positions(program_index: int, program_ids: Sequence[str]) -> set[int]:
    """Complement-pair schedule: exact column balance for each complete pair."""
    pair_index = program_index // 2
    digest = hashlib.sha256(
        f"expanded-label-row-v1\0{SEED}\0{pair_index}\0{program_ids[program_index - program_index % 2]}".encode()
    ).digest()
    ranked = sorted(range(1, 7), key=lambda value: hashlib.sha256(digest + bytes([value])).digest())
    first = set(ranked[:3])
    return first if program_index % 2 == 0 else set(range(1, 7)) - first


def accepted_execution(validation: Any, case_ids: Sequence[str], label: str) -> None:
    if not isinstance(validation, Mapping) or validation.get("accepted") is not True:
        raise FreezeError(f"{label} execution validation is not accepted")
    rows = validation.get("cases")
    if not isinstance(rows, list) or [str(row.get("case_id")) for row in rows] != list(case_ids):
        raise FreezeError(f"{label} validation cases differ")
    if any(row.get("accepted") is not True or row.get("trimmed_exact_match") is not True for row in rows):
        raise FreezeError(f"{label} has a failed case")


def freeze(prepared_path: Path, output_path: Path) -> dict[str, Any]:
    prepared = resolve_read(prepared_path, "eligible prepared manifest")
    prepared_root = prepared.parent
    payload = json.loads(prepared.read_text(encoding="utf-8"))
    filtered_schema = "expanded-model-preflight-filtered-variants-v1"
    model_filter_audit_path: Path | None = None
    model_filter_audit: dict[str, Any] | None = None
    upstream_prepared_path: Path | None = None
    metadata_root = prepared_root
    if isinstance(payload, Mapping) and payload.get("schema_version") == filtered_schema:
        upstream_prepared_path = resolve_relative(
            payload.get("source_prepared_manifest"), HERE, "upstream prepared manifest"
        )
        if sha256_file(upstream_prepared_path) != payload.get("source_prepared_manifest_sha256"):
            raise FreezeError("filtered manifest upstream prepared hash differs")
        metadata_root = upstream_prepared_path.parent
        model_filter_audit_path = resolve_relative(
            payload.get("model_preflight_filter_audit"), prepared_root, "model preflight filter audit"
        )
        audit_any = json.loads(model_filter_audit_path.read_text(encoding="utf-8"))
        if not isinstance(audit_any, dict):
            raise FreezeError("model preflight filter audit is not an object")
        model_filter_audit = audit_any
        counts = model_filter_audit.get("counts")
        eligible_count = len(payload.get("variants") or [])
        if (
            model_filter_audit.get("status") != "validated_complete_outcome_free_filter"
            or not isinstance(counts, Mapping)
            or counts.get("eligible_programs") != eligible_count
            or counts.get("model_outcomes_generated") != 0
            or counts.get("study_generations") != 0
            or (model_filter_audit.get("output_artifacts") or {})
            .get("eligible_variants", {})
            .get("sha256")
            != sha256_file(prepared)
        ):
            raise FreezeError("model preflight filter audit is stale or not outcome-free")
    policy_path = metadata_root / "wrapper_policy.json"
    preparation_policy = (
        json.loads(policy_path.read_text(encoding="utf-8"))
        if policy_path.is_file()
        else {"source": "upstream preparer without expansion wrapper policy"}
    )
    merge_audit_path = metadata_root / "merge_audit.json"
    preparation_merge_audit = (
        json.loads(merge_audit_path.read_text(encoding="utf-8"))
        if merge_audit_path.is_file()
        else None
    )
    variants = payload.get("variants") if isinstance(payload, Mapping) else None
    if not isinstance(variants, list) or not variants:
        raise FreezeError("prepared manifest has no eligible variants")
    output = output_path.expanduser()
    output = output if output.is_absolute() else HERE / output
    output = output.resolve(strict=False)
    try:
        output.relative_to(HERE.resolve(strict=True))
    except ValueError as exc:
        raise FreezeError(f"freeze output must remain below {HERE}") from exc
    if output.exists():
        raise FreezeError(f"immutable freeze output already exists: {output}")
    output.mkdir(parents=True)

    def identity(row: Mapping[str, Any]) -> tuple[int, int, str]:
        provenance = (row.get("candidate_metadata") or {}).get("provenance") or {}
        return int(provenance["row_index"]), int(provenance["solution_index"]), str(row["id"])

    ordered = sorted(variants, key=identity)
    program_ids = [str(row["id"]) for row in ordered]
    if len(set(program_ids)) != len(program_ids):
        raise FreezeError("prepared IDs are not unique")
    programs: list[dict[str, Any]] = []
    construction: list[dict[str, Any]] = []
    try:
        for index, variant_any in enumerate(ordered):
            if not isinstance(variant_any, Mapping) or variant_any.get("eligible") is not True:
                raise FreezeError("prepared row is not explicitly eligible")
            variant = variant_any
            program_id = str(variant["id"])
            cases_raw = variant.get("cases")
            if not isinstance(cases_raw, list) or len(cases_raw) != 6:
                raise FreezeError(f"{program_id} does not have exactly six cases")
            # Preserve the outcome-blind order registered by the screening
            # manifest; execution-validation rows use this exact order.
            cases = [dict(case) for case in cases_raw]
            case_ids = [str(case["case_id"]) for case in cases]
            input_hashes = [sha256_text(str(case["stdin"])) for case in cases]
            if len(set(case_ids)) != 6 or len(set(input_hashes)) != 6:
                raise FreezeError(f"{program_id} cases/inputs are not distinct")
            original = resolve_relative(variant["original_path"], prepared_root, "original source")
            obfuscated = resolve_relative(variant["obfuscated_path"], prepared_root, "obfuscated source")
            if sha256_file(original) != variant["original"]["sha256"] or sha256_file(obfuscated) != variant["obfuscated"]["sha256"]:
                raise FreezeError(f"{program_id} source hash differs")
            original_validation_path = resolve_relative(
                variant["original"]["execution_validation_path"], prepared_root, "original validation"
            )
            original_validation = json.loads(original_validation_path.read_text(encoding="utf-8"))
            accepted_execution(original_validation["execution_validation"], case_ids, f"{program_id}/original")
            accepted_execution(variant["obfuscated"]["execution_validation"], case_ids, f"{program_id}/obfuscated")
            destination = output / "programs" / f"p{index + 1:04d}"
            destination.mkdir(parents=True)
            original_copy = destination / "original.java"
            obfuscated_copy = destination / "obfuscated.java"
            shutil.copyfile(original, original_copy)
            shutil.copyfile(obfuscated, obfuscated_copy)
            false_set = false_positions(index, program_ids)
            binary_cases: list[dict[str, Any]] = []
            for position, case in enumerate(cases, 1):
                stdin = str(case["stdin"])
                oracle = str(case["expected_stdout"])
                source_case_id = str(case["case_id"])
                label = position not in false_set
                if label:
                    candidate = oracle
                    mutation = {"algorithm": "exact_oracle"}
                else:
                    candidate, mutation = false_output(oracle, program_id, source_case_id)
                opaque = "ev-" + hashlib.sha256(
                    f"expanded-case-id-v1\0{SEED}\0{program_id}\0{source_case_id}".encode()
                ).hexdigest()[:20]
                binary_cases.append(
                    {
                        "id": opaque,
                        "source_case_id": source_case_id,
                        "pack_position": position,
                        "stdin": stdin,
                        "stdin_sha256": sha256_text(stdin),
                        "candidate_stdout": candidate,
                        "candidate_stdout_sha256": sha256_text(candidate),
                        "oracle_stdout_sha256": sha256_text(oracle),
                        "label": label,
                    }
                )
                construction.append(
                    {
                        "program_id": program_id,
                        "source_case_id": source_case_id,
                        "pack_position": position,
                        "label": label,
                        "mutation": mutation,
                    }
                )
            provenance = (variant.get("candidate_metadata") or {}).get("provenance") or {}
            candidate_metadata = variant.get("candidate_metadata") or {}
            source_tests = candidate_metadata.get("tests") or candidate_metadata.get("cases") or []
            source_case_provenance = []
            for source_case in source_tests:
                if not isinstance(source_case, Mapping):
                    continue
                source_case_provenance.append(
                    {
                        key: source_case.get(key)
                        for key in (
                            "id",
                            "case_id",
                            "suite",
                            "dataset_test_index",
                            "case_origin",
                            "selection_tier",
                            "dataset_expected_stdout_sha256",
                            "program_stdout_sha256",
                            "dataset_expected_equals_program_stdout",
                            "synthetic_provenance",
                        )
                        if key in source_case
                    }
                )
            programs.append(
                {
                    "id": program_id,
                    "original_path": original_copy.relative_to(output).as_posix(),
                    "obfuscated_path": obfuscated_copy.relative_to(output).as_posix(),
                    "original_sha256": sha256_file(original_copy),
                    "obfuscated_sha256": sha256_file(obfuscated_copy),
                    "original_physical_loc": len(original_copy.read_text(encoding="utf-8").splitlines()),
                    "obfuscated_physical_loc": len(obfuscated_copy.read_text(encoding="utf-8").splitlines()),
                    "original_target_method": variant["original_target_method"],
                    "obfuscated_target_method": variant["obfuscated_target_method"],
                    "original_main_class": variant["original_main_class"],
                    "obfuscated_main_class": variant["obfuscated_main_class"],
                    "provenance": dict(provenance),
                    "selection_tier": candidate_metadata.get("selection_tier"),
                    "candidate_protocol_extension": candidate_metadata.get("protocol_extension"),
                    "source_case_provenance": source_case_provenance,
                    "source_case_metadata": source_tests,
                    "cases": binary_cases,
                }
            )
    except Exception:
        shutil.rmtree(output)
        raise
    position_false_counts = {
        str(position): sum(not case["label"] for program in programs for case in program["cases"] if case["pack_position"] == position)
        for position in range(1, 7)
    }
    manifest = {
        "schema_version": "expanded-java-300-600-binary-freeze-v1",
        "selection_stage": (
            payload.get("selection_stage")
            if isinstance(payload, Mapping) and isinstance(payload.get("selection_stage"), str)
            else "all static/execution-eligible variants; no model outcomes"
        ),
        "dataset": {
            "id": "deepmind/code_contests",
            "revision": "802411c3010cb00d1b05bad57ca77365a3c699d6",
            "split": "valid",
        },
        "source_prepared_manifest": str(prepared),
        "source_prepared_manifest_sha256": sha256_file(prepared),
        "upstream_prepared_manifest": str(upstream_prepared_path) if upstream_prepared_path else None,
        "upstream_prepared_manifest_sha256": (
            sha256_file(upstream_prepared_path) if upstream_prepared_path else None
        ),
        "model_preflight_filter_audit": model_filter_audit,
        "model_preflight_filter_audit_sha256": (
            sha256_file(model_filter_audit_path) if model_filter_audit_path else None
        ),
        "source_preparation_policy": preparation_policy,
        "source_preparation_merge_audit": preparation_merge_audit,
        "source_preparation_merge_audit_sha256": (
            sha256_file(merge_audit_path) if merge_audit_path.is_file() else None
        ),
        "program_count": len(programs),
        "cases_per_program": 6,
        "labels_per_condition": len(programs) * 6,
        "conditions": ["original_plain", "obfuscated_plain", "obfuscated_codesteer"],
        "generation": {"do_sample": True, "temperature": 1.30, "top_p": 0.95, "top_k": 50, "max_new_tokens": 192},
        "codesteer_level": 2,
        "construction": {
            "seed": SEED,
            "three_true_three_false_per_program": True,
            "false_position_schedule": "complement pairs; each complete pair balances every position",
            "false_counts_by_pack_position": position_false_counts,
            "model_outputs_read": False,
            "synthesized_source_inputs": False,
        },
        "programs": programs,
    }
    manifest_path = output / "inference_manifest.json"
    atomic_json(manifest_path, manifest)
    atomic_json(output / "construction_audit.json", {"records": construction, "record_count": len(construction)})
    digest = sha256_file(manifest_path)
    (output / "inference_manifest.sha256").write_text(f"{digest}  inference_manifest.json\n", encoding="utf-8")
    summary = {
        "program_count": len(programs),
        "case_count": len(programs) * 6,
        "generation_count": len(programs) * 3,
        "label_judgments_across_conditions": len(programs) * 18,
        "manifest_sha256": digest,
        "model_outcomes_read": False,
    }
    atomic_json(output / "summary.json", summary)
    return summary


def parse_args(argv: Sequence[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--prepared", type=Path, default=DEFAULT_PREPARED)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    return parser.parse_args(argv)


if __name__ == "__main__":
    args = parse_args()
    print(json.dumps(freeze(args.prepared, args.output), indent=2, sort_keys=True))
