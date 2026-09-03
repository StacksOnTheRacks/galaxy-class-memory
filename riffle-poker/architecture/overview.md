---
doc: architecture.overview
schema_version: 1
updated: 2026-09-03
system: "Riffle Poker is a first-party poker game. It owns gameplay and rules. Turnur is match authority (SDK key, seats, turns, hidden views, move log). A host (RiffSync first) owns identity, chat, rooms, and media. Riffle attaches into that host via iframe; it is not a social or media product."
context: "The playable NLHE table (#1–#9) is merged and CI-green against an in-memory fake Turnur; no host page exists yet. Sister products: Turnur (match engine) and RiffSync (watch-party host). RiffSync remains the first product host and is out of play-lab. TypeScript preferred (soft) for client/runtime/library. Runtime hosting not locked."
data_flow: "1. Host provides a player session; identity stays on the host. 2. Host mints an opaque short-lived bootstrap token at Riffle and embeds the Riffle play URL (with that token) in an iframe; host also issues a seat capability (separate channel). 3. Iframe redeems the bootstrap token at Riffle runtime to bind match attach context; UI talks only to Riffle runtime. 4. Runtime verifies the seat capability, runs in-process NLHE rules, and calls Turnur via @turnur/sdk with the server-held SDK key. 5. Turnur owns seats, turns, hidden views, and the move log. 6. Runtime returns seat-scoped table state to the iframe. 7. Host continues to own chat, rooms, and media around the table."
deployment_shape: "Runtime hosting not locked. Embed shape (iframe), bootstrap (opaque token mint→redeem), and rules locus (in-process library) are locked. No IaC choice yet."
current_focus: "play-lab HLD — first-party same-origin host harness against live Turnur; host match.create; lab orchestrator; capability postMessage into two /play iframes"
major_components:
  - "Poker rules — in-process NLHE library; deal, legal actions, streets, showdown; lives in this repo"
  - "Play surface — iframe client at Riffle origin (seat-scoped table UI)"
  - "Riffle runtime — sole SDK-key holder; redeems bootstrap; verifies seat capabilities; orchestrates rules ↔ Turnur"
  - "Play lab — first-party same-origin host harness (GET /lab + server orchestrator); implements host contract; not a lobby/identity product"
  - "Turnur integration — game SDK key; match attach/probe; seats, turns, hidden views, move log"
  - "Host — identity, chat, rooms, media, bootstrap mint + iframe embed, seat capability issuance; first intended host is RiffSync"
  - "Turnur — match authority; not owned by this repo"
---
