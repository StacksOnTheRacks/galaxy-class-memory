---
doc: architecture.constraints
schema_version: 1
updated: 2026-09-25
hard_constraints:
  - "Forward hosting is serverless only: API Gateway WebSocket + Lambda + DynamoDB + S3/CloudFront via CDK/GHA OIDC"
  - "Actions over WebSocket; Lambda is authoritative for rules and persistence"
  - "Seat-scoped snapshots; hole cards never broadcast to other seats"
  - "Gameplay and rules live in Riffle Poker. Riffle evaluates poker legality in-process in Lambda."
  - "Play chips only — no real-money wagering, cashier, or KYC"
  - "Riffle is a poker game, not a watch-party, chat, catalog, or media product"
  - "No live mic/camera on the play surface; tiles are avatar or initials"
  - "No RiffSync, embed, or Turnur dependency for new work"
  - "Turnur is mothballed — no new @turnur/sdk consumption"
soft_constraints:
  - "Prefer TypeScript when a stack is chosen"
  - "Prefer one Lambda for WS connect/disconnect/default"
  - "Dashboard UI must compose at desktop, tablet, and phone breakpoints"
  - "Shipped Turnur/MatchStore paths are frozen — do not extend for new work"
out_of_bounds:
  - "Always-on game servers, ElastiCache/Redis as required path"
  - "Embed/RiffSync as product requirement in current initiative"
  - "Turnur as match backend or developer platform GTM"
  - "Rooms, presence, chat, or a media/SFU plane of Riffle's own"
  - "Real-money wagering, cashier, or KYC systems"
  - "Live audio/video on player tiles"
assumptions:
  - "Operator locked cheap interactive serverless path 2026-09-25"
  - "Shipped Turnur-backed and MatchStore HTTP code is historical proof, not forward architecture"
  - "Embed and RiffSync attach are later, not blocked on dashboard-holdem"
---
