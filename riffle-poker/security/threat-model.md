---
doc: security.threat_model
schema_version: 1
updated: 2026-09-25
assets:
  - "Seat-scoped hidden hole cards (except legal showdown reveal)"
  - "Match state — seats, stacks, pot, board, turn, move log (play chips; no cash)"
  - "dashboard-holdem — DynamoDB match state (seats, stacks, pot, board, turn, move log)"
  - "dashboard-holdem — seat-scoped hole cards in DynamoDB / Lambda memory"
  - "dashboard-holdem — server-issued seat tokens (anonymous table session)"
  - "dashboard-holdem — API Gateway WebSocket connection↔seat binds"
  - "dashboard-holdem — GitHub Actions OIDC deploy role / CDK stack"
  - "dashboard-holdem — S3/CloudFront static play origin"
  - "Historical — Riffle play session bearer, embed shared play URL, host keys (frozen; do not extend)"
trust_boundaries:
  - "dashboard-holdem browser / CloudFront static UI — untrusted; presentation only"
  - "API Gateway WebSocket + Lambda — sole match/rules authority for forward path"
  - "DynamoDB — match SoT; no direct client access"
  - "GitHub Actions OIDC → AWS deploy role — CI trust boundary"
  - "Historical — host page embed, notify-only WS, MatchStore HTTP (frozen)"
threats:
  - "Cross-seat or spectator hole-card leak via WS fanout, DynamoDB read, errors, cache, or logs"
  - "Unauthorized action on another seat's turn"
  - "Connection hijack / reconnect without seat token"
  - "GitHub OIDC deploy over-scope"
  - "Secrets in static client bundle"
  - "Accidental payment/cashier rails despite play chips only"
  - "Seat-token theft via XSS on static origin"
  - "Historical — embed URL leakage, host postMessage abuse, bearer theft on MatchStore path (frozen)"
mitigations:
  - "Lambda-only writes + seat-token auth; public fanout strips holes"
  - "DynamoDB least privilege; no public table; hole fields not on public GSIs"
  - "Reconnect rebind via seat token; connectionId alone never authorizes"
  - "OIDC repo/env-scoped least privilege for CDK deploy"
  - "No client AWS secrets; no hole/token logging"
  - "Play chips only — reject client-supplied stacks/pots/deals"
  - "Historical — frame-ancestors, bearer-only, do not extend host-key paths"
open_questions: []
---

Account login is out of dashboard-holdem initiative; anonymous seat token is the forward auth model for v1.
