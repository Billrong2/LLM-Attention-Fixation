# Initial-screen cached runner snapshot

`run_long_code_experiment.py` is the exact runner used for the valid 23-sample
initial screen under `full_results_cached/`. Its SHA-256 is
`62fad0d37d164f9adf925ddc37d9a9e2711a0b581ab0e9108c19ef2529da8807`,
matching every initial result root's environment provenance.

The current runner later changed only to correct concrete-case path precedence
for the supplemental manifest. Keeping this snapshot allows the packager to
copy and verify the exact runtime dependency for both experiment waves.
