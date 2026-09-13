---
doc: product.open_questions
schema_version: 1
updated: 2026-09-12
questions:
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
  - id: ws-apigw-access-log-redaction
    question: "API Gateway WebSocket $connect uses ?token=. Confirm LLD mechanism so access logs and CloudWatch never emit the query string (omit access logging vs custom format without query variables). Not an ALB question — Turnur is APIGW WS."
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
