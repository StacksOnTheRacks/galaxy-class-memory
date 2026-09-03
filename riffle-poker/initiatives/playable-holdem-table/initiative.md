---
doc: product.initiative
schema_version: 1
updated: 2026-09-02
slug: playable-holdem-table
title: "Playable no-limit Hold'em table"
status: lld
user_facing: true
signoffs:
  po: true
  architect: true
  designer: true
  security: true
board_milestone: ""
board_tickets: []
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
