---
name: handing-off
description: Use when a prettifysite project finishes phase 3 and the design decisions need to be written into a committed spec before theme and layout work, or when a long session needs a checkpoint before compaction.
---

# Phase 4: handing off

## Goal
Everything decided so far lives in one committed spec, so any session can
continue without the chat history.

## Steps
1. Copy `${CLAUDE_PLUGIN_ROOT}/templates/spec.md` to `docs/design-spec.md`
   (or the project's docs folder) and fill every section from `brief.md`,
   `decisions.md` and the canvas. Exact values: hex codes, font names and
   weights, scale numbers, durations and easings, button specs.
2. Back up canvas board sources into `.pretty/boards/`.
3. Show a summary of the spec (not the whole file). Gate: "Spec approved?"
4. Commit the spec and `.pretty/` (`docs: add design spec`), per the
   project's commit conventions.
5. Tell the user this is a good moment to compact or start a fresh session:
   `/prettifysite:start` will resume from `.pretty/`.

## Red flags
- A spec with "TBD" values that were actually decided
- Committing before the gate
