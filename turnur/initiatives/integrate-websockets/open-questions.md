---
doc: product.open_questions
schema_version: 1
updated: 2026-09-11
questions:
  - id: ws-connect-auth
    question: "SDK key on $connect query token (operator confirmed). Document in integrator README?"
    blocking: false
    status: answered
    owner: architect
  - id: ws-event-catalog-v1
    question: "Confirm v1 emit set: match.created, seat.created, turn.designated, move.accepted, view.updated (view.updated seatId-only)."
    blocking: false
    status: open
    owner: architect
  - id: ws-client-location
    question: "Riffle play lab: WebSocket from server-side orchestrator vs browser iframe — affects where SDK key lives."
    blocking: false
    status: open
    owner: po
  - id: ws-adr-lock
    question: "When to promote examine slice to ADR vs ship minimal notify behind feature flag."
    blocking: false
    status: deferred
    owner: architect
  - id: ws-connection-limits
    question: "Max concurrent connections per gameId/matchId."
    blocking: false
    status: deferred
    owner: architect
---

<!--
Authoring (not validated):
- questions: [{ id, question, blocking, status, owner }]
- status: open | answered | deferred
- Remove answered items; defer with status deferred rather than deleting if still relevant.
- Bump updated when any frontmatter field changes.
-->
