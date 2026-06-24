#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_directories=(
  ".github/workflows"
  "app"
  "scripts"
  "docs/images"
  "docs/evidence"
  "docs/troubleshooting"
  "docs/runner"
  ".vscode"
)

required_files=(
  "README.md"
  ".gitignore"
  ".env.example"
  "Makefile"
  "package.json"
  "Dockerfile"
  "app/server.js"
  "app/config.js"
  "scripts/safe-diagnostics.sh"
  "scripts/check-project.sh"
  "docs/setup-self-hosted-runner.md"
  "docs/security-notes.md"
  "docs/evidence.md"
  "docs/troubleshooting.md"
  "docs/runner/labels.md"
  ".vscode/settings.json"
  ".github/workflows/github-hosted-check.yml"
  ".github/workflows/self-hosted-check.yml"
  ".github/workflows/safe-diagnostics.yml"
  ".github/workflows/docker-self-hosted.yml"
)

for directory in "${required_directories[@]}"; do
  if [[ ! -d "$PROJECT_ROOT/$directory" ]]; then
    printf "Diretório ausente: %s\n" "$directory" >&2
    exit 1
  fi
done

for file in "${required_files[@]}"; do
  if [[ ! -f "$PROJECT_ROOT/$file" ]]; then
    printf "Arquivo ausente: %s\n" "$file" >&2
    exit 1
  fi
done

node --check "$PROJECT_ROOT/app/config.js" >/dev/null
node --check "$PROJECT_ROOT/app/server.js" >/dev/null

(
  cd "$PROJECT_ROOT"
  node -e "const config = require('./app/config'); if (!config.port) { process.exit(1); } console.log('Configuração carregada com sucesso na porta', config.port);"
)

printf "Validação concluída com sucesso.\n"
