python -u main.py \
  --level2 \
  --gpu-ids=0 \
  --prior=slice \
  --beta-post=0.8 \
  --n-bins=12 \
  --runs-per-snippet=200 \
  --model-name=codellama/CodeLlama-7b-Instruct-hf \
  --record-layers=off \
  --auto-run-tag