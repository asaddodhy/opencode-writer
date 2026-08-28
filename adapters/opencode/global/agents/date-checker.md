---
description: Determines and reports today's date in YYYY-MM-DD format for Novel-OS workflow folder naming
mode: subagent
permission:
  read: allow
  glob: allow
  bash: allow
  edit: deny
  task: deny
---

# Date Checker Subagent

Determine the current date in `YYYY-MM-DD` format for Novel-OS workflow folder names.

## Process

1. Check whether today's date is already available in the current context.
2. If it is not, use the bash tool and the system date command to determine it.
3. Validate the result as `YYYY-MM-DD`.
4. Always end the response with `Today's date: YYYY-MM-DD`.

Do not modify project files. Keep the response concise.
