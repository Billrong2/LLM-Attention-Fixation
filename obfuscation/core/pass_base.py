from __future__ import annotations

import time
from dataclasses import dataclass, field
from typing import Any, Dict, Optional

from .budget import BudgetManager
from .rng import DeterministicRNG


@dataclass
class Diagnostic:
    pass_name: str
    reason: str
    candidate: str | None = None


@dataclass
class PassReport:
    name: str
    tier: str
    applied: bool
    reason: str
    node_delta: int
    helpers_injected: int
    time_ms: float
    extra: Dict[str, Any] = field(default_factory=dict)


@dataclass
class HelperRegistry:
    language: str
    _helpers: Dict[str, str] = field(default_factory=dict)

    def add(self, key: str, source: str) -> bool:
        if key in self._helpers:
            return False
        self._helpers[key] = source
        return True

    def render(self) -> str:
        if not self._helpers:
            return ""
        return "\n\n".join(self._helpers[k] for k in sorted(self._helpers))

    def count(self) -> int:
        return len(self._helpers)


@dataclass
class PassContext:
    language: str
    program_id: str
    profile_name: str
    level: str
    seed: int
    rng: DeterministicRNG
    budget: BudgetManager
    helpers: HelperRegistry
    diagnostics: list[Diagnostic] = field(default_factory=list)
    pass_reports: list[PassReport] = field(default_factory=list)
    metrics: dict[str, Any] = field(default_factory=dict)
    analyses: dict[str, Any] = field(default_factory=dict)
    tier_map: dict[str, str] = field(default_factory=dict)
    pass_settings: dict[str, dict[str, Any]] = field(default_factory=dict)
    disabled_passes: set[str] = field(default_factory=set)
    pass_extras: dict[str, dict[str, Any]] = field(default_factory=dict)

    def add_diag(self, pass_name: str, reason: str, candidate: str | None = None) -> None:
        self.diagnostics.append(Diagnostic(pass_name=pass_name, reason=reason, candidate=candidate))


class ObfuscationPass:
    name = "base"
    applies_to_lang = {"java", "python"}

    def apply(self, source: str, ctx: PassContext) -> tuple[str, bool, str, int, int]:
        raise NotImplementedError

    def run(self, source: str, ctx: PassContext, tier: str) -> str:
        if ctx.language not in self.applies_to_lang:
            ctx.pass_reports.append(
                PassReport(self.name, tier, False, f"unsupported_language:{ctx.language}", 0, 0, 0.0)
            )
            return source
        if self.name in ctx.disabled_passes:
            ctx.pass_reports.append(PassReport(self.name, tier, False, "disabled_for_retry", 0, 0, 0.0, extra={}))
            return source

        t0 = time.time()
        ctx.pass_extras.pop(self.name, None)
        out, applied, reason, node_delta, helpers = self.apply(source, ctx)

        if ctx.language == "java":
            # Enforce or at least collect method coverage for Java passes.
            from ..java.passes.utils import enforce_method_coverage, method_coverage_stats

            policy = str(ctx.pass_settings.get(self.name, {}).get("method_coverage_policy", "best_effort")).lower()
            fallback_insertions = 0
            if policy == "force_all":
                out, fallback_insertions = enforce_method_coverage(
                    original_source=source,
                    transformed_source=out,
                    pass_name=self.name,
                    rng=ctx.rng.fork(f"{self.name}:coverage"),
                )
            coverage = method_coverage_stats(original_source=source, transformed_source=out)
            coverage["method_coverage_policy"] = policy
            coverage["fallback_insertions"] = fallback_insertions
            ctx.pass_extras[self.name] = coverage
            if fallback_insertions > 0:
                applied = True
                node_delta += fallback_insertions
                if reason:
                    reason = f"{reason}|force_all_fallback:{fallback_insertions}"
                else:
                    reason = f"force_all_fallback:{fallback_insertions}"

        dt = (time.time() - t0) * 1000.0
        extra = dict(ctx.pass_extras.get(self.name, {}))
        ctx.pass_reports.append(
            PassReport(
                name=self.name,
                tier=tier,
                applied=applied,
                reason=reason,
                node_delta=node_delta,
                helpers_injected=helpers,
                time_ms=round(dt, 3),
                extra=extra,
            )
        )
        return out
