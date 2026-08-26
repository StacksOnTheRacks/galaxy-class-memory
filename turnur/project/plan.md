---
doc: project.plan
schema_version: 1
updated: 2026-08-25
objective: "Ship game authentication on the running control plane: SDK key so a game can authenticate to Turnur before host attach and match primitives."
in_scope:
  - "Now — game authentication slice: registry + key storage (#9), key validation (#10), probe route GET /v1/game/me (#11), TypeScript SDK at packages/turnur-sdk/ (#12), integrator docs (#13)"
  - "Shipped baseline preserved: TypeScript / Node 22 / AWS CDK control plane, TurnurApi stack, GET /v1/health, CI (#1–#4 Done via PRs #5–#8)"
  - "Next after auth — host attach; match-state primitives (seats, turns, hidden views, move log); signed result as later capability"
  - "Out of scope: player/host auth, epic/umbrella issues, identity/chat/rooms/media on Turnur"
sequence:
  - "Control plane #1–#4 — Done (PRs #5–#8)"
  - "#9 Ready (ai-ready) — /forge.implement-ticket next"
  - "Refinement — #10 → #11 → #12 → #13 (game authentication milestone)"
  - "Implement — #9 then same order after each ticket reaches Ready + ai-ready"
  - "Host attach a match — icebox; after game auth ships"
  - "Match primitives (seats → turns → hidden views → move log) — icebox; after host attach"
  - "Signed result — later capability"
dependencies:
  - "Board: #1–#4 Done; #9 Ready (ai-ready); #10–#13 Refinement on game auth milestone"
  - "Strict ticket order: #9 storage → #10 validation → #11 probe → #12 SDK → #13 docs"
  - "Game auth blocks host attach and all match primitives; host attach blocks match primitives"
  - "ADR-001 locked (control plane); ADR-002 locked at #9 refinement (game registry / key storage)"
  - "Architect + Security tech spec (ai-ready) required before /forge.implement-ticket on each auth ticket (#9 complete)"
  - "Identity, chat, rooms, and media stay on the host"
handoffs:
  - "Engineering → /forge.implement-ticket on #9 (Ready + ai-ready)"
  - "Product → /forge.refinement on #10–#13"
  - "Engineering → /forge.implement-ticket #10 → #13 as tickets reach Ready + ai-ready"
  - "Product → groom host attach + match primitives to Refinement after auth milestone closes"
---

Board/SCM wins on ticket status. Zero In Progress; #9 Ready; delivery capacity on implement #9 then Refinement #10–#13.
