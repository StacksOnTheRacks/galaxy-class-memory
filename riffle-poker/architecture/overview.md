---
doc: architecture.overview
schema_version: 1
updated: 2026-09-25
system: "Riffle Poker is a standalone play-chip no-limit Hold'em app with a dashboard play UI. Riffle owns rules, table state, and realtime over API Gateway WebSocket. Forward path: static SPA (S3/CloudFront) + Lambda + DynamoDB. No embed/RiffSync/Turnur/live A/V in the forward path."
context: "Operator lock 2026-09-25: cheap serverless stack (dashboard-holdem). Prior Turnur-backed, embed-first, and notify-only WS paths are historical / superseded for new work."
data_flow: "1. Browser loads SPA from CloudFront/S3. 2. Client opens WebSocket; joins table; sits with display name + seat token. 3. Actions over WS → Lambda applies NLHE → DynamoDB → seat-scoped PostToConnection snapshots. 4. Hole cards only in owning seat snapshot."
deployment_shape: "CDK: API Gateway WebSocket + Lambda + DynamoDB + S3/CloudFront. Deploy from GitHub Actions via OIDC. No always-on server; no ElastiCache."
current_focus: "dashboard-holdem LLD — #59–#67 In Refinement. /forge.refinement next."
major_components:
  - "Static play SPA — S3 + CloudFront"
  - "WebSocket API — API Gateway"
  - "NLHE Lambda — in-process rules, match writes, fan-out"
  - "DynamoDB — table/seat/hand/connection store"
  - "CDK + GitHub Actions — infra deploy"
  - "Poker rules — in-process NLHE library inside Lambda"
---
