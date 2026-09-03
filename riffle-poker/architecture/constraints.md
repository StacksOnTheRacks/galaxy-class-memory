---
doc: architecture.constraints
schema_version: 1
updated: 2026-09-02
hard_constraints:
  - "After a match is attached, Turnur is state authority for seats, turns, hidden views, and the move log. Riffle must not become a parallel match engine."
  - "Gameplay and rules live in Riffle Poker. Turnur does not evaluate poker legality."
  - "Identity, chat, rooms, and media stay on the host. Riffle does not own player accounts."
  - "Riffle is a game, not a host, lobby, chat, catalog, or media product."
  - "Riffle is the registered Turnur game; its runtime holds the SDK key. The host never becomes match authority."
  - "Host embeds the play surface as an iframe at Riffle origin; host passes opaque match/room context; identity stays on the host."
  - "Poker rules execute as an in-process library inside Riffle runtime (not in the iframe client; not a separate rules service for this shape)."
  - "Turnur SDK key is held only by Riffle runtime — never in browser/iframe client."
  - "Host-issued seat capability (player↔match↔seat) is verified by Riffle before seat-scoped Turnur reads/writes; postMessage is not seat authority."
soft_constraints:
  - "First host is RiffSync; remain host-agnostic so another host can attach later."
  - "Prefer TypeScript when a stack is chosen, to consume @turnur/sdk without a second language boundary. Not locked."
  - "Defer Riffle runtime hosting / IaC until a slice needs it; rules locus and iframe embed are locked."
out_of_bounds:
  - "Player login, accounts, or identity as a Riffle concern."
  - "Rooms, presence, chat, or a media/SFU plane of its own."
  - "Forking or replacing Turnur."
  - "Inventing a full control-plane or AWS stack at init."
  - "Real-money wagering, cashier, or KYC systems."
assumptions:
  - "First-party game, Turnur authority, host-attachable is the working sketch."
  - "Turnur match primitives (SDK key, seats, turns, hidden views, move log) will be consumable by a first-party game."
  - "How the host passes match/session context into the iframe (bootstrap) is still open (blocking for implement)."
  - "Concrete seat-capability token schema is LLD; the host-issued capability pattern is locked."
  - "Runtime hosting undecided (non-blocking while iframe + in-process library + server-side SDK key hold)."
---
