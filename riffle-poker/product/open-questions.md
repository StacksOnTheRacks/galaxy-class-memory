---
doc: product.open_questions_index
schema_version: 1
updated: 2026-09-02
items:
  - initiative: playable-holdem-table
    id: theme-bind-riffle-poker
    question: "Bind a Figma theme for riffle-poker (figma_url / figma_file_key on design/themes.md) so structure, tokens, and screen inventory can be projected. Until then designer HLD cannot cite real frames and design/screens.md must stay empty."
    blocking: true
    status: open
  - initiative: playable-holdem-table
    id: prebuild-seated-table-figma
    question: "Pre-build Figma Screens/Flows for the seated iframe table (felt, my-turn actions, between-hands, showdown, embed error) with named states and a11y annotations before HLD exit. Recommend /forge.design-spike after theme-bind if frames do not exist yet."
    blocking: true
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
