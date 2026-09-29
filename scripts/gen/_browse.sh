# shared: locate the gstack browse binary
B=""
for c in "$(git rev-parse --show-toplevel 2>/dev/null)/.claude/skills/gstack/browse/dist/browse" "$HOME/.claude/skills/gstack/browse/dist/browse"; do
  [ -x "$c" ] && B="$c" && break
done
[ -n "$B" ] || { echo "gstack browse not found; run check-prereqs.sh" >&2; exit 1; }
