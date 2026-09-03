---
doc: product.open_questions
schema_version: 1
updated: 2026-09-02
questions:
  - id: host-iframe-bootstrap
    question: "How does the host pass match/session context into the Riffle iframe (URL params, short-lived token, postMessage, etc.) so the runtime can attach the correct Turnur match without putting the Turnur SDK key in the browser?"
    blocking: true
    status: open
    owner: architect
  - id: theme-bind-riffle-poker
    question: "Bind a Figma theme for riffle-poker (figma_url / figma_file_key on design/themes.md) so structure, tokens, and screen inventory can be projected. Until then designer HLD cannot cite real frames and design/screens.md must stay empty."
    blocking: true
    status: open
    owner: designer
  - id: prebuild-seated-table-figma
    question: "Pre-build Figma Screens/Flows for the seated iframe table (felt, my-turn actions, between-hands, showdown, embed error) with named states and a11y annotations before HLD exit. Recommend /forge.design-spike after theme-bind if frames do not exist yet."
    blocking: true
    status: open
    owner: designer
  - id: stack-blinds-defaults
    question: "Starting stack and blinds defaults for the first playable NLHE table?"
    blocking: false
    status: open
    owner: product
  - id: runtime-hosting
    question: "Where does Riffle runtime host (process/platform)? Undecided; non-blocking while iframe + in-process library + server-side SDK key hold."
    blocking: false
    status: open
    owner: architect
  - id: seat-capability-token-schema
    question: "What is the concrete host-issued seat capability format (claims, issuer, crypto, TTL, refresh/revocation) that Riffle server verifies before seat-scoped Turnur reads/writes? Pattern is locked (host-issued capability); concrete format is LLD."
    blocking: false
    status: open
    owner: security
---

<!--
Authoring (not validated):
- questions: [{ id, question, blocking, status, owner }]
- status: open | answered | deferred
- Remove answered items; defer with status deferred rather than deleting if still relevant.
- Bump updated when any frontmatter field changes.
-->
