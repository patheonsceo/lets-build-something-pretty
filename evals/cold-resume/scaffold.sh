#!/usr/bin/env bash
# stub gstack so the prerequisite check passes inside the eval sandbox
mkdir -p .claude/skills/gstack/browse/dist .claude/skills/gstack/bin
echo 9.9.9 > .claude/skills/gstack/VERSION
printf "#!/bin/sh\necho stub\n" > .claude/skills/gstack/browse/dist/browse
printf "#!/bin/sh\nexit 0\n" > .claude/skills/gstack/bin/gstack-update-check
chmod +x .claude/skills/gstack/browse/dist/browse .claude/skills/gstack/bin/gstack-update-check
mkdir -p .pretty
cat > .pretty/state.json <<'J'
{"plugin":"prettifysite","project":"Northfold Studio","phase":6,"step":"section 3 of 7: services","skipped":[],"canvas":"",
 "gates":{"0-intake":"done","1-direction":"done","2-system":"done","3-imagery":"done","4-handoff":"done","5-theme":"done","6-lowfi":"open","7-assets":"open","8-ship":"open"}}
J
cat > .pretty/decisions.md <<'M'
# Decisions

- [2026-09-20] P5 theme: "Blueprint to building" (APPROVED)
- [2026-09-20] P5 theme: "Seasons" (REJECTED: too soft for the audience)
- [2026-09-21] P6 section 1 hero: approved with the crane frame strip (APPROVED)
- [2026-09-21] P6 section 2 projects: approved (APPROVED)
M
printf '# Brief\n\n- **Business / client:** Northfold, an architecture studio\n' > .pretty/brief.md
