---
doc: product.open_questions
schema_version: 1
updated: 2026-09-02
questions:
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
