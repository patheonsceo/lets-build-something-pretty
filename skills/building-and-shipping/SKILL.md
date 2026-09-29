---
name: building-and-shipping
description: Use when a prettifysite project is in phase 8, or when turning an approved design spec, theme, low-fi layouts and assets into production website code, testing it on desktop and mobile, and deploying it.
---

# Phase 8: building and shipping

## Goal
The approved design, built faithfully, fast, and tested like a release.

## Before the first line of code
Confirm `state.json` shows gates 0-7 closed. If any are open, go back.

## Build order
1. **Scaffold** with the chosen stack (`references/stack-recommended.md`).
   Give the site its own package workspace and lockfile. Check current library
   docs (Context7 if available) before using APIs from memory.
2. **Tokens** from the spec into the stylesheet (colours, type scale,
   spacing, radii, easings). Fonts self-hosted.
3. **Theme layers** (the site-wide ones from Phase 5): background flow, grid,
   rulers, grain, cursor, header. Build and look at them before any section.
4. **Sections, one at a time**, in page order, against their low-fi board.
   Commit per section. After each: build, screenshot, Read the screenshot,
   compare with the board.
5. **Hero moments** with the frame-sequence approach; WebGL lazy after LCP.
6. Read `references/lessons.md` (Motion + layout, Build + tooling) before
   writing any animation.

## QA (all must pass before calling it done)
Run on a production build (`build` then `start`), never dev:
1. `node ${CLAUDE_PLUGIN_ROOT}/scripts/qa/audit.mjs <url> <out-dir>`
   (desktop, tablet, phone, reduced motion; LCP, CLS, errors, overflow).
   It must print `QA PASS`.
2. Screenshots through every section at 1440, 768 and 390:
   `scripts/qa/sections.sh` for offsets, `scripts/qa/shoot.sh` to capture,
   `scripts/img/contact-sheet.sh` to view. Read every sheet.
3. Reduced motion: every pinned scene is reachable, nothing depends on motion.
4. Typecheck + lint clean.
Report the numbers honestly, including anything that failed.

## Ship
- Show the user the local production build and the QA results. Ask before
  pushing or deploying; they may want changes first.
- Deploy (Vercel by default), then rerun `audit.mjs` against the live URL.
  A slow first run right after deploy can be a cold cache: run it twice.
- Final report: what shipped, QA numbers, every placeholder and all proposed
  copy still on the site (from `assets.md`).

## Red flags
- Judging speed on the dev server
- "Looks fine" without reading screenshots
- Pushing or deploying without the user saying so
- Inventing content to fill gaps instead of using a marked placeholder
