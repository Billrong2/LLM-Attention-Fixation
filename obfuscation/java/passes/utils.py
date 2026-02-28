from __future__ import annotations

import base64
import re
from dataclasses import dataclass
from typing import Any

from ...core.rng import DeterministicRNG
JAVA_RESERVED = {
    "abstract", "assert", "boolean", "break", "byte", "case", "catch", "char", "class", "const", "continue",
    "default", "do", "double", "else", "enum", "extends", "final", "finally", "float", "for", "goto", "if",
    "implements", "import", "instanceof", "int", "interface", "long", "native", "new", "package", "private",
    "protected", "public", "return", "short", "static", "strictfp", "super", "switch", "synchronized", "this",
    "throw", "throws", "transient", "try", "void", "volatile", "while", "true", "false", "null",
}
JAVA_MODIFIERS = {
    "public",
    "private",
    "protected",
    "static",
    "final",
    "abstract",
    "native",
    "synchronized",
    "strictfp",
}


@dataclass
class MethodBlock:
    name: str
    visibility: str
    return_type: str
    params: str
    is_static: bool
    start: int
    body_start: int
    end: int


def find_class_name(source: str) -> str | None:
    m = re.search(r"\bclass\s+([A-Za-z_][A-Za-z0-9_]*)", source)
    return m.group(1) if m else None


def _find_matching_brace(text: str, open_idx: int) -> int:
    depth = 0
    for i in range(open_idx, len(text)):
        c = text[i]
        if c == "{":
            depth += 1
        elif c == "}":
            depth -= 1
            if depth == 0:
                return i
    return -1


def iter_method_blocks(source: str) -> list[MethodBlock]:
    blocks: list[MethodBlock] = []
    pat = re.compile(
        r"(?m)^\s*(public|private|protected)?\s*(static\s+)?([A-Za-z_][A-Za-z0-9_<>\[\]]*)\s+([A-Za-z_][A-Za-z0-9_]*)\s*\(([^)]*)\)\s*\{"
    )
    for m in pat.finditer(source):
        rtype = (m.group(3) or "").strip()
        if rtype in JAVA_MODIFIERS:
            # Common constructor/modifier mis-match in regex-only parsing.
            continue
        body_open = source.find("{", m.start())
        body_end = _find_matching_brace(source, body_open)
        if body_open < 0 or body_end < 0:
            continue
        blocks.append(
            MethodBlock(
                name=m.group(4),
                visibility=(m.group(1) or "").strip(),
                return_type=rtype,
                params=(m.group(5) or "").strip(),
                is_static=bool((m.group(2) or "").strip()),
                start=m.start(),
                body_start=body_open,
                end=body_end,
            )
        )
    return blocks


def replace_method_body(source: str, block: MethodBlock, new_body_inner: str) -> str:
    open_brace = block.body_start
    close_brace = block.end
    inner = "\n" + new_body_inner.strip("\n") + "\n"
    return source[: open_brace + 1] + inner + source[close_brace:]


def safe_identifier(name: str) -> bool:
    if not re.match(r"^[A-Za-z_][A-Za-z0-9_]*$", name):
        return False
    return name not in JAVA_RESERVED


def word_replace(text: str, mapping: dict[str, str]) -> str:
    if not mapping:
        return text
    pat = re.compile(r"\b(" + "|".join(re.escape(k) for k in sorted(mapping, key=len, reverse=True)) + r")\b")
    return pat.sub(lambda m: mapping[m.group(1)], text)


def word_replace_outside_literals(text: str, mapping: dict[str, str], skip_after_dot: bool = False) -> str:
    if not mapping:
        return text
    if not skip_after_dot:
        replace_fn = lambda chunk: word_replace(chunk, mapping)
    else:
        keys = sorted(mapping, key=len, reverse=True)
        pat = re.compile(r"\b(" + "|".join(re.escape(k) for k in keys) + r")\b")

        def replace_fn(chunk: str) -> str:
            def repl(m: re.Match[str]) -> str:
                start = m.start()
                if start > 0 and chunk[start - 1] == ".":
                    return m.group(0)
                return mapping[m.group(1)]

            return pat.sub(repl, chunk)

    # Keep string and char literals intact while replacing identifiers elsewhere.
    lit_pat = re.compile(r'"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'')
    out: list[str] = []
    pos = 0
    for m in lit_pat.finditer(text):
        if m.start() > pos:
            out.append(replace_fn(text[pos : m.start()]))
        out.append(m.group(0))
        pos = m.end()
    if pos < len(text):
        out.append(replace_fn(text[pos:]))
    return "".join(out)


def encode_b64_string(content: str) -> str:
    return base64.b64encode(content.encode("utf-8")).decode("ascii")


def parse_param_names(params: str) -> list[str]:
    out: list[str] = []
    if not params.strip():
        return out
    for p in params.split(","):
        p = p.strip()
        if not p:
            continue
        toks = p.split()
        if toks:
            name = toks[-1]
            if name.endswith("[]"):
                name = name[:-2]
            name = name.replace("...", "")
            if safe_identifier(name):
                out.append(name)
    return out


def insert_before_class_end(source: str, injection: str) -> str:
    if not injection.strip():
        return source
    idx = source.rfind("}")
    if idx == -1:
        return source
    block = "\n\n" + injection.strip() + "\n"
    return source[:idx] + block + source[idx:]


def _method_snapshots(source: str) -> list[dict[str, Any]]:
    blocks = iter_method_blocks(source)
    snaps: list[dict[str, Any]] = []
    for i, b in enumerate(blocks):
        full = source[b.start : b.end + 1]
        body = source[b.body_start + 1 : b.end]
        snaps.append(
            {
                "index": i,
                "name": b.name,
                "full": full,
                "body": body,
            }
        )
    return snaps


def method_coverage_stats(original_source: str, transformed_source: str) -> dict[str, Any]:
    before = _method_snapshots(original_source)
    after = _method_snapshots(transformed_source)
    total = len(before)
    touched = 0
    untouched_methods: list[str] = []
    main_touched = False

    n = min(len(before), len(after))
    for i in range(n):
        b = before[i]
        a = after[i]
        changed = b["full"] != a["full"]
        if changed:
            touched += 1
        else:
            untouched_methods.append(str(b["name"]))
        if b["name"] == "main" and changed:
            main_touched = True

    # If counts differ unexpectedly, mark extras as touched/untouched conservatively.
    if len(after) > len(before):
        touched += len(after) - len(before)
    elif len(before) > len(after):
        for i in range(len(after), len(before)):
            untouched_methods.append(str(before[i]["name"]))

    return {
        "method_coverage_total": total,
        "method_coverage_touched": touched,
        "main_touched": main_touched,
        "untouched_methods": untouched_methods,
    }


def _inject_noop_into_body(body: str, pass_name: str, method_name: str, rng: DeterministicRNG) -> str:
    indent = "    "
    for ln in body.splitlines():
        if ln.strip():
            indent = ln[: len(ln) - len(ln.lstrip())]
            break

    token = rng.randint(1000, 999999)
    var = f"_obf_{pass_name.lower()}_{method_name}_{token}"
    var = re.sub(r"[^A-Za-z0-9_]", "_", var)
    while re.search(rf"\b{re.escape(var)}\b", body):
        token = rng.randint(1000, 999999)
        var = f"_obf_{pass_name.lower()}_{method_name}_{token}"
        var = re.sub(r"[^A-Za-z0-9_]", "_", var)
    noop = f"{indent}int {var} = 0; {var} += 0;"
    core = body.lstrip("\n")
    if core:
        return "\n" + noop + "\n" + core
    return "\n" + noop + "\n"


def enforce_method_coverage(
    original_source: str,
    transformed_source: str,
    pass_name: str,
    rng: DeterministicRNG,
) -> tuple[str, int]:
    before = _method_snapshots(original_source)
    out = transformed_source
    after_blocks = iter_method_blocks(out)
    n = min(len(before), len(after_blocks))
    fallback_insertions = 0
    targets: list[int] = []
    for i in range(n):
        b = before[i]
        a = after_blocks[i]
        full_after = out[a.start : a.end + 1]
        if b["full"] == full_after:
            targets.append(i)

    for idx in reversed(targets):
        block = after_blocks[idx]
        body = out[block.body_start + 1 : block.end]
        touched_body = _inject_noop_into_body(
            body=body,
            pass_name=pass_name,
            method_name=block.name,
            rng=rng.fork(f"{block.name}:{idx}"),
        )
        out = out[: block.body_start + 1] + touched_body + out[block.end :]
        fallback_insertions += 1
    return out, fallback_insertions
