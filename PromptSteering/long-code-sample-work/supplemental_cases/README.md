# Supplemental long-code cases

This expansion was designed after the initial 25-source full screen had started but before that screen completed.  The rules were fixed and cases were selected without reading or using any model response, score, or other model outcome; this preparer performs no model inference.

The exact 25 frozen source/obfuscation variants are reused, so the screened-source denominator remains 25; supplemental cases are repeated measurements, not new source-level observations.

The immutable selection rules are in `../SUPPLEMENTAL_CASE_PROTOCOL.md`.  The
runner-compatible `variants` manifest is `supplemental_manifest.json`; the
unchanged 25-source denominator is documented in
`source_denominator_audit.json`; complete private/generated eligibility and
ranking decisions are in `selection_audit.jsonl`; JDK 17 evidence is in
`validation/`; and exact test and observed-output bytes are in `tests/`.

Summary: 60 supplemental cases selected across 25
frozen source variants.  15
sources received four cases; 10
had no non-frozen pair satisfying the fixed byte/line criteria.

The inference manifest contains 15 source variants and
12 distinct CodeContests problems.  Every retained
variant preserves its frozen prepared-variant metadata, points back to the same
immutable source pair, and replaces its `cases` array with the supplemental
cases only.

No public-test values, model outcomes, or model inference were used by the
preparer.
