# Recommended stack (the one the author mostly uses)

Offer this as the default at intake. The user may choose anything else; if they
do, keep the principles (static rendering, one animation clock, lazy WebGL,
reduced-motion path) and translate the rest.

| Layer | Choice | Why |
|---|---|---|
| Framework | Next.js (App Router), React, TypeScript strict | Static rendering, `next/image` (AVIF/WebP + blur), Metadata API for SEO |
| Styling | Tailwind CSS v4, CSS-first `@theme` tokens | Tokens from the design system map 1:1 to utilities |
| Motion | GSAP + ScrollTrigger + `@gsap/react` (`useGSAP`) | Pins, scrubs, timelines; reliable cleanup |
| Smooth scroll | Lenis, stepped from the GSAP ticker | One clock, no jitter between scroll and animation |
| WebGL | OGL (tiny) | Haze, particles, shader moments without three.js weight |
| Fonts | `next/font` (self-hosted) | No layout shift, no third-party requests |
| Package manager | pnpm, own workspace | Fast, strict, isolated |
| Deploy | Vercel | Zero-config for Next, preview per push |

Performance bar: LCP < 1.5s, CLS 0, 60fps scroll, 0 console errors.

Folder shape that worked:
```
src/app        layout, page, globals.css (tokens), sitemap/robots/manifest
src/sections   one file per section/chapter
src/theme      site-wide layers (header, cursor, grain, grid, background)
src/shots      frame-sequence engine
src/gl         WebGL moments
src/ui         buttons, reveal helpers, logo
src/lib        content, images (static imports), seo, motion tokens
src/assets     graded image library
public/frames  video frame sequences
```
