---
doc: architecture.overview
schema_version: 1
updated: 2026-09-12
system: "Turnur is an authoritative turn-based match engine (mothballed). Shipped: serverless HTTP API with game SDK-key auth and match authority primitives. Operator mothballed Turnur 2026-09-12 — no new delivery. Riffle Poker owns match state for new work."
context: "Shipped baseline: CDK TypeScript, API Gateway HTTP, Lambda Node 22, DynamoDB game registry and match tables, @turnur/sdk HTTP client. integrate-websockets abandoned. Repo is dormant reference code."
data_flow: "Historical shipped path: game authenticates with SDK key → HTTP match CRUD (seats, turns, views, moves). No active consumer for new Riffle work."
deployment_shape: "IaC: AWS CDK TypeScript under infra/cdk. Compute: Lambda Node 22, API Gateway HTTP API. No WebSocket API shipped. Deploy: operator/manual if ever needed."
current_focus: "Mothballed. Shipped shape preserved in repo. No integrate-websockets delivery."
major_components:
  - "CDK app (infra/cdk) — TurnurApiStack (shipped)"
  - "HTTP API — API Gateway HTTP API, /v1 routes (shipped)"
  - "Game registry — DynamoDB SDK-key lookup (shipped)"
  - "Match primitives — seats, turns, hidden views, move log (shipped)"
  - "TypeScript SDK — @turnur/sdk HTTP client (shipped)"
  - "integrate-websockets — abandoned (#44–#49 not planned)"
---

See `architecture/interfaces.md` for shipped route contracts.
