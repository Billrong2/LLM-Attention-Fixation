from __future__ import annotations

import re

from ...core.pass_base import ObfuscationPass, PassContext
from .utils import iter_method_blocks


class T4ExprSubstPass(ObfuscationPass):
    name = "T4"
    applies_to_lang = {"java"}

    @staticmethod
    def _rewrite_non_literals(text: str, repl_fn):
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
        rate = float(setting.get("target_rate", 0.6))
        if tier == "hard":
            rate = min(rate, 0.45)
        elif tier == "med":
            rate = min(rate, 0.6)
        else:
            rate = min(rate, 0.75)

        out = source
        changes = 0
        blocks = iter_method_blocks(out)
        for b in sorted(blocks, key=lambda x: x.start, reverse=True):
            body = out[b.body_start + 1 : b.end]
            local_rng = ctx.rng.fork(f"{b.name}:{b.start}")
            local_changes = 0

            def rewrite(chunk: str) -> str:
                nonlocal local_changes

                def bool_repl(m: re.Match[str]) -> str:
                    nonlocal local_changes
                    tok = m.group(0)
                    if not local_rng.weighted_bool(rate):
                        return tok
                    local_changes += 1
                    if tok == "true":
                        return "((1 ^ 0) == 1)"
                    return "((1 ^ 0) != 1)"

                chunk2 = re.sub(r"\b(?:true|false)\b", bool_repl, chunk)

                def int_repl(m: re.Match[str]) -> str:
                    nonlocal local_changes
                    raw = m.group(1)
                    if not local_rng.weighted_bool(rate):
                        return raw
                    local_changes += 1
                    if tier == "easy":
                        return f"(({raw}) + 0)"
                    if tier == "med":
                        k = local_rng.randint(2, 31)
                        return f"((({raw}) ^ {k}) ^ {k})"
                    k1 = local_rng.randint(2, 63)
                    return f"(((({raw}) ^ {k1}) ^ {k1}) + 0)"

                # Integer-like literals only; skip fractional/scientific forms.
                return re.sub(r"(?<![A-Za-z0-9_\\.])(-?\d+)(?![A-Za-z0-9_\\.])", int_repl, chunk2)

            new_body = self._rewrite_non_literals(body, rewrite)
            if local_changes > 0 and new_body != body:
                out = out[: b.body_start + 1] + new_body + out[b.end:]
                changes += local_changes

        if changes == 0:
            return source, False, "no_expr_candidates", 0, 0
        return out, True, f"expr_subst:{changes}", changes, 0
