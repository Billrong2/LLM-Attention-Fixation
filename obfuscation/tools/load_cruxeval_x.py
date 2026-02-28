#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import re
import shutil
from pathlib import Path

import pyarrow.parquet as pq
from huggingface_hub import snapshot_download


LANG_EXT = {
    "CS": ".cs",
    "Cpp": ".cpp",
    "D": ".d",
    "Go": ".go",
    "Java": ".java",
    "JavaScript": ".js",
    "Julia": ".jl",
    "Lua": ".lua",
    "PHP": ".php",
    "Perl": ".pl",
    "Python": ".py",
    "R": ".r",
    "Racket": ".rkt",
    "Ruby": ".rb",
    "Rust": ".rs",
    "Scala": ".scala",
    "Shell": ".sh",
    "Swift": ".swift",
    "TypeScript": ".ts",
}


def _slug_lang(name: str) -> str:
    return re.sub(r"[^A-Za-z0-9]+", "_", name).strip("_").lower()


def _rewrite_java_entry_class(source: str, class_name: str) -> str:
    updated, n = re.subn(
        r"\bpublic\s+class\s+([A-Za-z_][A-Za-z0-9_]*)",
        f"public class {class_name}",
        source,
        count=1,
    )
    if n == 0:
        updated, n = re.subn(
            r"\bclass\s+([A-Za-z_][A-Za-z0-9_]*)",
            f"class {class_name}",
            source,
            count=1,
        )
    if n > 0:
        # Keep simple consistency for references to the original class symbol.
        # We only rewrite when the first declaration exists.
        m = re.search(r"\bclass\s+([A-Za-z_][A-Za-z0-9_]*)", source)
        if m:
            old = m.group(1)
            updated = re.sub(rf"\b{re.escape(old)}\b", class_name, updated)
    return updated


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Download CruxEval-X, store raw parquet under Source/metadata/Cruxeval, "
            "and materialize standalone sample files under Source/Cruxeval."
        ),
    )
    parser.add_argument(
        "--dataset-root",
        type=Path,
        default=(Path(__file__).resolve().parents[2] / "Source" / "Cruxeval"),
        help="Target directory for standalone sample files.",
    )
    parser.add_argument(
        "--metadata-root",
        type=Path,
        default=(Path(__file__).resolve().parents[2] / "Source" / "metadata" / "Cruxeval"),
        help="Target directory for raw parquet metadata files.",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Overwrite dataset-root and metadata-root if they already exist.",
    )
    return parser.parse_args()


def main() -> None:
    args = parse_args()
    dataset_root = args.dataset_root.resolve()
    metadata_root = args.metadata_root.resolve()
    if args.force:
        if dataset_root.exists():
            shutil.rmtree(dataset_root)
        if metadata_root.exists():
            shutil.rmtree(metadata_root)
    dataset_root.mkdir(parents=True, exist_ok=True)
    metadata_root.mkdir(parents=True, exist_ok=True)

    snapshot = Path(snapshot_download(repo_id="xhwl/cruxeval-x", repo_type="dataset"))
    data_root = snapshot / "data"

    manifest: dict = {
        "dataset": "xhwl/cruxeval-x",
        "snapshot_path": str(snapshot),
        "dataset_root": str(dataset_root),
        "metadata_root": str(metadata_root),
        "languages": {},
    }

    readme_src = snapshot / "README.md"
    if readme_src.is_file():
        shutil.copy2(readme_src, metadata_root / "README.md")

    parquet_files = sorted(data_root.glob("*.parquet"))
    for parquet_path in parquet_files:
        lang_name = parquet_path.name.split("-00000-of-00001.parquet")[0]
        ext = LANG_EXT.get(lang_name)
        if ext is None:
            continue
        lang_slug = _slug_lang(lang_name)

        meta_lang_dir = metadata_root / lang_slug
        meta_lang_dir.mkdir(parents=True, exist_ok=True)
        raw_dst = meta_lang_dir / parquet_path.name
        shutil.copy2(parquet_path, raw_dst)

        table = pq.read_table(raw_dst)
        rows = table.to_pylist()
        width = max(3, len(str(max(0, len(rows) - 1))))

        out_lang_dir = dataset_root / lang_slug
        out_lang_dir.mkdir(parents=True, exist_ok=True)

        for idx, row in enumerate(rows):
            row_id = row.get("id", idx)
            label = f"{lang_name}_{int(row_id):0{width}d}"
            code = str(row.get("code", "")).rstrip() + "\n"
            if lang_name == "Java":
                code = _rewrite_java_entry_class(code, label)
            src_path = out_lang_dir / f"{label}{ext}"
            src_path.write_text(code, encoding="utf-8")

            sidecar = {
                "id": row_id,
                "label": label,
                "language": lang_name,
                "language_slug": lang_slug,
                "source_file": src_path.name,
                "has_input_reasoning": bool(row.get("input_reasoning")),
                "has_output_reasoning": bool(row.get("output_reasoning")),
            }
            (out_lang_dir / f"{label}.meta.json").write_text(
                json.dumps(sidecar, indent=2, sort_keys=True) + "\n",
                encoding="utf-8",
            )

        manifest["languages"][lang_slug] = {
            "language": lang_name,
            "raw_parquet": str(raw_dst.relative_to(metadata_root)),
            "rows": len(rows),
            "sample_dir": str(out_lang_dir.relative_to(dataset_root)),
            "extension": ext,
        }

    (metadata_root / "manifest.json").write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    print(f"[OK] CruxEval-X metadata: {metadata_root}")
    print(f"[OK] CruxEval-X standalone samples: {dataset_root}")


if __name__ == "__main__":
    main()
