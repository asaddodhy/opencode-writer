# Pre-Flight Rules

## Path Resolution

Throughout these workflows, you'll see references like `~/.novel-os/...` or `.novel-os/...`. Use the actual path relative to the current working directory.

- `~/.novel-os/` refers to the global Novel-OS installation at the user's home directory
- `.novel-os/` refers to the project-level Novel-OS directory in the current working directory

Use absolute paths for all file operations. You can determine the home path by running `echo $HOME` with your bash tool.

## Workflow Execution Rules

- When a step specifies a subagent (e.g., "Use the @manuscript-creator subagent"), you MUST use that subagent to perform the instructions for that step.
- Process steps sequentially in order.
- Use exact templates as provided.
- Focus on creative writing workflows and novel development.
