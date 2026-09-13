---
doc: project.plan
schema_version: 1
updated: 2026-09-12
objective: "Shipped: playable-holdem-table #1–#9, play lab #19–#24. Active LLD: integrate-turnur-websockets #31–#35 on Refinement. Next coarse: Artwork (lld, ungroomed)."
in_scope:
  - "Shipped — playable-holdem-table #1–#9 Done (milestone/1 closed)"
  - "Shipped — play lab #19–#24 Done (milestone/2 closed)"
  - "Active — integrate-turnur-websockets #31–#35 Refinement (milestone/3); implement blocked on Turnur #44–#49"
  - "Next — Artwork (lld, ungroomed); Web Site; Complete NLHE Hand; Multi-Hand Session; First Host Integration"
sequence:
  - "playable-holdem-table #1–#9 Done — iframe bootstrap, capability, seats, rules, holes, betting, board, hand-complete"
  - "Play lab #19–#24 Done — match.create, capability postMessage, lab orchestrators, two-iframe page, live two-seat hand"
  - "integrate-turnur-websockets #31–#35 Refinement — WS client env → subscription registry → lab subscribe → submit/advance polls → remaining polls + verify"
  - "Next — /forge.backlog-grooming Artwork; then refinement on #31–#35"
dependencies:
  - "integrate-turnur-websockets implement-ticket blocked until Turnur integrate-websockets #44–#49 ships"
  - "Live Turnur WS requires TURNUR_WS_URL from Turnur stack WebSocketApiUrl output"
  - "Lab browser NEVER sees RIFFLE_HOST_API_KEY or TURNUR_SDK_KEY"
  - "CI stays fake Turnur (TURNUR_WS_URL unset)"
handoffs:
  - "Product → /forge.plan-refresh then /forge.refinement on integrate-turnur-websockets #31–#35"
---

Board/SCM wins. Milestone/3 open with #31–#35 on Refinement.
