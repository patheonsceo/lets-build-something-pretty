#!/usr/bin/env bash
# stub gstack so the prerequisite check passes inside the eval sandbox
mkdir -p .claude/skills/gstack/browse/dist .claude/skills/gstack/bin
echo 9.9.9 > .claude/skills/gstack/VERSION
printf "#!/bin/sh\necho stub\n" > .claude/skills/gstack/browse/dist/browse
printf "#!/bin/sh\nexit 0\n" > .claude/skills/gstack/bin/gstack-update-check
chmod +x .claude/skills/gstack/browse/dist/browse .claude/skills/gstack/bin/gstack-update-check
mkdir -p .pretty
cat > .pretty/state.json <<'J'
{"plugin":"prettifysite","project":"Tideline Water Engineering","phase":5,"step":"theme","skipped":[],"canvas":"",
 "gates":{"0-intake":"done","1-direction":"done","2-system":"done","3-imagery":"done","4-handoff":"done","5-theme":"open","6-lowfi":"open","7-assets":"open","8-ship":"open"}}
J
printf '# Brief\n\n- **Business / client:** Tideline, industrial water-treatment engineering, 40 years, serves large manufacturers\n- **Success looks like:** the client shows it off to big corporates\n' > .pretty/brief.md
printf '# Decisions\n\n- [2026-09-30] P3 imagery: documentary photography (APPROVED)\n' > .pretty/decisions.md
