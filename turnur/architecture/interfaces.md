---
doc: architecture.interfaces
schema_version: 1
updated: 2026-08-25
external_interfaces:
  - "GET /v1/health — no auth — 200 Content-Type: application/json; charset=utf-8 — body { ok: true } (stable v1; additive fields only). Only GET registered on the HTTP API for this route."
internal_boundaries:
  - "GameRegistry DynamoDB — GetItem(PK=keyHash) → { gameId } — hash-only storage; stack output GameRegistryTableName for #10"
contracts_in_flight:
  - "GET /v1/game/me — SDK key auth — 200 with game identity on valid key; 401 on missing/invalid (#11). Depends on #9 registry + #10 validation."
  - "SDK key header contract — Authorization: Bearer <key> locked at #10 refinement"
ownership: []
---

HTTP API is API Gateway HTTP API v2. GET /v1/health is stable v1. Game routes land with the auth milestone (#9–#13).
