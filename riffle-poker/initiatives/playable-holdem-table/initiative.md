---
doc: product.initiative
schema_version: 1
updated: 2026-09-03
slug: playable-holdem-table
title: "Playable no-limit Hold'em table"
status: executing
user_facing: true
signoffs:
  po: true
  architect: true
  designer: true
  security: true
board_milestone: "[Playable no-limit Hold'em table](https://github.com/StacksOnTheRacks/riffle-poker/milestone/1)"
board_tickets:
  - "[#1 Host iframe attach via bootstrap mint → URL → redeem](https://github.com/StacksOnTheRacks/riffle-poker/issues/1)"
  - "[#2 Riffle runtime authenticates to Turnur with a server-side SDK key](https://github.com/StacksOnTheRacks/riffle-poker/issues/2)"
  - "[#3 Verify host-issued seat capability before seat-scoped Turnur ops](https://github.com/StacksOnTheRacks/riffle-poker/issues/3)"
  - "[#4 Create play-chip NLHE seats on the attached Turnur match](https://github.com/StacksOnTheRacks/riffle-poker/issues/4)"
  - "[#5 In-process NLHE rules library (deal, legalize, streets, showdown)](https://github.com/StacksOnTheRacks/riffle-poker/issues/5)"
  - "[#6 Deal hole cards as seat-scoped Turnur hidden views](https://github.com/StacksOnTheRacks/riffle-poker/issues/6)"
  - "[#7 Apply on-turn NLHE actions via Turnur turns and moves](https://github.com/StacksOnTheRacks/riffle-poker/issues/7)"
  - "[#8 Advance the public board through flop, turn, and river](https://github.com/StacksOnTheRacks/riffle-poker/issues/8)"
  - "[#9 Complete a hand by fold-to-one or non-all-in showdown](https://github.com/StacksOnTheRacks/riffle-poker/issues/9)"
---

<!--
Authoring (not validated):
- status: intake | hld | lld | executing | shipped
- signoffs: true | false | "na" (designer "na" when not user-facing)
- board_tickets: issue id/title strings after LLD grooming
- Bump updated when any frontmatter field changes.
-->

First playable no-limit Hold'em table (play chips) on Turnur, attachable to a RiffSync room. Rules and seated-player table UI live in riffle-poker. The game authenticates to Turnur with an SDK key; Turnur owns seats, turns, hidden views, and the move log. Identity, chat, rooms, and media stay on the host. Hole cards stay seat-scoped via Turnur hidden views. Outcome: a seated table can complete a no-limit Hold'em hand (deal through streets to showdown) from a host room without Riffle owning identity or becoming match authority.

Locked for this initiative:
- **Host embed:** iframe — host loads the Riffle play URL; minimal integrator work; host-agnostic (RiffSync first).
- **Rules execution:** in-process NLHE library inside the Riffle runtime. Iframe UI talks to that runtime; runtime holds rules + `@turnur/sdk`. SDK key never ships to the browser. Dedicated rules service and client-side rules are out of scope.
- **Seat binding:** host-issued short-lived seat capability (player↔match↔seat) verified by Riffle before any seat-scoped Turnur read/write; postMessage is not seat authority.
- **Signed result:** out of scope this HLD (aligns Turnur deferral).

Now-slice completeness bar: finish a hand via fold-to-one or non-all-in showdown. Side pots, all-in runout, disconnect/rejoin, and spectator polish are roadmap Next — not required to ship this initiative.

LLD complete: all nine tickets Ready (`ai-ready` + tech spec) under milestone/1. Initiative executing. Next: `/forge.implement-ticket` (sibling-Ready gate passes).
