---
doc: product.open_questions
schema_version: 1
updated: 2026-09-12
questions:
  - id: turnur-ws-shipping
    question: "Turnur integrate-websockets (#44–#49) must ship before Riffle adoption — track milestone status?"
    blocking: true
    status: open
    owner: architect
  - id: turnur-ws-url-config
    question: "How does Riffle runtime obtain TURNUR_WS_URL (env var, Turnur stack output, same deploy as HTTP base)?"
    blocking: false
    status: open
    owner: architect
  - id: notify-vs-read-strategy
    question: "On each event type, which HTTP reads are still required vs can be skipped (moves.list always, turn.get on turn.designated only, etc.)?"
    blocking: false
    status: open
    owner: architect
  - id: play-lab-vs-table-scope
    question: "v1 limited to play-lab orchestrator or all server orchestration paths in one slice?"
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
