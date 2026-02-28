from __future__ import annotations

import re


def expression_looks_pure(expr: str) -> bool:
    if re.search(r"\b(new|throw|return|System\.|Random\b)\b", expr):
        return False
    if "(" in expr and ")" in expr:
        return False
    return True
