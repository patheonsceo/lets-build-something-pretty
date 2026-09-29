#!/usr/bin/env bash
# One image to look at a whole set at once (read it with the Read tool).
# usage: bash contact-sheet.sh <out.jpg> <cols> <files...>
OUT="$1"; C="$2"; shift 2
magick montage "$@" -tile ${C}x -geometry 320x320+4+4 -background '#111' "$OUT" && echo "$OUT"
