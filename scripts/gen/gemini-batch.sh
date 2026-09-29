#!/usr/bin/env bash
# Generate every row of a TSV (name<TAB>subject) with one shared style prompt.
# usage: bash gemini-batch.sh <prompts.tsv> <out-dir> "<style prompt containing SUBJECT>"
# Skips rows whose <out-dir>/<name>.png already exists, so it is safe to re-run.
TSV="$1"; OUT="$2"; STYLE="$3"; mkdir -p "$OUT"
while IFS=$'\t' read -r name subj; do
  [ -z "$name" ] && continue
  [ -f "$OUT/$name.png" ] && continue
  bash "$(dirname "$0")/gemini-image.sh" "$OUT/$name.png" "${STYLE/SUBJECT/$subj}" | sed "s/^/$name: /"
done < "$TSV"
