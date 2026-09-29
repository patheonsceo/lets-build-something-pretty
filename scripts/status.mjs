// Print a prettifysite project's progress board from .pretty/.
// usage: node status.mjs [project-dir]
import { existsSync, readFileSync } from "node:fs";
import { join, resolve } from "node:path";

const root = resolve(process.argv[2] || ".");
const P = (f) => join(root, ".pretty", f);
if (!existsSync(P("state.json"))) { console.log("No prettifysite project here (.pretty/state.json not found). Run /prettifysite:start."); process.exit(0); }
const state = JSON.parse(readFileSync(P("state.json"), "utf8"));
const read = (f) => (existsSync(P(f)) ? readFileSync(P(f), "utf8") : "");

const phases = [
  ["0-intake", "Intake"], ["1-direction", "Direction"], ["2-system", "Design system"], ["3-imagery", "Imagery"],
  ["4-handoff", "Handoff"], ["5-theme", "Theme"], ["6-lowfi", "Low-fi design"], ["7-assets", "Assets"], ["8-ship", "Build + ship"],
];
const cur = Number(state.phase ?? 0);
const bar = (n, total, w = 20) => "█".repeat(Math.round((n / total) * w)).padEnd(w, "░");
const done = phases.filter(([k]) => /^(done|approved|closed|skipped)$/i.test(state.gates?.[k] ?? "")).length;

console.log(`\n  prettifysite · ${state.project || "untitled project"}`);
console.log(`  ${bar(done, phases.length)}  ${done}/${phases.length} gates signed off\n`);
phases.forEach(([k, name], i) => {
  const g = (state.gates?.[k] ?? "open").toLowerCase();
  const skipped = (state.skipped || []).includes(i) || g === "skipped";
  const mark = skipped ? "–" : /done|approved|closed/.test(g) ? "✓" : i === cur ? "▶" : "·";
  const note = skipped ? "skipped" : i === cur ? `in progress · ${state.step || ""}` : /done|approved|closed/.test(g) ? "signed off" : "";
  console.log(`  ${mark}  ${String(i).padStart(2, "0")}  ${name.padEnd(15)} ${note}`);
});
if (cur >= 9) console.log(`  ▶  09  After launch    polishing`);

const dec = read("decisions.md").split("\n").filter((l) => l.startsWith("- ["));
const count = (re) => dec.filter((l) => re.test(l)).length;
console.log(`\n  Decisions  ${count(/APPROVED/)} approved · ${count(/DELEGATED/)} delegated · ${count(/REJECTED/)} rejected`);
const last = dec.at(-1);
if (last) console.log(`  Last       ${last.slice(2, 140)}`);

const assets = read("assets.md").split("\n").filter((l) => l.startsWith("|") && !/^\|\s*(Asset|---)/.test(l));
const missing = assets.filter((l) => /\|\s*(missing|placeholder)\s*\|/i.test(l)).map((l) => l.split("|")[1].trim());
if (missing.length) console.log(`  Missing    ${missing.join(" · ")}`);

const shots = read("shotlist.md").split("\n").filter((l) => /^\|\s*\d+/.test(l));
if (shots.length) {
  const ok = shots.filter((l) => /approved/i.test(l)).length;
  console.log(`  Shot list  ${bar(ok, shots.length, 12)} ${ok}/${shots.length} assets approved`);
}
if (state.canvas) console.log(`  Canvas     ${state.canvas}`);
console.log(`\n  Resume with /prettifysite:start continue\n`);
