---
doc: project.plan
schema_version: 1
updated: 2026-09-24
objective: "Operator pivot: Turnur mothballed. Riffle owns match state and WebSockets. Now: standalone-play-and-embed remaining #44 In Refinement (milestone/4; #36–#43 closed). Next: Artwork (lld, not executing; milestone/5 + #53–#58). Shipped: playable-holdem-table #1–#9, play-lab #19–#24 (Turnur-backed; historical)."
in_scope:
  - "Shipped — playable-holdem-table #1–#9 Done (milestone/1 closed; Turnur-backed historical)"
  - "Shipped — play lab #19–#24 Done (milestone/2 closed; Turnur-backed historical)"
  - "Abandoned — integrate-turnur-websockets #31–#35 closed not planned (milestone/3 closed)"
  - "Now — standalone-play-and-embed remaining #44 In Refinement (milestone/4; #36–#43 closed)"
  - "Next — Artwork (lld, not executing; milestone/5 + #53–#58); Web Site; Complete NLHE Hand; Multi-Hand Session"
sequence:
  - "playable-holdem-table #1–#9 Done — iframe bootstrap, capability, seats, rules, holes, betting, board, hand-complete (Turnur-backed)"
  - "Play lab #19–#24 Done — match.create, capability postMessage, lab orchestrators, two-iframe page, live two-seat hand (Turnur-backed)"
  - "integrate-turnur-websockets #31–#35 abandoned — Turnur mothballed"
  - "Now — standalone-play-and-embed #44 In Refinement (#36–#43 closed: identity → MatchStore → shared URL → sit → display name → WS → actions → hole/board)"
  - "Next — Artwork after #44: figma-source-components → asset-pipeline-mapper → (play-surface-card-faces ∥ chip-art-pot-stacks ∥ felt-table-chrome); canva-kit parallel after figma-source; then Web Site; Complete NLHE Hand; Multi-Hand Session"
dependencies:
  - "Turnur is mothballed — no new Turnur shipping dependency"
  - "RiffSync Watch Party Game Mode depends on Riffle embed-mode, not Turnur"
  - "play-lab-fate and runtime-hosting remain non-blocking open questions"
  - "Artwork execution waits on #44 (shared play-surface files; Now/Next lock) — grooming tickets now is OK"
handoffs:
  - "Product → /forge.plan-refresh then /forge.refinement (Now: #44; Artwork slugs stay Next)"
---

Board/SCM wins. Milestone/4 open: #36–#43 closed, #44 In Refinement. Milestone/5 Artwork: #53–#58 In Refinement.
