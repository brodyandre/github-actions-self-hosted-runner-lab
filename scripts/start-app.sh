#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REQUIRED_NODE_MAJOR=20
APP_PORT="${PORT:-3000}"

run_local() {
  (
    cd "$PROJECT_ROOT"
    npm start
  )
}

if command -v node >/dev/null 2>&1; then
  current_node_major="$(node -p "process.versions.node.split('.')[0]")"

  if [[ "$current_node_major" -ge "$REQUIRED_NODE_MAJOR" ]]; then
    run_local
    exit 0
  fi
fi

if command -v docker >/dev/null 2>&1; then
  printf "Node.js local abaixo da versão esperada. Iniciando a aplicação em container Node 20 na porta %s.\n" "$APP_PORT"
  exec docker run --rm \
    -p "$APP_PORT:$APP_PORT" \
    -v "$PROJECT_ROOT:/app" \
    -w /app \
    node:20 \
    bash -lc "npm start"
fi

printf "Node.js 20 ou superior é necessário. Instale com 'nvm install 20 && nvm use 20' ou habilite Docker.\n" >&2
exit 1
