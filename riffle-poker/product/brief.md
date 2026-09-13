---
doc: product.brief
schema_version: 2
updated: 2026-09-12
product_name: "Riffle Poker"
product_description: "Standalone no-limit Texas Hold'em app (play chips). Players create an account or play anonymously. Riffle owns gameplay, rules, match state (seats, turns, hidden hole cards, move log), and WebSocket notify. Embed-mode lets a host (RiffSync first) load the same play surface via a shared iframe link; the host keeps chat, rooms, and media. Repo: https://github.com/StacksOnTheRacks/riffle-poker"
problem: "People want to play real poker together online without building match authority in-house. Host platforms want to attach poker to a room without owning rules or match state. Turnur is mothballed — Riffle is the product."
audience:
  - "Players who want a standalone poker app (account or anonymous, play chips)"
  - "Players in a host room (RiffSync first) via embed-mode iframe link"
  - "Host platforms attaching Riffle embed-mode while keeping identity, chat, and media on the host"
  - "Not for real-money operators, standalone casino builders, or anyone expecting Riffle to provide chat, rooms, or media playback"
goals:
  - "A playable no-limit Texas Hold'em table whose rules and UI live in this repo"
  - "Riffle owns match state and WebSockets — no Turnur dependency for new work"
  - "Standalone play: account sign-up/sign-in or anonymous session"
  - "Embed-mode: shared iframe link for hosts (RiffSync first beachhead)"
  - "Hole cards stay seat-scoped; public board visible to seated players"
non_goals:
  - "Chat, rooms, presence, or media/playback (host owns those in embed-mode)"
  - "Real money, rake, cashier, or KYC"
  - "Turnur as match backend or developer platform GTM"
  - "Becoming a watch-party, lobby chat, or SFU product"
  - "Additional poker variants as v1 (Omaha, Stud, mixed games)"
  - "Tournaments or sit-and-go as v1"
  - "A poker study, HUD, or solver product"
success_metrics:
  - metric: "Standalone playable hand"
    target: "A seated table completes a no-limit Hold'em hand (deal through showdown) with account or anonymous auth"
  - metric: "Embed-mode attach"
    target: "A host room loads Riffle embed iframe; players complete a hand; host keeps chat/rooms/media"
  - metric: "Hidden information"
    target: "Hole cards visible only to the owning seat"
  - metric: "Quantified targets"
    target: "TBD (greenfield; no instrumentation yet)"
current_focus: "Now: standalone-play-and-embed HLD (operator pivot — Turnur mothballed). Shipped: playable-holdem-table #1–#9, play-lab #19–#24 (Turnur-backed; historical). Next (operator-locked): Artwork; Web Site; Complete NLHE Hand; Multi-Hand Session."
---

Repo: [github.com/StacksOnTheRacks/riffle-poker](https://github.com/StacksOnTheRacks/riffle-poker). First expected embed host: [RiffSync](https://github.com/StacksOnTheRacks/riffsync). Turnur mothballed — not a live dependency for new work.
