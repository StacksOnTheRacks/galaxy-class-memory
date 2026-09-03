---
doc: product.brief
schema_version: 2
updated: 2026-09-02
product_name: "Riffle Poker"
product_description: "First-party poker game (Texas Hold'em default). Authenticates to Turnur with an SDK key and uses Turnur as the authoritative match backend for seats, turns, hidden views, the move log, and a signed result. A host (RiffSync first) attaches the match to a room. Gameplay and rules live here. Identity, chat, rooms, and media stay on the host. Repo: https://github.com/StacksOnTheRacks/riffle-poker"
problem: "People in a host room want to play real poker together without the host building match authority, and without the game owning identity, chat, or rooms. Turnur is an authoritative turn-based engine that explicitly does not ship a first-party game as v1 — Riffle Poker is that game."
audience:
  - "Players seated at a poker table in a host room (RiffSync first beachhead)"
  - "Host platforms attaching a first-party poker pack to rooms while keeping identity, chat, and media"
  - "Not for real-money operators, standalone casino builders, or anyone expecting Riffle to provide identity, chat, rooms, or media"
goals:
  - "A playable no-limit Texas Hold'em table (play chips) whose rules and UI live in this repo"
  - "The game authenticates to Turnur with an SDK key; Turnur owns seats, turns, hidden views, the move log, and a signed result"
  - "Host-agnostic attach path: RiffSync is the first expected host, not the only one"
  - "Identity, chat, rooms, and media stay on the host"
  - "Hole cards stay seat-scoped via Turnur hidden views; the public board is visible to seated players"
non_goals:
  - "Player or host identity on Riffle Poker"
  - "Chat, rooms, presence, or media/playback"
  - "Real money, rake, cashier, or KYC"
  - "Replacing or forking Turnur as match authority"
  - "Additional poker variants as v1 (Omaha, Stud, mixed games)"
  - "Tournaments or sit-and-go as v1"
  - "A standalone consumer lobby or matchmaking product as v1"
  - "Becoming a poker study, HUD, or solver product"
success_metrics:
  - metric: "Playable hand"
    target: "A seated table can complete a no-limit Hold'em hand on Turnur (deal through streets to showdown)"
  - metric: "Game authentication"
    target: "Riffle authenticates to Turnur with a valid SDK key; missing or invalid keys are rejected"
  - metric: "Host attach"
    target: "A RiffSync room can attach a Riffle match; identity, chat, rooms, and media stay on the host"
  - metric: "Hidden information"
    target: "Hole cards are visible only to the owning seat via Turnur hidden views"
  - metric: "Quantified targets"
    target: "TBD (greenfield; no instrumentation yet)"
current_focus: "LLD for playable-holdem-table — nine Now-slice tickets are on Refinement under host milestone Playable no-limit Hold'em table. First playable NLHE table (play chips) on Turnur, iframe-attached from a host room (RiffSync first). Rules run in-process in the Riffle runtime; SDK key stays server-side; host-issued seat capability binds player↔match↔seat. Signed result, side pots, all-in runout, disconnect/rejoin, and spectator polish are out of this slice. Next: /forge.plan-refresh then /forge.refinement."
---

Repo: [github.com/StacksOnTheRacks/riffle-poker](https://github.com/StacksOnTheRacks/riffle-poker). Match backend: [Turnur](https://github.com/StacksOnTheRacks/turnur). First expected host: [RiffSync](https://github.com/StacksOnTheRacks/riffsync).
