---
doc: architecture.constraints
schema_version: 1
updated: 2026-09-12
hard_constraints:
  - "Mothballed — no new feature delivery unless operator unmothballs."
  - "Implementation language is TypeScript. Toolchain and Lambda runtime are Node 22."
  - "Infrastructure is AWS CDK v2 (TypeScript), in the same family as RiffSync's infra/cdk."
  - "Shipped shape: Turnur was state authority for seats, turns, hidden views, the move log. Historical only."
  - "Turnur does not own player identity. Identity, chat, rooms, and media stay on the host."
  - "Turnur is a match engine, not a social app or game catalog."
soft_constraints:
  - "Prefer RiffSync control-plane patterns for any future unmothball work."
  - "Stay host-agnostic if unmothballed."
out_of_bounds:
  - "Third-party developer platform GTM while mothballed."
  - "Integrate WebSockets (#44–#49) — abandoned."
  - "Riffle as active Turnur consumer for new work."
  - "Player login, accounts, or identity as a Turnur concern."
  - "Becoming a watch-party, lobby, chat, catalog, or identity product."
  - "Copying RiffSync's Cognito, CloudFront SPA, WebSocket chat, SFU/TURN, or SES stacks."
assumptions:
  - "Shipped code remains in repo as dormant reference."
  - "Riffle may reimplement or migrate away from Turnur without Turnur shipping."
---
