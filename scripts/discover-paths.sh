#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

for scanner in "${SCRIPT_DIR}"/scanners/*.sh; do
  [[ -f "${scanner}" ]] || continue
  [[ "$(basename -- "${scanner}")" == "04-secrets.sh" ]] && continue
  bash "${scanner}"
done

custom_file="${SCRIPT_DIR}/scanners/99-custom-paths.txt"
if [[ -f "${custom_file}" ]]; then
  while IFS= read -r path; do
    [[ -n "${path}" && "${path}" != \#* ]] || continue
    [[ -e "${path}" ]] && printf '%s\n' "${path}"
  done < "${custom_file}"
fi
