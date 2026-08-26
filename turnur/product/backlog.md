---
doc: product.backlog
schema_version: 1
updated: 2026-08-25
in_progress: []
ready:
  - "[#9 Add game registry and SDK key storage to TurnurApi stack](https://github.com/StacksOnTheRacks/turnur/issues/9) (ai-ready)"
refinement:
  - "[#10 Validate game SDK keys on protected HTTP API routes](https://github.com/StacksOnTheRacks/turnur/issues/10)"
  - "[#11 Add GET /v1/game/me authenticated probe route](https://github.com/StacksOnTheRacks/turnur/issues/11)"
  - "[#12 Add TypeScript SDK client with API key configuration](https://github.com/StacksOnTheRacks/turnur/issues/12)"
  - "[#13 Document game authentication onboarding for integrators](https://github.com/StacksOnTheRacks/turnur/issues/13)"
blocked: []
icebox:
  - "Host attaches a match; identity, chat, rooms, and media stay on the host"
  - "Seats are created and owned by Turnur (who sits where)"
  - "Turn order is authoritative (whose turn; illegal-turn rejected)"
  - "Hidden views are seat-scoped (private information does not leak)"
  - "Move log is complete and append-only for the match"
  - "Match ends with a signed result (capability; not a first-goal)"
---

Board/SCM wins — reconcile against GitHub project board on grooming. #1–#4 Done (PRs #5–#8). #9 Ready (ai-ready); #10–#13 Refinement on game auth milestone. Host attach + match primitives remain icebox.
