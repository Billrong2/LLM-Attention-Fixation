from __future__ import annotations

import re

from ...core.pass_base import ObfuscationPass, PassContext
from .utils import iter_method_blocks


class T5BogusCFPass(ObfuscationPass):
    name = "T5"
    applies_to_lang = {"java"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = str(setting.get("tier", "easy")).lower()
        rate = float(setting.get("target_rate", 0.45))
        if tier == "hard":
            rate = min(rate, 0.35)
        elif tier == "med":
            rate = min(rate, 0.45)
        else:
            rate = min(rate, 0.6)

        out = source
        changes = 0
        blocks = iter_method_blocks(out)
        for b in sorted(blocks, key=lambda x: x.start, reverse=True):
            if not ctx.rng.weighted_bool(rate):
                continue
            body = out[b.body_start + 1 : b.end]

            indent = "        "
            for ln in body.splitlines():
                if ln.strip():
                    indent = ln[: len(ln) - len(ln.lstrip())]
                    break

            salt = re.sub(r"[^A-Za-z0-9_]", "_", b.name)
            token = ctx.rng.fork(f"{b.name}:{b.start}").randint(1000, 999999)
            v = f"_obf_t5_{salt}_{token}"

            snippets: list[str] = []
            snippets.append(
                f"{indent}if (((3 * 3) - 9) != 0) {{\n"
                f"{indent}    int {v} = 0;\n"
                f"{indent}    {v}++;\n"
                f"{indent}}}"
            )

            if tier in {"med", "hard"}:
                snippets.append(
                    f"{indent}if (((2 * 2) + 1) > 0) {{\n"
                    f"{indent}    int {v}_m = 0;\n"
                    f"{indent}    {v}_m += 0;\n"
                    f"{indent}}} else {{\n"
                    f"{indent}    int {v}_e = 1;\n"
                    f"{indent}    {v}_e -= 1;\n"
                    f"{indent}}}"
                )

            if tier == "hard":
                snippets.append(
                    f"{indent}int {v}_h = (1 ^ 1);\n"
                    f"{indent}if ({v}_h != 0) {{\n"
                    f"{indent}    {v}_h += 1;\n"
                    f"{indent}}}"
                )

            prefix = "\n" + "\n".join(snippets) + "\n"
            new_body = prefix + body.lstrip("\n")
            if new_body != body:
                out = out[: b.body_start + 1] + new_body + out[b.end:]
                changes += len(snippets)

        if changes == 0:
            return source, False, "no_bogus_insertions", 0, 0
        return out, True, f"bogus_cf:{changes}", changes, 0
