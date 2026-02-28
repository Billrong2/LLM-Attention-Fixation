from __future__ import annotations

import base64
import re

from ...core.pass_base import ObfuscationPass, PassContext
from .utils import insert_before_class_end, iter_method_blocks


class T3ConstHidePass(ObfuscationPass):
    name = "T3"
    applies_to_lang = {"java"}

    @staticmethod
    def _rewrite_non_literals(text: str, repl_fn) -> str:
        lit_pat = re.compile(r'"(?:\\.|[^"\\])*"|\'(?:\\.|[^\'\\])*\'')
        out: list[str] = []
        pos = 0
        for m in lit_pat.finditer(text):
            if m.start() > pos:
                out.append(repl_fn(text[pos : m.start()]))
            out.append(m.group(0))
            pos = m.end()
        if pos < len(text):
            out.append(repl_fn(text[pos:]))
        return "".join(out)

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = str(setting.get("tier", "easy")).lower()
        rate = float(setting.get("target_rate", 0.5))

        out = source
        changes = 0
        helper_name = f"_obf_t3_dec_{ctx.rng.fork('helper').randint(1000, 999999)}"
        need_helper = False
        blocks = iter_method_blocks(out)
        for b in sorted(blocks, key=lambda x: x.start, reverse=True):
            body = out[b.body_start + 1 : b.end]
            local_changes = 0

            def repl_string(m: re.Match[str]) -> str:
                nonlocal need_helper
                nonlocal local_changes
                inner = m.group(1)
                if not ctx.rng.weighted_bool(rate):
                    return m.group(0)
                local_changes += 1
                if tier == "easy":
                    return f'("" + "{inner}")'
                try:
                    decoded = bytes(inner, "utf-8").decode("unicode_escape")
                except Exception:
                    decoded = inner
                enc = base64.b64encode(decoded.encode("utf-8")).decode("ascii")
                need_helper = True
                return f'{helper_name}("{enc}")'

            new_body = re.sub(r'"((?:\\.|[^"\\])*)"', repl_string, body)

            if tier == "hard":
                local_rng = ctx.rng.fork(f"{b.name}:{b.start}")

                def int_repl(m: re.Match[str]) -> str:
                    nonlocal local_changes
                    raw = m.group(1)
                    if not local_rng.weighted_bool(rate):
                        return raw
                    k = local_rng.randint(3, 63)
                    local_changes += 1
                    return f"((({raw}) ^ {k}) ^ {k})"

                def rewrite(chunk: str) -> str:
                    return re.sub(r"(?<![A-Za-z0-9_\\.])(-?\d+)(?![A-Za-z0-9_\\.])", int_repl, chunk)

                new_body = self._rewrite_non_literals(new_body, rewrite)

            if local_changes > 0 and new_body != body:
                out = out[: b.body_start + 1] + new_body + out[b.end:]
                changes += local_changes

        helpers = 0
        if need_helper:
            helper = (
                f"    private static String {helper_name}(String x) {{\n"
                f"        return new String(java.util.Base64.getDecoder().decode(x));\n"
                f"    }}"
            )
            out = insert_before_class_end(out, helper)
            helpers = 1

        if changes == 0:
            return source, False, "no_literals_selected", 0, 0
        return out, True, f"constants_hidden:{changes}", changes, helpers
