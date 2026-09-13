---
doc: product.initiative
schema_version: 1
updated: 2026-09-13
slug: standalone-play-and-embed
title: "Standalone play and embed"
status: lld
user_facing: true
signoffs:
  po: true
  architect: true
  designer: true
  security: true
board_milestone: "[Standalone play and embed](https://github.com/StacksOnTheRacks/riffle-poker/milestone/4)"
board_tickets:
  - "[#36 First-party Riffle account and anonymous bearer session](https://github.com/StacksOnTheRacks/riffle-poker/issues/36)"
  - "[#37 Riffle MatchStore owns seats, turns, hidden views, and the move log](https://github.com/StacksOnTheRacks/riffle-poker/issues/37)"
  - "[#38 Shared play URL attach for standalone and host embed](https://github.com/StacksOnTheRacks/riffle-poker/issues/38)"
  - "[#39 Sit at Table binds a Riffle session to a seat](https://github.com/StacksOnTheRacks/riffle-poker/issues/39)"
  - "[#40 Anonymous player can change in-game display name](https://github.com/StacksOnTheRacks/riffle-poker/issues/40)"
  - "[#41 Browser WebSocket notify-only for public table updates](https://github.com/StacksOnTheRacks/riffle-poker/issues/41)"
  - "[#42 Apply on-turn NLHE actions against MatchStore](https://github.com/StacksOnTheRacks/riffle-poker/issues/42)"
  - "[#43 Hole cards stay seat-scoped and the public board is shared](https://github.com/StacksOnTheRacks/riffle-poker/issues/43)"
  - "[#44 Complete a play-chip hand on standalone and embed](https://github.com/StacksOnTheRacks/riffle-poker/issues/44)"
---

Operator pivot: Turnur mothballed. Riffle owns match state and WebSockets.

**Outcome:** Riffle Poker is a standalone no-limit Hold'em app. Players create an account or play anonymously. Riffle owns gameplay, rules, match state (seats, turns, hidden hole cards, move log), and WebSocket notify. Embed-mode lets a host (RiffSync first) load the same play surface via a shared play URL; the host keeps chat, rooms, and media.

**HLD bar:** Account or anonymous → **Sit at Table** → complete a play-chip hand (fold-to-one or non-all-in showdown). Host loads the same surface via shared play URL; guests (including unauthenticated RiffSync watch-party guests) self-sit; anonymous players can change in-game display name; hole cards seat-scoped; public board shared; table updates via Riffle notify.

**Locked this HLD:** First-party Riffle identity (not Cognito); anonymous session on Sit at Table; shared play URL (freeze mint/redeem + seat capability); browser WS notify-only; freeze Turnur host-key HTTP; no host seat authority; no production lobby; **bearer-only session** (Authorization or equivalent; no ambient cookie).

**Not this initiative:** Chat, rooms, media, real money, variants, tournaments, side pots / all-in runout / disconnect-rejoin / spectator polish, matchmaking. Anonymous-to-account without leaving the table is an open question, not required.

Suggested next: `/forge.plan-refresh` then `/forge.refinement`.
