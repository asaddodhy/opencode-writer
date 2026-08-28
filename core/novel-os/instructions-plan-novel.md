# Novel Planning Rules

## Overview

Generate novel documentation for new projects: premise, writing-style, writing-plan, decisions files for AI writing agent consumption.

## Pre-Flight Check

First, run the pre-flight check by reading and executing `~/.novel-os/instructions/meta/pre-flight.md`.

---

## Setup Verification

Before proceeding with novel planning:

1. **Global Novel-OS Check**: Verify that `~/.novel-os/instructions/` and `~/.novel-os/standards/` directories exist.
2. **Project State Assessment**: Check if `.novel-os/novel/` already exists in the current directory.
3. **Action Decision**:
   - If global Novel-OS missing: Direct user to install Novel-OS first.
   - If project setup exists: Offer to update/overwrite or skip.
   - If fresh project: Proceed with creation.

**IMPORTANT**: This command should execute even if `.novel-os/novel/` doesn't exist — its purpose is to create the project-specific Novel-OS structure.

---

## Step 0: Verify Setup Requirements

Use the @context-researcher subagent to verify system setup requirements and provide clear guidance.

### Verification Tasks
1. **Check Global Installation**: Verify `~/.novel-os/instructions/` and `~/.novel-os/standards/` exist.
2. **Check Project State**: Look for existing `.novel-os/novel/` directory in the current working directory.
3. **Report Status**: Provide clear status of both global and project setup.

### Error Conditions

**Global Missing:**
If Novel-OS base installation not found at `~/.novel-os/`, inform the user that Novel-OS must be installed first before running `/plan-novel`.

**Project Exists:**
If `.novel-os/novel/` already exists, ask the user:
1. **Update existing** — Merge new information with existing files
2. **Overwrite all** — Replace all files with fresh setup
3. **Skip setup** — Continue with existing configuration

**Success Condition:**
If global Novel-OS is present, proceed to Step 1 regardless of whether project setup exists. The workflow handles both fresh projects and existing ones.

---

## Step 1: Gather User Input

Use the @context-researcher subagent to collect all required inputs from the user.

### Required Information
Ask the user for:
1. Novel concept or premise
2. Key themes to explore (minimum 2)
3. Target audience and genre
4. Writing style preferences
5. Has the novel project folder been created and we're inside it? (yes/no)

### Data Resolution
If the user doesn't provide certain information, check these sources in order:
1. `~/.novel-os/standards/writing-style.md`
2. `~/.config/opencode/AGENTS.md`

---

## Step 2: Create Documentation Structure

Use the @manuscript-creator subagent to create the following file structure in the current project:

```
.novel-os/
└── novel/
    ├── premise.md          # Novel vision and purpose
    ├── premise-lite.md     # Condensed premise for AI context
    ├── writing-style.md    # Writing approach and style
    ├── writing-plan.md     # Writing phases and milestones
    └── decisions.md        # Creative decision log
```

---

## Step 3: Create premise.md

Use the @manuscript-creator subagent to create `.novel-os/novel/premise.md` with the following structure:

### Logline
Format: `[NOVEL_TITLE] is a [GENRE] novel about [PROTAGONIST] who must [CENTRAL_CONFLICT] in order to [STAKES].`
Length: 1-2 sentences, compelling hook.

### Target Audience
Include primary reader segments with descriptions and reader personas (name, age range, reading preferences, context, desires, favorite authors).

### Genre and Market
1-2 primary genres with descriptions, market positioning, and comparable titles.

### Themes
2-4 themes with exploration of how each manifests through specific examples.

### Hook
Three types of hooks:
- **Inciting Incident**: The opening event
- **Character Hook**: What makes the protagonist appealing
- **Situational Hook**: The unique situation

---

## Step 4: Create writing-style.md

Use the @manuscript-creator subagent to create `.novel-os/novel/writing-style.md` with:

- Narrative voice (first person, third person limited, third person omniscient, multiple POV)
- Tense (present or past)
- POV character
- Writing tone
- Dialogue style
- Description approach
- Pacing preference
- Chapter length
- Scene structure
- Character development style

For any missing items, check `~/.novel-os/standards/writing-style.md` first, then ask the user if still missing.

---

## Step 5: Create premise-lite.md

Use the @manuscript-creator subagent to create `.novel-os/novel/premise-lite.md`.

This is a condensed version of the premise for efficient AI context usage:

- Elevator pitch (single sentence from premise.md logline)
- Genre summary (1-3 sentences covering genre, target audience, key themes)

Format:
```
[ELEVATOR PITCH]

[1-3 SENTENCES SUMMARIZING GENRE, AUDIENCE, AND PRIMARY THEMES]
```

---

## Step 6: Create writing-plan.md

Use the @manuscript-creator subagent to create `.novel-os/novel/writing-plan.md`.

Structure the plan in 3-5 phases with 3-7 milestones per phase:

```
## Phase [N]: [NAME]

Goal: [PHASE GOAL]
Success Criteria: [MEASURABLE CRITERIA]

### Writing Milestones

- [ ] [MILESTONE] - [DESCRIPTION] [EFFORT]

### Dependencies
- [DEPENDENCY]
```

### Suggested Phase Structure
- Phase 1: Story foundation and character development
- Phase 2: First draft completion
- Phase 3: Revision and refinement
- Phase 4: Beta reader feedback integration
- Phase 5: Final polish and publication prep

### Effort Scale
- XS: 1-2 writing sessions
- S: 1 week
- M: 2-3 weeks
- L: 1 month
- XL: 2+ months

---

## Step 7: Create decisions.md

Use the @manuscript-creator subagent to create `.novel-os/novel/decisions.md`.

Each decision entry follows this format:

```
## [DATE]: [DECISION TITLE]

ID: DEC-001
Status: Accepted
Category: [creative/structural/character/plot/style]
Stakeholders: [LIST]

### Decision
Summary of the decision.

### Context
Why this decision was made, creative inspiration.

### Alternatives Considered
1. [ALTERNATIVE]
   - Pros: [LIST]
   - Cons: [LIST]

### Rationale
Key factors in the decision.

### Consequences
Positive:
- [EXPECTED BENEFITS]

Negative:
- [KNOWN TRADEOFFS]
```

---

## Final Checklist

- [ ] Global Novel-OS installation verified
- [ ] Project setup status assessed
- [ ] All 5 files created in `.novel-os/novel/`
- [ ] User inputs incorporated throughout
- [ ] Missing writing style items requested
- [ ] Initial creative decisions documented

### Execution Order
1. Verify Novel-OS setup requirements
2. Gather and validate all inputs
3. Create directory structure
4. Generate each file sequentially
5. Request any missing information
6. Validate complete documentation set

---

## Completion Message

After successfully completing all steps, present a success message to the user summarizing:

- The project structure created
- Key documentation generated (premise, writing style, writing plan, decision log)
- Next steps available (create-outline, write-scenes, etc.)
