from __future__ import annotations

from dataclasses import dataclass
from pathlib import Path
from typing import Any

import yaml

from .budget import BudgetConfig


@dataclass
class PassSetting:
    tier: str = "easy"
    target_rate: float = 1.0
    intensity: float = 1.0
    enabled: bool = True


@dataclass
class ProfileConfig:
    name: str
    budget: BudgetConfig
    python_allow_exec: bool = False
    java_allow_reflection: bool = False


@dataclass
class LevelConfig:
    name: str
    pass_order: list[str]
    passes: dict[str, PassSetting]
    shuffle_group: list[str]


def _load_yaml(path: Path) -> dict[str, Any]:
    with path.open("r", encoding="utf-8") as f:
        return yaml.safe_load(f) or {}


def _parse_budget(d: dict[str, Any]) -> BudgetConfig:
    return BudgetConfig(
        max_new_ast_nodes_percent=float(d.get("max_new_ast_nodes_percent", 200.0)),
        max_new_helpers=int(d.get("max_new_helpers", 16)),
        max_expr_depth_increase=int(d.get("max_expr_depth_increase", 6)),
        max_cfg_states_for_flattening=int(d.get("max_cfg_states_for_flattening", 24)),
        max_added_branches_per_100_stmts=int(d.get("max_added_branches_per_100_stmts", 40)),
    )


def load_level_config(root: Path, language: str, level: str, profile: str) -> tuple[LevelConfig, ProfileConfig]:
    path = root / "profiles" / language / f"{level.lower()}.yaml"
    if not path.exists():
        raise FileNotFoundError(f"Missing level config: {path}")
    raw = _load_yaml(path)

    profiles = raw.get("profiles", {})
    if profile not in profiles:
        raise KeyError(f"Profile '{profile}' not found in {path}")

    prof_raw = profiles[profile]
    pass_order = list(raw.get("pass_order", []))

    passes: dict[str, PassSetting] = {}
    for k, v in (raw.get("passes", {}) or {}).items():
        passes[k] = PassSetting(
            tier=str(v.get("tier", "easy")),
            target_rate=float(v.get("target_rate", 1.0)),
            intensity=float(v.get("intensity", 1.0)),
            enabled=bool(v.get("enabled", True)),
        )

    level_cfg = LevelConfig(
        name=level.lower(),
        pass_order=pass_order,
        passes=passes,
        shuffle_group=list(raw.get("shuffle_group", [])),
    )
    profile_cfg = ProfileConfig(
        name=profile,
        budget=_parse_budget(prof_raw.get("budget", {})),
        python_allow_exec=bool(prof_raw.get("python_allow_exec", False)),
        java_allow_reflection=bool(prof_raw.get("java_allow_reflection", False)),
    )
    return level_cfg, profile_cfg


def default_level_for_mode(mode: str) -> str:
    if mode == "level":
        return "level0"
    return "level1"
