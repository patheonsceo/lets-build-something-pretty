// QA audit for a running site: desktop 1440, tablet 768, phone 390, and
// desktop with prefers-reduced-motion. Reports LCP, CLS, TTFB, console errors,
// failed requests and horizontal overflow (measured after the page settles),
// and saves screenshots at 0/15/30/.../90% of the page for you to look at.
//
// usage: node audit.mjs <url> <out-dir>
// Uses the Playwright bundled with gstack (no extra install).
import { existsSync, mkdirSync } from "node:fs";
import { homedir } from "node:os";
const pwPath = `${homedir()}/.claude/skills/gstack/node_modules/playwright/index.mjs`;
if (!existsSync(pwPath)) { console.error("Playwright from gstack not found at " + pwPath); process.exit(1); }
const { chromium, devices } = await import(pwPath);
const [URL, OUT = "qa-out"] = process.argv.slice(2);
if (!URL) { console.error("usage: node audit.mjs <url> <out-dir>"); process.exit(1); }
mkdirSync(OUT, { recursive: true });

const runs = [
  ["desktop", { viewport: { width: 1440, height: 900 } }],
  ["tablet", { viewport: { width: 768, height: 1024 } }],
  ["phone", { ...devices["iPhone 13"] }],
  ["reduced", { viewport: { width: 1440, height: 900 }, reducedMotion: "reduce" }],
];
const b = await chromium.launch();
const report = {};
for (const [name, opts] of runs) {
  const ctx = await b.newContext(opts);
  const p = await ctx.newPage();
  const errs = [], bad = [];
  p.on("pageerror", (e) => errs.push(e.message));
  p.on("console", (m) => m.type() === "error" && errs.push(m.text()));
  p.on("response", (r) => r.status() >= 400 && bad.push(`${r.status()} ${r.url()}`));
  await p.goto(URL, { waitUntil: "load" });
  await p.waitForTimeout(4000);
  const m = await p.evaluate(() => new Promise((res) => {
    let lcp = 0, cls = 0;
    new PerformanceObserver((l) => { for (const e of l.getEntries()) lcp = e.startTime; }).observe({ type: "largest-contentful-paint", buffered: true });
    new PerformanceObserver((l) => { for (const e of l.getEntries()) if (!e.hadRecentInput) cls += e.value; }).observe({ type: "layout-shift", buffered: true });
    const nav = performance.getEntriesByType("navigation")[0];
    setTimeout(() => res({ lcp: Math.round(lcp), cls: +cls.toFixed(4), ttfb: Math.round(nav.responseStart),
      overflowPx: document.documentElement.scrollWidth - innerWidth, height: document.documentElement.scrollHeight }), 400);
  }));
  for (const f of [0, 0.15, 0.3, 0.45, 0.6, 0.75, 0.9]) {
    await p.evaluate((y) => window.scrollTo(0, y), Math.round(m.height * f));
    await p.waitForTimeout(1300);
    await p.screenshot({ path: `${OUT}/${name}-${String(Math.round(f * 100)).padStart(2, "0")}.png` });
  }
  const canScrollX = await p.evaluate(() => { scrollTo(80, scrollY); return scrollX > 0; });
  report[name] = { ...m, canScrollX, errors: errs, failedRequests: bad.slice(0, 8) };
  await ctx.close();
}
await b.close();
const pass = Object.values(report).every((r) => r.cls === 0 && r.errors.length === 0 && r.failedRequests.length === 0 && !r.canScrollX)
  && report.desktop.lcp < 1500 && report.phone.lcp < 1500;
console.log(JSON.stringify(report, null, 1));
console.log(pass ? "QA PASS" : "QA FAIL (see report)");
