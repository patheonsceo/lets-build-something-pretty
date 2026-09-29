#!/usr/bin/env bash
# One house grade for the whole library so it reads as one shoot.
# usage: bash grade.sh <in> <out> [preset]
#   documentary (default): slightly muted, lifted blacks, warm-neutral
#   warm:  sunrise/golden tint     cool: clinical/steel tint
IN="$1"; OUT="$2"; P="${3:-documentary}"
case "$P" in
  documentary) ARGS=(-modulate 94,80,100 +level 3%,100% -channel R -evaluate multiply 1.02 -channel B -evaluate multiply 0.95 +channel) ;;
  warm)        ARGS=(-channel R -evaluate multiply 1.07 -channel G -evaluate multiply 1.01 -channel B -evaluate multiply 0.88 +channel -modulate 104,90,100) ;;
  cool)        ARGS=(-modulate 96,82,100 +level 2%,100% -channel B -evaluate multiply 1.04 -channel R -evaluate multiply 0.97 +channel) ;;
  *) echo "unknown preset $P"; exit 1 ;;
esac
magick "$IN" "${ARGS[@]}" -strip -quality 86 -interlace plane "$OUT" && echo "graded $OUT ($P)"
