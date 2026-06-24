#!/usr/bin/env bash
set -euo pipefail

print_version() {
  local label="$1"
  shift

  if command -v "$1" >/dev/null 2>&1; then
    printf "%s: %s\n" "$label" "$("$@" 2>/dev/null)"
  else
    printf "%s: não encontrado\n" "$label"
  fi
}

printf "dateTime: %s\n" "$(date -Is)"
printf "hostname: %s\n" "$(hostname)"
printf "whoami: %s\n" "$(whoami)"
printf "pwd: %s\n" "$(pwd)"
printf "uname: %s\n" "$(uname -a)"
print_version "nodeVersion" node --version
print_version "npmVersion" npm --version
print_version "dockerVersion" docker --version
print_version "gitVersion" git --version
printf "GITHUB_ACTIONS: %s\n" "${GITHUB_ACTIONS:-}"
printf "RUNNER_OS: %s\n" "${RUNNER_OS:-}"
printf "RUNNER_ARCH: %s\n" "${RUNNER_ARCH:-}"
printf "RUNNER_NAME: %s\n" "${RUNNER_NAME:-}"
