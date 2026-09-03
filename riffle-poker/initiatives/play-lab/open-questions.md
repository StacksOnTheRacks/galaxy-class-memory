---
doc: product.open_questions
schema_version: 1
updated: 2026-09-03
questions:
  - id: lab-shell-frames
    question: "Lab-shell frames are missing on Screens / Flows. Prebuild via /forge.design-spike before designer HLD sign-off?"
    blocking: true
    status: open
    owner: designer
  - id: lab-runtime-hosting
    question: "Where is the play lab and Riffle runtime served for a human operator (local process only vs a deployed lab URL)?"
    blocking: false
    status: open
    owner: architect
  - id: lab-exposure-bound
    question: "Is localhost-only lab exposure (loopback bind / refuse non-loopback clients) a hard requirement this HLD, or may LLD choose any equivalent control that prevents an unauthenticated public match factory (loopback, default-off flag, lab secret, or combination)?"
    blocking: false
    status: open
    owner: security
  - id: lab-parent-origin
    question: "Must the lab parent be a distinct origin from the Riffle /play iframes (so sibling frames cannot reach each other through a same-origin parent), or may LLD use an equivalent isolation (e.g. iframe sandbox without allow-same-origin)?"
    blocking: false
    status: open
    owner: architect
  - id: lab-one-seat-intermediate
    question: "Is a one-seat-attached intermediate state a required Now screen, or is two-empty → two-live enough?"
    blocking: false
    status: open
    owner: product
---

<!--
Authoring (not validated):
- questions: [{ id, question, blocking, status, owner }]
- status: open | answered | deferred
- Remove answered items; defer with status deferred rather than deleting if still relevant.
- Bump updated when any frontmatter field changes.
-->
