---
doc: product.backlog
schema_version: 1
updated: 2026-09-12
in_progress: []
ready: []
refinement:
  - "[#31 Add TURNUR_WS_URL env gate and Turnur WS client factory](https://github.com/StacksOnTheRacks/riffle-poker/issues/31)"
  - "[#32 Add match subscription registry and waitForMatchEvent](https://github.com/StacksOnTheRacks/riffle-poker/issues/32)"
  - "[#33 Wire play-lab session to subscribe server-side on match attach](https://github.com/StacksOnTheRacks/riffle-poker/issues/33)"
  - "[#34 Refactor submit and advance post-mutation polls to WS notify](https://github.com/StacksOnTheRacks/riffle-poker/issues/34)"
  - "[#35 Refactor remaining orchestration poll sites and verify poll reduction](https://github.com/StacksOnTheRacks/riffle-poker/issues/35)"
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
  - "[#19 Host-facing POST /v1/matches wraps Turnur match.create](https://github.com/StacksOnTheRacks/riffle-poker/issues/19)"
  - "[#20 Play iframe accepts host seat capability via postMessage](https://github.com/StacksOnTheRacks/riffle-poker/issues/20)"
  - "[#21 Lab session orchestrator mints match, seats, bootstrap, and capabilities](https://github.com/StacksOnTheRacks/riffle-poker/issues/21)"
  - "[#22 Lab deal orchestrator deals and opens betting for two seats](https://github.com/StacksOnTheRacks/riffle-poker/issues/22)"
  - "[#23 First-party play lab page with two embedded /play iframes](https://github.com/StacksOnTheRacks/riffle-poker/issues/23)"
  - "[#24 Two lab seats complete a hand against live Turnur](https://github.com/StacksOnTheRacks/riffle-poker/issues/24)"
icebox:
  - "Artwork (Figma + Canva) (lld; /forge.backlog-grooming before tickets)"
  - "Web Site (Next; /forge.new-initiative before tickets)"
  - "Complete NLHE Hand (full rules) — side pots, all-in runout (Next; /forge.new-initiative before tickets)"
  - "Multi-Hand Session (Next; /forge.new-initiative before tickets)"
  - "First Host Integration (RiffSync) (Next; /forge.new-initiative before tickets)"
  - "Room-guest spectator view (public board only)"
  - "Disconnect/rejoin via the host"
  - "Additional poker variants (Omaha, Stud, mixed)"
  - "Tournaments / sit-and-go"
  - "Standalone playable client (no host)"
---

Board/SCM wins — playable-holdem-table #1–#9 and play-lab #19–#24 closed (Done). integrate-turnur-websockets #31–#35 on Refinement. Icebox is coarse outcomes only (Next/Later); do not treat these as tickets.
