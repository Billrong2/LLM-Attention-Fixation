# Excluded supplemental parent-shadow attempt

This directory preserves a stopped engineering attempt from 2026-07-13. It is
excluded from every screen, audit, selection, and final case-study claim.

The supplemental manifest stores each new case as `stdin_path` and
`expected_output_path`, while its parent variant also retains the original
case as inline `stdin` and `expected_stdout`. The runner's old merge added the
case paths without removing those parent inline aliases. Its text loader checks
an inline value before the corresponding path, so each supplemental ID used
its parent input and oracle instead of its own frozen case. Comparing the
runner snapshot's actual stdin hash with `concrete_case.input_sha256` exposed
the mismatch.

All four workers were stopped immediately after confirmation. The partial
attempt contains 278 completed records across its four shards (61, 64, 63,
and 90). These are repeated-parent-input engineering records, not supplemental
measurements, and no result from them is reused. `tokenizer_preflight_buggy/`
and `buggy_supplemental_launch_plan.json` preserve the exact pre-fix gate and
plan used by the attempt.

The corrected runner clears conflicting parent input/output aliases before
merging each concrete case. Regression tests now require every expanded stdin
and oracle hash to equal the frozen case hashes and require four distinct
inputs per supplemental source. The tokenizer-only gate was then regenerated
from the exact corrected prompts before any corrected inference launch.
