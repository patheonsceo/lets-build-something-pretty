#!/usr/bin/env bash
# Open Gemini in a HEADED gstack browser so the user can sign in themselves.
# usage: bash gemini-session.sh open    -> starts headed browser, loads saved state, opens Gemini
#        bash gemini-session.sh handoff -> hands the window to the user to sign in
#        bash gemini-session.sh resume  -> takes control back and saves the session
#        bash gemini-session.sh close   -> saves state and closes the browser
source "$(dirname "$0")/_browse.sh"
case "${1:-open}" in
  open)
    $B connect --force-restart >/dev/null 2>&1
    $B state load gemini >/dev/null 2>&1 || true
    $B goto https://gemini.google.com/app >/dev/null 2>&1; sleep 4
    if $B js "document.body.innerText" 2>/dev/null | grep -q "Sign in"; then echo "SIGNED_OUT"; else echo "SIGNED_IN"; fi ;;
  handoff) $B handoff "Please sign in to Gemini with your Google account, then tell Claude 'done'" ;;
  resume)  $B resume >/dev/null 2>&1; $B state save gemini >/dev/null 2>&1; echo "RESUMED" ;;
  close)   $B state save gemini >/dev/null 2>&1; $B disconnect >/dev/null 2>&1; echo "CLOSED" ;;
esac
