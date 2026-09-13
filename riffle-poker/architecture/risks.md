---
doc: architecture.risks
schema_version: 1
updated: 2026-09-12
structural_risks:
  - "Migration from shipped Turnur-backed runtime to Riffle-owned match store — data model and cutover TBD"
  - "Identity + anonymous session unresolved — blocks standalone and affects embed seat binding"
  - "WebSocket client locus unresolved — browser WS vs server-only affects cheat surface and latency"
coupling_hotspots:
  - "Shipped play-lab and table modules still call @turnur/sdk — must not extend while migration is open"
  - "Embed-mode may reuse or replace bootstrap/capability patterns from Turnur era — HLD decision"
migration_hazards:
  - "Turnur-backed ADRs and interfaces remain in repo until migration strategy chosen"
  - "Play-lab CI uses fake Turnur — may block or diverge during Riffle-owned match build"
watch_list:
  - "Embed link leakage (Referer, history, logs) — mitigate in embed-mode HLD"
  - "Hole-card leakage during migration — seat-scoped views must stay enforced"
  - "Anonymous session abuse (seat squatting, griefing) — security HLD"
  - "Iframe play surface at desktop and narrow embed widths"
  - "RiffSync Watch Party Game Mode must not make RiffSync match authority"
---
