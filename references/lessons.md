# Lessons (rules learned the hard way)

Each rule exists because breaking it cost a rebuild. Read the ones for your phase.

## Assets
- **Check every generated or supplied image for watermarks**, including client
  photos (AI tools stamp a small sparkle bottom-right). Patch with texture from
  beside it (`scripts/img/patch-watermark.sh`), never a blur or crop that
  changes framing.
- **Sets that sit together must share a baseline.** Objects meant for one row,
  rack or grid need the same shelf height and centre: `scripts/img/align-on-baseline.py`.
- **Grade the whole library once** with one house grade so it reads as one shoot.
- **Demo first.** Generate 2-3 images to lock the vibe before any batch.
- **Generate from the frozen shot list** (end of low-fi design), not before;
  otherwise sections change and images get redone.
- **An image prompt that includes a photo can be refused where text-only
  passes.** Retry text-only before giving up.

## Video
- **720p looks soft full-screen.** Plan a 1080p+ source for any full-bleed shot,
  or frame the video inside an inset viewport. Check quota/credits first.
- **Scroll-scrubbed video = WebP frame sequence on a canvas**, not a `<video>`
  (seeking is janky). ~14 fps desktop, portrait crop ~9 fps mobile, ~4-5 MB.
- **Watermarks on video:** crop them out of frame rather than delogo (smears).
- **End sharp.** If a scrub ends on a still moment, crossfade to a high-res
  photo of the same frame.
- **Reverse + regrade** an existing clip to get a second shot for free
  (a descent becomes an ascent at dawn).
- **Local AI upscalers** (Real-ESRGAN etc.) are slow and hallucinate on photos.
  Prefer a better source or a paid upscaler on real footage.

## Motion + layout
- **Animate transform and opacity only.** Never filter/backdrop-filter/box-shadow mid-motion.
- **Line-reveal masks clip on the y axis only** (`overflow-x: visible; overflow-y: clip`)
  plus bottom padding, or serif descenders and italic overhangs get cut. No
  negative side margins (they widen the page on phones).
- **Every pinned scroll scene needs a stacked fallback** for reduced motion
  (and usually phones), or later panels become unreachable.
- **Sticky beats pin** when possible; `overflow: hidden` on an ancestor breaks
  sticky, `overflow: clip` does not.
- **One ticker.** Lenis stepped from the GSAP ticker; everything else hooks the
  same ticker; pause work when off-screen.
- **WebGL lazy after LCP**, behind a static poster, never required for content.
- **GSAP never targets Next `<Link>` / `<Image>` directly**: wrap and animate the wrapper.
- **Flat sections are a failure.** Backgrounds flow into each other through the theme.

## Build + tooling
- **Give the site its own pnpm workspace + lockfile** (`pnpm-workspace.yaml`),
  or pnpm rewrites a parent lockfile.
- **A site in a subfolder of another app's repo:** exclude it from the parent
  tsconfig/eslint, and deploy it from its own repo (`git subtree split`).
- **Judge performance only on a production build** (`build && start`).
- **Measure horizontal overflow after the page settles**; a brief overflow
  during intro animation is not a bug if `body { overflow-x: clip }`.
- **Never `pkill -f <pattern>`** from the agent shell: it can match and kill
  the shell itself. Find the PID and kill that.

## Browser automation
- **Google sign-in needs a headed browser**, and the user signs in themselves.
  Save the session state afterwards; headless may lose it.
- **Downloads from web apps:** click the app's own "download full size" button
  via JS and pick the file up from the browser's download folder.
- **Close the automation browser when generation is done.**

## Honesty
- **Flag proposed copy** (not from the client) and every placeholder
  (client counts, phone numbers, certificate numbers, office photos) in
  `.pretty/assets.md` and in the final report.
- **Illustrative data is labelled** as illustrative on the page.
