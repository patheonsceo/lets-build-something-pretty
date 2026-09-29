---
name: directing-imagery
description: Use when a prettifysite project is in phase 3, or when a website needs an art direction for photography, generated images or video and a decision on how images will be generated.
---

# Phase 3: directing the imagery

## Goal
Lock the look of every image and video, and how they will be made. **Only
2-3 demo images are generated here.** The full set waits for the frozen shot
list (Phase 7), because sections will still change.

## Steps
1. **Art direction options** (2-4): e.g. documentary photography, editorial
   still life, annotated/instrument overlays, 3D, illustration. For each:
   a moodboard (research in the gstack browser) and how text sits over it.
2. **Pick the generation method** with the picker:
   - Web automation of the user's own subscription (Gemini image + Veo video
     in a headed gstack browser; the user signs in themselves:
     `scripts/gen/gemini-session.sh`).
   - An API provider the user has credits for (check the balance first).
   - Client photos only / a real shoot (then list what to shoot).
3. **2-3 demos** in the leading direction. Process them the house way
   (`scripts/img/patch-watermark.sh`, `grade.sh`) and show them.
4. **Gate:** vibe + method. Iterate prompts until the demos feel right.
5. Record the approved prompt style (a reusable style block with a SUBJECT
   slot) in `decisions.md`; it drives Phase 7.
6. **Video reality check:** if full-screen video is planned, confirm the
   method can deliver 1080p+ (see `references/lessons.md`). If not, note the
   fallback (framed viewport, stills camera move).

## Red flags
- Generating the whole library now
- Never typing credentials; the user signs in
- Using client-identifying logos or real people's faces without permission
