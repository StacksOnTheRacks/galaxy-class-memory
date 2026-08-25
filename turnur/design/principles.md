---
doc: design.principles
schema_version: 1
updated: 2026-08-25
principles:
  - "Optimize for integrators, not end players — docs, errors, and SDK surface target game devs and host engineers"
  - "Game-authenticated, host-attached — every API path assumes SDK-key game auth and host-owned player identity"
  - "Predictable HTTP semantics — RESTful resources, consistent status codes, idempotent attach where possible"
  - "Fail loudly with actionable errors — reject illegal turns, bad keys, and scope violations with machine-readable codes and human-readable remediation"
  - "Host-agnostic attach contract — RiffSync is first beachhead; no RiffSync-only assumptions in public API"
  - "Separation of concerns is the product — never blur match authority with identity, chat, rooms, or media"
  - "SDK–API parity — TypeScript SDK mirrors HTTP routes; no hidden server-only behavior integrators cannot reproduce"
  - "Thin slices, honest scope — ship health before auth before attach; document what is not implemented yet"
a11y_rules:
  - "API error messages must be readable without color or visual context alone (plain text, structured fields)"
  - "OpenAPI/docs examples include request and response bodies integrators can copy-paste"
  - "Status codes follow conventional meaning (401 auth, 403 scope, 409 conflict, 422 validation)"
  - "Rate-limit and quota responses include retry guidance in response body"
interaction_patterns:
  - "Attach-then-play — host attaches match, game authenticates, seats fill, turns flow through Turnur"
  - "Seat-scoped hidden views — integrators request views by seat; never leak cross-seat private state"
  - "Append-only move log — every state change is logged; integrators can replay or audit"
  - "Health-first onboarding — GET /v1/health proves connectivity before SDK key setup"
anti_patterns:
  - "Player login or session endpoints on Turnur"
  - "Chat, rooms, presence, or media APIs"
  - "RiffSync-specific routes or headers in the public contract"
  - "Silent partial failures — always return explicit error when turn is illegal or key is invalid"
  - "Duplicating host social features to 'complete' the experience"
  - "Real-time websocket gameplay sync — Turnur is turn-based authority, not realtime engine"
---
