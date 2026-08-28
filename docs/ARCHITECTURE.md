# Architecture

## Core

`core/novel-os/` is the shared, model-independent layer. It contains the three-layer context model, writing standards, and workflow instructions. The core does not assume Claude Code, OpenCode, Gemini CLI, or a particular provider.

## Adapters

Each client integration belongs under `adapters/<tool>/`.

The OpenCode adapter has two scopes:

- `global/`: files installed once under `~/.config/opencode/`.
- `project/`: files copied into a project, including the `novelist` agent configuration and its persona prompt.

Future tools should reuse the core files and provide only their own command, context, agent, or system-prompt format.

## Runtime State

Novel-OS stores reusable global files in `~/.novel-os/`. Each writing project stores its own premise, outline, tasks, and manuscript metadata in `.novel-os/`.

The repository intentionally does not contain a manuscript or generated project state.
