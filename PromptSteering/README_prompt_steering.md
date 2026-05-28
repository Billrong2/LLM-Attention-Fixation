# Prompt-Steering Baselines

This directory contains Prompt-Steering baselines for Qwen/Qwen2.5-Coder-7B-Instruct:

- General Prompt-Steering: asks the model to focus on AST, CFG, or Slice information in natural language.
- Node-specific Prompt-Steering: explicitly injects static AST/CFG/Slice elements into the prompt.

## HumanEval Obfuscated Results (Preliminary)

| HumanEval obfuscated setting | Metric | AST | CFG | Slice | Best |
| --- | --- | ---: | ---: | ---: | ---: |
| General Prompt-Steering | Output pass@1 | 35.83 | 35.83 | 28.35 | 35.83 |
| Node-specific Prompt-Steering | Output pass@1 | 32.68 | 35.04 | 38.58 | 38.58 |
| Best Prompt-Steering | Output pass@1 | 35.83 | 35.83 | 38.58 | 38.58 |
| General Prompt-Steering | Trace F1 | 17.66 | 17.87 | 17.82 | 17.87 |
| Node-specific Prompt-Steering | Trace F1 | 17.79 | 17.79 | 17.75 | 17.79 |
