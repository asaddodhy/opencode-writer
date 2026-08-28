# Novel-OS Creative Writing System

This file provides the AI with comprehensive workflow instructions for the Novel-OS creative writing system.

## Novel-OS File Structure

### Global Installation (`~/.novel-os/`)
```
~/.novel-os/
├── standards/                  # Writing standards and style guides
│   ├── writing-style.md        # General writing style guide
│   ├── narrative-techniques.md # Narrative technique guidelines
│   └── genre-guides/           # Genre-specific writing guides
└── instructions/               # Novel-OS workflow instructions
    └── core/                   # Core writing workflow processes
        ├── plan-novel.md       # Novel planning and setup
        ├── create-outline.md   # Chapter/scene outline creation
        ├── write-scenes.md     # Scene writing workflows
        ├── write-scene.md      # Individual scene writing
        └── analyze-manuscript.md # Manuscript analysis
```

### Project-Level Structure (`.novel-os/` in project root)
```
your-novel-project/
├── .novel-os/
│   ├── novel/                  # Created by /plan-novel
│   │   ├── premise.md          # Complete story vision
│   │   ├── premise-lite.md     # AI-optimized premise summary
│   │   ├── writing-style.md    # Novel-specific style
│   │   ├── writing-plan.md     # Phases and milestones
│   │   └── decisions.md        # Creative decision log
│   └── manuscripts/            # Created by /create-outline
│       └── [date]-[story-name]/
│           ├── story-outline.md
│           ├── story-outline-lite.md
│           ├── sub-specs/
│           │   ├── character-profiles.md
│           │   └── world-building.md
│           └── tasks.md
└── chapters/                   # Your actual novel content
    ├── chapter-01.md
    └── ...
```

## Three-Layer Context System

1. **Standards Layer** (`~/.novel-os/standards/`) — Set once, use everywhere. Defines writing style, narrative techniques, and genre conventions.
2. **Novel Layer** (`.novel-os/novel/`) — Project-specific creative vision. Premise, writing plan, creative decisions, and novel-specific style.
3. **Manuscript Layer** (`.novel-os/manuscripts/`) — Detailed writing roadmap. Story outlines, character profiles, scene-by-scene tasks.

## Available Subagents

Novel-OS provides specialized subagents that can be invoked via `@agent-name`:

- **`@writing-workflow`** — Version management, backups, progress tracking
- **`@prose-reviewer`** — Quality analysis, style consistency, narrative flow review
- **`@continuity-checker`** — Character consistency, plot coherence, story logic verification
- **`@manuscript-creator`** — File creation, directory setup, template application
- **`@context-researcher`** — Efficient on-demand context loading
- **`@date-checker`** — Current date determination for manuscript folder naming

## Commands

Commands are defined in `~/.config/opencode/commands/`. Each command file contains instructions that reference the corresponding workflow in `~/.novel-os/instructions/core/`.

- `/plan-novel` — Novel initialization and planning
- `/create-outline` — Story outline creation
- `/write-scenes` — Scene writing
- `/analyze-manuscript` — Existing manuscript analysis
