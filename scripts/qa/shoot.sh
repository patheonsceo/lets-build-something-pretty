#!/usr/bin/env bash
# Viewport screenshots at chosen scroll positions (pinned/scrubbed scenes do not
# show up in a full-page capture, so scroll and shoot).
# usage: bash shoot.sh <url> <out-prefix> <WxH> <y1> [y2 ...]
#   then: bash ../img/contact-sheet.sh sheet.jpg 3 <out-prefix>-*.png  and Read it.
source "$(dirname "$0")/../gen/_browse.sh"
URL="$1"; P="$2"; VP="$3"; shift 3
$B viewport "$VP" >/dev/null 2>&1
$B goto "$URL" >/dev/null 2>&1; sleep 2.5
for y in "$@"; do
  $B js "window.scrollTo(0,$y)" >/dev/null 2>&1; sleep 1.8
  $B screenshot --viewport "${P}-$(printf %06d "$y").png" >/dev/null 2>&1
done
$B console --errors 2>&1 | grep -v UNTRUSTED | tail -5
