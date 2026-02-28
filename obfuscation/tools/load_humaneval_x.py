#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import re
import shutil
from pathlib import Path

from huggingface_hub import snapshot_download


LANG_EXT = {
    "python": ".py",
    "java": ".java",
    "cpp": ".cpp",
    "js": ".js",
    "go": ".go",
}


def _count_jsonl_rows(path: Path) -> int:
    count = 0
    with path.open("r", encoding="utf-8") as fh:
        for line in fh:
            if line.strip():
                count += 1
    return count


def _task_label(task_id: str) -> str:
    raw = (task_id or "").strip()
    parts = raw.split("/", 1)
    if len(parts) == 2 and parts[1].isdigit():
        prefix = re.sub(r"[^A-Za-z0-9_]+", "_", parts[0]).strip("_") or "Task"
        return f"{prefix}_{int(parts[1]):03d}"
    label = re.sub(r"[^A-Za-z0-9_]+", "_", raw).strip("_")
    return label or "Task_000"


def _rewrite_java_entry_class(source: str, class_name: str) -> str:
    # Prefer replacing the test harness public class (usually "Main"), so filename/class align.
    updated, n = re.subn(
        r"\bpublic\s+class\s+([A-Za-z_][A-Za-z0-9_]*)",
        f"public class {class_name}",
        source,
        count=1,
    )
    if n > 0:
        return updated
    updated, _ = re.subn(
        r"\bclass\s+([A-Za-z_][A-Za-z0-9_]*)",
        f"class {class_name}",
        source,
        count=1,
    )
    return updated


def _compose_source(row: dict, lang: str, label: str) -> str:
    chunks: list[str] = []
    for key in ("prompt", "canonical_solution", "test"):
        val = row.get(key)
        if isinstance(val, str) and val.strip():
            chunks.append(val.rstrip())
    code = ("\n\n".join(chunks)).rstrip() + "\n"
    if lang == "java":
        code = _rewrite_java_entry_class(code, label)
    return code


def parse_args() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Download HumanEval-X, store raw JSONL under Source/metadata/Humaneval, "
            "and materialize standalone sample files under Source/Humaneval."
        ),
    )
    parser.add_argument(
        "--dataset-root",
        type=Path,
        default=(Path(__file__).resolve().parents[2] / "Source" / "Humaneval"),
        help="Target directory for standalone sample files.",
    )
    parser.add_argument(
        "--metadata-root",
        type=Path,
        default=(Path(__file__).resolve().parents[2] / "Source" / "metadata" / "Humaneval"),
        help="Target directory for raw metadata JSONL files.",
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

    snapshot = Path(
        snapshot_download(repo_id="THUDM/humaneval-x", repo_type="dataset")
    )

    manifest = {
        "dataset": "THUDM/humaneval-x",
        "snapshot_path": str(snapshot),
        "dataset_root": str(dataset_root),
        "metadata_root": str(metadata_root),
        "languages": {},
    }

    readme_src = snapshot / "README.md"
    if readme_src.is_file():
        shutil.copy2(readme_src, metadata_root / "README.md")

    for lang, ext in LANG_EXT.items():
        src = snapshot / "data" / lang / "data" / "humaneval.jsonl"
        if not src.is_file():
            continue

        meta_lang_dir = metadata_root / lang
        meta_lang_dir.mkdir(parents=True, exist_ok=True)
        raw_jsonl = meta_lang_dir / "humaneval.jsonl"
        shutil.copy2(src, raw_jsonl)

        dataset_lang_dir = dataset_root / lang
        dataset_lang_dir.mkdir(parents=True, exist_ok=True)

        written = 0
        with raw_jsonl.open("r", encoding="utf-8") as fh:
            for line in fh:
                if not line.strip():
                    continue
                row = json.loads(line)
                task_id = str(row.get("task_id", f"{lang}/{written}"))
                label = _task_label(task_id)
                code = _compose_source(row, lang, label)
                sample_path = dataset_lang_dir / f"{label}{ext}"
                sample_path.write_text(code, encoding="utf-8")

                sidecar = {
                    "task_id": task_id,
                    "label": label,
                    "language": lang,
                    "entry_point": row.get("entry_point"),
                    "source_file": sample_path.name,
                }
                (dataset_lang_dir / f"{label}.meta.json").write_text(
                    json.dumps(sidecar, indent=2, sort_keys=True) + "\n",
                    encoding="utf-8",
                )
                written += 1

        manifest["languages"][lang] = {
            "raw_jsonl": str(raw_jsonl.relative_to(metadata_root)),
            "rows": _count_jsonl_rows(raw_jsonl),
            "samples_written": written,
            "sample_dir": str(dataset_lang_dir.relative_to(dataset_root)),
        }

    (metadata_root / "manifest.json").write_text(
        json.dumps(manifest, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )
    print(f"[OK] HumanEval-X metadata: {metadata_root}")
    print(f"[OK] HumanEval-X standalone samples: {dataset_root}")


if __name__ == "__main__":
    main()
