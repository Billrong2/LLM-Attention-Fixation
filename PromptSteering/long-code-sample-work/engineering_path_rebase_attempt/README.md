# Excluded path-rebasing launch attempt

This directory preserves a stopped engineering launch from 2026-07-13. The
wrapper passed `long-code-sample-work/full_results_cached/...` as a relative
output path even though the runner intentionally rebases every relative output
below its own `long-code-sample-work` root. The resulting duplicate path was
caught during the first progress inspection. All four workers were stopped and
fresh workers were launched into corrected result roots.

The partial attempt contains 39 completed records: 12 `original_plain`, 11
`obfuscated_plain`, 8 `obfuscated_prompt_slice`, and 8
`obfuscated_codesteer`. These records are excluded from every screen, audit,
selection, and final case-study artifact. They are retained only to make the
interrupted launch and its disposition explicit.

- `partial_results/`: the actual runner roots produced by rebasing
- `launch_logs/`: the four wrapper console logs written at the originally
  requested relative paths
