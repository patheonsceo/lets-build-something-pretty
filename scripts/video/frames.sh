#!/usr/bin/env bash
# Export scroll-scrub frame sequences (WebP) for desktop and a portrait mobile crop.
# usage: bash frames.sh <master.mp4> <out-dir> [--fps 14] [--mfps 9] [--q 62] [--mcrop W:H:X:Y]
#   Writes <out-dir>/d/001.webp... and <out-dir>/m/001.webp..., prints counts + sizes.
#   Aim: ~4-5 MB desktop set. Lower --q or --fps if bigger.
IN="$1"; O="$2"; shift 2; FPS=14; MFPS=9; Q=62; MCROP=""
while [ $# -gt 0 ]; do case "$1" in
  --fps) FPS="$2"; shift 2 ;; --mfps) MFPS="$2"; shift 2 ;; --q) Q="$2"; shift 2 ;; --mcrop) MCROP="$2"; shift 2 ;; *) shift ;; esac; done
read W H < <(ffprobe -v error -select_streams v -show_entries stream=width,height -of csv=p=0:s=' ' "$IN")
[ -n "$MCROP" ] || MCROP="$((H*9/16)):$H:$(( (W - H*9/16) / 2 )):0"
mkdir -p "$O/d" "$O/m"
ffmpeg -v error -y -i "$IN" -vf "fps=$FPS" -c:v libwebp -quality "$Q" -compression_level 6 "$O/d/%03d.webp"
ffmpeg -v error -y -i "$IN" -vf "fps=$MFPS,crop=$MCROP" -c:v libwebp -quality $((Q+8)) "$O/m/%03d.webp"
echo "desktop $(ls "$O/d" | wc -l) frames $(du -sh "$O/d" | cut -f1) · mobile $(ls "$O/m" | wc -l) frames $(du -sh "$O/m" | cut -f1)"
