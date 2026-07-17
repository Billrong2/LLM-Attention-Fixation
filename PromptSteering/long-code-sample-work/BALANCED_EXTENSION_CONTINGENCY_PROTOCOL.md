# Frozen balanced extension contingency (Wave 3)

This protocol defines one conditional, adaptive extension wave for the
long-code qualitative case search. It was specified after the formal
initial-plus-supplemental strict canonical-problem count was 4 and during
corrected Wave 1, after an aggregate interim results-index exact-count look at
the then-completed subset. That look showed zero exact CodeSteer trials in the
subset and included identifiers of samples with baseline exact matches. No raw
model completion, reasoning trace, oracle content, or per-CodeSteer-success
content was used to specify the contingency or its case rules. An earlier
path-only startup attempt was excluded without inspecting its result contents
or scores.

This contingency is not preregistered and is not outcome-blind in timing. Its
case eligibility, ranking, and selection are nevertheless deterministic and
outcome-independent: no Wave-1 or Wave-2 outcome is an input to those rules.

Wave 3 may run only if a complete valid post-Wave-2 audit has fewer than ten
strict canonical CodeContests problems. The complete 114-case wave must be run
without interim outcome looks. Preparing, tokenizer-gating, and freezing this
wave do not evaluate that future trigger and do not read model results.

## Frozen population and selection

The source denominator remains the same 25 frozen Java source/obfuscation
variants. The same first tokenizer-eligible source used by balanced Waves 1 and
2 is retained for each of the 19 canonical CodeContests rows. No new source is
introduced.

The selection unit is `(row_index, suite, dataset_test_index)`. Only
`private_tests` and `generated_tests` are loaded. Public tests are not loaded,
inspected, ranked, or selected. Every initial, supplemental, Wave-1, and Wave-2
selection unit is excluded.

Eligible pairs use strict UTF-8, 5--512 input bytes, at most 60 expected-output
bytes, and at most seven expected-output lines. Ranking is deterministic:

1. private before generated;
2. fewer output lines;
3. fewer output bytes;
4. input-byte distance from 80;
5. dataset test index.

Both frozen sources must compile and execute on JDK 17 with no timeout, exit
zero, and empty stderr. Their historical-trimmed outputs must equal the dataset
oracle and one another. The prior deterministic ranking is reconstructed and
the frozen accepted ranks 1--4 are verified exactly. The next six passing cases
per canonical problem are accepted ranks 5--10, producing 114 cases.

## Exact tokenizer gate and inference plan

The Qwen/Qwen2.5-14B tokenizer at commit
`97e1e76335b7017d8f67c08a19d103c0504298c9` is loaded offline without model
weights. Every retained case must yield a non-positional SlicingPrior vector,
an active CASES signal, and a prompt that fits the registered 512-token
generation budget. A tokenizer rejection causes deterministic scanning deeper
in the same ranking before the manifest is re-frozen.

If the future trigger is met, Wave 3 uses the unchanged Qwen2.5-14B base-model
protocol: three paired trials, all four registered conditions, sampling at
temperature 1.05, top-p 0.95, top-k 7, maximum 512 new tokens, and base seed
20260713. The exact four shard sizes are 29, 29, 28, and 28 cases, corresponding
to 348, 348, 336, and 336 run records (1,368 total).

Case eligibility, ranking, and selection use no completion, score, aggregate
count, or sample identifier from the interim look. Preparation and freezing
read no inference result files, perform no language-model inference, and create
no result root. The aggregate interim look described above is disclosed as an
external timing fact and makes this an adaptive contingency.
