---
doc: architecture.overview
schema_version: 1
updated: 2026-09-12
system: "Riffle Poker is a standalone no-limit Hold'em app. Riffle owns gameplay, rules, match state (seats, turns, hidden views, move log), and WebSocket notify. Players create an account or play anonymously. Embed-mode lets a host (RiffSync first) load the play surface via a shared iframe link; the host keeps identity, chat, rooms, and media. Turnur is mothballed — not in the new architecture path."
context: "Shipped playable-holdem-table (#1–#9) and play-lab (#19–#24) used Turnur as match authority via @turnur/sdk — historical proof only. Operator pivot: Riffle absorbs match state and WS. TypeScript preferred (soft). Runtime hosting not locked."
data_flow: "1. Standalone: player signs up/signs in or starts anonymous session on Riffle. 2. Player joins or creates a table; Riffle runtime runs in-process NLHE rules and persists match state. 3. WebSocket notify pushes table updates to connected clients. 4. Embed-mode: host loads Riffle iframe link; players in the host room share the same play surface; host keeps chat/rooms/media. 5. Hole cards stay seat-scoped; public board is shared table state."
deployment_shape: "Runtime hosting not locked. Riffle-owned match store + WebSocket API TBD in standalone-play-and-embed HLD. Shipped Turnur integration remains in repo as historical code path."
current_focus: "standalone-play-and-embed HLD — identity, anonymous play, embed link, Riffle-owned match + WS. Next: Artwork; Web Site; Complete NLHE Hand; Multi-Hand Session."
major_components:
  - "Poker rules — in-process NLHE library; deal, legal actions, streets, showdown"
  - "Play surface — table UI (standalone app and embed iframe at Riffle origin)"
  - "Riffle runtime — match authority, rules orchestration, WebSocket notify (new direction)"
  - "Identity — account sign-up/sign-in and anonymous sessions (TBD in HLD)"
  - "Embed-mode — shared iframe link for hosts; host keeps social/media chrome"
  - "Play lab — first-party harness (historical Turnur-backed; fate TBD in HLD)"
  - "Host (RiffSync first) — chat, rooms, media, embed iframe load; not match authority"
---
