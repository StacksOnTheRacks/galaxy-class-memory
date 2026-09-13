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
  - id: ws-reconnect-backoff
    question: "Reconnect and resubscribe backoff policy when Turnur WS disconnects mid-hand?"
    blocking: false
    status: open
    owner: architect
  - id: ws-event-wait-timeout
    question: "Default timeout before poll fallback after HTTP mutation when expected push does not arrive?"
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

Answered in HLD (removed from list): turnur-ws-url-config (TURNUR_WS_URL env from Turnur stack output); play-lab-vs-table-scope (lab owns subscribe lifecycle; shared orchestration modules in same slice); notify-vs-read-strategy (event→HTTP matrix locked in spec.md).
