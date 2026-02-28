from __future__ import annotations


def print_source(source: str) -> str:
    return source if source.endswith("\n") else source + "\n"


def inject_helpers(source: str, helpers_block: str) -> str:
    if not helpers_block.strip():
        return source
    idx = source.rfind("}")
    if idx == -1:
        return source
    insertion = "\n\n" + helpers_block.strip() + "\n"
    return source[:idx] + insertion + source[idx:]
