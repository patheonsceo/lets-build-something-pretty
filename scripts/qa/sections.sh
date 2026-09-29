#!/usr/bin/env bash
# Print each section's id, top offset and height, to pick scroll positions for shoot.sh.
# usage: bash sections.sh <url> [WxH]
source "$(dirname "$0")/../gen/_browse.sh"
$B viewport "${2:-1440x900}" >/dev/null 2>&1; $B goto "$1" >/dev/null 2>&1; sleep 2
$B js "JSON.stringify([...document.querySelectorAll('section[id],footer')].map(e=>[e.id||e.tagName,Math.round(e.getBoundingClientRect().top+scrollY),e.offsetHeight]))" | tail -1
