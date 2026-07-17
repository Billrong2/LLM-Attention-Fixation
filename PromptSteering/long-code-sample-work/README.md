# Long-code CodeSteer case-study workspace

This directory stages the reproducible long-code case-study experiment before
the verified artifact is installed under the paper rebuttal directory.

The final case-study set is outcome-selected by an explicit rule: retain cases
where CodeSteer predicts the exact program output and the three comparison
conditions do not.  The complete screened pool and all generated transcripts
are retained so this selected set is not presented as representative accuracy.

## Four-condition runner

`run_long_code_experiment.py` consumes a JSON manifest and runs, for every
concrete case, the paired conditions `original_plain`, `obfuscated_plain`,
`obfuscated_prompt_slice`, and `obfuscated_codesteer`.  The registered protocol
uses `Qwen/Qwen2.5-14B`, three trials, sampling at temperature 1.05, top-p 0.95,
top-k 7, and 512 new tokens.  All four conditions in a sample/trial share the
same deterministic paired seed.

The preferred manifest form is:

```json
{
  "variants": [
    {
      "candidate_id": "example-01",
      "original": {"source_path": "original.java", "class": "Main"},
      "obfuscated": {"source_path": "obfuscated.java", "class": "Main"},
      "original_target_method": "solve",
      "obfuscated_target_method": "m1",
      "cases": [
        {"case_id": "c001", "stdin": "3\n", "expected_output": "7\n"}
      ]
    }
  ]
}
```

Paths may be absolute or relative to the manifest.  Each entry in `cases`
becomes an independent sample.  A flat `samples` list with `original_path`,
`obfuscated_path`, `target_method`, `stdin`, and `expected_stdout` is also
accepted.

For inference, use the 23-entry
`tokenizer_preflight/inference_eligible_variants.json` manifest.  It excludes
the two screened variants whose exact Qwen token-aligned SlicingPrior vector
collapses to the positional fallback; the original 25-entry manifest remains
available as an audit artifact, not as the inference input.

Model-free validation:

```bash
python3 long-code-sample-work/run_long_code_experiment.py \
  --manifest long-code-sample-work/tokenizer_preflight/inference_eligible_variants.json \
  --dry-run
```

Full run (results remain below this directory):

```bash
python3 long-code-sample-work/run_long_code_experiment.py \
  --manifest long-code-sample-work/tokenizer_preflight/inference_eligible_variants.json \
  --gpu-ids 0,1
```

Before inference the runner executes both source variants in sanitized local
scratch space, requires empty compiler/runtime stderr, verifies their
trimmed-exact outputs agree, confirms the prompt-only slice targets the recorded algorithm
method, checks the actual token-aligned CodeSteer slice vector is not its
positional fallback, checks that the `CASES` signal is active, and verifies the
prompt plus generation budget fits the model context.  A completed condition
is resumable only when its full fingerprint matches.

`trimmed_exact_match` follows the historical Table-2 rule: CRLF/CR is changed
to LF and only leading/trailing whitespace is stripped. Internal spaces and
newlines remain significant. Raw oracle and prediction strings and hashes are
also retained. Candidates whose token-aligned algorithm prior equals the
positional fallback are recorded in `preflight_rejections.json` and skipped;
they do not abort the rest of the screened pool.

Every run stores the submitted prompt, raw completion, source snapshot, oracle,
machine-readable score, generation and steering configuration, and complete
steering debug.  `results_index.json` is an index only; it deliberately does
not report pass@k.

For these long prompts, the runner locally memoizes the deterministic
prompt-static steering prior once per manager and decode bin. The shared
steering implementation is unchanged. `cache_equivalence_smoke/` preserves a
same-seed uncached/cached CodeSteer replay whose prompt, source, sampled raw
completion, parsed output, score, and steering diagnostics are byte-identical.
The pilot produced before this optimization is retained separately under
`engineering_uncached_pilot/` and is excluded from the case-study screen.
Two later stopped launch artifacts are also retained transparently and
excluded: `engineering_path_rebase_attempt/` (a duplicated relative output
prefix) and `engineering_supplemental_parent_shadow_attempt/` (case paths were
shadowed by parent inline input/output). The latter led to a regression check
that binds every expanded supplemental stdin and oracle to its frozen hash
before corrected inference.

The experiment root also records `environment.json`: hostname, UTC and local
start time, Python/PyTorch/Transformers/Accelerate versions, CUDA/GPU details,
the verified Qwen snapshot commit
`97e1e76335b7017d8f67c08a19d103c0504298c9`, and the SHA-256 of the experiment
configuration.  It does not copy environment variables or credentials.

## Deterministic audit and strict case-study selection

One or more complete or split result roots can be audited together:

```bash
python3 long-code-sample-work/audit_long_code_results.py \
  long-code-sample-work/results-wave-a \
  long-code-sample-work/results-wave-b \
  --output-dir long-code-sample-work/audit
```

The auditor recomputes run fingerprints, prompt/source hashes, output parsing
and trimmed-exact scores; checks steering activation/no-op
diagnostics and matched paired seeds; and requires all four conditions for all
three trials.  A sample is strictly eligible only if CodeSteer is exact in at
least one marker-JSON trial and every recorded trial of all three baselines is incorrect.
All screened candidates remain in `long_code_audit.json` and the two CSV files,
including invalid and ineligible candidates.

Problem uniqueness is derived from immutable CodeContests provenance
(`dataset_id`, frozen revision, split, and dataset row), not from a mutable
display label. The auditor also cross-checks that identity against the recorded
Codeforces contest/index key. The final unique-problem view retains every
variant and case but deterministically selects one representative by best
trace-heuristic score and then sample id.

Among valid, exact CodeSteer trials with a valid `FINAL_OUTPUT_JSON`, the audit
ranks traces with a fully recorded source-grounded heuristic.  The heuristic
uses reasoning length, source identifiers, execution vocabulary, target/input
grounding, intermediate-state evidence, output discussion, and uncertainty or
code-generation-drift penalties.  It never reads the oracle or predicted
output for its score, is not an LLM judgment, and does not replace the final
manual trace audit.
