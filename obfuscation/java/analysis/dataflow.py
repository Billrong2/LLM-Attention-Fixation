from __future__ import annotations

import re


def find_assignments(line: str) -> set[str]:
    return set(re.findall(r"\b([A-Za-z_][A-Za-z0-9_]*)\s*=", line))
