from __future__ import annotations

import re

from ...core.pass_base import ObfuscationPass, PassContext
from .utils import insert_before_class_end, iter_method_blocks, parse_param_names


class T8CallIndirectionPass(ObfuscationPass):
    name = "T8"
    applies_to_lang = {"java"}

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = str(setting.get("tier", "easy")).lower()
        rate = float(setting.get("target_rate", 0.4))

        out = source
        blocks = iter_method_blocks(out)
        if not blocks:
            return source, False, "no_methods", 0, 0

        # Build one deterministic wrapper per unique method name.
        candidates = [b for b in blocks if b.name != "main" and not b.name.startswith("_obf_t8_")]
        by_name: dict[str, object] = {}
        for b in candidates:
            if b.name in by_name:
                continue
            if not ctx.rng.fork(f"{b.name}:{b.start}").weighted_bool(rate):
                continue
            by_name[b.name] = b

        if not by_name:
            return source, False, "no_calls_selected", 0, 0

        wrappers: list[str] = []
        mapping: dict[str, str] = {}
        helper_count = 0

        for name, b in by_name.items():
            hid = ctx.rng.fork(f"w:{name}:{b.start}").randint(1000, 999999)
            w1 = f"_obf_t8_{name}_{hid}"
            static_kw = "static " if b.is_static else ""
            args = parse_param_names(b.params)
            arglist = ", ".join(args)
            call_target = f"{name}({arglist})" if b.is_static else f"this.{name}({arglist})"
            mapping[name] = w1

            if b.return_type == "void":
                body_easy = f"{call_target};"
            else:
                body_easy = f"return {call_target};"

            if tier == "easy":
                wrappers.append(
                    f"    private {static_kw}{b.return_type} {w1}({b.params}) {{\n"
                    f"        {body_easy}\n"
                    f"    }}"
                )
                helper_count += 1
                continue

            if tier == "med":
                sel = ctx.rng.fork(f"sel:{name}").randint(1, 3)
                if b.return_type == "void":
                    body = (
                        f"int _obf_sel = {sel};\n"
                        f"        switch (_obf_sel) {{\n"
                        f"            case {sel}: {call_target}; break;\n"
                        f"            default: {call_target}; break;\n"
                        f"        }}"
                    )
                else:
                    body = (
                        f"int _obf_sel = {sel};\n"
                        f"        switch (_obf_sel) {{\n"
                        f"            case {sel}: return {call_target};\n"
                        f"            default: return {call_target};\n"
                        f"        }}"
                    )
                wrappers.append(
                    f"    private {static_kw}{b.return_type} {w1}({b.params}) {{\n"
                    f"        {body}\n"
                    f"    }}"
                )
                helper_count += 1
                continue

            # hard tier: two-hop trampoline chain.
            w2 = f"{w1}_inner"
            mapping[name] = w1
            if b.return_type == "void":
                outer_body = f"{w2}({arglist});"
                inner_body = f"{call_target};"
            else:
                outer_body = f"return {w2}({arglist});"
                inner_body = f"return {call_target};"
            wrappers.append(
                f"    private {static_kw}{b.return_type} {w1}({b.params}) {{\n"
                f"        {outer_body}\n"
                f"    }}"
            )
            wrappers.append(
                f"    private {static_kw}{b.return_type} {w2}({b.params}) {{\n"
                f"        {inner_body}\n"
                f"    }}"
            )
            helper_count += 2

        # Rewrite call sites in original method bodies only.
        changes = 0
        refreshed = iter_method_blocks(out)
        for b in sorted(refreshed, key=lambda x: x.start, reverse=True):
            body = out[b.body_start + 1 : b.end]
            new_body = body
            for old, new in mapping.items():
                pat = re.compile(rf"(?<![A-Za-z0-9_\\.]){re.escape(old)}\s*\(")

                def repl(m: re.Match[str]) -> str:
                    nonlocal changes
                    changes += 1
                    return f"{new}("

                new_body = pat.sub(repl, new_body)
            if new_body != body:
                out = out[: b.body_start + 1] + new_body + out[b.end:]

        if not wrappers:
            return source, False, "no_wrappers_built", 0, 0
        out = insert_before_class_end(out, "\n\n".join(wrappers))

        if changes == 0:
            return source, False, "no_calls_rewritten", 0, helper_count
        return out, True, f"indirection_calls:{changes}", changes, helper_count
