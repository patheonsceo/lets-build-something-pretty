#!/usr/bin/env bash
# Crop a watermark out of frame, grade, optionally reverse. Output is a
# near-lossless master to cut frames from.
# usage: bash clean-and-grade.sh <in.mp4> <out.mp4> [--crop W:H:X:Y] [--grade documentary|dawn|none] [--reverse]
#   default crop 1120:630:0:0 removes the Gemini/Veo sparkle from a 1280x720 clip.
IN="$1"; OUT="$2"; shift 2
CROP="1120:630:0:0"; GRADE="documentary"; REV=""
while [ $# -gt 0 ]; do case "$1" in
  --crop) CROP="$2"; shift 2 ;; --grade) GRADE="$2"; shift 2 ;; --reverse) REV="reverse,"; shift ;; *) shift ;; esac; done
case "$GRADE" in
  documentary) G="eq=saturation=0.85:contrast=1.03:brightness=-0.015,colorbalance=rs=0.02:bs=-0.03" ;;
  dawn) G="colorbalance=rs=0.06:gs=0.01:bs=-0.08:rm=0.05:gm=0.01:bm=-0.06:rh=0.04:bh=-0.05,eq=brightness=0.03:saturation=0.92:gamma=1.04" ;;
  none) G="null" ;;
esac
ffmpeg -v error -y -i "$IN" -vf "${REV}crop=$CROP,$G" -c:v libx264 -crf 14 -pix_fmt yuv420p -an "$OUT" && echo "clean $OUT"
