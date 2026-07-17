# Balanced long-code contingency protocol

Protocol freeze date: 2026-07-13

## Prospective trigger and timing

This contingency was specified after the completed initial 23-case screen and
while the corrected 60-case supplemental screen was still running, before any
corrected supplemental model output or score was inspected.  Preparation uses
only immutable dataset records, frozen source/obfuscation manifests, JDK 17,
and the exact cached Qwen tokenizer.  It performs no language-model inference.

The trigger is a valid deterministic combined audit of the registered initial
and corrected supplemental screens with fewer than ten strictly eligible,
distinct canonical CodeContests problems.  An invalid or incomplete audit does
not trigger the contingency; run integrity must be repaired first.

## Immutable source and problem population

The source denominator remains the same 25 correct human Java submissions from
the CodeContests `valid` split at revision
`802411c3010cb00d1b05bad57ca77365a3c699d6`.  Inference remains restricted to
the 23 frozen source variants passing the original exact-tokenizer gate.  They
represent 19 canonical problems, keyed by dataset id, revision, split, and row
index.  This contingency creates repeated concrete inputs; it adds no source
or problem to that denominator.

For each canonical row, choose the first tokenizer-eligible frozen variant in
the order of `prepared_variants/eligible_variants.json`.  Source choice cannot
depend on a model outcome.

## Outcome-blind concrete-case selection

Read only `private_tests`, `generated_tests`, and the exact human solution from
the immutable parquet.  Public tests must not be loaded, inspected, ranked, or
selected.  Deduplicate and exclude every pair identified by canonical dataset
row, suite, and zero-based dataset test index that already appears in either
the initial or supplemental manifests.

A remaining pair is statically eligible only when:

- input and expected output are strict UTF-8 strings;
- input length is 5--512 UTF-8 bytes, inclusive;
- expected-output length is at most 60 UTF-8 bytes; and
- expected output has at most seven lines under `len(str.splitlines())`.

Rank eligible pairs lexicographically by:

1. suite (`private_tests` before `generated_tests`);
2. fewer expected-output lines;
3. fewer expected-output bytes;
4. smaller absolute distance between input bytes and 80; and
5. smaller dataset test index.

In rank order, validate the chosen frozen original and obfuscated programs with
the recorded JDK 17.  Both must compile, exit zero without timeout, emit empty
stderr, match the dataset oracle under the historical comparator, and agree
with one another.  Continue deterministically past any rejection until four
cases pass for every canonical problem.  The first two accepted ranks form
Wave 1; accepted ranks three and four form Wave 2.

The seven-line cap is a coverage rule derived without model results.  The seven
problems absent from the first supplemental manifest have minimum candidate
outputs of 4, 5, 7, 4, 7, 7, and 5 lines while satisfying the unchanged byte
bounds.

## Exact tokenizer gate

Before inference, rebuild each exact runner prompt with the cached
`Qwen/Qwen2.5-14B` tokenizer snapshot
`97e1e76335b7017d8f67c08a19d103c0504298c9`.  Retain a case only if:

- its SlicingPrior vector is not the normalized positional fallback;
- the SliceHybrid `CASES` signal is active; and
- prompt tokens plus 512 generation tokens fit the context.

No model weights may be loaded.  If a selected case fails this gate, record the
rejection and continue the same frozen dataset rank order until that problem
again has four passing cases.  Wave manifests are frozen only after all 76
cases pass.

## Conditional waves and inference settings

Each wave contains exactly two cases for each of the 19 canonical problems: 38
cases, three trials, and all four registered conditions.  The model and all
settings remain unchanged: Qwen2.5-14B base, `do_sample=True`, temperature
1.05, top-p 0.95, top-k 7, 512 new tokens, and the registered level-2
CodeSteer profile.

After the contingency protocol and both manifests are hashed, open the
corrected combined audit:

1. If at least ten distinct problems are strict, run neither wave.
2. Otherwise run all of Wave 1 and audit only after the wave is complete.
3. If the combined strict count remains below ten, run all of Wave 2.
4. Never stop within a wave or choose a problem/input using an observed model
   result.

A sample remains strict only when all 12 matched records are valid, at least
one CodeSteer trial is trimmed-exact with valid `FINAL_OUTPUT_JSON`, and every
recorded trial of all three baselines is incorrect.  The final artifact must
retain all screened cases and disclose the conditional case-finding design.
It must not display Pass@ values.

## Required integrity evidence

The frozen artifact records complete eligibility/ranking audit rows, JDK
validation records, raw input/oracle/output hashes, exact source hashes,
loader-level stdin/oracle hash checks, tokenizer reports, disjoint Wave 1/Wave
2 identities, four-GPU launch plans, source/test/problem denominators, and a
SHA-256 inventory.  Parent-level input/output aliases are removed from emitted
variants so a concrete case path cannot be shadowed.
