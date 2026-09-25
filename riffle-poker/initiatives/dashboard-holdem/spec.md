---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-25
summary: "Interactive play-chip no-limit Hold'em as a cheap serverless product. Static frontend (S3 + CloudFront) talks to an Amazon API Gateway WebSocket API. One Lambda applies in-process NLHE, persists table/hand/seat/connection state in DynamoDB, and fans out seat-scoped snapshots via the API Gateway management API. Hole cards never leave the owning seat's snapshot. No RiffSync, embed, Turnur, live A/V, always-on server, ElastiCache, or cashier."
approach: "Prefer the cheapest shape that stays interactive: single Lambda on $connect / $disconnect / $default — one cold-start pool, one deploy unit. Rules stay in-process inside that Lambda. DynamoDB is the only durable store (table, seats, hand, connection→table index). Client sends actions over the WebSocket; Lambda validates turn + legality, conditional-writes DynamoDB, then PostToConnection seat-scoped snapshots to each open connection on that table. Static SPA on S3 behind CloudFront in the same CDK app. Infra = AWS CDK; CI on GitHub Actions with OIDC→AWS, synth, deploy."
interfaces:
  - "Browser → CloudFront/S3 — static SPA (table UI, sit, actions, avatars/initials)"
  - "Browser → API Gateway WebSocket — connect; join_table; sit/leave; start_hand; action (fold|check|call|bet|raise)"
  - "API Gateway → Lambda — $connect, $disconnect, $default (single function)"
  - "Lambda → DynamoDB — conditional writes for table/seat/hand; connection registry"
  - "Lambda → API Gateway Management API — PostToConnection seat-scoped snapshot; never put another seat's holes on a foreign connection"
  - "GitHub Actions → AWS (OIDC) — cdk synth + deploy; no long-lived AWS keys in repo"
structure:
  - "Static play SPA — S3 + CloudFront"
  - "NLHE rules — in-process library inside Lambda; no I/O from the library"
  - "Realtime handler — one Lambda: auth/session bind on connect, apply moves, persist, fan-out"
  - "DynamoDB — table, seat, hand, connection entities (single-table OK; LLD keys)"
  - "CDK stack — WS API, Lambda, DynamoDB, S3, CloudFront, IAM for management API"
  - "Out of this HLD — RiffSync, iframe embed, Turnur, SFU/A/V, cashier, always-on Node, ElastiCache"
constraints:
  - "Interactive + cheapest hosting: serverless WS path only; no always-on compute; no ElastiCache"
  - "Actions over WebSocket; Lambda is trust boundary for rules and persistence"
  - "Seat-scoped snapshots; hole cards never broadcast to other seats"
  - "Play chips only; no cashier, rake, KYC, real money"
  - "No RiffSync, embed, Turnur, live audio/video; tiles = avatar or initials"
  - "CDK + GHA OIDC deploy; no account ids or secret values in memory"
  - "Prefer one Lambda unless a split clearly lowers cost (it does not for this shape)"
  - "NLHE only this HLD; no tournaments/SNG/matchmaking lobby as product surface beyond create/join table"
open_questions:
  - table-discovery
  - disconnect-policy
---

HTTP REST for gameplay is not required this HLD. Optional health/static only via CloudFront.

**Data (conceptual):** Table (tableId, blinds, status, street, board, pot(s), currentSeat, turnVersion); Seat (occupant, displayName, avatar/initials, stack, bet, folded/all-in, hole cards seat-scoped); Hand (handId, street, board, pot, move log); Connection (connectionId → tableId, seatId, subject).

Success bar: seated players complete NLHE hands including all-in settlement with correct stacks on the dashboard UI.
