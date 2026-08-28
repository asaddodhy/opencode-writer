#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
REPO_ROOT="$(CDPATH= cd -- "${SCRIPT_DIR}/.." && pwd)"
PROJECT_NAME="the-writer"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
ARCHIVE_NAME="${PROJECT_NAME}-backup-${TIMESTAMP}.tar.gz"
NETWORK_DESTINATION="${WRITER_BACKUP_DESTINATION:-/Volumes/Seagate_Backup_Plus_Drive/The Writer}"
LOCAL_FALLBACK="${WRITER_BACKUP_FALLBACK:-${HOME}/Writer-backups}"
STAGING="$(mktemp -d "${TMPDIR:-/tmp}/the-writer-backup.XXXXXX")"
PAYLOAD="${STAGING}/payload"
MANIFEST="${STAGING}/manifest.txt"

cleanup() {
  rm -rf "${STAGING}"
}
trap cleanup EXIT

mkdir -p "${PAYLOAD}"

"${SCRIPT_DIR}/discover-paths.sh" > "${MANIFEST}"

while IFS= read -r source_path; do
  [[ -n "${source_path}" ]] || continue
  [[ -e "${source_path}" ]] || continue
  relative_path="${source_path#/}"
  destination="${PAYLOAD}/${relative_path}"
  mkdir -p "$(dirname -- "${destination}")"
  cp -R "${source_path}" "${destination}"
done < "${MANIFEST}"

capture_worktree_patch() {
  local source_dir="$1"
  local label="$2"
  local index_file="${STAGING}/${label}.index"
  local patch_file="${PAYLOAD}/patches/${label}/worktree.patch"
  local base_file="${PAYLOAD}/patches/${label}/base-commit.txt"

  [[ -d "${source_dir}/.git" ]] || return 0
  mkdir -p "$(dirname -- "${patch_file}")"
  git -C "${source_dir}" rev-parse HEAD > "${base_file}"

  if [[ -f "${source_dir}/.git/index" ]]; then
    cp "${source_dir}/.git/index" "${index_file}"
  else
    : > "${index_file}"
  fi

  local untracked
  untracked="$(git -C "${source_dir}" ls-files --others --exclude-standard -z | tr '\0' '\n')"
  if [[ -n "${untracked}" ]]; then
    while IFS= read -r path; do
      [[ -n "${path}" ]] || continue
      GIT_INDEX_FILE="${index_file}" git -C "${source_dir}" add -N -- "${path}"
    done <<< "${untracked}"
  fi

  GIT_INDEX_FILE="${index_file}" git -C "${source_dir}" diff --binary > "${patch_file}"
  printf '%s\n' "${source_dir}" > "${PAYLOAD}/patches/${label}/source-path.txt"
}

capture_worktree_patch "${HOME}/Documents/Writing/novel-os" "novel-os-app"

printf '%s\n' "Backup project: ${PROJECT_NAME}" > "${PAYLOAD}/BACKUP-METADATA.txt"
printf '%s\n' "Created: $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "${PAYLOAD}/BACKUP-METADATA.txt"
printf '%s\n' "Source repository: ${REPO_ROOT}" >> "${PAYLOAD}/BACKUP-METADATA.txt"
printf '%s\n' "Manifest source paths:" >> "${PAYLOAD}/BACKUP-METADATA.txt"
cat "${MANIFEST}" >> "${PAYLOAD}/BACKUP-METADATA.txt"

archive_path="${NETWORK_DESTINATION}/${ARCHIVE_NAME}"
if mkdir -p "${NETWORK_DESTINATION}" 2>/dev/null && tar -czf "${archive_path}" -C "${STAGING}" payload; then
  printf '%s\n' "BACKUP_DESTINATION=network"
  printf '%s\n' "BACKUP_ARCHIVE=${archive_path}"
else
  printf '%s\n' "WARNING: Network destination unavailable; using local fallback: ${LOCAL_FALLBACK}" >&2
  mkdir -p "${LOCAL_FALLBACK}"
  archive_path="${LOCAL_FALLBACK}/${ARCHIVE_NAME}"
  tar -czf "${archive_path}" -C "${STAGING}" payload
  printf '%s\n' "BACKUP_DESTINATION=local-fallback"
  printf '%s\n' "BACKUP_ARCHIVE=${archive_path}"
fi

gzip -t "${archive_path}"
entry_count="$(tar -tzf "${archive_path}" | wc -l | tr -d ' ')"
[[ "${entry_count}" -gt 10 ]] || { printf '%s\n' "ERROR: Archive entry count is implausibly low: ${entry_count}" >&2; exit 1; }
for critical in \
  "payload/BACKUP-METADATA.txt" \
  "payload/patches/novel-os-app/base-commit.txt" \
  "payload/patches/novel-os-app/worktree.patch" \
  "payload/${HOME#/}/.config/opencode/AGENTS.md" \
  "payload/${HOME#/}/.novel-os/standards/writing-style.md"; do
  tar -tzf "${archive_path}" | grep -Fqx "${critical}" || {
    printf '%s\n' "MISSING: ${critical}" >&2
    exit 1
  }
done

printf '%s\n' "ARCHIVE_ENTRIES=${entry_count}"
printf '%s\n' "ARCHIVE_VERIFIED=true"
