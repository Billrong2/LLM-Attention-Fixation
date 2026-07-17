# Prompt Steering

This experiment extends the baseline output-prediction experiment used for the six reported Table 2 rows. It reuses the exact slicing prior from the baseline and reruns output prediction with the corresponding slices explicitly stated in the natural-language prompt. This is prompt-only steering: it does not install attention hooks or apply activation-level steering.

The Qwen2.5-7B/CruxEval and DeepSeek-6.7B/CruxEval rows are intentionally excluded. The two `long-code-*` directories are separate experiments and are not part of this pipeline.

## Reproduce the reported numbers

The portable result archive contains the exact prompts, sampled completions, generation settings, logical source identities, source hashes, oracle/predicted labels, and per-case scores for 24,018 trials. Machine-specific paths and tensor-heavy token/attention fields were removed.

```bash
cd PromptSteering
sha256sum -c results/SHA256SUMS
python evaluate_prompt_results.py
python -m unittest -v test_evaluate_prompt_results.py
```

`evaluate_prompt_results.py` validates the archived attempts, rejects incomplete or duplicate records and case-set drift, and reproduces the reported cumulative Pass@k values.

| Model | Dataset | P@1 | P@2 | P@3 |
|---|---|---:|---:|---:|
| Qwen2.5-7B | HumanEval | 72.99 | 81.74 | 85.74 |
| DeepSeek-6.7B | HumanEval | 65.91 | 84.52 | 90.08 |
| Qwen2.5-14B | HumanEval | 86.82 | 93.66 | 96.29 |
| Qwen2.5-14B | CruxEval | 89.42 | 96.25 | 98.15 |
| DeepSeek-V2-Lite | HumanEval | 68.00 | 82.35 | 88.19 |
| DeepSeek-V2-Lite | CruxEval | 79.66 | 93.79 | 97.42 |

The authoritative protocol, exact correct-case counts, denominators, and baseline anchors are in `results/table2_manifest.json`. The generated CSV is `results/table2_prompt_steering.csv`.

## Generate new trials

Generation requires the repository-level model/evaluation code, the prepared Java variants under `Rebuttal/artifacts/obfuscation/source`, a Java 17 JDK, and the Python packages in `requirements.txt`. Set model cache locations as needed, then run:

```bash
export PROMPT_JAVA_HOME=/path/to/jdk-17
export CACHE_DIR=/path/to/huggingface/cache
bash run_prompt_slice_final_pipeline.sh
```

The launcher runs only the six rows listed above with slice prompts, three sampled trials, temperature 0.9, and top-p 0.95. Optional `SHARD_INDEX`, `NUM_SHARDS`, `SNIPPETS`, and `GPU_IDS` variables support partial execution. A partial shard deliberately skips final export and evaluation.

The original experiment did not record immutable model/tokenizer revisions or a complete hardware environment, and sampled inference can vary across software and hardware stacks. Therefore, this package guarantees exact **reaggregation** of the archived results, not bit-for-bit regeneration of model completions.

For compatibility with the reported experiment, counterfactual answer parsing retains the original permissive behavior: complete JSON is preferred, but embedded JSON and a small regex fallback can also be scored. Changing that parser changes the reported numbers.

## Main files

- `run_prompt_slice_final_pipeline.sh`: six-row generation pipeline.
- `run_element_prompt_steering_output.py`: prompt construction, generation, and per-case scoring.
- `element_prompting.py` and `prompt.py`: syntax-derived structural guidance.
- `prompt_steering_common.py`: source discovery and Java compatibility helpers.
- `export_prompt_results.py`: deterministic portable-result exporter.
- `evaluate_prompt_results.py`: strict Table 2 evaluator.
- `results/`: compact trial archive, manifest, checksums, and reproduced table.
