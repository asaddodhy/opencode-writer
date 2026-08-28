#!/usr/bin/env bash
set -euo pipefail

emit_config_entries() {
  local directory="$1"
  local path
  [[ -d "${directory}" && -r "${directory}" ]] || return 0
  for path in "${directory}"/* "${directory}"/.[!.]*; do
    [[ -e "${path}" ]] || continue
    case "$(basename -- "${path}")" in
      node_modules|antigravity-logs|logs|cache|caches|.cache) continue ;;
    esac
    printf '%s\n' "${path}"
  done
}

emit_config_entries "${HOME}/.config/opencode"
emit_config_entries "${HOME}/.novel-os"
