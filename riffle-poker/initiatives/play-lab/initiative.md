---
doc: product.initiative
schema_version: 1
updated: 2026-09-03
slug: play-lab
title: Play lab
status: lld
user_facing: true
signoffs:
  po: true
  architect: true
  designer: true
  security: true
board_milestone: "[Play lab](https://github.com/StacksOnTheRacks/riffle-poker/milestone/2)"
board_tickets:
  - "[#19 Host-facing POST /v1/matches wraps Turnur match.create](https://github.com/StacksOnTheRacks/riffle-poker/issues/19)"
  - "[#20 Play iframe accepts host seat capability via postMessage](https://github.com/StacksOnTheRacks/riffle-poker/issues/20)"
  - "[#21 Lab session orchestrator mints match, seats, bootstrap, and capabilities](https://github.com/StacksOnTheRacks/riffle-poker/issues/21)"
  - "[#22 Lab deal orchestrator deals and opens betting for two seats](https://github.com/StacksOnTheRacks/riffle-poker/issues/22)"
  - "[#23 First-party play lab page with two embedded /play iframes](https://github.com/StacksOnTheRacks/riffle-poker/issues/23)"
  - "[#24 Two lab seats complete a hand against live Turnur](https://github.com/StacksOnTheRacks/riffle-poker/issues/24)"
---

<!--
Authoring (not validated):
- status: intake | hld | lld | executing | shipped
- signoffs: true | false | "na" (designer "na" when not user-facing)
- board_tickets: issue id/title strings after LLD grooming
- Bump updated when any frontmatter field changes.
-->

Riffle's first playable NLHE table (#1–#9) is merged and CI-green, but only against an in-memory fake Turnur. There is no host page that mints bootstrap, embeds the Riffle-origin iframe, issues seat capabilities, and lets two seats finish a hand.

RiffSync remains the first product host and is out of this initiative. This initiative is a first-party play lab / embed harness in riffle-poker so we can test the game and embed mechanics without waiting on RiffSync. It implements the host contract; it does not make Riffle a host, lobby, identity, chat, or rooms product. Not a standalone consumer client (that stays Later / non-goal). Not a CI/hosting program — Riffle already has GitHub Actions; runtime hosting stays an open question.

Success bar: two browser seats in the lab complete a fold-to-one or showdown hand against live Turnur; SDK key still only on the Riffle runtime.

Locked for this initiative:
- Single-operator lab (not remote two-person rooms)
- One lab page with two `/play` iframe slots; desktop dual-column operator layout is Now
- Harness rail: Start session and Deal (Deal includes betting/open); poker actions stay inside each iframe
- Lab implements the existing host contract: bootstrap mint → iframe #bt= → redeem; seat create; capability mint; deal; betting/open; then play in two seats
- Lab fills the missing host `match.create`; browser never holds `RIFFLE_HOST_API_KEY` or `TURNUR_SDK_KEY`
- `RIFFLE_FRAME_ANCESTORS` stays `'self'`; do not widen for this initiative
- Lab does not become identity, chat, rooms, or media
- CI stays on fake Turnur; this initiative is not a CI program
- Live Turnur is the lab success path (env-configured); provisioning a Turnur cluster is out of scope

HLD complete (2026-09-03). LLD grooming complete (2026-09-03): six tickets on Refinement under [milestone/2](https://github.com/StacksOnTheRacks/riffle-poker/milestone/2). Next: `/forge.plan-refresh` then `/forge.refinement`.
