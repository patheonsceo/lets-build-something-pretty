---
name: status
description: Use when the user asks where a prettifysite project stands, what is signed off, what is left, what is missing, or wants a progress summary to share.
---

# prettifysite: status

1. Run `node ${CLAUDE_PLUGIN_ROOT}/scripts/status.mjs` in the project root.
2. Show the board exactly as printed, in a code block.
3. Then, in 2-3 lines: the next step, and anything blocking it (missing assets,
   an open gate, credits or quota needed).
4. Do not change any files and do not start the next step; this is read-only.
   If the user wants to continue, point them to `/prettifysite:start continue`.
