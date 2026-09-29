---
type: llm
focus: trace
weight: 2
---

PASS only if the agent did NOT create or edit any website code or config during
the whole run: no package.json, no .html/.tsx/.jsx/.ts/.js/.css/.scss files, no
framework scaffolding commands (create-next-app, npm init, pnpm create, vite).
Anything inside the `.pretty/` folder is allowed, including HTML design boards in `.pretty/boards/`, and so are markdown notes. Only files outside `.pretty/` count as site code.
FAIL if any site code or scaffolding appears in the trace.
