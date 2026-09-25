---
doc: architecture.risks
schema_version: 1
updated: 2026-09-25
structural_risks:
  - "Lambda cold start vs as interactive as possible"
  - "Fan-out cost/latency on larger tables (PostToConnection per connection)"
  - "DynamoDB conditional-write races under burst actions on same hand"
coupling_hotspots:
  - "SPA tightly coupled to WS message contract (join_table, action, snapshot)"
  - "Connection registry must stay consistent on disconnect for fan-out"
  - "Shipped MatchStore/Turnur modules remain in repo — must not extend while building serverless path"
migration_hazards:
  - "Freeze+replace vs leftover Turnur/embed/MatchStore-HTTP paths; do not extend historical contracts"
  - "Prior embed/RiffSync expectations (Watch Party Game Mode) deferred until embed initiative returns"
watch_list:
  - "Hole-card leakage via wrong PostToConnection payload or DynamoDB over-read"
  - "Connection hijack / missing seat-token auth on join and action"
  - "GitHub OIDC deploy role blast radius"
  - "Seat-token theft via XSS on static origin"
  - "Snapshot payload size as My Hand adds strength/outs"
  - "Abandoning embed breaks RiffSync Game Mode until a later embed initiative ships"
---
