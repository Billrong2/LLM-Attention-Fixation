from __future__ import annotations

import json
from dataclasses import asdict, dataclass, field
from pathlib import Path
from typing import Any


@dataclass
class EquivalenceMetadata:
    stdout_match: bool
    stderr_match: bool
    exit_match: bool
    details: str = ""


@dataclass
class ObfuscationMetadata:
    program_id: str
    language: str
    profile_name: str
    mode: str
    level: str | None
    technique: str | None
    difficulty: str | None
    seed: int
    passes_applied: list[dict[str, Any]]
    budgets: dict[str, Any]
    metrics: dict[str, Any]
    skipped_passes_with_reasons: list[dict[str, str]]
    equivalence: dict[str, Any]
    original_class_name: str | None = None
    obfuscated_class_name: str | None = None
    class_renamed: bool = False
    method_coverage_total: int = 0
    method_coverage_touched: int = 0
    main_touched: bool = False
    untouched_methods: list[str] = field(default_factory=list)


@dataclass
class ObfuscationResult:
    source: str
    metadata: ObfuscationMetadata


def write_metadata(path: Path, metadata: ObfuscationMetadata) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as f:
        json.dump(asdict(metadata), f, indent=2, sort_keys=True)
