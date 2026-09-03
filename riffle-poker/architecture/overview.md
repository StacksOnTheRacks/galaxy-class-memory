---
doc: architecture.overview
schema_version: 1
updated: 2026-09-02
system: "Riffle Poker is a first-party poker game. It owns gameplay and rules. Turnur is match authority (SDK key, seats, turns, hidden views, move log). A host (RiffSync first) owns identity, chat, rooms, and media. Riffle attaches into that host via iframe; it is not a social or media product."
context: "The riffle-poker repo is greenfield (README only). Sister products: Turnur (match engine) and RiffSync (watch-party host). TypeScript preferred (soft) for client/runtime/library. Runtime hosting not locked. Logical sketch for playable-holdem-table HLD."
data_flow: "1. Host provides a player session; identity stays on the host. 2. Host embeds the Riffle play URL in an iframe with opaque match/room context and issues a seat capability. 3. Iframe UI talks only to Riffle runtime. 4. Runtime verifies the seat capability, runs in-process NLHE rules, and calls Turnur via @turnur/sdk with the server-held SDK key. 5. Turnur owns seats, turns, hidden views, and the move log. 6. Runtime returns seat-scoped table state to the iframe. 7. Host continues to own chat, rooms, and media around the table."
deployment_shape: "Runtime hosting not locked. Embed shape (iframe) and rules locus (in-process library) are locked. No IaC choice yet."
current_focus: "playable-holdem-table HLD — iframe embed, in-process rules library, Turnur SDK integration, host-issued seat capability."
major_components:
  - "Poker rules — in-process NLHE library; deal, legal actions, streets, showdown; lives in this repo"
  - "Play surface — iframe client at Riffle origin (seat-scoped table UI)"
  - "Riffle runtime — sole SDK-key holder; verifies seat capabilities; orchestrates rules ↔ Turnur"
  - "Turnur integration — game SDK key; match attach/probe; seats, turns, hidden views, move log"
  - "Host — identity, chat, rooms, media, iframe embed, seat capability issuance; first intended host is RiffSync"
  - "Turnur — match authority; not owned by this repo"
---
