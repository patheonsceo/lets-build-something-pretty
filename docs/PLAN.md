# Let's Build Something Pretty: plugin plan

Status: DRAFT v0.1 for review. Nothing is built until this is signed off.

## 1. What it is

A public Claude Code plugin that turns the agent into a design partner for
building show-off-worthy websites (landing pages or multi-page sites), step by
step, with the user signing off every decision. It packages a proven process
that takes a site from a forgettable first build to a cinematic, credible,
show-off-worthy one.

One command starts or resumes a project: `/prettifysite:start`.

Naming: the repo (and marketplace) is `lets-build-something-pretty`; the plugin
itself is named `prettifysite`, because Claude Code always namespaces plugin
commands as `/plugin:skill` (a bare `/prettifysite` is not possible). Every phase is
also callable directly, e.g. `/prettifysite:intake`, `/prettifysite:inventing-the-theme`.

Install:
```
/plugin marketplace add patheonsceo/lets-build-something-pretty
/plugin install prettifysite@lets-build-something-pretty
```

## 2. Principles (the rules every phase skill enforces)

1. **Never one-shot.** One decision at a time. Show options, get a verdict,
   record it, move on.
2. **Mutual sign-off gates.** A phase ends only when the user approves. The
   agent may push back and recommend, but the user decides.
3. **See, don't guess.** Research and QA happen in a real browser (gstack), with
   screenshots the agent actually looks at.
4. **Both sides bring inspiration.** The user is asked for references; the agent
   does its own research across several platforms.
5. **State lives on disk.** Every sign-off, rejection and reason is written to
   `.pretty/` so any session (or any agent) can resume after a compaction.
6. **Creative ambition bar.** No flat, templated sections. Every site gets a
   through-line theme, motion, and at least one hero moment.
7. **Performance bar.** LCP < 1.5s, CLS 0, 60fps scroll, reduced-motion path,
   0 console errors, no horizontal scroll at 390px. Judged on a production build.
8. **Honesty.** Placeholders, proposed (non-client) copy and assumptions are
   flagged, never passed off as real.

## 3. The phases

Each phase is its own skill, loaded only when that phase is active.

| # | Phase (skill) | Goal | Gate (user signs off) |
|---|---|---|---|
| 0 | `intake` | Brief, content, assets, constraints, stack, deploy target; prerequisites check | Brief + asset list confirmed |
| 1 | `finding-direction` | Research both sides, converge on a direction | Direction approved |
| 2 | `designing-the-system` | Design system built one element at a time on a canvas | Each element signed off; clean final canvas |
| 3 | `directing-imagery` | Art direction, 2-3 demo generations, pick the generation method | Vibe + method approved |
| 4 | `handing-off` | Spec + decisions committed; context checkpoint | Spec approved |
| 5 | `inventing-the-theme` | Brainstorm the site-wide theme: motion, section flow, hero moments | Theme chosen |
| 6 | `designing-lowfi` | Low-fidelity layout of every section, iterate, critique pass | Layout signed off |
| 7 | `generating-assets` | Generate every image and video from the approved shot list | Each asset approved |
| 8 | `building-and-shipping` | Build section by section, test, deploy | QA checklist passes |
| 9 | `polishing-after-launch` | Feedback loop on the live site | Ongoing |

### Phase 0: intake
- Run `scripts/check-prereqs.sh`: gstack present and current (if old, stop and
  ask the user to run `/gstack-upgrade`; if missing, give the install steps),
  Node + pnpm, ffmpeg + ImageMagick (for asset processing), optional
  superpowers / impeccable / frontend-design.
- Ask (AskUserQuestion, a few at a time): business, audience, what "success"
  means ("the client shows it off"), existing site or v1, copy source, assets
  they have, assets missing, brand constraints, pages, deploy target.
- Stack: default is the **recommended stack, the one the author mostly uses**:
  Next.js (App Router) + TypeScript + Tailwind v4 + GSAP/ScrollTrigger + Lenis +
  OGL. The user may swap it.
- Ask whether the client already has a brand/design system. If yes, offer to
  skip Phases 1-2 (import their tokens, fonts and components instead) and
  record the choice.
- Writes `.pretty/brief.md` and `.pretty/assets.md` (have / missing / placeholder).

### Phase 1: finding direction
- Ask the user for inspirations (links, screenshots, sites they love and hate).
- Agent research: web search + gstack browser across Awwwards, Dribbble,
  Pinterest, Behance, godly, siteinspire, competitors. Screenshot, look, tag
  what works.
- Present 2-4 directions on a canvas (moodboard + one-line concept each).
  To-and-fro until one is approved.
- Uses: gstack `/browse`, WebSearch, superpowers:brainstorming, canvas artifact.

### Phase 2: designing the system (long, one element at a time)
Order, each with its own sign-off:
1. Colour (brand extraction, ramps, accents, signal colours)
2. Type pairings (several, then weights; show real content, big numerals)
3. Scale, spacing, grid, shape (radius) rules
4. Buttons + inputs, with hover / press / in / out states
5. Glass / surfaces, header behaviour
6. Cursor (optional)
7. Text-over-photo legibility
8. Motion tokens + patterns
Then clean the canvas: remove rejected options, order everything.
- Uses: canvas artifact (or local HTML boards viewed through gstack as a
  fallback), frontend-design, impeccable.

### Phase 3: directing imagery
- Art direction options (e.g. documentary, editorial, 3D, illustration).
- 2-3 demo generations to lock the vibe.
- Ask how to generate: web automation of the user's subscription (Gemini via
  gstack headed browser, user signs in themselves) or an API provider
  (credits checked first). Record the choice.
- Bulk generation is NOT done here (see Phase 7).

### Phase 4: handing off
- Write the spec from `templates/spec.md`: goal, concept, tokens, components,
  motion, asset plan, testing bar. Commit it.
- Update `.pretty/state.json`; tell the user it is a good moment to compact.

### Phase 5: inventing the theme
- Agent must propose 3+ distinct site-wide themes. Each includes: the
  through-line idea, how backgrounds/sections flow into each other, the motion
  language, 1-3 cinematic/hero moments, and what makes it show-off-worthy.
- Rejects "flat sections" answers by rule.
- Uses: superpowers:brainstorming, canvas strip/detail boards.

### Phase 6: designing low-fi
- Tell the user explicitly: "this is low fidelity".
- One section at a time, explain the concept behind each.
- Critique pass before sign-off (impeccable / design-review lens): find the
  sections that are "not up to the mark" now, not after the build.
- Output: the approved shot list for Phase 7.

### Phase 7: generating assets
- Images and videos from the shot list, with the method chosen in Phase 3.
- Process: watermark check + patch, house grade, crop/align, resize, WebP/AVIF,
  frame sequences for scroll-scrubbed video.
- Video rule: full-screen shots need a 1080p+ source or a framed layout.
- Each asset approved; rejects regenerated.

### Phase 8: building and shipping
- Scaffold (own workspace + lockfile), theme layers first, then sections one
  at a time, committing per section.
- Test with `scripts/qa/`: prod build, 390/768/1440 screenshots (agent reads
  them), reduced motion, horizontal scroll, LCP/CLS, console errors.
- Deploy (Vercel by default), then run the live checks.

### Phase 9: polishing after launch
- User feedback loop: each request is scoped, shown, tested, committed; the user
  says when to push.

### How questions are asked (all phases)
Every decision uses Claude Code's interactive question picker
(AskUserQuestion): clickable options, a recommended option first, previews
(ASCII mockups, code, palettes) for visual comparisons, multi-select where
choices combine, and a free-text "Other" always available. Rules:
- 1-4 questions per round, 2-4 options each; never a wall of questions.
- Visual choices are also shown on the canvas; the picker records the verdict.
- Open-ended input (links, inspirations, copy) is asked as plain text.
- If the picker is unavailable (headless / other harness), fall back to a
  numbered text list and wait for the answer.

## 4. Repo layout

```
.claude-plugin/
  plugin.json          manifest: name "prettifysite", version, author
  marketplace.json     repo is its own marketplace; plugin source "."
skills/
  start/SKILL.md       /prettifysite:start, the instruction manual + resume logic
  intake/ … polishing-after-launch/SKILL.md   one per phase (above)
references/
  lessons.md           hard-won rules (below)
  stack-recommended.md the author's stack + why
  gates.md             how to run a sign-off gate (AskUserQuestion + previews)
  canvas.md            canvas board conventions + local fallback
templates/
  brief.md  decisions.md  spec.md  state.json  shotlist.md
scripts/
  check-prereqs.sh
  gen/  gemini-generate.sh  gemini-download.sh      (web automation, gstack)
  img/  patch-watermark.sh  grade.sh  align-on-shelf.py  to-webp.sh
  video/ clean-and-grade.sh  frames.sh              (ffmpeg)
  qa/   shoot.sh  perf-and-a11y.mjs                 (screenshots, LCP/CLS, reduced motion)
README.md  LICENSE
docs/PLAN.md (this file)
```

## 5. Project state (`.pretty/` in the user's project)

- `state.json`: current phase + step, gate statuses.
- `brief.md`, `assets.md`: from intake.
- `decisions.md`: every sign-off, every rejection and why (append-only).
- `shotlist.md`: from Phase 6, drives Phase 7.
- Canvas URL(s).
`/prettifysite:start` reads this first and resumes exactly where the project stopped.

## 6. Lessons baked in as rules (`references/lessons.md`)

- AI output (and some client photos) carry watermarks: check every asset.
- Line-reveal masks clip on the y axis only, or serif descenders get cut.
- Pinned scroll scenes need a stacked fallback for reduced motion, or content
  becomes unreachable.
- Give the site its own pnpm workspace so a parent lockfile is never rewritten.
- If the site lives in a subfolder of a repo with another app, exclude it from
  the parent tsconfig/eslint, and deploy it from its own repo (git subtree).
- Judge performance only on a production build.
- 720p video looks soft full-screen: plan 1080p+ or a framed layout.
- Reversed + regraded footage can create a second shot for free.
- Google sign-in needs a headed browser and the user signs in themselves.
- Never `pkill -f` from the agent's own shell.
- Image sets meant to sit together (a rack, a grid) must be aligned on a common
  baseline.
- Flag proposed copy and placeholders (client count, phone, certificates).

## 7. Prerequisites

Required: Claude Code, gstack (browser for research + QA), Node, pnpm,
ffmpeg, ImageMagick. gstack is not a Claude Code plugin, so it cannot be
declared as a manifest dependency; `check-prereqs.sh` verifies it (and its
version) at the start of every run. Plugin manifests can declare plugin
dependencies, but superpowers lives in another marketplace, so it stays
"recommended" and is detected at runtime rather than force-installed. Recommended: superpowers, impeccable, frontend-design.
Optional: an image/video API account, or a Gemini (Google AI Pro) subscription
for web automation.

## 8. Testing the plugin before release

Following writing-skills (RED/GREEN/REFACTOR), each skill gets pressure
scenarios run with subagents, first without the skill (baseline), then with it:
- "Just build the whole site now" (does it refuse to skip gates?)
- "Pick the fonts for me, I trust you" (does it still show options + record?)
- New session mid-phase (does it resume from `.pretty/`?)
- Missing gstack / old gstack (does it stop and guide?)
- Theme phase (does it produce 3+ ambitious themes, not flat sections?)

## 9. README outline

Hook ("From 2/10 to show-off"), install (two commands), what happens in each
phase (table), prerequisites, the recommended stack, credits, license.
Text only: no client names, no screenshots or pictures of any client work.

## 10. Decided

- Plugin name `prettifysite`; commands `/prettifysite:start`, `/prettifysite:intake`, ...
- No client names or pictures anywhere in the repo.
- Phases 1-2 skippable when the client already has a brand system (asked at intake).
- Version 1 ships all 10 phases.
