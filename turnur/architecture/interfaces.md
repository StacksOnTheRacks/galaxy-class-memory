---
doc: architecture.interfaces
schema_version: 1
updated: 2026-08-27
external_interfaces:
  - "GET /v1/health — no auth — 200 Content-Type: application/json; charset=utf-8 — body { ok: true } (stable v1; additive fields only)"
  - "GET /v1/game/me — SDK key auth (in-handler via requireGameAuth) — 200 Content-Type: application/json; charset=utf-8 — body { gameId } on valid key; 401 structured JSON from #10 on missing/invalid (#11 Ready)"
  - "POST /v1/matches — SDK key auth (requireGameAuth) — 201 Content-Type: application/json; charset=utf-8 — body { matchId } on success; 401 structured JSON on auth failure (#20 Ready)"
  - "GET /v1/matches/:matchId — SDK key auth (requireGameAuth) — 200 Content-Type: application/json; charset=utf-8 — body { matchId, status, createdAt } on owned match; 404 match_not_found; 403 match_forbidden; 401 structured JSON on auth failure (#21 Ready)"
  - "@turnur/sdk — createTurnurClient({ baseUrl, apiKey }) — client.game.me() mirrors GET /v1/game/me; client.match.create() mirrors POST /v1/matches; client.match.get(matchId) mirrors GET /v1/matches/:matchId; 401/403/404 → TurnurApiError with code/message (#12 Done; match methods #22 Ready)"
internal_boundaries:
  - "GameRegistry DynamoDB — GetItem(PK=keyHash) → { gameId } — hash-only storage; stack output GameRegistryTableName for #10"
  - "Game auth middleware (requireGameAuth) — Authorization: Bearer <sdk-key> — absent header → 401 game_auth_required; empty Bearer / wrong scheme / unknown hash / malformed key → 401 game_auth_invalid — success → GameAuthContext { gameId } (#10 Ready)"
  - "MatchRegistry DynamoDB — GetItem(PK=matchId) → { gameId, status, createdAt } — metadata only; stack output MatchRegistryTableName for #20–#21"
contracts_in_flight: []
ownership: []
---

HTTP API is API Gateway HTTP API v2. GET /v1/health and GET /v1/game/me are stable v1 probes. POST /v1/matches is the v1 attach route (#20 Ready); GET /v1/matches/:matchId is the v1 probe route (#21 Ready). @turnur/sdk mirrors game/me and match attach/probe for integrators (#12 Done; match methods #22 Ready). Integrator onboarding docs in infra/cdk/README.md cover health → SDK key → game/me (#13 Ready).
