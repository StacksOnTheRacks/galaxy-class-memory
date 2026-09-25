---
doc: product.brief
schema_version: 2
updated: 2026-09-25
product_name: "Riffle Poker"
product_description: "Standalone no-limit Texas Hold'em app (play chips) with a dashboard play UI. Riffle owns gameplay, rules, match state, and WebSocket notify. Current build focus is the game in-dashboard; embed-mode and RiffSync are not in the active initiative. Repo: https://github.com/StacksOnTheRacks/riffle-poker"
problem: "People want to play real poker together online without an always-on casino stack or felt-table novelty — a clear dashboard table that finishes hands correctly."
audience:
  - "Players who want a standalone poker app (account or anonymous, play chips) on the dashboard UI"
  - "Not for embed hosts / RiffSync attach in the current initiative"
  - "Not for real-money operators, chat/rooms/media seekers, or felt-table art consumers as v1 focus"
goals:
  - "Playable NLHE on the dashboard UI (sit, deal, act, streets, fold-out or showdown)"
  - "All-in works; side pots when required for correct settlement"
  - "Riffle-owned match state on cheap interactive hosting (WS APIGW + Lambda + DynamoDB)"
  - "Hole cards seat-scoped; public board shared"
non_goals:
  - "Embed-mode / RiffSync / iframe host attach (later, not this initiative)"
  - "Felt-table artwork pipeline and Canva kit as current work"
  - "Live mic/camera on the play surface"
  - "Chat, rooms, presence, or media/playback"
  - "Real money, rake, cashier, or KYC"
  - "Turnur as match backend or developer platform GTM"
  - "Additional poker variants as v1 (Omaha, Stud, mixed games)"
  - "Tournaments or sit-and-go as v1"
  - "A poker study, HUD, or solver product"
success_metrics:
  - metric: "Dashboard playable hand"
    target: "Seated table completes NLHE hand through fold-out or showdown (including all-in settlement) with stacks correct"
  - metric: "Hidden information"
    target: "Hole cards visible only to the owning seat"
  - metric: "Quantified targets"
    target: "TBD (greenfield; no instrumentation yet)"
current_focus: "Now: anonymous-table-play in Refinement (#79–#84, milestone/7). Dashboard Hold'em #59–#68 Done. Prior standalone #36–#43 Done; #44 and artwork #53–#58 closed not planned. Next: Web Site; Multi-Hand Session."
---

Repo: [github.com/StacksOnTheRacks/riffle-poker](https://github.com/StacksOnTheRacks/riffle-poker). Turnur mothballed — not a live dependency for new work.
