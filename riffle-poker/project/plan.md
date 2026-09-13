---
doc: project.plan
schema_version: 1
updated: 2026-09-13
objective: "Operator pivot: Turnur mothballed. Riffle owns match state and WebSockets. Now: standalone-play-and-embed Refinement tickets (#36–#44). Shipped: playable-holdem-table #1–#9, play-lab #19–#24 (Turnur-backed; historical)."
in_scope:
  - "Shipped — playable-holdem-table #1–#9 Done (milestone/1 closed; Turnur-backed historical)"
  - "Shipped — play lab #19–#24 Done (milestone/2 closed; Turnur-backed historical)"
  - "Abandoned — integrate-turnur-websockets #31–#35 closed not planned (milestone/3 closed)"
  - "Now — standalone-play-and-embed LLD (milestone/4; #36–#44 on Refinement)"
  - "Next — Artwork (lld, ungroomed); Web Site; Complete NLHE Hand; Multi-Hand Session"
sequence:
  - "playable-holdem-table #1–#9 Done — iframe bootstrap, capability, seats, rules, holes, betting, board, hand-complete (Turnur-backed)"
  - "Play lab #19–#24 Done — match.create, capability postMessage, lab orchestrators, two-iframe page, live two-seat hand (Turnur-backed)"
  - "integrate-turnur-websockets #31–#35 abandoned — Turnur mothballed"
  - "Now — standalone-play-and-embed #36–#44 on Refinement (identity → MatchStore → shared URL → sit → display name → WS → actions → hole/board → hand complete)"
  - "Next — /forge.plan-refresh then /forge.refinement on standalone-play-and-embed; Artwork grooming; Web Site intake; Complete NLHE Hand; Multi-Hand Session"
dependencies:
  - "Turnur is mothballed — no new Turnur shipping dependency"
  - "RiffSync Watch Party Game Mode depends on Riffle embed-mode, not Turnur"
  - "play-lab-fate and runtime-hosting remain non-blocking open questions"
handoffs:
  - "Product → /forge.plan-refresh then /forge.refinement on standalone-play-and-embed"
  - "Product → /forge.backlog-grooming for artwork when operator wants that Next item"
---

Board/SCM wins. Milestone/4 open with #36–#44 on Refinement.
