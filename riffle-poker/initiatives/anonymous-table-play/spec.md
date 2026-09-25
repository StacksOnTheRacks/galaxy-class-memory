---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-25
summary: "Anonymous play-chip NLHE on the default CloudFront hostname: one seeded DynamoDB table (unguessable UUID), SPA at https://<distribution>.cloudfront.net/<table-guid>, browser joins that table over the existing API Gateway WebSocket + Lambda runtime, sits with a display name (seat label), and plays via the dashboard-holdem client/runtime. No lobby, no auth, no create-table UI, no Turnur/embed/RiffSync, no custom domain."
approach: "Extend MatchRuntimeStack in the existing CDK app (same stack, not a sibling): WS API + Lambda + DynamoDB already live there; adding S3 + CloudFront keeps one deploy unit, one OIDC role surface, and colocated outputs (WebSocketUrl, distribution domain, SeededTableId / PlayUrl) without cross-stack exports. Default CloudFront hostname only. Origin = private S3 bucket (OAC). SPA deep-link fallback via CloudFront custom error responses: map origin 403 and 404 to /index.html with HTTP 200 so /<guid> serves the SPA (no CloudFront Function). Build the dashboard play SPA and deploy it as the bucket artifact (e.g. BucketDeployment). Inject the public WebSocket URL via a non-secret runtime config object written at deploy (e.g. /config.json beside the SPA with webSocketUrl from the stage URL) — never bake AWS credentials. Seed exactly one table record with an unguessable UUID via an idempotent deploy-time write (CDK custom resource / equivalent): mint on first deploy, do not remint on stack update; export SeededTableId (and optionally PlayUrl = https://{distributionDomain}/{tableId}) as stack outputs for the operator. Public play path must not call create_table; the deployed Lambda $default handler rejects create_table (e.g. unsupported_action) so a WS client cannot mint extra tables; unit/integration tests seed via MatchStore helpers (or assert the reject path) while historical create_table coverage moves off the public WS action. Browser reads location.pathname as a single segment = table GUID, loads config, opens WS, join_table, then sit with displayName + seatId 1–8 using existing sit/seat-token contracts; unknown id → table_not_found UI; no table listing. Do not extend src/server Hono/Turnur/MatchStore. Gameplay rules, seat-scoped snapshots, and dashboard composition stay owned by dashboard-holdem — this initiative only wires hosting, route, seed, and anonymous join/sit entry. OIDC: extend the existing production deploy role for S3/CloudFront on this stack; no long-lived keys; no account ids or secret values in memory."
interfaces:
  - "Browser → CloudFront/S3 — static dashboard play SPA; GET /<table-guid> (SPA); GET /config.json (public webSocketUrl)"
  - "Browser → API Gateway WebSocket — connect; join_table; sit/leave; start_hand; action (fold|check|call|bet|raise); never create_table on public path"
  - "API Gateway → Lambda — $connect, $disconnect, $default (existing MatchRuntimeHandler; create_table rejected)"
  - "Lambda → DynamoDB — existing table/seat/hand/connection; one seeded TABLE item"
  - "Lambda → API Gateway Management API — PostToConnection seat-scoped snapshots (dashboard-holdem)"
  - "CDK / deploy → DynamoDB — idempotent seed of exactly one tableId (unguessable UUID)"
  - "GitHub Actions → AWS (OIDC) — cdk synth + deploy MatchRuntimeStack including S3/CloudFront; no long-lived AWS keys"
structure:
  - "MatchRuntimeStack (+S3 bucket, CloudFront distribution, OAC, SPA deploy, seed custom resource, outputs)"
  - "Dashboard play SPA artifact — CloudFront origin; pathname = table GUID"
  - "Public runtime config — non-secret webSocketUrl at origin"
  - "Existing WS Lambda + DynamoDB — join/sit/play; create_table disabled at handler boundary"
  - "Out of this HLD — NLHE rules redesign, lobby/discovery, auth/Cognito, custom DNS, Turnur/embed/RiffSync, felt artwork, real money, src/server Hono"
constraints:
  - "Exactly one seeded table; play surface must not create more tables; deployed Lambda rejects create_table"
  - "URL shape locked: https://<distribution>.cloudfront.net/<table-guid>; no custom domain; no /play/ prefix for the forward path"
  - "No lobby, no table listing, no auth/Cognito/onramp, no Turnur/embed/RiffSync"
  - "Display name is a seat label, not an account; sit still requires seatId 1–8 + seat token (existing runtime)"
  - "Reuse dashboard-holdem for NLHE, seat-scoped snapshots, and dashboard UI composition — do not re-specify rules here"
  - "Do not extend src/server Hono / Turnur / historical MatchStore HTTP"
  - "CDK + GHA OIDC; extend existing deploy role for S3/CloudFront; no account ids or secrets in memory"
  - "Play chips only; interactive serverless path only"
open_questions: []
---

HTTP REST for gameplay is not required. CloudFront serves static assets and SPA fallback only.

**Client route:** Replace historical `/play/<matchId>` (`PLAY_PATH_RE`) for this product surface with a single path segment = table GUID. Load `config.json`, connect WS, `join_table` with that id, then sit. Unknown GUID → `table_not_found` (or equivalent UI); never list other tables.

**Ownership boundary:** dashboard-holdem owns rules, seat-scoped snapshots, and dashboard composition. This initiative owns S3/CloudFront hosting, GUID path, one-table seed, anonymous join/sit entry, and public `create_table` rejection.

**Success bar:** Operator forms the CloudFront URL from stack outputs; a player opens it, joins the seeded table, sits with a display name, and completes play-chip NLHE hands on the dashboard UI with no account and no second table creatable from the public WS.
