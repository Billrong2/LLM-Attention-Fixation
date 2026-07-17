# Outcome-blind supplemental-case protocol

Protocol date: 2026-07-13

## Timing and purpose

This supplemental expansion was designed after the initial 25-source full
screen had started, but before that screen completed.  The case-selection
rules below were fixed without reading or using any model response, score, or
other model outcome.  The preparer performs no model inference.

The expansion reuses the exact 25 original/obfuscated source pairs frozen in
`candidate_pool/candidate_manifest.json` and
`prepared_variants/eligible_variants.json`.  It neither edits those manifests
nor creates new source/obfuscation variants.  The screened-source denominator
therefore remains 25; supplemental test cases are repeated measurements for
those same sources, not new source-level observations.

## Data and eligibility

For each frozen source, recover test pairs from the exact CodeContests valid
row recorded by its candidate provenance.  Consider only `private_tests` and
`generated_tests`; do not read or select from `public_tests`.  Exclude every
`(suite, dataset_test_index)` already present in the frozen variant.

A test pair is tractable only when:

- both input and expected output encode as strict UTF-8;
- input size is 5--512 UTF-8 bytes, inclusive;
- expected-output size is at most 60 UTF-8 bytes; and
- expected output has at most three lines, where line count is Python
  `str.splitlines()` and a terminal newline does not add a line.

## Fixed ranking and validation

Rank every tractable, non-frozen pair lexicographically by:

1. suite (`private_tests` before `generated_tests`);
2. fewer expected-output lines;
3. fewer expected-output bytes;
4. smaller absolute distance between input byte count and 80; and
5. smaller zero-based dataset test index.

Scan this ranking and select the first four pairs that pass independent JDK 17
execution validation.  Stop executing candidates after four have passed; if
fewer than four pass or exist, retain fewer.  For every executed pair, compile
and run both the frozen original and frozen obfuscated source.  Acceptance
requires successful compilation, no timeout, runtime exit code zero, empty
runtime stderr, and the historical trimmed-exact comparator against the
dataset oracle for both programs.  The comparator converts CRLF to LF and
applies outer `strip()` only; internal whitespace remains significant.  The
two program outputs must consequently also agree under that comparator.

Record raw SHA-256 hashes for the input, oracle output, each program's stdout,
and each program's stderr.  Preserve the complete eligibility/ranking audit,
including candidates not executed because the quota was already filled.

