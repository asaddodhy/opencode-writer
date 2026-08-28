# Installation

## OpenCode

Run from the repository root:

```bash
./install.sh
```

This installs the shared Novel-OS core and the global OpenCode adapter. It does not overwrite provider settings or install credentials.

For a specific project, copy the project adapter files:

```bash
cp -R adapters/opencode/project/.opencode /path/to/your/project/
cp adapters/opencode/project/opencode.json /path/to/your/project/
```

The project adapter's `opencode.json` defines the `novelist` agent and references the included persona prompt. Keep provider configuration in your own OpenCode configuration.

Restart OpenCode after installation so it discovers the new agents and commands.

## Verification

Check that these paths exist:

```bash
ls ~/.novel-os/instructions/core
ls ~/.config/opencode/agents
ls ~/.config/opencode/commands
```

In OpenCode, use `Tab` to select `novelist`. Use `@prose-reviewer`, `@continuity-checker`, and the other specialized agents when needed.
