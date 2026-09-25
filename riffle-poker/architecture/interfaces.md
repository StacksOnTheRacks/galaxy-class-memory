---
doc: architecture.interfaces
schema_version: 1
updated: 2026-09-25
external_interfaces:
  - "Current (dashboard-holdem) — Browser ↔ CloudFront/S3 SPA; Browser ↔ API Gateway WebSocket (join_table, sit/leave, start_hand, action, snapshot); GitHub Actions OIDC → AWS CDK deploy"
  - "Frozen (historical) — Host → Riffle runtime POST /v1/matches, bootstrap, capability, hands/* with Bearer RIFFLE_HOST_API_KEY; GET /v1/ws notify-only; iframe embed; @turnur/sdk. Do not extend for new work."
internal_boundaries:
  - "Play surface UI is presentation; Lambda is the trust boundary for rules and match writes"
  - "Rules library is in-process inside Lambda; no I/O from the library itself"
  - "Hole cards live in seat-scoped storage and snapshots; public board is shared table state"
  - "Static SPA and browser are untrusted; seat token + Lambda authorization is the trust boundary"
contracts_in_flight:
  - "dashboard-holdem — table-discovery, disconnect-policy (non-blocking)"
ownership:
  - "Riffle owns SPA, WS API, Lambda rules/state, DynamoDB for forward work"
  - "Turnur mothballed — no new ownership on Turnur side"
  - "Embed/RiffSync host ownership is historical / later — not forward path"
---
