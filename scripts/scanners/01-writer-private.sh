#!/usr/bin/env bash
set -euo pipefail

emit() {
  if [[ -e "$1" ]]; then
    printf '%s\n' "$1"
  fi
}

emit "${HOME}/Documents/Writing/novel-os/.env"
emit "${HOME}/Documents/Writing/novel-os/novel_os.db"
emit "${HOME}/Documents/Writing/novel-os/projects"
