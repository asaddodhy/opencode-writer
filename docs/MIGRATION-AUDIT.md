# Migration Audit

## Source Repositories

The workflow port in this repository comes from:

- `https://github.com/forsonny/book-os` — the original Book-OS/Novel-OS workflow and configuration repository.

The local directory `/Users/dodhya/Documents/Writing/novel-os` is a different project:

- `https://github.com/mrigankad/Novel-OS` — a Python application with an orchestrator, persistent StoryState database, runtime agents, continuity engine, API, web UI, and tests.

That application was already present in the workspace. It was not created by the Book-OS port and is not part of this repository.

## Book-OS Migration Coverage

### Migrated and adapted

- Core workflow instructions: planning, outlining, scene writing, and manuscript analysis
- Pre-flight instructions
- Writing style and narrative technique standards
- Literary fiction, mystery/thriller, and fantasy/science-fiction genre guides
- Description style guide
- Novel-OS assistant persona as an OpenCode `novelist` primary agent
- Context researcher, manuscript creator, writing workflow, prose reviewer, continuity checker, and date checker subagents
- Novel-OS command routing as OpenCode commands
- Global OpenCode routing documentation

### Intentionally not copied verbatim

- Claude Code output-style and command syntax
- Claude Code and Cursor installers
- Windows-specific setup scripts
- Model/provider configuration and credentials

Those items are replaced by the OpenCode adapter and the provider configuration remains OpenCode's responsibility.

## Separate Application

The local `Writing/novel-os` application should be backed up separately if desired. It should not be mixed into this adapter repository because it has a different architecture, runtime, data model, and upstream repository. Its `.env`, database, virtual environment, caches, and generated files must be reviewed before any separate backup.

## Preserved Lockfile Change

The application snapshot includes the pre-existing local modification to `apps/novel-os/web/package-lock.json`. The change removes 42 `libc` selector fields from optional Linux native binding records, including `glibc` and `musl` values. It does not change dependency versions, resolved package URLs, integrity hashes, or application code. Because the source project does not document the motivation, this repository records it as a lockfile normalization/compatibility adjustment rather than attributing it to a confirmed bug fix.
