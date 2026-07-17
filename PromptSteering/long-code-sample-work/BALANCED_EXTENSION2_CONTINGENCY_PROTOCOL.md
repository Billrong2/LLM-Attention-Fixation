# Frozen final second adaptive balanced extension contingency (Waves 4--5)

This protocol freezes a control-only adaptive extension for the long-code
qualitative case search. It was specified and revised prospectively during
live Wave 3, after the completed valid post-Wave-2 audit reported four distinct
strict canonical CodeContests problems. It is adaptive and outcome-aware from
that Wave-2 aggregate result, is not preregistered, and is not outcome-blind in
timing. No Wave-3 model output, result, score, completion, reasoning trace, or
result file was inspected or used to specify or revise the contingency. Case
eligibility, the deterministic rank key, accepted-rank continuation, and both
feasibility-driven revisions are outcome-independent.

## Preserved fail-closed revisions

Two larger prospective designs failed closed under the unchanged frozen rules.
Both failures and their static/JDK evidence are preserved; neither revision
used a model outcome.

1. The initial design requested ranks 21--25 for a 19-by-5 Wave 6. An
   exhaustive scan found canonical row 27 has 202 statically eligible
   candidates but only 24 JDK-valid accepted ranks, so rank 25 cannot be
   supplied uniformly.
2. The first revision requested ranks 11--24 across three waves. A second
   exhaustive scan found canonical row 54 has 255 statically eligible
   candidates but only 19 JDK-valid accepted ranks, so rank 20 and every later
   rank cannot be supplied uniformly.

The final design is the largest uniform sequential extension supported across
the same 19 problems: Wave 4 uses ranks 11--15 and Wave 5 uses ranks 16--19.
There is no Wave 6. This second revision was made prospectively during live
Wave 3 before any Wave-3 output or result inspection.

Preparation, tokenizer gating, revision, and freezing read only static
manifests, frozen source files, the immutable dataset columns named below,
protocol controls, tokenizer files, and JDK tools. They do not read or
enumerate an inference result directory, perform language-model inference, or
create an inference result root. The post-Wave-2 count of four is an externally
supplied trigger/timing fact.

## Sequential launch rule

The two optional waves are frozen in advance but are not automatically
authorized to run.

1. Wave 4 may launch only after a complete valid post-Wave-3 audit reports
   fewer than 10 distinct strict canonical CodeContests problems.
2. Wave 5 may launch only after Wave 4 is complete and a complete valid
   post-Wave-4 audit reports fewer than 10 such problems.

If the threshold of 10 is reached, every later optional wave stops. A wave must
be completed before its audit; no interim outcome look within a wave is
allowed. Freezing a wave neither evaluates nor certifies its trigger.

## Frozen population and deterministic continuation

The source denominator remains the same 25 frozen Java source/obfuscation
variants. The same first tokenizer-eligible source used by balanced Waves 1--3
is retained for each of the same 19 canonical CodeContests rows. No new source
or canonical problem is introduced.

The selection unit is `(row_index, suite, dataset_test_index)`. Only
`private_tests` and `generated_tests` are loaded. Public tests are not loaded,
inspected, ranked, or selected. Every initial, supplemental, Wave-1, Wave-2,
and Wave-3 selection unit is excluded.

Eligible pairs use strict UTF-8, 5--512 input bytes, at most 60 expected-output
bytes, and at most seven expected-output lines. The deterministic rank key is:

1. private before generated;
2. fewer output lines;
3. fewer output bytes;
4. input-byte distance from 80;
5. dataset test index.

Both frozen sources must compile and execute on JDK 17 with no timeout, exit
zero, and empty stderr. Their historical-trimmed outputs must equal the dataset
oracle and one another. The rank stream is reconstructed from its beginning;
the frozen accepted ranks 1--10 are verified exactly before the continuation:

- Wave 4: accepted ranks 11--15, exactly 5 per problem (95 cases);
- Wave 5: accepted ranks 16--19, exactly 4 per problem (76 cases).

Wave 4 fails closed unless its exact 19-by-5 population can be supplied. Wave
5 fails closed unless its exact 19-by-4 population can be supplied. No smaller,
re-ranked, substituted, or partially frozen wave is permitted. Both failed
larger proposals remain in their preservation audits and are not overwritten.

## Tokenizer gate and launch plans

The Qwen/Qwen2.5-14B tokenizer at commit
`97e1e76335b7017d8f67c08a19d103c0504298c9` is loaded offline without model
weights. Every retained case must yield a non-positional SlicingPrior vector,
an active SliceHybrid CASES signal, and a prompt that fits the registered
512-token generation budget. A tokenizer rejection causes deterministic
scanning deeper in the same rank stream; any replacement retains a continuous
accepted-rank interpretation and all earlier frozen keys remain excluded.

Each triggered wave uses the unchanged Qwen2.5-14B base-model protocol: three
paired trials, all four registered conditions, temperature 1.05, top-p 0.95,
top-k 7, maximum 512 new tokens, and base seed 20260713. Wave 4 has exact shards
of 24, 24, 24, and 23 cases, corresponding to 288, 288, 288, and 276 expected
run records (1,140 total). Wave 5 has four exact 19-case shards, corresponding
to 228 records each (912 total). The maximum across both optional waves is
2,052 records. Launch-plan arguments are HERE-relative to
`long-code-sample-work`; the only prospective roots are
`balanced_extension2_contingency_inference/wave_4/shard_I` and
`balanced_extension2_contingency_inference/wave_5/shard_I`. Freezing creates no
such root, and no Wave-6 launch plan or prospective path exists.
