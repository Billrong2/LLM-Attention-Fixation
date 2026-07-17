# Static-prior cache equivalence smoke

This directory records a same-sample, same-trial, same-seed CodeSteer replay
after adding a runner-local cache for the deterministic prompt-static prior.
The comparison run is the already-completed uncached record at:

`../engineering_uncached_pilot/shard_0/runs/cc-valid-r113-s0083-1574-c-slay-the-dragon__t5_easy_seed1__00-generated-156/trial_001/obfuscated_codesteer`

The cached replay is:

`runs/cc-valid-r113-s0083-1574-c-slay-the-dragon__t5_easy_seed1__00-generated-156/trial_001/obfuscated_codesteer`

Both runs use paired seed `656761695`, the immutable Qwen2.5-14B snapshot
`97e1e76335b7017d8f67c08a19d103c0504298c9`, and the registered CodeSteer
profile. The prompt, decoded prompt, source, raw sampled completion, parsed
stdout, oracle, score, and complete steering-debug record are byte-identical.
In particular, both raw completions have SHA-256
`2c531540a37d2b50320bd73b73a0f922d30cc7b1f3c7a228c568ea9f0063f138`
and parse as `FINAL_OUTPUT_JSON: {"stdout":"1\n5\n"}`. The prediction is
incorrect in both runs; this smoke tests execution equivalence, not accuracy.

The uncached runner snapshot has SHA-256
`51a3d49b8b743e7750196bd7297f91bdafd73a0821f5a4e6f0c010ae9b16f01d`.
The cached runner has SHA-256
`62fad0d37d164f9adf925ddc37d9a9e2711a0b581ab0e9108c19ef2529da8807`.
The only intended runtime change is memoization within one `SteeringManager`,
keyed by `(current_bin, number_of_bins)`. The first request for a bin invokes
the original provider and stores its exact returned array; later redundant
requests return that same array without recomputing the deterministic
prompt-static slice.

`equivalence.json` contains the machine-readable identities and artifact
hashes. Run fingerprints and timestamps are expected to differ because the
runner implementation and experiment configuration explicitly record the
cache profile.
