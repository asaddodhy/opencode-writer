# Opencode Writer

Reusable writing workflows for OpenCode, organized around the Novel-OS system.

The repository separates the writing system from its client integration:

- `core/novel-os/` contains model-independent writing standards and workflows.
- `adapters/opencode/` contains OpenCode commands, agents, routing rules, and project configuration.
- `apps/novel-os/` contains a sanitized source snapshot of the separate Novel OS application.
- `adapters/` is reserved for future integrations with other writing tools.

This repository is the port of the workflow/configuration project at
`forsonny/book-os`. It is separate from the similarly named Python application
at `mrigankad/Novel-OS`; see `docs/MIGRATION-AUDIT.md` for the distinction.

## Capabilities

- Plan a novel with `/plan-novel`.
- Create an outline with `/create-outline`.
- Write scenes with `/write-scenes`.
- Analyze an existing manuscript with `/analyze-manuscript`.
- Switch between OpenCode's normal `build` agent and the `novelist` primary agent.
- Delegate focused work to prose, continuity, workflow, manuscript, and context subagents.

The normal OpenCode `build` agent remains available for coding. The `novelist` agent adds the creative-writing persona and Novel-OS workflow awareness.

## Installation

From this repository, run:

```bash
./install.sh
```

The installer copies:

- Novel-OS core files to `~/.novel-os/`.
- Global OpenCode commands, agents, and routing rules to `~/.config/opencode/`.

It does not configure a model provider, API key, MCP server, or project-specific `opencode.json`. Configure those separately for the OpenCode installation you use.

To install the project adapter in a novel project, copy the contents of `adapters/opencode/project/` into that project. The included `opencode.json` defines the `novelist` agent and leaves provider selection to OpenCode's normal configuration.

## Usage

Start OpenCode in a project and switch agents with `Tab`:

- `build`: normal coding and general development.
- `novelist`: Novel-OS writing workflows.

Commands and subagents are globally available after installation. Novel-specific files are created inside each project under `.novel-os/`.

## Repository Policy

This repository stores reusable configuration, instructions, and a sanitized application source snapshot. Manuscripts, generated project state, credentials, databases, virtual environments, and dependency directories do not belong here.

## Source

Novel-OS is adapted from [forsonny/book-os](https://github.com/forsonny/book-os). This repository contains the OpenCode-compatible adaptation of its Novel-OS workflows.
