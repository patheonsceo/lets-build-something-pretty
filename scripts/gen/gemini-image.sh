#!/usr/bin/env bash
# Generate one image in the open Gemini chat and download it full size.
# usage: bash gemini-image.sh <out.png> "<prompt>"
# Requires: gemini-session.sh open (SIGNED_IN). Prefix is added: "Generate an image."
source "$(dirname "$0")/_browse.sh"
OUT="$1"; P="$2"
count() { $B js "[...document.querySelectorAll('button')].filter(x=>(x.getAttribute('aria-label')||'').includes('Download full size')).length" 2>/dev/null | tail -1; }
N0=$(count)
REF=$($B snapshot -i 2>/dev/null | grep -m1 '\[textbox\]' | grep -o '@e[0-9]*')
$B fill "$REF" "Generate an image. $P" >/dev/null 2>&1; sleep 1
$B js "[...document.querySelectorAll('button')].find(b=>b.getAttribute('aria-label')==='Send message')?.click()" >/dev/null 2>&1
for i in $(seq 1 40); do sleep 5; N=$(count); [ "$N" -gt "$N0" ] 2>/dev/null && break; done
[ "${N:-0}" -gt "$N0" ] 2>/dev/null || { echo "NO_IMAGE (refused or timed out)"; exit 2; }
sleep 3; STAMP=$(mktemp); touch "$STAMP"
$B js "(()=>{const b=[...document.querySelectorAll('button')].filter(x=>(x.getAttribute('aria-label')||'').includes('Download full size'));b[b.length-1].click()})()" >/dev/null 2>&1
for i in $(seq 1 30); do sleep 3; f=$(find /tmp/playwright-artifacts-* -type f -newer "$STAMP" -size +100k 2>/dev/null | head -1); [ -n "$f" ] && break; done
rm -f "$STAMP"
[ -n "${f:-}" ] || { echo "DOWNLOAD_TIMEOUT"; exit 3; }
sleep 2; cp "$f" "$OUT"; echo "OK $OUT $(magick identify -format '%wx%h' "$OUT" 2>/dev/null)"
