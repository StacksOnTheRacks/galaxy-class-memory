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

**Outcome:** Riffle Poker is a standalone no-limit Hold'em app. Players create an account or play anonymously. Riffle owns gameplay, rules, match state (seats, turns, hidden hole cards, move log), and WebSocket notify. Embed-mode lets a host (RiffSync first) load the same play surface via a shared iframe link; the host keeps chat, rooms, and media.

**Not in this HLD stub:** board tickets, auth provider choice, WS protocol, embed link mint shape, or migration plan for shipped Turnur-backed code. Those resolve in `/forge.initiative-design`.

Suggested next: `/forge.initiative-design` on this initiative.
