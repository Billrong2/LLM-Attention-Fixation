# Long-code output-prediction case-study protocol

## Purpose

This experiment constructs a deliberately outcome-selected case-study set of
ten long programs.  It is not an estimate of population accuracy.  A sample is
eligible for the final set only when at least one CodeSteer trial predicts the
complete output correctly and every recorded trial from each of the three
comparison conditions is incorrect.  The complete screened pool, rejected
samples, trial seeds, prompts, completions, and scores are retained.

## Published source dataset

The candidate source is the `valid` split of DeepMind CodeContests at immutable
revision `802411c3010cb00d1b05bad57ca77365a3c699d6`.  CodeContests was released
with AlphaCode and contains paired tests plus correct and incorrect human
competitive-programming submissions.

- Repository: https://github.com/google-deepmind/code_contests
- Dataset: https://huggingface.co/datasets/deepmind/code_contests
- File: `data/valid-00000-of-00001-5e672c5751f060d3.parquet`
- Downloaded file SHA-256: `02e8c1ccedae716f1e43cc813fcb7823c3db666ea92638820aba80e8cef451ab`

The selected submissions are third-party Codeforces material carried by the
dataset.  The upstream repository's Apache-2.0 license covers the repository
code, while its README warns that third-party materials can have separate
terms.  The artifact therefore preserves the upstream provenance and this
notice instead of implying that the repository license governs the contest
submissions.

## Eligibility before model inference

1. A correct human Java submission with 250--350 physical source lines.
2. At most three distinct submissions per contest problem, selected without
   model outcomes.  The final selector prefers one case per problem; retaining
   extra source-level implementations enlarges the disclosed screening
   denominator without using model outcomes during candidate construction.
3. A self-contained source file that compiles under the recorded JDK.
4. At least one stored input/output pair whose execution exits successfully
   and exactly reproduces the dataset output.
5. CodeSteer's normal target-selection rule identifies a method called from
   `main` that has at least one formal parameter and a genuine return sink.
   This avoids silently substituting CodeSteer's positional fallback for its
   Table-2 parameter-to-return slice.
6. The obfuscated source compiles and remains output-equivalent on every
   validation input recorded for that candidate.

## Matched inference conditions

All four conditions use the same Qwen/Qwen2.5-14B base model, task contract,
maximum generation length, paired trial seed, and sampler:

- original source, no intervention;
- obfuscated source, no intervention;
- obfuscated source plus the established prompt-only slice guidance;
- obfuscated source plus CodeSteer.

Generation uses `do_sample=True`, temperature 1.05, top-p 0.95, and top-k 7.
The maximum generation length is 512 new tokens and the default design records
three paired trials per condition.  The cached model is immutable Hugging Face
snapshot `97e1e76335b7017d8f67c08a19d103c0504298c9`; its `config.json` SHA-256 is
`fdb89460be9a6383451437cdf632a3e087522efa682265461f33507e7069f026`.
CodeSteer uses
level-2 post-softmax steering, `slice_hybrid`, beta 0.8, 12 decode bins, the
last eight transformer layers, recency mixing 0.2 with a 64-token window, and
no head subset, matching the checked-in reproducibility configuration.

The experiment runner memoizes CodeSteer's deterministic prompt-static prior
within each `SteeringManager`, keyed by the current decode bin and number of
bins. This avoids recomputing the same vector once per steered layer and decode
token; it does not alter the provider, vector values, logits, or sampler. A
same-sample, same-trial, same-seed uncached/cached replay, including byte-equal
raw completion and steering diagnostics, is retained in
`cache_equivalence_smoke/`. The exact cached runner and cache profile are
recorded in every experiment root and are checked during deterministic audit.

## Reporting rule

The final ten are labeled **CodeSteer-only success cases**.  The artifact must
report the number of statically eligible candidates, the number actually
screened, and the number satisfying the post-hoc selection rule.  These ten
examples may illustrate a mechanism or failure mode, but cannot by themselves
support an aggregate outperformance claim.

The ten must also represent ten unique published-dataset problems. Uniqueness
is keyed by the immutable CodeContests dataset id, frozen revision, split, and
row index. The human-readable Codeforces contest/index key is independently
cross-checked but is not trusted as the grouping key. Multiple source variants
or input cases from the same dataset row count as one problem.
