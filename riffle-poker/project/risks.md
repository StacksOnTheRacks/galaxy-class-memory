---
doc: project.risks
schema_version: 1
updated: 2026-09-12
risks:
  - "Migrating shipped Turnur-backed runtime to Riffle-owned match state — scope and sequencing TBD in standalone-play-and-embed HLD"
  - "Identity + anonymous session design unresolved — blocks standalone slice"
  - "Embed-mode link shape unresolved — blocks RiffSync Watch Party Game Mode attach"
  - "WebSocket client locus (browser vs server) unresolved — affects latency and security model"
issues: []
dependencies:
  - "Play lab #19–#24 shipped (Turnur-backed historical) — migration strategy open"
  - "RiffSync Watch Party Game Mode depends on Riffle embed-mode, not Turnur"
  - "Artwork / Web Site before public standalone launch if visual identity matters"
assumptions:
  - "Operator locked Turnur mothball; Riffle owns match + WS for all new work"
  - "Do not groom integrate-turnur-websockets — superseded"
---

See `architecture/risks.md` for structural watch list.
