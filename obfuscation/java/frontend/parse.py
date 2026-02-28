from __future__ import annotations

import javalang


def parse_source(source: str):
    return javalang.parse.parse(source)


def syntax_valid(source: str) -> tuple[bool, str]:
    try:
        parse_source(source)
        return True, "ok"
    except Exception as exc:  # pragma: no cover - parser errors are data dependent
        return False, str(exc)
