---
doc: architecture.interfaces
schema_version: 1
updated: 2026-08-27
external_interfaces:
  - "GET /v1/health — no auth — 200 Content-Type: application/json; charset=utf-8 — body { ok: true } (stable v1; additive fields only)"
  - "GET /v1/game/me — SDK key auth (in-handler via requireGameAuth) — 200 Content-Type: application/json; charset=utf-8 — body { gameId } on valid key; 401 structured JSON from #10 on missing/invalid (#11 Ready)"
  - "@turnur/sdk — createTurnurClient({ baseUrl, apiKey }) — client.game.me() mirrors GET /v1/game/me; 401 → TurnurApiError with code/message (#12 Ready)"
internal_boundaries:
  - "GameRegistry DynamoDB — GetItem(PK=keyHash) → { gameId } — hash-only storage; stack output GameRegistryTableName for #10"
  - "Game auth middleware (requireGameAuth) — Authorization: Bearer <sdk-key> — absent header → 401 game_auth_required; empty Bearer / wrong scheme / unknown hash / malformed key → 401 game_auth_invalid — success → GameAuthContext { gameId } (#10 Ready)"
  - "MatchRegistry DynamoDB — GetItem(PK=matchId) → { gameId, status, createdAt } — metadata only; stack output MatchRegistryTableName for #20–#21"
contracts_in_flight: []
ownership: []
---

HTTP API is API Gateway HTTP API v2. GET /v1/health and GET /v1/game/me are stable v1 probes. @turnur/sdk mirrors game/me for integrators (#12 Ready). Integrator onboarding docs in infra/cdk/README.md cover health → SDK key → game/me (#13 Ready).
