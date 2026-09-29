#!/usr/bin/env bash
# stub gstack so the prerequisite check passes inside the eval sandbox
mkdir -p .claude/skills/gstack/browse/dist .claude/skills/gstack/bin
echo 9.9.9 > .claude/skills/gstack/VERSION
printf "#!/bin/sh\necho stub\n" > .claude/skills/gstack/browse/dist/browse
printf "#!/bin/sh\nexit 0\n" > .claude/skills/gstack/bin/gstack-update-check
chmod +x .claude/skills/gstack/browse/dist/browse .claude/skills/gstack/bin/gstack-update-check
# A law-firm project paused in Phase 2 (type pairings), colour already approved.
mkdir -p .pretty
cat > .pretty/state.json <<'J'
{"plugin":"prettifysite","project":"Hale & Rowe LLP","phase":2,"step":"type pairings","skipped":[],"canvas":"",
 "gates":{"0-intake":"done","1-direction":"done","2-system":"open","3-imagery":"open","4-handoff":"open","5-theme":"open","6-lowfi":"open","7-assets":"open","8-ship":"open"}}
J
printf '# Decisions\n\n- [2026-09-29] P1 direction: Quiet authority, editorial (APPROVED)\n- [2026-09-30] P2 colour: ink + bone + oxblood accent (APPROVED)\n' > .pretty/decisions.md
printf '# Brief\n\n- **Business / client:** Hale & Rowe LLP, a commercial law firm\n- **Scope:** landing page\n' > .pretty/brief.md
