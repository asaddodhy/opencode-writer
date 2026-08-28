# Scene Writing Rules

## Overview

Write a specific scene along with its narrative elements systematically following a structured creative writing workflow.

## Pre-Flight Check

First, run the pre-flight check by reading and executing `~/.novel-os/instructions/meta/pre-flight.md`.

---

## Step 1: Scene Understanding

Read and analyze the given scene and all its elements from `tasks.md` to gain complete understanding of what needs to be written.

**Analyze:**
- Scene description and purpose
- All scene elements and requirements
- Scene dependencies and connections
- Expected outcomes and word count

---

## Step 2: Story Context Review

Search and extract relevant sections from `story-outline.md` to understand the narrative context and character state for this scene.

Find sections related to:
- Current scene's story function
- Character states and relationships
- Plot progression requirements
- Thematic elements to include

Only extract narrative details for the current scene. Skip unrelated elements.

---

## Step 3: Writing Style Review

Use the @context-researcher subagent to retrieve relevant sections from `~/.novel-os/standards/writing-style.md` that apply to the current scene's narrative approach and genre requirements.

Request: "Find writing style sections relevant to:
- Narrative voice: [CURRENT POV]
- Scene type: [CURRENT SCENE TYPE]
- Characters involved: [CHARACTER LIST]
- Genre conventions needed"

---

## Step 4: Character Voice Review

Use the @context-researcher subagent to retrieve relevant character details from `character-profiles.md` for the characters appearing in this scene.

Request: "Find character details for:
- Scene characters: [CHARACTERS IN SCENE]
- Character relationships and dynamics
- Dialogue patterns and voice
- Current motivations and conflicts"

---

## Step 5: Scene Writing and Elements

Write the scene and all its narrative elements in order.

### Typical Scene Structure
1. **Opening** — Establish setting and character state
2. **Development** — Advance plot and character goals
3. **Climax** — Scene conflict or revelation
4. **Resolution** — Transition to next story beat

### Writing Order

**Scene Planning (first element):**
- Outline scene beats and character goals
- Establish setting and mood
- Plan dialogue and action sequences
- Set scene word count target
- Mark scene planning complete

**Scene Drafting (middle elements):**
For each writing element (2 through n-1):
- Write the specific scene content
- Maintain character voice consistency
- Advance plot as outlined
- Include thematic elements
- Mark element complete

**Scene Polishing (final element):**
- Review entire scene for flow
- Check character consistency
- Verify plot advancement
- Polish prose quality
- Mark final element complete

---

## Step 6: Scene-Specific Quality Verification

Use the @prose-reviewer subagent to review and verify only the prose written for this specific scene (not the entire manuscript).

Request: "Review prose quality for this scene's content:
- All new prose written for this scene
- Character dialogue and voice consistency
- Narrative flow within the scene
- Style adherence for this section"

If any quality issues: Revise and re-review only the revised sections.
If no issues: Confirm the scene meets quality standards.

---

## Step 7: Scene Status Updates

Update `tasks.md` immediately after completing each scene.

- Completed: `- [x] Scene description`
- Incomplete: `- [ ] Scene description`
- Blocked: `- [ ] Scene description` + `⚠️ Creative block: [DESCRIPTION]`

If blocked, attempt maximum 3 different approaches before documenting the block.
