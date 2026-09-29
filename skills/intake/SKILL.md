---
name: intake
description: Use when a prettifysite project is in phase 0, or when starting a new website design project and nothing is known yet about the business, audience, content, assets or constraints.
---

# Phase 0: intake

## Goal
Know enough to design: who it is for, what success looks like, what exists,
what is missing. Nothing visual happens in this phase.

## Steps
1. Prerequisites are already checked by `start`. If `check-prereqs.sh` printed
   OPTIONAL-MISSING lines, mention them once.
2. Ask in rounds with the question picker (see `references/gates.md`), 1-4
   questions per round:
   - Round 1: scope (landing page / multi-page), audience, what success looks
     like, how it must still feel (e.g. credible, established, playful).
   - Round 2: existing site or first build? copy source (client / to write /
     partly)? If any copy is to be written, note it: `writing-the-copy` runs later.
     does a brand/design system exist? If yes, offer to **skip phases 1-2**
     and import their tokens, fonts and components instead.
   - Round 3: stack (offer `references/stack-recommended.md` as
     "Recommended stack (mostly used by the author)"), deploy target.
   - Plain text (not the picker): links to the existing site, brand files,
     copy docs, photos, and anything they love or hate.
3. Open every link the user gives in the gstack browser and look at it
   (screenshot, then Read the screenshot). Note what is there.
4. Fill `.pretty/brief.md`. Fill `.pretty/assets.md`: have / missing /
   placeholder for logo, photos, copy, contact details, proof (certificates,
   client logos, numbers).
5. Show the brief and asset table. Gate: "Approve brief" / "Change something".

## Output
`brief.md`, `assets.md`, decisions recorded, `state.json` phase 1 (or 3 if
phases 1-2 were skipped, after importing the existing system into the spec
notes).

## Red flags
- Designing, researching visuals or writing code in this phase
- Inventing business facts (addresses, numbers, founding years, reviews):
  they go in `assets.md` as missing, never into copy
- Asking 10 questions in one message
