---
doc: project.plan
schema_version: 1
updated: 2026-08-27
objective: "Groom and ship host attach + match-state primitives on the running control plane with game authentication live."
in_scope:
  - "Shipped: control plane #1–#4 (PRs #5–#8); game auth #9–#13 (PRs #14–#18) — registry, validation, GET /v1/game/me, TypeScript SDK, integrator docs"
  - "Next — host attach a match; identity, chat, rooms, and media stay on the host"
  - "Then — match-state primitives: seats, turns, hidden views, move log"
  - "Later — signed result capability"
  - "Out of scope: player/host auth, epic/umbrella issues, identity/chat/rooms/media on Turnur"
sequence:
  - "Control plane #1–#4 — Done (PRs #5–#8)"
  - "Game authentication #9–#13 — Done (PRs #14–#18)"
  - "Grooming — host attach a match (icebox → board)"
  - "Grooming — match primitives after host attach slice is ticketed"
  - "Implement — host attach then primitives as tickets reach Ready + ai-ready"
  - "Signed result — later capability"
dependencies:
  - "Board: zero open issues; #1–#13 Done; game auth milestone all issues closed (milestone still open on GitHub)"
  - "Host attach blocks match primitives; game auth no longer blocks delivery"
  - "ADR-001 locked (control plane); ADR-002 locked (game registry / key storage)"
  - "Architect + Security tech spec (ai-ready) required before /forge.implement-ticket on new tickets"
  - "Identity, chat, rooms, and media stay on the host"
handoffs:
  - "Product → /forge.backlog-grooming on host attach + match primitives (icebox)"
  - "Engineering → idle until new Ready + ai-ready tickets exist"
  - "Project → optionally close milestone Game authentication (SDK key) on GitHub"
---

Board/SCM wins. Game auth shipped; delivery capacity on grooming the next slice before implement resumes.
