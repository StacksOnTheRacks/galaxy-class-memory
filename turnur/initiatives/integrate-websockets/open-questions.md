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
    question: "API Gateway WebSocket $connect uses ?token=. Confirm LLD mechanism so access logs and CloudWatch never emit the query string."
    blocking: false
    status: deferred
    owner: security
---

Superseded — Turnur mothballed. Initiative abandoned — do not groom.
