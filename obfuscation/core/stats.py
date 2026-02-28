from __future__ import annotations

from dataclasses import dataclass


@dataclass
class Counter:
    total: int = 0
    applied: int = 0
    skipped: int = 0

    def to_dict(self) -> dict:
        return {"total": self.total, "applied": self.applied, "skipped": self.skipped}
