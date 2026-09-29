---
type: llm
focus: last_message
weight: 2
---

PASS only if the final message: picks the remaining design-system decisions on
the user's behalf, presents them together once (one board or one summary), and
asks ONE approval question (approve all / change something) before any build.
FAIL if it says building has started, or if it re-asks many separate questions.
