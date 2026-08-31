---
doc: architecture.overview
schema_version: 1
updated: 2026-08-30
system: "Riffle Poker is a first-party poker game. It owns gameplay and rules. Turnur is match authority (SDK key, seats, turns, hidden views, move log). A host (RiffSync first) owns identity, chat, rooms, and media. Riffle attaches into that host; it is not a social or media product."
context: "The riffle-poker repo is greenfield (README only). Sister products: Turnur (match engine) and RiffSync (watch-party host). No language, IaC, or deploy shape is locked. This sketch is logical only."
data_flow: "1. Host provides a player session; identity stays on the host. 2. Host surfaces or embeds Riffle play. 3. Riffle, as a Turnur game, creates or joins a match via Turnur SDK-key auth. 4. Turnur owns seats, turns, hidden views, and the move log. 5. Riffle applies poker rules to propose and interpret moves and to render each seat's view. 6. Host continues to own chat, rooms, and media around the table."
deployment_shape: "Not locked. No IaC, runtime, or hosting choice yet."
current_focus: "Project init — thin architecture sketch from the product idea. First slice and stack are undecided."
major_components:
  - "Poker rules — deal, legal actions, streets, showdown; lives in this repo"
  - "Play surface — table UI a host can attach or embed (shape undecided)"
  - "Turnur integration — game SDK key; match attach/probe; seats, turns, hidden views, move log"
  - "Host — identity, chat, rooms, media; first intended host is RiffSync"
  - "Turnur — match authority; not owned by this repo"
---
