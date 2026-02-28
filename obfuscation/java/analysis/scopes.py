from __future__ import annotations

import re
from dataclasses import dataclass, field


@dataclass
class ScopeInfo:
    method_names: set[str] = field(default_factory=set)
    private_methods: set[str] = field(default_factory=set)


def extract_scope_info(source: str) -> ScopeInfo:
    info = ScopeInfo()
    for m in re.finditer(r"(?m)^\s*(public|private|protected)?\s*(static\s+)?[\w\[\]<>]+\s+([A-Za-z_][A-Za-z0-9_]*)\s*\(", source):
        name = m.group(3)
        info.method_names.add(name)
        if (m.group(1) or "") == "private":
            info.private_methods.add(name)
    return info
