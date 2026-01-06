python -u main.py \
  --level2 \
  --prior=ast \
  --gpu-ids=2 \
  --beta-post=0.8 \
  --n-bins=12 \
  --runs-per-snippet=200 \
  --model-name=codellama/CodeLlama-7b-Instruct-hf \
  --record-layers=off \
  --auto-run-tag