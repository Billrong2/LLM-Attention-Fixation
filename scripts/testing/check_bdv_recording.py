#!/usr/bin/env python3
from __future__ import annotations

import argparse
import gzip
import json
from pathlib import Path

import numpy as np


def _assert_file(path: Path) -> None:
    if not path.is_file():
        raise FileNotFoundError(f"Missing required file: {path}")


def main() -> None:
    ap = argparse.ArgumentParser(description="Validate record-layers superset artifacts in a run directory.")
    ap.add_argument("--run-dir", type=Path, required=True, help="Path containing model_output.json and recorder artifacts.")
    ap.add_argument("--schema-path", type=Path, default=None, help="Optional explicit bdv_schema.json path.")
    args = ap.parse_args()

    run_dir = args.run_dir
    model_out = run_dir / "model_output.json"
    full_json_gz = run_dir / "record_layers_full.json.gz"
    b1 = run_dir / "bdv_features_b1.npz"
    b3 = run_dir / "bdv_features_b3.npz"
    schema = args.schema_path or run_dir.parent / "bdv_schema.json"

    for p in (model_out, full_json_gz, b1, b3, schema):
        _assert_file(p)

    model_payload = json.loads(model_out.read_text(encoding="utf-8"))
    if not bool(model_payload.get("recording_complete")):
        raise AssertionError("model_output.json has recording_complete=false.")

    with gzip.open(full_json_gz, "rt", encoding="utf-8") as fh:
        raw_payload = json.load(fh)
    if raw_payload.get("schema_version") != "record_layers_full_v1":
        raise AssertionError("Unexpected record_layers_full schema version.")
    if "steps" not in raw_payload:
        raise AssertionError("record_layers_full missing steps.")

    b1_npz = np.load(b1, allow_pickle=False)
    b3_npz = np.load(b3, allow_pickle=False)
    if int(b1_npz["bucket_count"]) != 1:
        raise AssertionError("bdv_features_b1 bucket_count must be 1.")
    if int(b3_npz["bucket_count"]) != 3:
        raise AssertionError("bdv_features_b3 bucket_count must be 3.")
    if b1_npz["phi_head"].ndim not in (3, 4):
        raise AssertionError("Unexpected phi_head rank for b1.")
    if b3_npz["phi_head"].ndim != 4:
        raise AssertionError("Unexpected phi_head rank for b3.")

    print(f"[OK] recorder superset artifacts validated at {run_dir}")


if __name__ == "__main__":
    main()

