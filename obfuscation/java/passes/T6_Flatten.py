from __future__ import annotations

import re

from ...core.pass_base import ObfuscationPass, PassContext
from .utils import iter_method_blocks


class T6FlattenPass(ObfuscationPass):
    name = "T6"
    applies_to_lang = {"java"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = str(setting.get("tier", "easy")).lower()
        rate = float(setting.get("target_rate", 0.35))
        if tier == "hard":
            rate = min(rate, 0.35)
        elif tier == "med":
            rate = min(rate, 0.5)
        else:
            rate = min(rate, 0.7)

        out = source
        changes = 0
        blocks = iter_method_blocks(out)
        for b in sorted(blocks, key=lambda x: x.start, reverse=True):
            if not ctx.rng.weighted_bool(rate):
                continue
            body = out[b.body_start + 1 : b.end]
            if not body.strip():
                continue

            indent = "        "
            for ln in body.splitlines():
                if ln.strip():
                    indent = ln[: len(ln) - len(ln.lstrip())]
                    break

            seed_rng = ctx.rng.fork(f"{b.name}:{b.start}")
            sid = seed_rng.randint(1000, 999999)
            state_var = re.sub(r"[^A-Za-z0-9_]", "_", f"_obf_t6_state_{b.name}_{sid}")

            stripped = body.strip("\n")
            body_lines = stripped.splitlines()
            nested = "\n".join(f"{indent}            {ln.lstrip()}" for ln in body_lines if ln is not None)

            if tier == "easy":
                wrapped = (
                    f"\n{indent}do {{\n"
                    f"{indent}    {{\n"
                    f"{indent}        int _obf_t6_easy_{sid} = 0;\n"
                    f"{indent}        _obf_t6_easy_{sid} += 0;\n"
                    f"{nested}\n"
                    f"{indent}    }}\n"
                    f"{indent}}} while (false);\n"
                )
            elif tier == "med":
                wrapped = (
                    f"\n{indent}int {state_var} = 0;\n"
                    f"{indent}while ({state_var} == 0) {{\n"
                    f"{indent}    {state_var} = 1;\n"
                    f"{indent}    break;\n"
                    f"{indent}}}\n"
                    f"{indent}do {{\n"
                    f"{nested}\n"
                    f"{indent}}} while (false);\n"
                )
            else:
                wrapped = (
                    f"\n{indent}int {state_var} = 0;\n"
                    f"{indent}while ({state_var} == 0) {{\n"
                    f"{indent}    {state_var} = 1;\n"
                    f"{indent}    break;\n"
                    f"{indent}}}\n"
                    f"{indent}if (({state_var} ^ 1) < 0) {{\n"
                    f"{indent}    int _obf_t6_guard_{sid} = 0;\n"
                    f"{indent}    _obf_t6_guard_{sid} += 0;\n"
                    f"{indent}}}\n"
                    f"{indent}do {{\n"
                    f"{nested}\n"
                    f"{indent}}} while (false);\n"
                )

            out = out[: b.body_start + 1] + wrapped + out[b.end:]
            changes += 1

        if changes == 0:
            return source, False, "no_regions_selected", 0, 0
        return out, True, f"flattened_methods:{changes}", changes, 0
