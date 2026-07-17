# Uncached engineering pilot (excluded from case-study analysis)

This directory preserves the first engineering launch on 2026-07-13.  It was
intentionally stopped after 76 of 276 condition-runs because profiling showed
that `SteeringManager.prior_vector()` rebuilt the same static Java slice once
per steered layer and decode token.  At the registered 512-token cap this can
mean roughly 4,096 identical AST/dataflow computations per completion.

The pilot is not an experimental result root and must not be passed to the
case-study selector.  It contains 21 original-plain, 19 obfuscated-plain, 19
prompt-slice, and 17 CodeSteer completions; none was output-exact.  It is kept
only to preserve the complete engineering history and the motivation for the
mathematically no-op per-bin cache used by the clean restart.

The exact runner used here is copied to
`../runtime_snapshots/uncached_pilot/run_long_code_experiment.py` with SHA-256
`51a3d49b8b743e7750196bd7297f91bdafd73a0821f5a4e6f0c010ae9b16f01d`.
