---
doc: product.insights
schema_version: 1
updated: 2026-08-25
themes:
  - "Dual-sided attach: host owns social surface; game owns rules/UI; Turnur owns match authority"
  - "Game-authenticated integration — SDK key for games, not player accounts on Turnur"
  - "Host-agnostic contract with RiffSync as first concrete beachhead, not the only host"
  - "Control plane delivered — integration slices (game auth, host attach, match primitives) are ungroomed icebox candidates"
evidence:
  - "product/brief.md audience and problem statements (2026-08-24)"
  - "architecture/constraints.md — host does not become match authority; identity/chat/rooms/media stay on host"
  - "product/competitive.md — wins vs DIY backend, in-house host authority, and full-stack platforms"
  - "product/roadmap.md — next: game auth, then host attach + match primitives"
  - "GitHub turnur #1–#4 Done (PRs #5–#8, merged 2026-08-21–22); control plane delivered; no open issues or user feedback; game/host integrator slices not yet groomed"
open_questions:
  - "Host attach contract — how a host attaches a match (architecture/constraints assumption; undecided)"
  - "Signed-result verification — mechanism and who verifies (host, game, or both)"
  - "First game pack on RiffSync — which game proves the attach path end-to-end"
implications:
  - "API and docs should optimize for game-authenticated integration; player flows remain host-owned"
  - "Control-plane goals met; next product motion is grooming and shipping game authentication before host attach"
  - "Near-term design validation runs through RiffSync host integrator + one game pack developer path once auth and attach slices exist"
  - "Personas stay provisional until auth and attach slices are exercised on the first host"
---
