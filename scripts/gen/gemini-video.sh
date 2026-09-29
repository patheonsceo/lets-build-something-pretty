#!/usr/bin/env bash
# Generate one Veo video in Gemini (optionally starting from an image) and download it.
# usage: bash gemini-video.sh <out.mp4> "<prompt>" [start-image]
# Starts a fresh chat, selects "Create video", attaches the image, sends, waits (up to ~10 min).
source "$(dirname "$0")/_browse.sh"
OUT="$1"; P="$2"; IMG="${3:-}"
$B goto https://gemini.google.com/app >/dev/null 2>&1; sleep 3
$B js "[...document.querySelectorAll('button')].find(b=>b.getAttribute('aria-label')==='Upload & tools')?.click()" >/dev/null 2>&1; sleep 1
$B js "[...document.querySelectorAll('[role=menuitemcheckbox]')].find(b=>b.innerText.includes('Create video'))?.click()" >/dev/null 2>&1; sleep 2
$B js "[...document.querySelectorAll('button')].find(b=>['Try it','Dismiss'].includes(b.innerText.trim()))?.click()" >/dev/null 2>&1; sleep 1
if [ -n "$IMG" ]; then
  R=$($B snapshot -i 2>/dev/null | grep '"File upload"' | grep -o '@e[0-9]*' | head -1)
  $B click "$R" >/dev/null 2>&1; sleep 1.5
  timeout 60 $B upload 'input[type=file]' "$(realpath "$IMG")" >/dev/null 2>&1; sleep 5
  $B js "[...document.querySelectorAll('button')].find(b=>b.innerText.trim()==='Agree')?.click()" >/dev/null 2>&1
fi
REF=$($B snapshot -i 2>/dev/null | grep -m1 '\[textbox\]' | grep -o '@e[0-9]*')
$B fill "$REF" "$P" >/dev/null 2>&1; sleep 1
$B js "[...document.querySelectorAll('button')].find(b=>b.getAttribute('aria-label')==='Send message')?.click()" >/dev/null 2>&1
ok=0; for i in $(seq 1 60); do sleep 10
  if $B js "[...document.querySelectorAll('button')].some(b=>b.getAttribute('aria-label')==='Download video')" 2>/dev/null | grep -q true; then ok=1; break; fi
  if $B js "document.querySelector('main')?.innerText" 2>/dev/null | grep -qi "can't generate"; then echo "REFUSED (try a text-only prompt)"; exit 2; fi
done
[ $ok = 1 ] || { echo "TIMEOUT (quota may be used up)"; exit 3; }
STAMP=$(mktemp); touch "$STAMP"
$B js "[...document.querySelectorAll('button')].filter(b=>b.getAttribute('aria-label')==='Download video').pop().click()" >/dev/null 2>&1
for i in $(seq 1 40); do sleep 3; f=$(find /tmp/playwright-artifacts-* -type f -newer "$STAMP" -size +200k 2>/dev/null | head -1); [ -n "$f" ] && break; done
rm -f "$STAMP"; [ -n "${f:-}" ] || { echo "DOWNLOAD_TIMEOUT"; exit 4; }
sleep 3; cp "$f" "$OUT"; echo "OK $OUT $(ffprobe -v error -select_streams v -show_entries stream=width,height,duration -of csv=p=0 "$OUT")"
