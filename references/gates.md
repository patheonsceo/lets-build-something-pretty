# Running a gate

A gate is how every decision gets made. Same shape every time.

## The shape

1. **Show.** Put the options where the user can see them: a canvas board for
   anything visual, a short table or list for anything else. 2-4 options,
   genuinely different, one marked as your recommendation with a one-line why.
2. **Ask.** Use the question picker (AskUserQuestion):
   - 1-4 questions per round, 2-4 options each.
   - Recommended option first, label ends with "(Recommended)".
   - Use `preview` (ASCII mockup, palette swatch text, code) when options are
     visual and the canvas is not enough on its own.
   - `multiSelect: true` only when choices genuinely combine.
   - The user can always answer "Other" in free text; treat it as a new option.
   - Open-ended input (links, inspirations, copy) is asked as plain text, not
     through the picker.
   - Picker unavailable (headless or another harness): print a numbered list
     and wait for the reply.
3. **Record.** Append to `.pretty/decisions.md`:
   `- [YYYY-MM-DD] P<phase> <topic>: <verdict> (APPROVED | DELEGATED | REJECTED: <option> because <reason>)`
   Rejected options are recorded too, with the user's reason. They are how
   the next session avoids repeating them.
4. **Advance.** Update `.pretty/state.json` (`phase`, `step`, `gates`).
   Tell the user in one line what is next.

## Iteration is normal

"Not quite" is a verdict. Record what was wrong, make a new round of options
that fixes it, gate again. Do not defend the rejected option; do not merge the
feedback silently into a build.

## Pushback

You may disagree. Say so once, with a concrete reason, then let the user
decide. Their verdict is recorded as theirs.

## Delegation

See the start skill: pick, record as DELEGATED, show together once, one gate.
