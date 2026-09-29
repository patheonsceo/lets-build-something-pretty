---
name: designing-the-system
description: Use when a prettifysite project is in phase 2, or when building a website design system (colour, type pairings, spacing, grid, buttons, states, glass, header, cursor, legibility, motion tokens) that must be approved piece by piece.
---

# Phase 2: the design system, one element at a time

## Goal
A complete, signed-off design system on a clean canvas. This is the longest
phase. One-shotting it is the most common way sites end up generic.

## Order (each is its own gate; do not batch unless the user delegates)
1. **Colour.** Extract from the logo/brand; build ramps (50-950) and name
   them; add accents with strict roles (e.g. a signal colour only for live
   data, a warning colour only for "near limit"). Show on real UI, not swatches only.
2. **Type.** Show several pairings (6-10) on real content: headline, body,
   big numerals, a quote. Then the finalists in 2 weights. Record why.
3. **Scale, spacing, grid, shape.** Type scale (e.g. √2), 4px spacing steps,
   columns/gutters per breakpoint, radius rules (nested radii concentric).
4. **Buttons + inputs.** Primary, secondary, text-link, over-photo variants.
   Every state: rest, hover, press, focus, disabled; how they animate in and
   out. Make them interactive on the board so the user can try them.
5. **Surfaces + header.** Glass/blur recipes (static, never animated), how
   the header behaves at the top vs on scroll.
6. **Cursor** (optional; ask). If yes: small, contrast-aware on dark/light,
   hands off to buttons.
7. **Text over photos.** Test real photos; grade + scrim until body copy
   passes contrast. Show before/after.
8. **Motion tokens.** Durations, easings, the few reveal patterns allowed.

After all eight: **clean the canvas**. Remove rejected options, order the
boards, leave only what was signed off. Gate: "System complete?"

## Tools
Canvas (`references/canvas.md`), `frontend-design` / `impeccable` skills if
installed for critique, gstack to check boards render as intended.

## Red flags
- Showing all eight at once
- Swatches without real UI; fonts without real copy
- Moving on with rejected options still on the canvas
