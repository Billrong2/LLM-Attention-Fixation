from __future__ import annotations

import ast
from dataclasses import asdict
from pathlib import Path
from typing import Any

from .budget import BudgetManager
from .config import LevelConfig, ProfileConfig, load_level_config
from .metadata import ObfuscationMetadata, ObfuscationResult
from .metrics import calculate_metrics, difficulty_score
from .pass_base import HelperRegistry, PassContext
from .rng import DeterministicRNG, derive_seed


PASS_ORDER_DEFAULT = ["T2", "T1", "T8", "T4", "T3", "T5", "T6", "T7"]


def _registry(language: str):
    if language == "java":
        from ..java.passes import all_passes
    elif language == "python":
        from ..python.passes import all_passes
    else:
        raise ValueError(f"Unsupported language: {language}")
    return {p.name: p for p in all_passes()}


def _validate_source(language: str, source: str) -> tuple[bool, str]:
    if language == "python":
        try:
            ast.parse(source)
            return True, "ok"
        except Exception as exc:
            return False, str(exc)
    if language == "java":
        from ..java.frontend.parse import syntax_valid

        return syntax_valid(source)
    return False, f"unsupported:{language}"


def _inject_helpers(language: str, source: str, helpers_text: str) -> str:
    if language == "python":
        from ..python.frontend.print import inject_helpers

        return inject_helpers(source, helpers_text)
    if language == "java":
        from ..java.frontend.print import inject_helpers

        return inject_helpers(source, helpers_text)
    return source


def _level_pass_sequence(level_cfg: LevelConfig, mode: str, technique: str | None) -> list[str]:
    if mode == "technique":
        if not technique:
            raise ValueError("technique mode requires technique")
        return [technique]
    if level_cfg.pass_order:
        return list(level_cfg.pass_order)
    return list(PASS_ORDER_DEFAULT)


def _compose_pass_settings(
    level_cfg: LevelConfig,
    seq: list[str],
    difficulty: str | None,
    mode: str,
    method_coverage_policy: str,
) -> dict[str, dict[str, Any]]:
    out: dict[str, dict[str, Any]] = {}
    for p in seq:
        ps = level_cfg.passes.get(p)
        if ps:
            out[p] = {
                "tier": difficulty or ps.tier,
                "target_rate": ps.target_rate,
                "intensity": ps.intensity,
                "enabled": ps.enabled,
                "method_coverage_policy": method_coverage_policy,
            }
        else:
            # In level mode, unspecified passes are disabled by default.
            # In technique mode, explicit selected pass remains enabled.
            enabled_default = mode == "technique"
            out[p] = {
                "tier": difficulty or "easy",
                "target_rate": 1.0,
                "intensity": 1.0,
                "enabled": enabled_default,
                "method_coverage_policy": method_coverage_policy,
            }
    return out


def obfuscate_program(
    source: str,
    language: str,
    profile: str,
    seed: int,
    mode: str,
    level: str | None,
    technique: str | None,
    difficulty: str | None,
    program_id: str,
    config_root: Path,
    disabled_passes: set[str] | None = None,
    method_coverage_policy: str = "best_effort",
) -> ObfuscationResult:
    lvl = (level or "level0").lower()
    level_cfg, profile_cfg = load_level_config(config_root, language, lvl, profile)
    registry = _registry(language)
    pass_seq = _level_pass_sequence(level_cfg, mode, technique)
    pass_settings = _compose_pass_settings(level_cfg, pass_seq, difficulty, mode, method_coverage_policy)

    program_seed = derive_seed(seed, program_id, language, profile, mode, lvl, technique or "-")
    rng = DeterministicRNG(program_seed)

    before_metrics = calculate_metrics(language, source)
    budget = BudgetManager(profile_cfg.budget)
    budget.reset(before_metrics.get("ast_nodes", 0))

    ctx = PassContext(
        language=language,
        program_id=program_id,
        profile_name=profile,
        level=lvl,
        seed=program_seed,
        rng=rng,
        budget=budget,
        helpers=HelperRegistry(language=language),
        tier_map={k: v.get("tier", "easy") for k, v in pass_settings.items()},
        pass_settings=pass_settings,
        disabled_passes=set(disabled_passes or set()),
    )

    current = source
    for p_name in pass_seq:
        if p_name not in registry:
            ctx.add_diag(p_name, "unknown_pass")
            continue
        settings = pass_settings.get(p_name, {})
        if not settings.get("enabled", True):
            ctx.add_diag(p_name, "disabled_in_profile")
            continue

        p = registry[p_name]
        prev = current
        current = p.run(current, ctx, settings.get("tier", "easy"))
        ok, reason = _validate_source(language, current)
        if not ok:
            current = prev
            ctx.add_diag(p_name, f"rollback_invalid:{reason}")
            if ctx.pass_reports:
                ctx.pass_reports[-1].applied = False
                ctx.pass_reports[-1].reason = f"rollback_invalid:{reason}"
                ctx.pass_reports[-1].node_delta = 0
                ctx.pass_reports[-1].helpers_injected = 0

    helpers_text = ctx.helpers.render()
    if helpers_text:
        merged = _inject_helpers(language, current, helpers_text)
        ok, reason = _validate_source(language, merged)
        if ok:
            current = merged
        else:
            ctx.add_diag("helpers", f"helper_injection_rollback:{reason}")

    after_metrics = calculate_metrics(language, current)
    after_metrics["helpers_injected"] = ctx.helpers.count()
    after_metrics["difficulty_score"] = difficulty_score(after_metrics)

    budget.record_ast_after(after_metrics.get("ast_nodes", 0))
    if not budget.allow_ast_growth():
        # Budget breach: deterministic fallback to original.
        ctx.add_diag("budget", "ast_growth_exceeded_fallback_original")
        current = source
        after_metrics = before_metrics
        after_metrics["helpers_injected"] = 0
        after_metrics["difficulty_score"] = difficulty_score(after_metrics)

    skipped = [{"pass": d.pass_name, "reason": d.reason} for d in ctx.diagnostics]
    metadata = ObfuscationMetadata(
        program_id=program_id,
        language=language,
        profile_name=profile_cfg.name,
        mode=mode,
        level=lvl if mode == "level" else None,
        technique=technique if mode == "technique" else None,
        difficulty=difficulty,
        seed=program_seed,
        passes_applied=[asdict(p) for p in ctx.pass_reports],
        budgets=budget.snapshot(),
        metrics=after_metrics,
        skipped_passes_with_reasons=skipped,
        equivalence={"stdout_match": False, "stderr_match": False, "exit_match": False, "details": "not_run"},
    )
    return ObfuscationResult(source=current, metadata=metadata)
