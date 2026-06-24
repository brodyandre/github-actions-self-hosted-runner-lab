#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

print_section() {
  printf "\n== %s ==\n" "$1"
}

print_tool_version() {
  local tool_name="$1"

  if command -v "$tool_name" >/dev/null 2>&1; then
    "$tool_name" --version
  else
    printf "%s: não encontrado\n" "$tool_name"
  fi
}

print_section "Contexto"
printf "Data: %s\n" "$(date -Is)"
printf "Projeto: %s\n" "$PROJECT_ROOT"
uname -a

if grep -qi microsoft /proc/version 2>/dev/null; then
  printf "WSL detectado: sim\n"
else
  printf "WSL detectado: não\n"
fi

print_section "Ferramentas"
print_tool_version node
print_tool_version npm
print_tool_version git
printf "Node.js recomendado para o laboratório: 20.x ou superior\n"

if command -v docker >/dev/null 2>&1; then
  docker --version
else
  printf "docker: não encontrado\n"
fi

print_section "Estrutura do laboratório"
find "$PROJECT_ROOT/.github/workflows" -maxdepth 1 -type f -name "*.yml" -printf "%f\n" | sort

print_section "Espaço em disco"
df -h "$PROJECT_ROOT" | sed -n '1,2p'

print_section "Observação"
printf "Este script não imprime variáveis de ambiente, tokens, segredos ou arquivos sensíveis do runner.\n"
