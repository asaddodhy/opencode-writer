# Analyze Current Manuscript and Install Novel-OS

## Overview

Install Novel-OS into an existing novel project, analyze current manuscript state and writing progress. Builds on plan-novel.md.

## Pre-Flight Check

First, run the pre-flight check by reading and executing `~/.novel-os/instructions/meta/pre-flight.md`.

---

## Step 1: Analyze Existing Manuscript

Perform a deep manuscript analysis of the current project to understand current state before documentation.

### Analysis Areas

**Manuscript Structure:**
- Chapter organization
- Scene structure patterns
- File naming conventions
- Draft organization

**Story Elements:**
- Genre and style in use
- Character development approach
- Plot structure and pacing
- Narrative voice and POV

**Writing Progress:**
- Completed chapters/scenes
- Work in progress
- Character arcs developed
- Plot threads established
- Word count and length

**Writing Patterns:**
- Writing style in use
- Dialogue conventions
- Description approach
- Chapter/scene transitions

---

## Step 2: Gather Creative Context

Use the @context-researcher subagent to supplement manuscript analysis with creative context and future writing plans.

Present the user with a summary of what you found in their manuscript, then ask:

1. **Story Vision**: What's the core theme or message of this novel? What drew you to this story?
2. **Current State**: Are there character arcs or plot elements I should know about that aren't obvious from the text?
3. **Writing Plan**: What scenes or chapters are planned next? Any major plot developments coming?
4. **Creative Decisions**: Are there important story or style decisions I should document?
5. **Writing Preferences**: Any writing habits or techniques you prefer that I should capture?

Combine user input with your manuscript analysis and prepare the information for `/plan-novel`.

---

## Step 3: Execute Plan-Novel with Context

Execute the standard flow for installing Novel-OS in existing novel projects.

Read `~/.novel-os/instructions/core/plan-novel.md` and execute it with the gathered information as context:

```
Novel Concept: [DERIVED FROM ANALYSIS AND USER INPUT]
Key Themes: [IDENTIFIED EXISTING AND PLANNED THEMES]
Target Audience: [FROM USER CONTEXT]
Writing Style: [DETECTED FROM MANUSCRIPT]
```

---

## Step 4: Customize Generated Documentation

Refine the generated documentation to ensure accuracy for the existing novel:

**Writing Plan Adjustment:**
- Mark completed chapters/scenes as done
- Move finished work to "Phase 0: Already Written"
- Adjust future phases based on actual progress

**Style Verification:**
- Verify detected writing style is accurate
- Add any specific voice or tone details
- Document actual narrative approach

**Decisions Documentation:**
- Add historical creative decisions that shaped current story
- Document why certain plot or character choices were made
- Capture any major story pivots or changes

---

## Step 5: Final Verification and Summary

Verify installation completeness and provide clear next steps.

### Verification Checklist
- [ ] `.novel-os/novel/` directory created
- [ ] All novel documentation reflects actual manuscript
- [ ] Writing plan shows completed and planned work accurately
- [ ] Writing style matches current manuscript voice

### Summary Template

Present to the user:

```
## Novel-OS Successfully Installed

I've analyzed your [GENRE] manuscript and set up Novel-OS with documentation
that reflects your actual writing.

### What I Found
- Genre/Style: [DETECTED STYLE]
- Completed Work: [WORD COUNT] words, [CHAPTER COUNT] chapters
- Writing Voice: [DETECTED VOICE]
- Current Phase: [WRITING STAGE]

### What Was Created
- Novel documentation in .novel-os/novel/
- Writing plan with completed work in Phase 0
- Style guide reflecting actual manuscript voice
```

## Error Handling

| Scenario | Action |
|---|---|
| Cannot determine genre | Ask user for clarification |
| Multiple narrative voices detected | Ask user which voice pattern to document |
| Cannot determine full story scope | List detected elements and ask for missing pieces |

## Final Checklist

- [ ] Manuscript analyzed thoroughly
- [ ] User creative context gathered
- [ ] plan-novel.md executed with proper context
- [ ] Documentation customized for existing novel
- [ ] Writer can adopt Novel-OS workflow
