# Showing design work

Design work is shown, never only described.

## Preferred: an artifact canvas
If the Artifact tool (claude.ai canvas) is available, keep one canvas per
project with a page per phase: Wireframe, Concepts, Brand, Design system,
Creative direction, Theme, Low-fi. One board per decision. Save its URL in
`.pretty/state.json` (`canvas`).

Rules:
- One idea per board, labelled with a mono caption (e.g. `THEME · OPTION B`).
- Show real content (the client's words, real numbers), not lorem ipsum.
- Rejected options are removed at each phase's end; the canvas ends clean
  and ordered, showing only what was signed off.
- Back up each board's source into `.pretty/boards/` so it survives.

## Fallback: local boards
Without an artifact canvas, write each board as a standalone HTML file in
`.pretty/boards/`, serve the folder (`npx serve .pretty/boards`), open it in
the gstack browser, screenshot, look at the screenshot yourself, then tell the
user the local URL.

## Low fidelity
When a board is low-fi (Phase 6), say so on the board and in the message:
grey boxes, real copy, motion described in captions. The point is layout,
flow and concept, not polish.
