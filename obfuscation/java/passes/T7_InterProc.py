from __future__ import annotations

import re

from ...core.pass_base import ObfuscationPass, PassContext
from .utils import insert_before_class_end, iter_method_blocks


class T7InterProcPass(ObfuscationPass):
    name = "T7"
    applies_to_lang = {"java"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = str(setting.get("tier", "easy")).lower()
        rate = float(setting.get("target_rate", 0.3))

        out = source
        changes = 0
        helper_defs: list[str] = []
        helper_count = 0

        blocks = iter_method_blocks(out)
        for idx, b in enumerate(sorted(blocks, key=lambda x: x.start, reverse=True)):
            if not ctx.rng.weighted_bool(rate):
                continue
            body = out[b.body_start + 1 : b.end]
            indent = "        "
            for ln in body.splitlines():
                if ln.strip():
                    indent = ln[: len(ln) - len(ln.lstrip())]
                    break

            salt = re.sub(r"[^A-Za-z0-9_]", "_", b.name)
            hid = ctx.rng.fork(f"{b.name}:{b.start}").randint(1000, 999999)
            hname = f"_obf_t7_hook_{salt}_{hid}"
            static_kw = "static " if b.is_static else ""
            helper_defs.append(
                f"    private {static_kw}void {hname}() {{\n"
                f"        int _obf_t7_{hid} = 0;\n"
                f"        _obf_t7_{hid} += 0;\n"
                f"    }}"
            )
            helper_count += 1

            call_stmt = f"\n{indent}{hname}();\n"
            new_body = call_stmt + body.lstrip("\n")
            out = out[: b.body_start + 1] + new_body + out[b.end:]
            changes += 1

        if helper_defs:
            out = insert_before_class_end(out, "\n\n".join(helper_defs))

        if changes == 0:
            return source, False, "no_interproc_changes", 0, 0
        return out, True, f"interproc_changes:{changes}", changes, helper_count
