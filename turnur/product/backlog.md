---
doc: product.backlog
schema_version: 1
updated: 2026-08-23
in_progress: []
ready:
  - "[#2 Add TurnurApi stack with API Gateway HTTP API and Node 22 Lambda](https://github.com/StacksOnTheRacks/turnur/issues/2) (ai-ready)"
  - "[#3 Implement GET /v1/health handler and wire route](https://github.com/StacksOnTheRacks/turnur/issues/3) (ai-ready)"
  - "[#4 Add GitHub Actions CI for cdk synth and Vitest on PRs](https://github.com/StacksOnTheRacks/turnur/issues/4) (ai-ready)"
refinement: []
blocked: []
icebox:
  - "Game authentication: a game authenticates to Turnur with an SDK key and can talk to it as a backend state provider"
  - "Host attaches a match; identity, chat, rooms, and media stay on the host"
  - "Seats are created and owned by Turnur (who sits where)"
  - "Turn order is authoritative (whose turn; illegal-turn rejected)"
  - "Hidden views are seat-scoped (private information does not leak)"
  - "Move log is complete and append-only for the match"
  - "Match ends with a signed result (capability; not a first-goal)"
---

Board/SCM wins — reconcile against GitHub project board on grooming. #1 Done (PR #5).
