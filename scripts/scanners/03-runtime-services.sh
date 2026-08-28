#!/usr/bin/env bash
set -euo pipefail

emit_readable_files() {
  local directory="$1"
  [[ -d "${directory}" && -r "${directory}" ]] || return 0
  for path in "${directory}"/*; do
    if [[ -f "${path}" && -r "${path}" ]]; then
      printf '%s\n' "${path}"
    fi
  done
}

emit_readable_files "${HOME}/Library/LaunchAgents"
emit_readable_files "${HOME}/Library/LaunchDaemons"
emit_readable_files "/Library/LaunchAgents"
emit_readable_files "/Library/LaunchDaemons"
