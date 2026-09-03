---
doc: product.initiative
schema_version: 1
updated: 2026-09-02
slug: playable-holdem-table
title: "Playable no-limit Hold'em table"
status: hld
user_facing: true
signoffs:
  po: false
  architect: false
  designer: false
  security: false
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

First playable no-limit Hold'em table (play chips) on Turnur, attachable to a RiffSync room. Rules and seated-player table UI live in riffle-poker. The game authenticates to Turnur with an SDK key; Turnur owns seats, turns, hidden views, the move log, and a signed result. Attach is host-agnostic with RiffSync first. Identity, chat, rooms, and media stay on the host. Hole cards stay seat-scoped via Turnur hidden views. Outcome: a seated table can complete a no-limit Hold'em hand (deal through streets to showdown) from a host room without Riffle owning identity or becoming match authority.
