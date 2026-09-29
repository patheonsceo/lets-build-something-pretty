#!/usr/bin/env bash
# an empty repo, plus a stub gstack
# stub gstack so the prerequisite check passes inside the eval sandbox
mkdir -p .claude/skills/gstack/browse/dist .claude/skills/gstack/bin
echo 9.9.9 > .claude/skills/gstack/VERSION
printf "#!/bin/sh\necho stub\n" > .claude/skills/gstack/browse/dist/browse
printf "#!/bin/sh\nexit 0\n" > .claude/skills/gstack/bin/gstack-update-check
chmod +x .claude/skills/gstack/browse/dist/browse .claude/skills/gstack/bin/gstack-update-check
