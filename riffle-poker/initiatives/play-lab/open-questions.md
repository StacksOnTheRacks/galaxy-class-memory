---
doc: product.open_questions
schema_version: 1
updated: 2026-09-04
questions:
  - id: lab-runtime-hosting
    question: "Where is the play lab and Riffle runtime served for a human operator (local process only vs a deployed lab URL)?"
    blocking: false
    status: open
    owner: architect
  - id: lab-parent-origin
    question: "Must the lab parent be a distinct origin from the Riffle /play iframes (so sibling frames cannot reach each other through a same-origin parent), or may LLD use an equivalent isolation (e.g. iframe sandbox without allow-same-origin)?"
    blocking: false
    status: open
    owner: architect
---

<!--
Authoring (not validated):
- questions: [{ id, question, blocking, status, owner }]
- status: open | answered | deferred
- Remove answered items; defer with status deferred rather than deleting if still relevant.
- Bump updated when any frontmatter field changes.
-->

Answered and removed by play-lab design-spike (2026-09-03):
- lab-shell-frames — prebuilt on Screens / Flows (4012:52, 4012:70, 4012:89, 4012:142)
- lab-one-seat-intermediate — not required Now; two-empty → two-live is sufficient

Answered and removed at refinement of #21 (2026-09-04):
- lab-exposure-bound — `POST /v1/lab/session` requires default-off `RIFFLE_LAB_ENABLED` (enabled only for trimmed `1` or `true`, case-insensitive) plus loopback remote address (connection / test-injected seam; never `X-Forwarded-For`). No lab shared secret. `GET /lab` is #23.
