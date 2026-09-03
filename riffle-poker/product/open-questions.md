---
doc: product.open_questions_index
schema_version: 1
updated: 2026-09-03
items:
  - initiative: play-lab
    id: lab-runtime-hosting
    question: "Where is the play lab and Riffle runtime served for a human operator (local process only vs a deployed lab URL)?"
    blocking: false
    status: open
  - initiative: play-lab
    id: lab-exposure-bound
    question: "Is localhost-only lab exposure (loopback bind / refuse non-loopback clients) a hard requirement this HLD, or may LLD choose any equivalent control that prevents an unauthenticated public match factory (loopback, default-off flag, lab secret, or combination)?"
    blocking: false
    status: open
  - initiative: play-lab
    id: lab-parent-origin
    question: "Must the lab parent be a distinct origin from the Riffle /play iframes (so sibling frames cannot reach each other through a same-origin parent), or may LLD use an equivalent isolation (e.g. iframe sandbox without allow-same-origin)?"
    blocking: false
    status: open
  - initiative: playable-holdem-table
    id: stack-blinds-defaults
    question: "Starting stack and blinds defaults for the first playable NLHE table?"
    blocking: false
    status: open
  - initiative: playable-holdem-table
    id: runtime-hosting
    question: "Where does Riffle runtime host (process/platform)? Undecided; non-blocking while iframe + in-process library + server-side SDK key hold."
    blocking: false
    status: open
---

<!--
Authoring (not validated):
- Rollup of initiatives/*/open-questions.md for /forge.initiative-planning.
- items: [{ initiative, id, question, blocking, status }]
- Maintained by open-questions-rollup skill — do not hand-edit as SoT.
- Bump updated when any frontmatter field changes.
-->
