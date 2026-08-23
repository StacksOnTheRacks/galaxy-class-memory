---
doc: architecture.interfaces
schema_version: 1
updated: 2026-08-23
external_interfaces:
  - "GET /v1/health — no auth — 200 Content-Type: application/json; charset=utf-8 — body { ok: true } (stable v1; additive fields only). Only GET registered on the HTTP API for this route."
internal_boundaries: []
contracts_in_flight: []
ownership: []
---

HTTP API is API Gateway HTTP API v2. Additional routes land with #2–#3.
