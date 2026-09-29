---
name: writing-the-copy
description: Use when a prettifysite project has no client copy (or weak copy) for its sections, when intake records "copy to be written", or when the user asks for headlines, section text, microcopy or a brand voice for a website.
---

# Writing the copy

## Goal
Words that sound like the brand, say something true, and fit the design,
approved section by section. Copy is design: it gets gates like everything else.

## When it runs
- Intake recorded "copy: to be written" (or partly): run the **voice** step
  right after Phase 3, and the **section** step inside Phase 6, one section
  at a time, before that section's low-fi board is gated.
- Any time later when the user asks for copy.

## Step 1: find the voice (one gate)
1. Gather the raw material: the brief, the client's existing site and
   documents, competitors (open them in the gstack browser), how the client
   talks in their own messages.
2. Ask the house rules (picker): language and spelling (e.g. UK/US/Indian
   English), formality, words to avoid, punctuation rules (e.g. no em dashes),
   claims the client can legally make.
3. Write the **same short paragraph in 3 distinct voices** (e.g. "calm
   authority", "warm and plain", "bold and punchy"), each with 3 sample
   headlines. Recommend one. Gate. Record the voice + rules in
   `decisions.md` and at the top of `.pretty/copy.md`.

## Step 2: section by section
For each section (in page order, alongside its low-fi board):
1. Write **2-3 headline options** and one body draft in the chosen voice,
   sized to the layout (character counts that fit the board).
2. Include the microcopy: buttons, labels, form fields, errors, alt text.
3. Facts come only from the brief and `assets.md`. Anything not confirmed is
   written as a marked placeholder (`[N]+ clients`, `[phone]`), never invented.
4. Gate (picker for the headline, free text for edits). Record in `copy.md`
   with status `APPROVED` or `PROPOSED`.

## Step 3: the copy deck
`.pretty/copy.md` holds every approved line per section, the voice, the house
rules, and a list of every placeholder and every line still marked PROPOSED.
The build (Phase 8) uses only this file for text. The final report lists every
PROPOSED line so the client can confirm it.

## Red flags
- Writing all sections at once
- Inventing numbers, years, awards, client names or testimonials
- Lorem ipsum anywhere a real line could go
- Copy that doesn't fit the layout it was written for
