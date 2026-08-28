# Story Outline Creation Rules

## Overview

Generate detailed story outlines aligned with novel premise and writing plan.

## Pre-Flight Check

First, run the pre-flight check by reading and executing `~/.novel-os/instructions/meta/pre-flight.md`.

---

## Step 1: Outline Initiation

Use the @context-researcher subagent to identify the outline initiation method.

**Option A — "What's next?":**
If the user asks "what's next?", check `.novel-os/novel/writing-plan.md`, find the next uncompleted milestone, suggest it, and wait for approval.

**Option B — Specific idea:**
If the user describes a specific outline idea, accept it in any format and proceed to context gathering.

---

## Step 2: Context Gathering

Use the @context-researcher subagent to read `.novel-os/novel/premise-lite.md` and `.novel-os/novel/writing-style.md` only if not already in context.

- If both files are already in context: Skip this step, proceed to Step 3.
- If only some are in context: Read only the files not already loaded.

---

## Step 3: Story Requirements Clarification

Use the @context-researcher subagent to clarify story scope and narrative considerations.

Ask numbered questions as needed to ensure clear creative direction:

**Scope:**
- Story arc — what story elements are included
- Exclusions — what subplots or elements are excluded (optional)

**Narrative:**
- Character focus
- Plot complexity
- Thematic depth
- Pacing requirements

---

## Step 4: Date Determination

Use your bash tool to determine the current date in YYYY-MM-DD format for folder naming. Store this date for use in subsequent steps.

---

## Step 5: Outline Folder Creation

Use the @manuscript-creator subagent to create a directory: `.novel-os/manuscripts/YYYY-MM-DD-story-name/` using the date from Step 4.

- Use kebab-case for story name
- Maximum 5 words in name

Examples:
- `2025-03-15-midnight-library-story`
- `2025-03-16-detective-mystery-novel`

---

## Step 6: Create story-outline.md

Use the @manuscript-creator subagent to create `.novel-os/manuscripts/YYYY-MM-DD-story-name/story-outline.md`.

### Story Overview
1-2 sentences summarizing the story and central conflict.

### Three-Act Structure

**Act I: Setup** — Summary and key events (approx word count)
**Act II: Confrontation** — Summary and key events (approx word count)
**Act III: Resolution** — Summary and key events (approx word count)

### Chapter Breakdown

For each chapter:
```
### Chapter [N]: [TITLE]

Purpose: [CHAPTER PURPOSE]
POV: [CHARACTER NAME]
Setting: [LOCATION AND TIME]
Events: [KEY EVENTS]
Word Count: [TARGET WORDS]
```

15-30 chapters typical.

### Character Arcs

For each main character:
```
### [CHARACTER NAME]

Starting Point: [INITIAL STATE]
Journey: [TRANSFORMATION PROCESS]
Ending Point: [FINAL STATE]
Key Scenes: [IMPORTANT CHARACTER MOMENTS]
```

---

## Step 7: Create story-outline-lite.md

Use the @manuscript-creator subagent to create `.novel-os/manuscripts/YYYY-MM-DD-story-name/story-outline-lite.md`.

A condensed outline for efficient AI context usage (1-3 sentences summarizing story and central conflict).

---

## Step 8: Create Character Profiles

Use the @manuscript-creator subagent to create `sub-specs/character-profiles.md`.

For each main character:
```
### [NAME] (Role)

Age: [AGE]
Occupation: [JOB]
Personality: [KEY TRAITS]
Motivation: [WHAT THEY WANT]
Conflict: [WHAT STANDS IN THEIR WAY]
Arc: [HOW THEY CHANGE]
```

Include:
- Protagonist details
- Antagonist details
- Supporting character details
- Character relationships
- Backstory elements
- Motivations and goals
- Internal and external conflicts
- Character voice and dialogue patterns

---

## Step 9: Create World Building (Conditional)

Use the @manuscript-creator subagent to create `sub-specs/world-building.md` ONLY if the story requires significant world building (fantasy, sci-fi, historical, etc.).

**Setting:**
- Physical locations
- Time period
- Cultural context
- Social structures

**Rules:**
- Magic/technology systems
- Natural laws
- Social conventions
- Historical accuracy requirements

**Atmosphere:**
- Mood and tone
- Sensory details
- Symbolic elements

---

## Step 10: User Review

Request user review of all created files. Wait for approval or revision requests before proceeding to task creation.

Present:
```
I've created the story outline documentation:

- Story Outline: .novel-os/manuscripts/YYYY-MM-DD-story-name/story-outline.md
- Story Summary: .novel-os/manuscripts/YYYY-MM-DD-story-name/story-outline-lite.md
- Character Profiles: .novel-os/manuscripts/YYYY-MM-DD-story-name/sub-specs/character-profiles.md

Please review and let me know if any changes are needed before I create the writing task breakdown.
```

---

## Step 11: Create tasks.md

Use the @manuscript-creator subagent to await user approval from Step 10, then create `tasks.md`.

Structure tasks as 3-8 major tasks with up to 8 subtasks each:

```
- [ ] 1. [MAJOR TASK DESCRIPTION]
    - [ ] 1.1 Plan and outline [STORY ELEMENT]
    - [ ] 1.2 [WRITING STEP]
    - [ ] 1.3 [WRITING STEP]
    - [ ] 1.4 Review and polish [STORY ELEMENT]

- [ ] 2. [MAJOR TASK DESCRIPTION]
    - [ ] 2.1 Plan and outline [STORY ELEMENT]
```

Ordering Principles:
- Consider story dependencies
- Follow writing process flow
- Group related story elements
- Build narrative incrementally

---

## Step 12: Decision Documentation (Conditional)

Evaluate creative impact. Only update `decisions.md` if there's significant deviation from premise or writing plan and user approves.

Check `.novel-os/novel/premise-lite.md` and `.novel-os/novel/writing-plan.md` (if not already in context).

If the outline does NOT significantly deviate, skip this step and state: "Outline aligns with premise and writing plan."

If it does deviate, explain the deviation and ask the user if they want a decision entry created.

---

## Step 13: Writing Readiness Check

Present the user with:
- Story name and description
- First writing task summary from tasks.md
- Estimated scope/word count
- Key deliverables for Task 1

Ask: "Would you like me to proceed with writing Task 1?"

If yes, reference `~/.novel-os/instructions/core/write-scenes.md` and focus only on Task 1.

## Writing Standards

Follow these throughout:
- `.novel-os/novel/writing-style.md`
- `.novel-os/novel/premise.md`
- `~/.novel-os/standards/writing-style.md`

Maintain consistency with novel premise, alignment with writing plan, and narrative coherence.

## Final Checklist

- [ ] Accurate date determined via bash
- [ ] Outline folder created with correct date prefix
- [ ] story-outline.md contains all required sections
- [ ] All applicable sub-specs created
- [ ] User approved documentation
- [ ] tasks.md created with writing workflow approach
- [ ] Creative decisions evaluated
