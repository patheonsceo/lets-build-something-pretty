#!/usr/bin/env bash
# prettifysite prerequisite check.
# Prints one STATUS line per tool: OK / MISSING / OUTDATED / OPTIONAL-MISSING,
# then a final READY or BLOCKED line. Never installs anything by itself.
#
# usage: bash scripts/check-prereqs.sh [--phase N]
#
# Phase-aware: a tool only BLOCKS when the current phase needs it; otherwise it
# is reported as LATER (needed from phase X). With no --phase, the phase is read
# from .pretty/state.json if present, else 0.
#   always: gstack (browser for references, boards, QA), node (hook + scripts)
#   phase 3 and 7: ImageMagick, ffmpeg (imagery demos, asset processing)
#   phase 8+: pnpm (build)        git: warning only (commits are skipped without it)

set -u
blocked=0
PHASE=""
[ "${1:-}" = "--phase" ] && PHASE="${2:-}"
if [ -z "$PHASE" ] && [ -f .pretty/state.json ]; then
  PHASE=$(grep -o '"phase"[[:space:]]*:[[:space:]]*[0-9]*' .pretty/state.json | grep -o '[0-9]*$')
fi
PHASE=${PHASE:-0}
# needs <from-phase> [only-phases...]: is the tool required right now?
needs() { local from=$1; shift; if [ $# -gt 0 ]; then for p in "$@"; do [ "$PHASE" = "$p" ] && return 0; done; [ "$PHASE" -ge 8 ] && return 0; return 1; fi; [ "$PHASE" -ge "$from" ]; }
miss() { # name, hint, required-now?
  if [ "$3" = 1 ]; then line "$1" MISSING "$2"; blocked=1; else line "$1" LATER "not needed yet (phase $PHASE); $2"; fi; }
line() { printf '%-18s %-17s %s\n' "$1" "$2" "$3"; }

have() { command -v "$1" >/dev/null 2>&1; }

# --- gstack (required: real browser for research, screenshots and QA) ------
GSTACK=""
for d in "$HOME/.claude/skills/gstack" ".claude/skills/gstack"; do
  [ -d "$d" ] && GSTACK="$d" && break
done
if [ -z "$GSTACK" ]; then
  line gstack MISSING "install: git clone --single-branch --depth 1 https://github.com/garrytan/gstack.git ~/.claude/skills/gstack && cd ~/.claude/skills/gstack && ./setup"
  blocked=1
else
  ver=$(cat "$GSTACK/VERSION" 2>/dev/null || echo unknown)
  upd=""
  if [ -x "$GSTACK/bin/gstack-update-check" ]; then
    upd=$("$GSTACK/bin/gstack-update-check" 2>/dev/null | head -1 || true)
  fi
  if printf '%s' "$upd" | grep -qiE 'UPGRADE_AVAILABLE|available|behind|outdated'; then
    line gstack OUTDATED "v$ver installed; run /gstack-upgrade before continuing ($upd)"
    blocked=1
  else
    line gstack OK "v$ver at $GSTACK"
  fi
  B="$GSTACK/browse/dist/browse"
  if [ -x "$B" ]; then line gstack-browse OK "$B"; else line gstack-browse MISSING "run: cd $GSTACK && ./setup"; blocked=1; fi
fi

# --- core toolchain --------------------------------------------------------
if have node; then line node OK "$(node -v)"; else line node MISSING "install Node.js 20+ (https://nodejs.org)"; blocked=1; fi
if have pnpm; then line pnpm OK "$(pnpm -v)"; else miss pnpm "install: npm i -g pnpm (or corepack enable)" $(needs 8 && echo 1 || echo 0); fi
if have git && git --version >/dev/null 2>&1; then line git OK "$(git --version | awk '{print $3}')"; else line git OPTIONAL-MISSING "install git; without it the spec and each stage are not committed"; fi

# --- asset processing ------------------------------------------------------
if have magick; then line imagemagick OK "$(magick -version | head -1 | awk '{print $3}')"; else miss imagemagick "install ImageMagick 7 (magick) for watermark patching, grading, cropping" $(needs 99 3 7 && echo 1 || echo 0); fi
if have ffmpeg; then line ffmpeg OK "$(ffmpeg -version | head -1 | awk '{print $3}')"; else miss ffmpeg "install ffmpeg for video cleanup and frame sequences" $(needs 99 3 7 && echo 1 || echo 0); fi
if have python3; then line python3 OK "$(python3 -V | awk '{print $2}')"; else line python3 OPTIONAL-MISSING "used by align-on-baseline.py"; fi

# --- recommended companion skills -----------------------------------------
sp=$(ls -d "$HOME"/.claude/plugins/cache/*/superpowers 2>/dev/null | head -1)
if [ -n "$sp" ]; then line superpowers OK "$sp"; else line superpowers OPTIONAL-MISSING "recommended: /plugin install superpowers@claude-plugins-official"; fi
imp=$(ls -d "$HOME"/.claude/skills/impeccable "$HOME"/.claude/plugins/cache/*/impeccable 2>/dev/null | head -1)
if [ -n "$imp" ]; then line impeccable OK "$imp"; else line impeccable OPTIONAL-MISSING "recommended for design critique passes"; fi

echo
echo "phase: $PHASE"
if [ "$blocked" = 1 ]; then echo "BLOCKED: fix the MISSING/OUTDATED lines above, then run /prettifysite:start again."; else echo "READY (LATER lines are fine for now; install them before that phase)"; fi
