---
doc: product.open_questions_index
schema_version: 1
updated: 2026-09-02
items:
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
  - initiative: playable-holdem-table
    id: seat-capability-token-schema
    question: "What is the concrete host-issued seat capability format (claims, issuer, crypto, TTL, refresh/revocation) that Riffle server verifies before seat-scoped Turnur reads/writes? Pattern is locked (host-issued capability); concrete format is LLD."
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
