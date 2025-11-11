#!/usr/bin/env bash

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_ROOT"

for source_file in Source/*.java; do
    snippet="$(basename "$source_file" .java)"
    python -u main.py \
        --skip-steering \
        --runs-per-snippet 1000 \
        --snippet "$snippet"
done
