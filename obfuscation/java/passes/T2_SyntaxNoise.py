from __future__ import annotations

import re

from ...core.pass_base import ObfuscationPass, PassContext
from .utils import iter_method_blocks


class T2SyntaxNoisePass(ObfuscationPass):
    name = "T2"
    applies_to_lang = {"java"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = str(setting.get("tier", "easy")).lower()
        rate = float(setting.get("target_rate", 0.5))

        out = source
        changes = 0
        blocks = iter_method_blocks(out)
        for b in sorted(blocks, key=lambda x: x.start, reverse=True):
            body = out[b.body_start + 1 : b.end]
            local_changes = 0

            def repl_return(m: re.Match[str]) -> str:
                nonlocal local_changes
                expr = m.group(1).strip()
                if '"' in expr:
                    return m.group(0)
                if not ctx.rng.weighted_bool(rate):
                    return m.group(0)
                local_changes += 1
                return f"return (({expr}));"

            new_body = re.sub(r"return\s+([^;]+);", repl_return, body)

            if tier == "hard" and ctx.rng.weighted_bool(rate):
                marker = ctx.rng.fork(f"{b.name}:{b.start}").randint(1000, 999999)
                prefix = (
                    f"\n            if (((2 * 2) == 4)) {{\n"
                    f"                int _obf_t2_{marker} = 0;\n"
                    f"                _obf_t2_{marker} += 0;\n"
                    f"            }}\n"
                )
                new_body = prefix + new_body.lstrip("\n")
                local_changes += 1

            if local_changes > 0 and new_body != body:
                out = out[: b.body_start + 1] + new_body + out[b.end:]
                changes += local_changes

        if changes == 0:
            return source, False, "no_candidates", 0, 0
        return out, True, f"syntax_noise:{changes}", changes, 0
