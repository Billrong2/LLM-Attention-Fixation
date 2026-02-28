from __future__ import annotations

import argparse
import json
from pathlib import Path

from ..core.metadata import write_metadata
from ..core.pipeline import obfuscate_program


def main() -> None:
    ap = argparse.ArgumentParser(description="Replay obfuscation from metadata seed/config.")
    ap.add_argument("--meta", required=True)
    ap.add_argument("--input", required=True)
    ap.add_argument("--out", required=True)
    ap.add_argument("--config-root", default="eyetracking/obfuscation")
    args = ap.parse_args()

    meta = json.loads(Path(args.meta).read_text(encoding="utf-8"))
    source = Path(args.input).read_text(encoding="utf-8")
    result = obfuscate_program(
        source=source,
        language=meta["language"],
        profile=meta["profile_name"],
        seed=int(meta["seed"]),
        mode=meta.get("mode", "level"),
        level=meta.get("level"),
        technique=meta.get("technique"),
        difficulty=meta.get("difficulty"),
        program_id=meta["program_id"],
        config_root=Path(args.config_root),
    )
    out_path = Path(args.out)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    out_path.write_text(result.source, encoding="utf-8")
    write_metadata(out_path.with_suffix(out_path.suffix + ".meta.json"), result.metadata)


if __name__ == "__main__":
    main()
