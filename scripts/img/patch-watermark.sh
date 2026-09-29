#!/usr/bin/env bash
# Hide a small watermark (e.g. the AI sparkle bottom-right) by copying the
# texture right beside it through a soft radial mask. Framing is unchanged.
# usage: bash patch-watermark.sh <in> <out> [cx cy size dx]
#   defaults = Gemini image sparkle: centre at 88.3% / 88.2% of the image,
#   patch ~9% of width, texture taken ~11% to the left.
#   For other marks, find the centre by cropping the corner and looking at it.
IN="$1"; OUT="$2"
W=$(magick identify -format %w "$IN"); H=$(magick identify -format %h "$IN")
CX=${3:-$((W*1808/2048))}; CY=${4:-$((H*1806/2048))}; S=${5:-$((W*190/2048))}; DX=${6:-$((W*230/2048))}
h=$((S/2))
magick "$IN" \( +clone -crop ${S}x${S}+$((CX-h-DX))+$((CY-h)) +repage \
  \( -size ${S}x${S} radial-gradient:white-black -level 0%,45% \) -alpha off -compose copy_opacity -composite \) \
  -geometry +$((CX-h))+$((CY-h)) -compose over -composite -quality 92 "$OUT"
echo "patched $OUT (centre $CX,$CY size $S)"
