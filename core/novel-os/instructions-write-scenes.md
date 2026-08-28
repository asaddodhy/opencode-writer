# Scene Writing Rules

## Overview

Initiate writing of one or more scenes or chapters for a given story outline.

## Pre-Flight Check

First, run the pre-flight check by reading and executing `~/.novel-os/instructions/meta/pre-flight.md`.

---

## Step 1: Scene Assignment

Identify which scenes or chapters to write from the outline.

- If the user specifies exact scene(s) or chapter(s), use those.
- If not specified, find the next unwritten scene in `tasks.md`.
- Confirm scene selection with the user.

---

## Step 2: Context Analysis

Use the @context-researcher subagent to gather minimal context for scene understanding.

**Essential:** Read `tasks.md` for writing breakdown.

**Conditional (if not already in context):**
- `.novel-os/novel/premise-lite.md` for story alignment
- `story-outline-lite.md` for narrative summary
- `sub-specs/character-profiles.md` for character consistency

---

## Step 3: Check Writing Environment

Check for any distractions or conflicting processes and prepare an optimal writing environment.

Present: "Ready to begin focused writing session? (yes/no)"

---

## Step 4: Manuscript Version Management

Use the @writing-workflow subagent to manage manuscript versions and ensure proper backup.

Request: "Check and manage manuscript version for story: [STORY FOLDER]. Create backup if needed, set up current draft version, handle any unsaved changes."

Version naming: Derive from story folder name (exclude date prefix). Example: folder `2025-03-15-mystery-novel` → version `mystery-novel-v1.0`.

---

## Step 5: Scene Writing Loop

First, read `~/.novel-os/instructions/core/write-scene.md` for the individual scene writing template.

Then, for each assigned scene:
1. Execute instructions from `write-scene.md` with the scene number and all associated writing elements
2. Wait for scene completion
3. Update `tasks.md` status

Continue until all assigned scenes are complete or the user requests a stop.

After each scene, check `tasks.md` for remaining scenes. If all complete, proceed to Step 6. Otherwise, continue with the next scene.

---

## Step 6: Review Written Scenes

Use the @prose-reviewer subagent to review the written scenes for quality, consistency, and narrative flow.

Request: "Review the written scenes for:
- Prose quality and style consistency
- Character voice consistency
- Narrative flow and pacing
- Technical writing issues"

Address any reported issues. Repeat until prose meets quality standards.

---

## Step 7: Manuscript Workflow

Use the @writing-workflow subagent to save progress, update word counts, and create a version checkpoint.

Request: "Complete manuscript workflow for [STORY NAME] scenes:
- Manuscript: [STORY FOLDER PATH]
- Changes: All written scenes/chapters
- Progress: [WORD COUNT INCREASE]
- Status: [COMPLETION STATUS]"

---

## Step 8: Writing Plan Progress Check (Conditional)

First evaluate: did the written scenes potentially complete a writing milestone?

If no: Skip this step, proceed to Step 9.
If yes: Check `.novel-os/novel/writing-plan.md` (if not already in context) and update progress.

Only mark milestones as complete if the written work fully satisfies the milestone criteria.

---

## Step 9: Writing Session Summary

Present a structured summary to the user:

```markdown
## What's been written

1. [SCENE 1] - [DESCRIPTION]
2. [SCENE 2] - [DESCRIPTION]

## Progress Update

- Words written: [WORD COUNT]
- Total manuscript: [TOTAL WORDS]
- Completion: [PERCENTAGE]%

## Creative decisions made

(Only if applicable)
- [DECISION] - [DESCRIPTION AND REASON]

## Next writing session

Next up: [NEXT SCENE OR CHAPTER]
```

## Error Handling

| Scenario | Action |
|---|---|
| Creative block | Document in tasks.md with ⚠️. Include in summary. |
| Quality issues | Revise before proceeding. Never save substandard prose. |
| Narrative roadblocks | Attempt 3 approaches. Document if unresolved. Seek user input. |

## Final Checklist

- [ ] Scene writing complete
- [ ] Prose quality reviewed
- [ ] tasks.md updated
- [ ] Progress saved and backed up
- [ ] Version checkpoint created
- [ ] Writing plan checked/updated
- [ ] Summary provided to user
