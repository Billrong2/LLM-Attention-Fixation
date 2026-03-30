# LLM Attention Fixation

LLM Attention Fixation is a research codebase for studying and steering code-generation attention under original and obfuscated program representations.

The repository combines:

- attention collection and rendering for code-generation runs
- structured steering priors, including slicing, AST, and CFG
- obfuscated-code evaluation runs against a prepared corpus
- execution-trace and counterfactual evaluation pipelines

## What This Repo Is For

The main workflow in this repository is:

1. prepare source Java cases or point the runner at a prepared obfuscated corpus
2. run model generation with optional steering
3. evaluate trace prediction or counterfactual behavior
4. analyze metrics across datasets and techniques

The current evaluation pipeline is designed to use standard grouped or trial metrics from generated runs. Cherry-pick reporting based on "best steered trials vs worst baseline trials" is intentionally excluded from the active pipeline.

## Main Components

- [main.py](/workspace/LLM-Attention-Fixation_gitready/main.py)
  - main attention-collection entrypoint
- [models.py](/workspace/LLM-Attention-Fixation_gitready/models.py)
  - model loading, generation, attention export, and steering integration
- [steering](/workspace/LLM-Attention-Fixation_gitready/steering)
  - steering configs, runtime logic, priors, and backend adapters
- [obfuscation](/workspace/LLM-Attention-Fixation_gitready/obfuscation)
  - obfuscated-code evaluation runner
- [evaluation](/workspace/LLM-Attention-Fixation_gitready/evaluation)
  - trace prediction, execution tracing, and evaluation helpers
- [scripts/steering/compute_head_mask.py](/workspace/LLM-Attention-Fixation_gitready/scripts/steering/compute_head_mask.py)
  - optional offline head-mask generation utility

## Running Qwen2.5

The lean artifact uses direct entrypoints instead of launcher wrappers.

Original/source-code steering run:

```bash
python main.py \
  --dataset humaneval \
  --model-name Qwen/Qwen2.5-Coder-7B-Instruct \
  --cache-dir .cache/models \
  --gpu-ids 0 \
  --runs-per-snippet 3 \
  --max-new-tokens 512 \
  --snippet Java_000 \
  --steer \
  --prior slice_hybrid \
  --beta-post 0.8 \
  --steer-last-n-layers 8 \
  --head-subset-mode none \
  --record-layers on \
  --auto-run-tag
```

Obfuscated-code steering run:

```bash
python obfuscation/main.py \
  --dataset humaneval \
  --source-root /path/to/obf_corpus \
  --model-name Qwen/Qwen2.5-Coder-7B-Instruct \
  --cache-dir .cache/models \
  --gpu-ids 0 \
  --code-snippet Java_000 \
  --techniques identifier_renaming \
  --runs-per-snippet 3 \
  --max-new-tokens 512 \
  --steer \
  --prior slice_hybrid \
  --beta-post 0.8 \
  --steer-last-n-layers 8 \
  --head-subset-mode none \
  --record-layers on \
  --auto-run-tag
```

Supported structured priors in the current steering stack include:

- `slice`
- `slice_hybrid`
- `ast`
- `cfg`

## Data And Artifacts

Large experiment outputs are expected to live outside Git, usually in external storage or a local `artifacts/` directory. This includes:

- attention visualizations
- generated run logs
- model caches
- obfuscation outputs
- derived metrics tables and plots

Generated artifacts and local machine state are intentionally ignored in Git so the repository stays source-focused.

## Security And Git Hygiene

This repository is configured to avoid committing local secrets and machine-specific files such as:

- API key files
- Hugging Face token files
- local editor settings
- local logs and generated reports
- certificate and private key material

Before pushing, it is still a good idea to review `git status` and confirm that no local datasets, logs, or secrets are staged.

## Typical Development Notes

- Keep large datasets and run outputs in external storage rather than the repository.
- Keep prepared obfuscated corpora outside the repository and pass them in with `--source-root`.
- Prefer grouped evaluation or full trial metrics over cherry-picked summaries.

## Status

This repository is under active research development. The GitHub-facing tree is intentionally lean: it keeps the core runtime and steering code while excluding launch wrappers, progress scripts, obfuscation-generation tooling, and generated artifacts.
