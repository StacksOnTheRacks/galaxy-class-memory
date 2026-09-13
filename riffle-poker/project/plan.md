---
doc: project.plan
schema_version: 1
updated: 2026-09-12
objective: "Operator pivot: Turnur mothballed. Riffle owns match state and WebSockets. Now: standalone-play-and-embed HLD. Shipped: playable-holdem-table #1–#9, play-lab #19–#24 (Turnur-backed; historical)."
in_scope:
  - "Shipped — playable-holdem-table #1–#9 Done (milestone/1 closed; Turnur-backed historical)"
  - "Shipped — play lab #19–#24 Done (milestone/2 closed; Turnur-backed historical)"
  - "Abandoned — integrate-turnur-websockets #31–#35 closed not planned (milestone/3 closed)"
  - "Now — standalone-play-and-embed HLD (no board tickets yet)"
  - "Next — Artwork (lld, ungroomed); Web Site; Complete NLHE Hand; Multi-Hand Session"
sequence:
  - "playable-holdem-table #1–#9 Done — iframe bootstrap, capability, seats, rules, holes, betting, board, hand-complete (Turnur-backed)"
  - "Play lab #19–#24 Done — match.create, capability postMessage, lab orchestrators, two-iframe page, live two-seat hand (Turnur-backed)"
  - "integrate-turnur-websockets #31–#35 abandoned — Turnur mothballed"
  - "Now — /forge.initiative-design on standalone-play-and-embed"
  - "Next — Artwork grooming; Web Site intake; Complete NLHE Hand; Multi-Hand Session"
dependencies:
  - "Turnur is mothballed — no new Turnur shipping dependency"
  - "Standalone-play-and-embed HLD must resolve identity, anonymous session, embed link, and WS client locus before LLD"
  - "RiffSync Watch Party Game Mode depends on Riffle embed-mode, not Turnur"
handoffs:
  - "Product → /forge.initiative-design on standalone-play-and-embed"
  - "Product → /forge.backlog-grooming for artwork when HLD allows parallel work"
---

Board/SCM wins. Milestone/3 closed with #31–#35 not planned.
