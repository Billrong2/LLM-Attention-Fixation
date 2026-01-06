from __future__ import annotations

import re
from pathlib import Path
from typing import Optional


def model_dir_name(model_name: str) -> str:
    safe = re.sub(r"[^A-Za-z0-9._-]+", "_", (model_name or "").strip())
    return safe or "model"


def resolve_attn_root(project_root: Path, model_dir: Optional[str] = None) -> Path:
    attn_root = project_root / "attn_viz"
    if model_dir:
        return attn_root / model_dir
    if not attn_root.exists():
        return attn_root
    children = [d for d in attn_root.iterdir() if d.is_dir()]
    if not children:
        return attn_root
    # detect old vs new structure
    direct_baseline = any((child / "baseline").is_dir() for child in children)
    model_dirs = []
    for child in children:
        try:
            if any((grand / "baseline").is_dir() for grand in child.iterdir() if grand.is_dir()):
                model_dirs.append(child)
        except OSError:
            continue
    if model_dirs and not direct_baseline:
        if len(model_dirs) == 1:
            return model_dirs[0]
        raise RuntimeError(
            "Multiple model directories found under attn_viz; specify a model name."
        )
    if direct_baseline and not model_dirs:
        return attn_root
    if direct_baseline and model_dirs:
        raise RuntimeError(
            "Both legacy and model-namespaced attn_viz layouts found; specify a model name."
        )
    return attn_root
