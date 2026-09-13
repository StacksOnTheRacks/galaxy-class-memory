---
doc: project.plan
schema_version: 1
updated: 2026-09-12
objective: "Ship Integrate WebSockets (#44–#49) as notify-only fanout beside HTTP match authority. Signed result and Authoritative writes remain operator-locked Next queue."
in_scope:
  - "Shipped: control plane #1–#4 (PRs #5–#8); game auth #9–#13 (PRs #14–#18); host attach #19–#23 (PRs #24–#28); match authority primitives #29–#35 (PRs #36–#42)"
  - "In flight — Integrate WebSockets #44–#49 on [milestone/4](https://github.com/StacksOnTheRacks/turnur/milestone/4) (Refinement → Ready → implement)"
  - "Next — Signed result; Authoritative writes. Coarse outcomes — /forge.new-initiative before tickets"
  - "Out of scope: player/host auth, epic/umbrella issues, identity/chat/rooms/media on Turnur, game-rule engine, Idempotency-Key, action/realtime gameplay, browser-embedded production WS"
sequence:
  - "Control plane #1–#4 — Done (PRs #5–#8)"
  - "Game authentication #9–#13 — Done (PRs #14–#18)"
  - "Host attach #19–#23 — Done (PRs #24–#28); milestone Host attach a match closed"
  - "Match authority primitives #29–#35 — Done (PRs #36–#42)"
  - "Integrate WebSockets #44 ConnectionRegistry + connect/disconnect"
  - "Integrate WebSockets #45 subscribe handler"
  - "Integrate WebSockets #46 publish-match-event + seat.created"
  - "Integrate WebSockets #47 remaining mutation publishers"
  - "Integrate WebSockets #48 SDK createTurnurWsClient"
  - "Integrate WebSockets #49 integrator README"
  - "After WebSockets ships — /forge.new-initiative: Signed result → Authoritative writes"
dependencies:
  - "Board: #44–#49 on Refinement under Integrate WebSockets milestone"
  - "HTTP remains authority until ADR locks push channel (ws-adr-lock deferred)"
  - "Primitives #29–#35 shipped; WebSocket is notify-only examine slice"
  - "Signed result and authoritative writes wait on /forge.new-initiative"
  - "Every new route uses requireGameAuth + MatchRegistry ownership"
  - "Identity, chat, rooms, and media stay on the host"
handoffs:
  - "Product → /forge.refinement on #44–#49 (compile ticket .feature → Ready + tech spec)"
  - "Product → /forge.new-initiative on remaining Next queue after WebSockets (Signed result, Authoritative writes)"
---

Board/SCM wins. #44–#49 on [Integrate WebSockets](https://github.com/StacksOnTheRacks/turnur/milestone/4) in Refinement.
