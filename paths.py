from __future__ import annotations

import os
import re
from pathlib import Path
from typing import Optional


DEFAULT_ARTIFACT_ROOT = Path("/data/xxr230000/eyetracking")


def model_dir_name(model_name: str) -> str:
    safe = re.sub(r"[^A-Za-z0-9._-]+", "_", (model_name or "").strip())
    return safe or "model"


def resolve_artifact_root(project_root: Path) -> Path:
    env_root = os.getenv("EYETRACKING_DATA_ROOT", "").strip()
    if env_root:
        return Path(env_root).expanduser()

    project_posix = project_root.as_posix()
    if project_posix.startswith("/people/cs/x/xxr230000/eyetracking"):
        return DEFAULT_ARTIFACT_ROOT

    if os.name == "posix" and DEFAULT_ARTIFACT_ROOT.parent.exists():
        return DEFAULT_ARTIFACT_ROOT

    return project_root


def resolve_artifact_path(project_root: Path, path: Path | str) -> Path:
    resolved = Path(path).expanduser()
    if resolved.is_absolute():
        return resolved
    return resolve_artifact_root(project_root) / resolved


def resolve_eval_root(project_root: Path) -> Path:
    return resolve_artifact_root(project_root) / "eval"


def resolve_head_mask_root(project_root: Path) -> Path:
    return resolve_artifact_root(project_root) / "steering" / "head_masks"


def resolve_alignment_outputs_root(project_root: Path) -> Path:
    return resolve_artifact_root(project_root) / "alignment" / "outputs"


def resolve_attn_root(
    project_root: Path,
    model_dir: Optional[str] = None,
    *,
    for_write: bool = False,
) -> Path:
    attn_root = resolve_artifact_root(project_root) / "attn_viz"
    if not for_write and not attn_root.exists():
        legacy_attn_root = project_root / "attn_viz"
        if legacy_attn_root.exists():
            attn_root = legacy_attn_root
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
