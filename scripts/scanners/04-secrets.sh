#!/usr/bin/env bash
set -euo pipefail

if [[ -f "${HOME}/Documents/Writing/novel-os/.env" && -r "${HOME}/Documents/Writing/novel-os/.env" ]]; then
  printf '%s\n' "${HOME}/Documents/Writing/novel-os/.env"
fi
