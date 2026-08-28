#!/usr/bin/env bash
set -euo pipefail

repo_root="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"
novel_os_dir="${HOME}/.novel-os"
opencode_dir="${HOME}/.config/opencode"

mkdir -p \
  "${novel_os_dir}/standards/genre-guides" \
  "${novel_os_dir}/instructions/core" \
  "${novel_os_dir}/instructions/meta" \
  "${opencode_dir}/agents" \
  "${opencode_dir}/commands"

cp "${repo_root}/core/novel-os/standards-writing-style.md" \
  "${novel_os_dir}/standards/writing-style.md"
cp "${repo_root}/core/novel-os/standards-narrative-techniques.md" \
  "${novel_os_dir}/standards/narrative-techniques.md"
cp "${repo_root}/core/novel-os/instructions-plan-novel.md" \
  "${novel_os_dir}/instructions/core/plan-novel.md"
cp "${repo_root}/core/novel-os/instructions-create-outline.md" \
  "${novel_os_dir}/instructions/core/create-outline.md"
cp "${repo_root}/core/novel-os/instructions-write-scenes.md" \
  "${novel_os_dir}/instructions/core/write-scenes.md"
cp "${repo_root}/core/novel-os/instructions-write-scene.md" \
  "${novel_os_dir}/instructions/core/write-scene.md"
cp "${repo_root}/core/novel-os/instructions-analyze-manuscript.md" \
  "${novel_os_dir}/instructions/core/analyze-manuscript.md"
cp "${repo_root}/core/novel-os/instructions-pre-flight.md" \
  "${novel_os_dir}/instructions/meta/pre-flight.md"

cp "${repo_root}/adapters/opencode/global/AGENTS.md" "${opencode_dir}/AGENTS.md"
cp "${repo_root}/adapters/opencode/global/agents/"*.md "${opencode_dir}/agents/"
cp "${repo_root}/adapters/opencode/global/commands/"*.md "${opencode_dir}/commands/"

printf '%s\n' "Installed Novel-OS core and OpenCode adapter."
printf '%s\n' "Project adapter: copy adapters/opencode/project/ into each writing project."
