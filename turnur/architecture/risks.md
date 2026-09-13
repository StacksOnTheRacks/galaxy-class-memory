---
doc: architecture.risks
schema_version: 1
updated: 2026-09-12
structural_risks:
  - "Auth enforcement coupling: where SDK key validation lives (authorizer vs handler vs shared middleware) affects every protected route and #12 SDK assumptions."
  - "Key storage model: hash algorithm, lookup pattern, and dev/test credential strategy must stay consistent across #9–#11."
coupling_hotspots:
  - "TurnurApiStack will accumulate game registry + auth + route wiring; keep boundaries clear between storage (#9), validation (#10), and routes (#11)."
  - "Mutation HTTP handlers + publish-match-event + ConnectionRegistry GSI — successful write must return HTTP 201/200 even if PostToConnection fails."
migration_hazards: []
watch_list:
  - "integrate-websockets HLD — notify-only WebSocket examine; do not lock transport as ADR (ws-adr-lock deferred)"
  - "Separate PUT for hidden views vs accepted move (stale read) — Authoritative writes is the Next slice"
  - "Signed-result verification mechanism still undecided"
---
