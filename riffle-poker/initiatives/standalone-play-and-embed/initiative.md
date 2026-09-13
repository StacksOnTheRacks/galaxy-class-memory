---
doc: product.initiative
schema_version: 1
updated: 2026-09-12
slug: standalone-play-and-embed
title: "Standalone play and embed"
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

Operator pivot: Turnur mothballed. Riffle owns match state and WebSockets.

**Outcome:** Riffle Poker is a standalone no-limit Hold'em app. Players create an account or play anonymously. Riffle owns gameplay, rules, match state (seats, turns, hidden hole cards, move log), and WebSocket notify. Embed-mode lets a host (RiffSync first) load the same play surface via a shared play URL; the host keeps chat, rooms, and media.

**HLD bar:** Account or anonymous → **Sit at Table** → complete a play-chip hand (fold-to-one or non-all-in showdown). Host loads the same surface via shared play URL; guests (including unauthenticated RiffSync watch-party guests) self-sit; anonymous players can change in-game display name; hole cards seat-scoped; public board shared; table updates via Riffle notify.

**Locked this HLD:** First-party Riffle identity (not Cognito); anonymous session on Sit at Table; shared play URL (freeze mint/redeem + seat capability); browser WS notify-only; freeze Turnur host-key HTTP; no host seat authority; no production lobby.

**Not this initiative:** Chat, rooms, media, real money, variants, tournaments, side pots / all-in runout / disconnect-rejoin / spectator polish, matchmaking. Anonymous-to-account without leaving the table is an open question, not required.

Suggested next: `/forge.initiative-planning` (Designer re-check after design-spike frames built).
