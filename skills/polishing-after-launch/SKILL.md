---
name: polishing-after-launch
description: Use when a prettifysite site is live (phase 9) and the user asks for changes, reports something that looks off, or wants a section redone.
---

# Phase 9: polishing after launch

## Goal
Every change after launch gets the same care as before it, at a smaller scale.

## For each request
1. **Classify it.**
   - Bug or small fix (clipped text, overlap, wrong colour): find the root
     cause, fix, verify.
   - Change of design or concept (a section "isn't up to the mark", "different
     idea"): this is a mini Phase 5-6. Propose 2-3 concepts with the picker
     (previews help), get one chosen, then build it.
   - New assets: mini Phase 7 (demo, approve, generate, process).
2. **Look first.** Screenshot the current state at the relevant widths and
   Read it before changing anything.
3. **Fix, then verify** with the same QA as Phase 8 (at least the affected
   sections at 1440 and 390, plus `audit.mjs` if layout or loading changed).
   Fixes can have side effects (e.g. a margin that widens the page on phones).
4. **Commit locally.** Push and deploy only when the user says so; they may be
   batching changes.
5. Record the change in `decisions.md`.

## Red flags
- Redesigning a section without offering options
- Pushing because the fix "is obviously right"
- Calling it fixed without a screenshot of the fix
