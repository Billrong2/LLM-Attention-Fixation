#!/usr/bin/env python3
"""Export portable, evaluation-complete records from raw Prompt-Steering runs."""

from __future__ import annotations

import argparse
import gzip
import hashlib
import io
import json
import os
from pathlib import Path
from typing import Any, Iterable


HERE = Path(__file__).resolve().parent
DEFAULT_MANIFEST = HERE / "results" / "table2_manifest.json"
DEFAULT_OUTPUT = HERE / "results" / "prompt_steering_trials.jsonl.gz"


def read_json(path: Path) -> dict[str, Any]:
    return json.loads(path.read_text(encoding="utf-8"))


def sha256_bytes(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def run_index(path: Path) -> int:
    try:
        return int(path.parent.name.removeprefix("run_"))
    except ValueError as exc:
        raise ValueError(f"Invalid run directory: {path.parent}") from exc


def source_location(
    payload: dict[str, Any], project_root: Path
) -> tuple[str, Path]:
    obfuscation = payload.get("obfuscation") or {}
    dataset = str(payload.get("dataset", ""))
    snippet = str(payload.get("snippet", ""))
    technique = str(obfuscation.get("technique", ""))
    tier = str(obfuscation.get("tier", ""))
    variant_file = str(obfuscation.get("variant_file", ""))
    relpath = Path("Rebuttal") / "artifacts" / "obfuscation" / "source" / dataset / "java"
    relpath = relpath / snippet / technique / tier / variant_file

    candidates = [Path(str(obfuscation.get("variant_path", ""))), project_root / relpath]
    for candidate in candidates:
        if str(candidate) and candidate.is_file():
            return relpath.as_posix(), candidate
    raise FileNotFoundError(f"Could not resolve source for {dataset}/{snippet}/{technique}/{tier}")


def iter_raw_paths(
    artifact_root: Path, manifest: dict[str, Any]
) -> Iterable[tuple[dict[str, Any], Path]]:
    run_tag = str(manifest["run_tag"])
    for row in manifest["rows"]:
        base = (
            artifact_root
            / "obfuscation"
            / "result"
            / str(row["model_label"])
            / str(row["dataset"])
        )
        if not base.is_dir():
            raise FileNotFoundError(f"Missing raw result directory: {base}")
        paths = sorted(base.rglob("model_output.json"))
        matched = [path for path in paths if run_tag in path.parts]
        for path in matched:
            yield row, path


def compact_record(
    *,
    row: dict[str, Any],
    path: Path,
    payload: dict[str, Any],
    project_root: Path,
    protocol: dict[str, Any],
) -> dict[str, Any]:
    obfuscation = payload.get("obfuscation") or {}
    prompt = payload.get("prompt_steering") or {}
    generation = payload.get("generation_params") or {}
    trial = run_index(path)

    expected_model = str(row["model_name"])
    expected_dataset = str(row["dataset"])
    checks = {
        "model": payload.get("model") == expected_model,
        "dataset": payload.get("dataset") == expected_dataset,
        "task_profile": payload.get("task_profile") == "counterfactual_tf",
        "source_kind": payload.get("source_kind") == "obfuscated",
        "trial_id": payload.get("trial_id") == trial,
        "run_index": payload.get("run_index") == trial,
        "prompt_mode": prompt.get("mode") == protocol["prompt_mode"],
        "prompt_mechanism": prompt.get("mechanism") == protocol["prompt_mechanism"],
        "temperature": float(generation.get("temperature", -1)) == float(protocol["temperature"]),
        "top_p": float(generation.get("top_p", -1)) == float(protocol["top_p"]),
        "do_sample": generation.get("do_sample") is protocol["do_sample"],
        "base_seed": generation.get("base_seed") == protocol["base_seed"],
        "per_case_scores": bool(payload.get("per_case_scores")),
    }
    failed = [name for name, passed in checks.items() if not passed]
    if failed:
        raise ValueError(f"Invalid raw result {path}: {', '.join(failed)}")

    source_relpath, source_path = source_location(payload, project_root)
    snippet = str(payload.get("snippet", ""))
    technique = str(obfuscation.get("technique", ""))
    tier = str(obfuscation.get("tier", ""))
    variant_file = str(obfuscation.get("variant_file", ""))
    unit_id = "/".join((snippet, technique, tier, variant_file))

    return {
        "record_type": "trial",
        "schema_version": 1,
        "model_label": str(row["model_label"]),
        "model": expected_model,
        "dataset": expected_dataset,
        "unit_id": unit_id,
        "snippet": snippet,
        "technique": technique,
        "tier": tier,
        "variant_file": variant_file,
        "source_relpath": source_relpath,
        "source_sha256": sha256_file(source_path),
        "trial_id": trial,
        "run_index": trial,
        "generation_params": generation,
        "prompt_steering": prompt,
        "structural_prompt": payload.get("structural_prompt") or {},
        "prompt_text": str(payload.get("prompt_text", "")),
        "generated_completion": str(
            payload.get("generated_completion") or payload.get("predicted_output_raw", "")
        ),
        "parse_complete": bool(payload.get("parse_complete", True)),
        "parse_retry_exhausted": bool(payload.get("parse_retry_exhausted", False)),
        "oracle_labels": payload.get("oracle_labels") or {},
        "predicted_labels": payload.get("predicted_labels") or {},
        "per_case_scores": payload.get("per_case_scores") or [],
    }


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--artifact-root", type=Path, default=HERE / "artifacts")
    parser.add_argument("--manifest", type=Path, default=DEFAULT_MANIFEST)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--project-root", type=Path, default=HERE.parent)
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    manifest = read_json(args.manifest.resolve())
    manifest_hash = sha256_file(args.manifest.resolve())
    protocol = manifest["protocol"]
    expected_trials = set(range(1, int(protocol["trials_per_unit"]) + 1))
    output = args.output.resolve()
    output.parent.mkdir(parents=True, exist_ok=True)
    temporary = output.with_suffix(output.suffix + ".tmp")

    records: list[dict[str, Any]] = []
    for row, path in iter_raw_paths(args.artifact_root.resolve(), manifest):
        payload = read_json(path)
        record = compact_record(
            row=row,
            path=path,
            payload=payload,
            project_root=args.project_root.resolve(),
            protocol=protocol,
        )
        if int(record["trial_id"]) not in expected_trials:
            raise ValueError(f"Unexpected trial {record['trial_id']} in {path}")
        records.append(record)

    records.sort(
        key=lambda item: (
            str(item["model_label"]),
            str(item["dataset"]),
            str(item["unit_id"]),
            int(item["trial_id"]),
        )
    )
    header = {
        "record_type": "metadata",
        "schema_version": 1,
        "manifest_sha256": manifest_hash,
        "run_tag": manifest["run_tag"],
        "trial_records": len(records),
    }

    with temporary.open("wb") as raw_handle:
        with gzip.GzipFile(fileobj=raw_handle, mode="wb", filename="", mtime=0, compresslevel=9) as gzip_handle:
            with io.TextIOWrapper(gzip_handle, encoding="utf-8", newline="\n") as text_handle:
                for item in [header, *records]:
                    text_handle.write(json.dumps(item, sort_keys=True, separators=(",", ":")))
                    text_handle.write("\n")
    os.replace(temporary, output)
    print(f"Wrote {len(records)} portable trial records to {output}")
    print(f"SHA256 {sha256_file(output)}")


if __name__ == "__main__":
    main()
