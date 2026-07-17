#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

python3 package_long_code_case_study.py \
  --audit-json combined_audit_wave4/long_code_audit.json \
  --audit-candidates-csv combined_audit_wave4/long_code_candidates.csv \
  --audit-runs-csv combined_audit_wave4/long_code_runs.csv \
  --tokenizer-report tokenizer_preflight/full_report.json \
  --tokenizer-exclusions tokenizer_preflight/exclusions.jsonl \
  --tokenizer-manifest tokenizer_preflight/inference_eligible_variants.json \
  --tokenizer-set-name initial \
  --tokenizer-report supplemental_tokenizer_preflight/full_report.json \
  --tokenizer-exclusions supplemental_tokenizer_preflight/exclusions.jsonl \
  --tokenizer-manifest supplemental_tokenizer_preflight/inference_eligible_variants.json \
  --tokenizer-set-name supplemental \
  --tokenizer-report balanced_contingency/tokenizer_preflight/wave_1/full_report.json \
  --tokenizer-exclusions balanced_contingency/tokenizer_preflight/wave_1/exclusions.jsonl \
  --tokenizer-manifest balanced_contingency/tokenizer_preflight/wave_1/inference_eligible_variants.json \
  --tokenizer-set-name balanced_wave_1 \
  --tokenizer-report balanced_contingency/tokenizer_preflight/wave_2/full_report.json \
  --tokenizer-exclusions balanced_contingency/tokenizer_preflight/wave_2/exclusions.jsonl \
  --tokenizer-manifest balanced_contingency/tokenizer_preflight/wave_2/inference_eligible_variants.json \
  --tokenizer-set-name balanced_wave_2 \
  --tokenizer-report balanced_extension_contingency/tokenizer_preflight/full_report.json \
  --tokenizer-exclusions balanced_extension_contingency/tokenizer_preflight/exclusions.jsonl \
  --tokenizer-manifest balanced_extension_contingency/tokenizer_preflight/inference_eligible_variants.json \
  --tokenizer-set-name balanced_wave_3 \
  --tokenizer-report balanced_extension2_contingency/tokenizer_preflight/wave_4/full_report.json \
  --tokenizer-exclusions balanced_extension2_contingency/tokenizer_preflight/wave_4/exclusions.jsonl \
  --tokenizer-manifest balanced_extension2_contingency/tokenizer_preflight/wave_4/inference_eligible_variants.json \
  --tokenizer-set-name balanced_wave_4 \
  --balanced-contingency-root balanced_contingency \
  --balanced-extension-contingency-root balanced_extension_contingency \
  --balanced-extension2-contingency-root balanced_extension2_contingency \
  --manual-review manual_trace_review_wave4_paired.json \
  --output-dir case-study-staging-wave4-paired \
  full_results_cached/shard_0 \
  full_results_cached/shard_1 \
  full_results_cached/shard_2 \
  full_results_cached/shard_3 \
  supplemental_results/shard_0 \
  supplemental_results/shard_1 \
  supplemental_results/shard_2 \
  supplemental_results/shard_3 \
  balanced_contingency_inference/wave_1/shard_0 \
  balanced_contingency_inference/wave_1/shard_1 \
  balanced_contingency_inference/wave_1/shard_2 \
  balanced_contingency_inference/wave_1/shard_3 \
  balanced_contingency_inference/wave_2/shard_0 \
  balanced_contingency_inference/wave_2/shard_1 \
  balanced_contingency_inference/wave_2/shard_2 \
  balanced_contingency_inference/wave_2/shard_3 \
  balanced_extension_contingency_inference/wave_3/shard_0 \
  balanced_extension_contingency_inference/wave_3/shard_1 \
  balanced_extension_contingency_inference/wave_3/shard_2 \
  balanced_extension_contingency_inference/wave_3/shard_3 \
  balanced_extension2_contingency_inference/wave_4/shard_0 \
  balanced_extension2_contingency_inference/wave_4/shard_1 \
  balanced_extension2_contingency_inference/wave_4/shard_2 \
  balanced_extension2_contingency_inference/wave_4/shard_3
