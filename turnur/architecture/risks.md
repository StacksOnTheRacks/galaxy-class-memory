---
doc: architecture.risks
schema_version: 1
updated: 2026-08-25
structural_risks:
  - "Auth enforcement coupling: where SDK key validation lives (authorizer vs handler vs shared middleware) affects every protected route and #12 SDK assumptions."
  - "Key storage model: hash algorithm, lookup pattern, and dev/test credential strategy must stay consistent across #9–#11."
coupling_hotspots:
  - "TurnurApiStack will accumulate game registry + auth + route wiring; keep boundaries clear between storage (#9), validation (#10), and routes (#11)."
migration_hazards: []
watch_list:
  - "ADR-002 at #9 refinement — DynamoDB registry shape and key hashing"
  - "CI path filters may need expansion when packages/turnur-sdk/ lands (#12)"
---
