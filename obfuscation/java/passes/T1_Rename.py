from __future__ import annotations

import re

from ...core.pass_base import ObfuscationPass, PassContext
from ...core.rng import DeterministicRNG
from .utils import (
    find_class_name,
    iter_method_blocks,
    parse_param_names,
    safe_identifier,
    word_replace_outside_literals,
)


class T1RenamePass(ObfuscationPass):
    name = "T1"
    applies_to_lang = {"java"}

    def _next_name(self, rng: DeterministicRNG, tier: str, idx: int) -> str:
        if tier == "easy":
            return f"v{idx}"
        if tier == "med":
            return f"_o{idx}"
        alphabet = ["l", "I", "O", "0", "1"]
        token = "".join(rng.choice(alphabet) for _ in range(5))
        return f"_{token}{idx}"

    def apply(self, source: str, ctx: PassContext):
        setting = ctx.pass_settings.get(self.name, {})
        tier = setting.get("tier", "easy")
        rate = float(setting.get("target_rate", 1.0))

        class_name = find_class_name(source)
        blocks = iter_method_blocks(source)
        if not blocks:
            return source, False, "no_methods", 0, 0

        method_map: dict[str, str] = {}
        midx = 0
        for b in blocks:
            if b.visibility == "private" and b.name != "main" and safe_identifier(b.name):
                if ctx.rng.weighted_bool(rate):
                    midx += 1
                    method_map[b.name] = f"_m{midx}"

        out = word_replace_outside_literals(source, method_map)
        blocks = iter_method_blocks(out)

        replaced_total = len(method_map)
        for b in sorted(blocks, key=lambda x: x.start, reverse=True):
            method_src = out[b.start : b.end + 1]
            header = out[b.start : b.body_start + 1]
            body = out[b.body_start + 1 : b.end]
            local_map: dict[str, str] = {}
            idx = 0

            param_map: dict[str, str] = {}
            if tier in {"med", "hard"}:
                pidx = 0
                for pname in parse_param_names(b.params):
                    if pname in {"this", "super"}:
                        continue
                    if pname in param_map:
                        continue
                    if safe_identifier(pname) and ctx.rng.weighted_bool(rate):
                        pidx += 1
                        if tier == "hard":
                            token = self._next_name(ctx.rng.fork(f"{b.name}:param:{pname}"), tier, pidx)
                            renamed = f"p{token}"
                        else:
                            renamed = f"_p{pidx}"
                        param_map[pname] = renamed

            decl_pat = re.compile(
                r"\b(?:byte|short|int|long|float|double|boolean|char|String|[A-Z][A-Za-z0-9_<>\[\]]*)\s+([a-zA-Z_][A-Za-z0-9_]*)\s*(?==|;|,)"
            )
            for m in decl_pat.finditer(body):
                name = m.group(1)
                if name in {"this", "super", "args"}:
                    continue
                if name == class_name:
                    continue
                if name in local_map:
                    continue
                if name in param_map.values():
                    continue
                if safe_identifier(name) and ctx.rng.weighted_bool(rate):
                    idx += 1
                    candidate = self._next_name(ctx.rng.fork(f"{b.name}:{name}"), tier, idx)
                    while candidate in param_map.values() or candidate in local_map.values():
                        idx += 1
                        candidate = self._next_name(ctx.rng.fork(f"{b.name}:{name}:{idx}"), tier, idx)
                    local_map[name] = candidate

            full_map = {}
            full_map.update(param_map)
            full_map.update(local_map)
            if not full_map:
                continue

            new_header = word_replace_outside_literals(header, param_map, skip_after_dot=True) if param_map else header
            new_body = word_replace_outside_literals(body, full_map, skip_after_dot=True)
            new_method = new_header + new_body + "}"
            if new_method != method_src:
                replaced_total += len(full_map)
                out = out[: b.start] + new_method + out[b.end + 1 :]

        if replaced_total == 0:
            return source, False, "no_candidates", 0, 0
        return out, True, f"renamed:{replaced_total}", replaced_total, 0
