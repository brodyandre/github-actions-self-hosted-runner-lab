#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REQUIRED_NODE_MAJOR=20

if [[ $# -eq 0 ]]; then
  printf "Uso: %s '<comando>'\n" "$(basename "$0")" >&2
  exit 1
fi

run_command() {
  (
    cd "$PROJECT_ROOT"
    bash -lc "$1"
  )
}

if command -v node >/dev/null 2>&1; then
  current_node_major="$(node -p "process.versions.node.split('.')[0]")"

  if [[ "$current_node_major" -ge "$REQUIRED_NODE_MAJOR" ]]; then
    run_command "$1"
    exit 0
  fi
fi

if command -v docker >/dev/null 2>&1; then
  printf "Node.js local abaixo da versão esperada. Executando em container Node 20.\n"
  docker run --rm \
    --user "$(id -u):$(id -g)" \
    -v "$PROJECT_ROOT:/app" \
    -w /app \
    node:20 \
    bash -lc "$1"
  exit 0
fi

printf "Node.js 20 ou superior é necessário. Instale com 'nvm install 20 && nvm use 20' ou habilite Docker.\n" >&2
exit 1
