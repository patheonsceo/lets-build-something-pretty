# <Project>: design spec

Status: <draft | APPROVED on YYYY-MM-DD>. Source of truth for the build.
Decisions log: `.pretty/decisions.md`. Canvas: <url>.

## 1. Goal and bar
- Client / business:
- Audience that must be impressed:
- Success looks like:
- Must still feel:
- Priorities: performance (LCP < 1.5s, CLS 0, 60fps), then smoothness, then SEO.

## 2. Direction
- Approved direction + one-line concept:
- References (links + what to take from each):
- Rejected directions (and why):

## 3. Design system (exact values)
### Colour
| Token | Hex | Role |
|---|---|---|

### Type
- Families + weights:
- Scale (desktop → mobile, line-height, tracking):
- Rules (e.g. serif only for 1-3 italic words):

### Space, grid, shape
- Spacing steps:
- Grid per breakpoint (columns / margin / gutter / max width):
- Radius rules:

### Motion
- Durations:
- Easings:
- Allowed patterns:
- Reduced motion:

### Components
- Buttons (variants, states, press behaviour):
- Inputs:
- Surfaces / glass recipes:
- Header behaviour:
- Cursor:
- Text over photos (grade + scrim values):

## 4. Imagery
- Art direction:
- Generation method:
- Prompt style block (with SUBJECT slot):
- House grade:

## 5. Theme (filled in Phase 5)
- Through-line:
- Section flow:
- Site-wide layers:
- Motion language:
- Hero moments (frame by frame):

## 6. Sections (filled in Phase 6)
One entry per section: layout, copy source, motion, interactions, phone
version, board link.

## 7. Assets
Shot list: `.pretty/shotlist.md`. Missing from client: (list).

## 8. Build plan
Stack, folder structure, commit convention, deploy target.

## 9. Testing
Production build · `scripts/qa/audit.mjs` must print QA PASS · screenshots at
1440 / 768 / 390 · reduced motion reaches every panel · typecheck + lint clean.
