---
doc: product.backlog
schema_version: 1
updated: 2026-09-04
in_progress: []
ready:
  - "[#19 Host-facing POST /v1/matches wraps Turnur match.create](https://github.com/StacksOnTheRacks/riffle-poker/issues/19)"
refinement:
  - "[#20 Play iframe accepts host seat capability via postMessage](https://github.com/StacksOnTheRacks/riffle-poker/issues/20)"
  - "[#21 Lab session orchestrator mints match, seats, bootstrap, and capabilities](https://github.com/StacksOnTheRacks/riffle-poker/issues/21)"
  - "[#22 Lab deal orchestrator deals and opens betting for two seats](https://github.com/StacksOnTheRacks/riffle-poker/issues/22)"
  - "[#23 First-party play lab page with two embedded /play iframes](https://github.com/StacksOnTheRacks/riffle-poker/issues/23)"
  - "[#24 Two lab seats complete a hand against live Turnur](https://github.com/StacksOnTheRacks/riffle-poker/issues/24)"
blocked: []
done:
  - "[#1 Host iframe attach via bootstrap mint → URL → redeem](https://github.com/StacksOnTheRacks/riffle-poker/issues/1)"
  - "[#2 Riffle runtime authenticates to Turnur with a server-side SDK key](https://github.com/StacksOnTheRacks/riffle-poker/issues/2)"
  - "[#3 Verify host-issued seat capability before seat-scoped Turnur ops](https://github.com/StacksOnTheRacks/riffle-poker/issues/3)"
  - "[#4 Create play-chip NLHE seats on the attached Turnur match](https://github.com/StacksOnTheRacks/riffle-poker/issues/4)"
  - "[#5 In-process NLHE rules library (deal, legalize, streets, showdown)](https://github.com/StacksOnTheRacks/riffle-poker/issues/5)"
  - "[#6 Deal hole cards as seat-scoped Turnur hidden views](https://github.com/StacksOnTheRacks/riffle-poker/issues/6)"
  - "[#7 Apply on-turn NLHE actions via Turnur turns and moves](https://github.com/StacksOnTheRacks/riffle-poker/issues/7)"
  - "[#8 Advance the public board through flop, turn, and river](https://github.com/StacksOnTheRacks/riffle-poker/issues/8)"
  - "[#9 Complete a hand by fold-to-one or non-all-in showdown](https://github.com/StacksOnTheRacks/riffle-poker/issues/9)"
icebox:
  - "Room-guest spectator view (public board only)"
  - "Additional poker variants (Omaha, Stud, mixed)"
  - "Tournaments / sit-and-go"
  - "Standalone playable client (no host)"
---

Board/SCM wins — playable-holdem-table #1–#9 closed (Done). Play-lab #19 Ready (`ai-ready`); #20–#24 on Refinement under [milestone/2](https://github.com/StacksOnTheRacks/riffle-poker/milestone/2). Icebox is coarse outcomes only (Next/Later); do not treat these as tickets.
