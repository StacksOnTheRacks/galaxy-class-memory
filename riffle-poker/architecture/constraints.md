---
doc: architecture.constraints
schema_version: 1
updated: 2026-08-30
hard_constraints:
  - "After a match is attached, Turnur is state authority for seats, turns, hidden views, and the move log. Riffle must not become a parallel match engine."
  - "Gameplay and rules live in Riffle Poker. Turnur does not evaluate poker legality."
  - "Identity, chat, rooms, and media stay on the host. Riffle does not own player accounts."
  - "Riffle is a game, not a host, lobby, chat, catalog, or media product."
  - "Riffle is the registered Turnur game; its runtime holds the SDK key. The host never becomes match authority."
soft_constraints:
  - "First host is RiffSync; remain host-agnostic so another host can attach later."
  - "Prefer TypeScript when a stack is chosen, to consume @turnur/sdk without a second language boundary. Not locked."
  - "Defer runtime, IaC, and where rules execute (in-process library vs dedicated service vs client) until a first slice needs it."
out_of_bounds:
  - "Player login, accounts, or identity as a Riffle concern."
  - "Rooms, presence, chat, or a media/SFU plane of its own."
  - "Forking or replacing Turnur."
  - "Inventing a full control-plane or AWS stack at init."
  - "Real-money wagering, cashier, or KYC systems."
assumptions:
  - "First-party game, Turnur authority, host-attachable is the working sketch."
  - "Turnur match primitives (SDK key, seats, turns, hidden views, move log) will be consumable by a first-party game."
  - "How a host embeds the play surface is undecided."
  - "How poker rules execute (library in-process vs dedicated service vs client) is undecided."
---
