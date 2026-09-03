---
doc: product.initiative
schema_version: 1
updated: 2026-09-03
slug: play-lab
title: Play lab
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

Riffle's first playable NLHE table (#1–#9) is merged and CI-green, but only against an in-memory fake Turnur. There is no host page that mints bootstrap, embeds the Riffle-origin iframe, issues seat capabilities, and lets two seats finish a hand.

RiffSync remains the first product host and is out of this initiative. This initiative is a first-party play lab / embed harness in riffle-poker so we can test the game and embed mechanics without waiting on RiffSync. It implements the host contract; it does not make Riffle a host, lobby, identity, chat, or rooms product. Not a standalone consumer client (that stays Later / non-goal). Not a CI/hosting program — Riffle already has GitHub Actions; runtime hosting stays an open question.

Success bar: two browser seats in the lab complete a fold-to-one or showdown hand against live Turnur; SDK key still only on the Riffle runtime.
