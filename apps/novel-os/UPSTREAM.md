# Upstream Snapshot

This directory is a source snapshot of the separate Novel OS application:

- Upstream repository: `https://github.com/mrigankad/Novel-OS`
- Upstream remote: `https://github.com/mrigankad/Novel-OS.git`
- Local source branch at snapshot time: `dev`
- Local source state: upstream `HEAD` plus the pre-existing uncommitted change to `web/package-lock.json`

The pending lockfile change was intentionally preserved. It removes 42 `libc` selector entries (`glibc` and `musl`) from optional Linux native-package records in `web/package-lock.json`. Dependency versions, package URLs, integrity hashes, and the application source were not changed. This is documented as a lockfile normalization/compatibility adjustment; the original project does not document a more specific intended fix.

The snapshot excludes secrets and generated/local runtime data, including `.env`, databases, virtual environments, caches, `outputs/`, `projects/`, `node_modules/`, and Python bytecode.

This directory is not an OpenCode adapter. It is included so both writing systems can be backed up from one repository while retaining their separate architectures.
