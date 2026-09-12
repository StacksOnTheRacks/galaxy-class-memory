---
doc: project.plan
schema_version: 1
updated: 2026-09-11
objective: "Both Now slices shipped (playable-holdem-table #1–#9, play lab #19–#24). Next intake starts at Artwork via /forge.new-initiative before tickets."
in_scope:
  - "Shipped — playable-holdem-table #1–#9 Done (milestone/1 closed)"
  - "Shipped — play lab #19–#24 Done (milestone/2 closed)"
  - "Next — Artwork (Figma + Canva); Web Site; Complete NLHE Hand (full rules); Multi-Hand Session; First Host Integration (RiffSync). Coarse outcomes — /forge.new-initiative before tickets"
sequence:
  - "playable-holdem-table #1–#9 Done — iframe bootstrap, capability, seats, rules, holes, betting, board, hand-complete"
  - "Play lab #19–#24 Done — match.create, capability postMessage, lab orchestrators, two-iframe page, live two-seat hand"
  - "Next — /forge.new-initiative in locked order: Artwork → Web Site → Complete NLHE Hand → Multi-Hand Session → First Host Integration (RiffSync)"
dependencies:
  - "playable-holdem-table #1–#9 shipped — lab reused bootstrap, capability, deal, betting, and /play surfaces"
  - "Live Turnur is env-only (TURNUR_BASE_URL + TURNUR_SDK_KEY); CI stays fake Turnur"
  - "Lab browser NEVER sees RIFFLE_HOST_API_KEY or TURNUR_SDK_KEY"
  - "Complete NLHE Hand and Multi-Hand Session do not require a new Turnur milestone (rules stay in-process); Multi-Hand may want Turnur match lifecycle later"
  - "First Host Integration (RiffSync) waits on a deployed Riffle origin and sister Watch Party Game Mode"
  - "Do not invent tickets from Icebox"
handoffs:
  - "Product → /forge.new-initiative on Next queue, Artwork (Figma + Canva) first"
---

Board/SCM wins. 0 open issues. Milestone/1 and milestone/2 closed; all initiative tickets Done. PR #30 (leftover #24 docs) is out of this event. Next command: `/forge.new-initiative` (Artwork).
