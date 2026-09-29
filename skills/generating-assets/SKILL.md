---
name: generating-assets
description: Use when a prettifysite project is in phase 7, or when generating, cleaning, grading and approving a website's images, videos and scroll-scrubbed frame sequences from an approved shot list.
---

# Phase 7: generating the assets

## Goal
Every row of the frozen shot list generated, processed the house way and
approved by the user. Scripts live in `${CLAUDE_PLUGIN_ROOT}/scripts/`.

## Steps
1. **Set up the method chosen in Phase 3.**
   - Web automation (Gemini): `bash scripts/gen/gemini-session.sh open`.
     If it prints `SIGNED_OUT`, run `handoff`, ask the user to sign in in the
     window that opened and say "done", then `resume`. Never type credentials.
   - API: confirm the balance covers the shot list before starting.
2. **Images.** Write a TSV (`name<TAB>subject`) from the shot list and run
   `bash scripts/gen/gemini-batch.sh <tsv> <raw-dir> "<approved style with SUBJECT>"`.
   It skips files that already exist, so re-running resumes.
3. **Look at everything.** `bash scripts/img/contact-sheet.sh sheet.jpg 5 <files>`
   and Read the sheet. Reject off-brief images and regenerate them.
4. **Process:**
   - watermark: `bash scripts/img/patch-watermark.sh in out` (check the
     corner of every image, and of client photos too)
   - grade: `bash scripts/img/grade.sh in out <documentary|warm|cool>`
   - sets that sit together: `python3 scripts/img/align-on-baseline.py`
5. **Video.** `bash scripts/gen/gemini-video.sh out.mp4 "<prompt>" [start-image]`
   (image-to-video from an approved still keeps continuity). If refused,
   retry text-only. Then:
   - `bash scripts/video/contact-sheet.sh clip.mp4 sheet.jpg` and look at it
   - `bash scripts/video/clean-and-grade.sh clip.mp4 master.mp4` (crops the watermark)
   - `bash scripts/video/frames.sh master.mp4 public/frames/<shot>`
   - a free extra shot: `clean-and-grade.sh --reverse --grade dawn`
6. **Gate** each batch with contact sheets. Update `.pretty/assets.md` and
   the shot list status. Record rejects and why.
7. **Close the automation browser** (`gemini-session.sh close`).

## Red flags
- Skipping the watermark check "because it looks clean"
- A 720p clip planned full-screen with no fallback
- Keeping rejected images in the project folder
- Leaving the browser open
