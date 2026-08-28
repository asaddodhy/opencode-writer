#!/usr/bin/env bash
set -euo pipefail
umask 077

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
REPO_ROOT="$(CDPATH= cd -- "${SCRIPT_DIR}/.." && pwd)"
PROJECT_NAME="the-writer"
TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
ARCHIVE_NAME="${PROJECT_NAME}-backup-${TIMESTAMP}.tar.gz"
SECRETS_NAME="${PROJECT_NAME}-secrets-${TIMESTAMP}.tar.gz.age"
DESTINATION="${WRITER_BACKUP_DESTINATION:-/Volumes/Seagate_Backup_Plus_Drive/NAS/Local Repo Backup}"
FALLBACK="${WRITER_BACKUP_FALLBACK:-${HOME}/Writer-backups}"
RECIPIENT_FILE="${WRITER_AGE_RECIPIENT_FILE:-${REPO_ROOT}/config/age-recipient.txt}"
IDENTITY_FILE="${WRITER_AGE_IDENTITY_FILE:-${HOME}/.config/klip-backup/identity.txt}"
STAGING="$(mktemp -d "${TMPDIR:-/tmp}/the-writer-backup.XXXXXX")"
PAYLOAD="${STAGING}/payload"
SECRET_STAGING="${STAGING}/secrets"
MANIFEST="${STAGING}/manifest.txt"

cleanup() {
  rm -rf "${STAGING}"
}
trap cleanup EXIT INT TERM

[[ -r "${RECIPIENT_FILE}" ]] || { printf '%s\n' "ERROR: age recipient file is unreadable: ${RECIPIENT_FILE}" >&2; exit 1; }
command -v age >/dev/null || { printf '%s\n' "ERROR: age is required; install it with: brew install age" >&2; exit 1; }

mkdir -p "${PAYLOAD}" "${SECRET_STAGING}"
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
  local patch_dir="${PAYLOAD}/patches/${label}"

  [[ -d "${source_dir}/.git" ]] || return 0
  mkdir -p "${patch_dir}"
  git -C "${source_dir}" rev-parse HEAD > "${patch_dir}/base-commit.txt"
  cp "${source_dir}/.git/index" "${index_file}"

  local untracked
  untracked="$(git -C "${source_dir}" ls-files --others --exclude-standard -z | tr '\0' '\n')"
  if [[ -n "${untracked}" ]]; then
    while IFS= read -r path; do
      [[ -n "${path}" ]] || continue
      GIT_INDEX_FILE="${index_file}" git -C "${source_dir}" add -N -- "${path}"
    done <<< "${untracked}"
  fi

  GIT_INDEX_FILE="${index_file}" git -C "${source_dir}" diff --binary > "${patch_dir}/worktree.patch"
  printf '%s\n' "${source_dir}" > "${patch_dir}/source-path.txt"
}

capture_worktree_patch "${HOME}/Documents/Writing/novel-os" "novel-os-app"

printf '%s\n' "Backup project: ${PROJECT_NAME}" > "${PAYLOAD}/BACKUP-METADATA.txt"
printf '%s\n' "Created: $(date -u +%Y-%m-%dT%H:%M:%SZ)" >> "${PAYLOAD}/BACKUP-METADATA.txt"
printf '%s\n' "Source repository: ${REPO_ROOT}" >> "${PAYLOAD}/BACKUP-METADATA.txt"
printf '%s\n' "Main tarball excludes all secrets; see the adjacent encrypted secrets container." >> "${PAYLOAD}/BACKUP-METADATA.txt"
printf '%s\n' "Manifest source paths:" >> "${PAYLOAD}/BACKUP-METADATA.txt"
cat "${MANIFEST}" >> "${PAYLOAD}/BACKUP-METADATA.txt"

mkdir -p "${SECRET_STAGING}/secrets"
if [[ -f "${HOME}/Documents/Writing/novel-os/.env" ]]; then
  cp "${HOME}/Documents/Writing/novel-os/.env" "${SECRET_STAGING}/secrets/novel-os.env"
  chmod 600 "${SECRET_STAGING}/secrets/novel-os.env"
  printf '%s\n' "secrets/novel-os.env" > "${SECRET_STAGING}/SECRETS-MANIFEST.txt"
else
  : > "${SECRET_STAGING}/SECRETS-MANIFEST.txt"
fi

archive_path="${DESTINATION}/${ARCHIVE_NAME}"
secrets_path="${DESTINATION}/${SECRETS_NAME}"
if ! mkdir -p "${DESTINATION}" 2>/dev/null; then
  printf '%s\n' "WARNING: Network destination unavailable; using local fallback: ${FALLBACK}" >&2
  DESTINATION="${FALLBACK}"
  mkdir -p "${DESTINATION}"
  archive_path="${DESTINATION}/${ARCHIVE_NAME}"
  secrets_path="${DESTINATION}/${SECRETS_NAME}"
  backup_destination="local-fallback"
else
  backup_destination="network"
fi

tar -czf "${archive_path}" -C "${STAGING}" payload
tar -czf - -C "${SECRET_STAGING}" . | age -r "$(tr -d '\r\n' < "${RECIPIENT_FILE}")" -o "${secrets_path}"
chmod 600 "${secrets_path}"

gzip -t "${archive_path}"
entry_count="$(tar -tzf "${archive_path}" | wc -l | tr -d ' ')"
secret_entry_count="$(age -d -i "${IDENTITY_FILE}" "${secrets_path}" | tar -tzf - | wc -l | tr -d ' ')"
[[ "${entry_count}" -gt 10 ]] || { printf '%s\n' "ERROR: Main archive entry count is implausibly low: ${entry_count}" >&2; exit 1; }
[[ "${secret_entry_count}" -ge 2 ]] || { printf '%s\n' "ERROR: Secrets archive verification found too few entries: ${secret_entry_count}" >&2; exit 1; }

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

if tar -tzf "${archive_path}" | grep -Eiq '(^|/)\.env$|auth\.json$|credentials\.json$|token\.json$|\.pem$|\.p12$|\.pfx$|\.key$'; then
  printf '%s\n' "ERROR: Secret-like file found in main tarball" >&2
  exit 1
fi

age -d -i "${IDENTITY_FILE}" "${secrets_path}" | tar -tzf - | grep -Fqx "./secrets/novel-os.env"

printf '%s\n' "MAIN_ARCHIVE=${archive_path}"
printf '%s\n' "SECRETS_CONTAINER=${secrets_path}"
printf '%s\n' "MAIN_ARCHIVE_ENTRIES=${entry_count}"
printf '%s\n' "SECRETS_CONTAINER_ENTRIES=${secret_entry_count}"
printf '%s\n' "MAIN_ARCHIVE_VERIFIED=true"
printf '%s\n' "SECRETS_CONTAINER_VERIFIED=true"
