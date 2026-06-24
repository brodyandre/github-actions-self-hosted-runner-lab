#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
NODE20_RUNNER="$PROJECT_ROOT/scripts/run-with-node20.sh"

required_files=(
  "README.md"
  "package.json"
  "app/server.js"
  "test/server.test.js"
  "scripts/safe-diagnostics.sh"
  "docs/setup-self-hosted-runner.md"
  "docs/security-notes.md"
  ".github/workflows/github-hosted-runner.yml"
  ".github/workflows/self-hosted-runner.yml"
  ".github/workflows/self-hosted-diagnostics.yml"
  ".github/workflows/docker-self-hosted.yml"
)

for file in "${required_files[@]}"; do
  if [[ ! -f "$PROJECT_ROOT/$file" ]]; then
    printf "Arquivo ausente: %s\n" "$file" >&2
    exit 1
  fi
done

printf "Arquivos obrigatórios encontrados com sucesso.\n"
"$NODE20_RUNNER" "npm test"

printf "Validação concluída com sucesso.\n"
