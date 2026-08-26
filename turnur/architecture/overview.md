---
doc: architecture.overview
schema_version: 1
updated: 2026-08-25
system: "Turnur is an authoritative turn-based match engine. Hosts attach a match; Turnur owns seats, turns, hidden views, the move log, and a signed result. Identity, chat, rooms, and media stay on the host. First running surface: a serverless HTTP API with GET /v1/health."
context: "The turnur repo is greenfield. Hosts (RiffSync or anything like it) remain the social and media surface. Sister product RiffSync is a watch-party host. Turnur copies RiffSync's control-plane patterns (CDK TypeScript, API Gateway HTTP, Lambda, Vitest, synth-on-PR) and does not inherit Cognito, CloudFront SPA, WebSocket chat, or SFU/TURN."
data_flow: "1. CI runs synth + Vitest on PR/push for infra/cdk/**. 2. Operator deploys TurnurApiStack (API Gateway HTTP + health Lambda). 3. GET /v1/health returns { ok: true }. 4. Next: game registry + SDK key auth (#9–#13). 5. Later: host attaches match; Turnur owns match state and emits a signed result."
deployment_shape: "IaC: AWS CDK TypeScript under infra/cdk (RiffSync layout: bin/, lib/, lambda/). Compute: Lambda Node 22, API Gateway HTTP API. No ECS/EC2. CI: GitHub Actions — npm ci, build, test, synth on PR/push (infra/cdk/**). Deploy: operator/manual. Not in v1 shape: Cognito, CloudFront SPA, WebSocket API, SFU/TURN, SES."
current_focus: "Control plane baseline shipped (#1–#4 Done, PRs #5–#8). #9 Ready (ai-ready): DynamoDB game registry. #10–#13 Refinement: validation, probe route, SDK, docs."
major_components:
  - "CDK app (infra/cdk) — TypeScript AWS CDK v2; TurnurApiStack (shipped)"
  - "HTTP API — API Gateway HTTP API, /v1 routes (health shipped)"
  - "Health Lambda — Node 22 TypeScript handler for GET /v1/health (shipped)"
  - "CI — GitHub Actions synth + Vitest on PRs (shipped)"
  - "Game registry (#9 Ready) — DynamoDB key-hash lookup; ADR-002 locked"
  - "Game auth middleware (in flight #10–#11) — SDK key validation; GET /v1/game/me probe"
  - "TypeScript SDK (in flight #12) — packages/turnur-sdk/"
  - "Host — attaches a match later; owns identity, chat, rooms, and media"
  - "Match primitives (later) — seats, turns, hidden views, move log, signed result"
---

See `architecture/interfaces.md` for the health route contract.
