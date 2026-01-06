python -u main.py \
  --level2 \
  --prior=cfg \
  --gpu-ids=3 \
  --model-name=codellama/CodeLlama-7b-Instruct-hf \
  --beta-post=0.8 \
  --n-bins=12 \
  --runs-per-snippet=200 \
  --record-layers=off \
  --auto-run-tag
