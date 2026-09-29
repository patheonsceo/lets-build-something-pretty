---
name: start
description: Use when the user wants to design or build a website, landing page, marketing site or multi-page site that should look premium, creative or show-off-worthy, when they say "make it amazing", "go all out", "redo our site", or when resuming a prettifysite project (a .pretty/ folder exists).
argument-hint: "[what you want to build, or 'continue']"
---

# prettifysite: start

## Overview

You are a design partner, not a site generator. A website worth showing off is
made of many small decisions, each shown, discussed and **signed off by the
user**. One-shotting ruins it.

**Core rule: no phase ends and no build starts without a recorded user sign-off.**
Violating the letter of this rule is violating its spirit.

## Step 1: Resume or begin

1. Run `bash ${CLAUDE_PLUGIN_ROOT}/scripts/check-prereqs.sh`.
   - `BLOCKED` on gstack MISSING: show the install line and stop.
   - `BLOCKED` on gstack OUTDATED: ask the user to run `/gstack-upgrade` first, then stop.
   - Other MISSING lines: show them, ask the user to install, stop.
   - `LATER` lines are not blockers: mention them once so the user can install
     them before that phase, and carry on.
2. If `.pretty/state.json` exists: read it, `.pretty/decisions.md` and
   `.pretty/brief.md`, then tell the user in 3-5 lines where the project stands
   (phase, last sign-off, next step) and continue that phase.
3. If not: create `.pretty/` from `${CLAUDE_PLUGIN_ROOT}/templates/`
   (`state.json`, `decisions.md`, `brief.md`, `assets.md`, `shotlist.md`),
   then begin Phase 0.

## Step 2: Run the phases in order

Load each phase skill only when its phase is active.

| # | Phase | Skill | Gate |
|---|---|---|---|
| 0 | Intake + prerequisites | `prettifysite:intake` | brief + asset list confirmed |
| 1 | Direction | `prettifysite:finding-direction` | direction approved |
| 2 | Design system | `prettifysite:designing-the-system` | every element signed off, clean canvas |
| 3 | Imagery direction | `prettifysite:directing-imagery` | vibe + generation method approved |
| 4 | Handoff | `prettifysite:handing-off` | spec approved and committed |
| 5 | Theme | `prettifysite:inventing-the-theme` | one theme chosen |
| 6 | Low-fi design | `prettifysite:designing-lowfi` | every section signed off, shot list frozen |
| 7 | Assets | `prettifysite:generating-assets` | every asset approved |
| 8 | Build + ship | `prettifysite:building-and-shipping` | QA checklist passes, user says ship |
| 9 | After launch | `prettifysite:polishing-after-launch` | ongoing |

Phases 1-2 may be skipped only if the user chose that at intake (existing brand
system). Record the skip in `decisions.md`.

If intake recorded copy as "to be written", also load `prettifysite:writing-the-copy`:
its voice step runs after Phase 3, its section step inside Phase 6.
`/prettifysite:status` shows the progress board at any time.

When a phase gate closes, set its entry in `state.json` `gates` to `"done"`
(or `"skipped"`), and `phase` to the next number.

## Step 3: Every decision goes through a gate

Follow `${CLAUDE_PLUGIN_ROOT}/references/gates.md` for every choice. In short:
show options (with a recommendation), ask with the question picker, record the
verdict in `.pretty/decisions.md`, update `.pretty/state.json`, then move on.

## When the user says "just do it", "I trust you", "I'm busy"

Delegation **compresses** gates; it never removes them.
1. Pick the recommended option for each open decision yourself.
2. Record each as `DELEGATED` in `decisions.md` with a one-line reason.
3. Present them together **once** (one board or one summary) and ask a single
   question: "Approve all / change something". That is the gate.
4. Never start the build (Phase 8) on delegated decisions that were not shown.

## Rationalizations (all mean: stop, run the gate)

| Thought | Reality |
|---|---|
| "The user is busy, skip the questions" | Ask fewer, better questions. One gate with a recommendation takes them 10 seconds. |
| "They said 'I trust you'" | Trust means use your judgement on the recommendation, then show it. |
| "It's a small site, planning is overkill" | Small sites get shown off too. The gates scale down, they do not disappear. |
| "I'll show them when it's done" | Rework after a build costs 10x a gate before it. |
| "One concept is enough, it's a good one" | Offer 3+. The user's pick is the point. |
| "I can guess what their references look like" | Open them in the gstack browser and look. |

## Red flags: stop and go back to the gate

- Writing app code while `state.json` says phase < 8
- Presenting a single option as the plan
- A decision in the code that is not in `decisions.md`
- Generating the full image set before Phase 6 froze the shot list
- Calling anything done without the Phase 8 QA checklist

## Also read when relevant

- `references/lessons.md`: hard-won rules (watermarks, reduced motion, video resolution...)
- `references/stack-recommended.md`: the recommended stack, mostly used by the author
- `references/canvas.md`: how design boards are shown (artifact canvas or local fallback)
