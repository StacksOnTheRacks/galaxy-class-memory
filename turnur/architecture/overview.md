# System

Turnur is an authoritative turn-based match engine. Hosts attach a match; Turnur owns seats, turns, hidden views, the move log, and a signed result. Identity, chat, rooms, and media stay on the host. First running surface: a serverless HTTP API with `GET /v1/health`.

# Context

The `turnur` repo is greenfield (README only; no runtime or issues). Hosts (RiffSync or anything like it) remain the social and media surface. Sister product RiffSync is a watch-party host. Turnur copies RiffSync’s **control-plane patterns** (CDK TypeScript, API Gateway HTTP, Lambda, Vitest, synth-on-PR) and does not inherit Cognito, CloudFront SPA, WebSocket chat, or SFU/TURN.

# Major components

Logical sketch:

- **CDK app** (`infra/cdk`) — TypeScript AWS CDK v2; stack(s) for the control plane.
- **HTTP API** — API Gateway HTTP API, `/v1` routes.
- **Health Lambda** — Node 22 TypeScript handler for `GET /v1/health` (first slice).
- **Host** — attaches a match later; owns identity, chat, rooms, and media.
- **Match primitives (later)** — seats, turns, hidden views, move log, signed result.
- **Game auth (later)** — product intent is an SDK key; not implemented in the first slice.

# Data flow

1. Operator or CI synthesizes the CDK app (`cdk synth`).
2. Optional deploy publishes API Gateway + Lambda.
3. Client or operator calls `GET /v1/health` and receives ok.
4. Later: a host attaches a match; a game authenticates; Turnur owns match state and emits a signed result.

# Deployment shape

- **IaC:** AWS CDK TypeScript under `infra/cdk` (RiffSync layout: `bin/`, `lib/`, `lambda/`).
- **Compute:** Lambda Node 22, API Gateway HTTP API. No ECS/EC2 in the first slice.
- **CI:** PR synth + unit tests; deploy is operator/manual until a pipeline is worth it.
- **Not in v1 shape:** Cognito, CloudFront SPA, WebSocket API, SFU/TURN, SES.

# Current focus

Scaffold + health endpoint so Turnur is a running application. Auth mechanism and match store are not in this slice.
