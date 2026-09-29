// prettifysite gate guard (PreToolUse on Write/Edit/MultiEdit/NotebookEdit).
//
// If the file being written belongs to a prettifysite project (a .pretty/state.json
// exists in it or a parent folder) and that project has not reached Phase 8
// (build), writing app code triggers a confirmation prompt for the USER, with
// the reason. Design artefacts (.pretty/, docs/, boards, markdown) are always
// allowed. Outside prettifysite projects this hook does nothing.
import { existsSync, readFileSync } from "node:fs";
import { dirname, join, relative, resolve, sep } from "node:path";

let input = "";
for await (const chunk of process.stdin) input += chunk;
let data;
try { data = JSON.parse(input); } catch { process.exit(0); }

const file = data?.tool_input?.file_path || data?.tool_input?.notebook_path;
if (!file) process.exit(0);
const abs = resolve(data.cwd || process.cwd(), file);

// Walk up from the file to find the project's .pretty/state.json.
let dir = dirname(abs), root = null;
while (true) {
  if (existsSync(join(dir, ".pretty", "state.json"))) { root = dir; break; }
  const up = dirname(dir);
  if (up === dir) break;
  dir = up;
}
if (!root) process.exit(0);

let state;
try { state = JSON.parse(readFileSync(join(root, ".pretty", "state.json"), "utf8")); } catch { process.exit(0); }
const phase = Number(state.phase ?? 0);
if (phase >= 8) process.exit(0);

const rel = relative(root, abs);
const parts = rel.split(sep);
const designArtefact =
  parts[0] === ".pretty" || parts[0] === "docs" || parts[0] === ".claude" || parts[0] === ".github" ||
  parts.includes("boards") || /\.(md|mdx|txt|json)$/i.test(rel) && !/(^|\/)(package|tsconfig|next\.config)/.test(rel);
if (designArtefact) process.exit(0);

const names = ["Intake", "Direction", "Design system", "Imagery", "Handoff", "Theme", "Low-fi design", "Assets"];
process.stdout.write(JSON.stringify({
  hookSpecificOutput: {
    hookEventName: "PreToolUse",
    permissionDecision: "ask",
    permissionDecisionReason:
      `prettifysite: this project is in Phase ${phase} (${names[phase] ?? "?"}, step "${state.step ?? ""}"). ` +
      `Site code is written in Phase 8, after every design gate is signed off. ` +
      `Approve only if you asked for this file now (e.g. a prototype board).`,
  },
}));
