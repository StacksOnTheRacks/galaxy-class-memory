---
doc: product.backlog
schema_version: 1
updated: 2026-08-27
in_progress: []
ready:
  - "[#19 Add Match registry storage to TurnurApi stack](https://github.com/StacksOnTheRacks/turnur/issues/19)"
refinement:
  - "[#20 Add POST /v1/matches attach route](https://github.com/StacksOnTheRacks/turnur/issues/20)"
  - "[#21 Add GET /v1/matches/:matchId probe route](https://github.com/StacksOnTheRacks/turnur/issues/21)"
  - "[#22 Add TypeScript SDK match attach and get methods](https://github.com/StacksOnTheRacks/turnur/issues/22)"
  - "[#23 Document host attach onboarding for integrators](https://github.com/StacksOnTheRacks/turnur/issues/23)"
blocked: []
icebox:
  - "Seats are created and owned by Turnur (who sits where)"
  - "Turn order is authoritative (whose turn; illegal-turn rejected)"
  - "Hidden views are seat-scoped (private information does not leak)"
  - "Move log is complete and append-only for the match"
  - "Match ends with a signed result (capability; not a first-goal)"
---

Board/SCM wins — #1–#13 Done (PRs #5–#18). #19 Ready (ai-ready); host attach [#20–#23](https://github.com/StacksOnTheRacks/turnur/milestone/2) remain in Refinement on [Host attach a match](https://github.com/StacksOnTheRacks/turnur/milestone/2). Match primitives + signed result remain icebox.
