---
doc: project.plan
schema_version: 1
updated: 2026-09-11
objective: "Primitives shipped. Intake the operator-locked Next queue starting with Integrate WebSockets (examine; play-lab latency). Too large for LLD split — /forge.new-initiative, not tickets."
in_scope:
  - "Shipped: control plane #1–#4 (PRs #5–#8); game auth #9–#13 (PRs #14–#18); host attach #19–#23 (PRs #24–#28); match authority primitives #29–#35 (PRs #36–#42)"
  - "Next — Integrate WebSockets (examine; play-lab latency); Signed result; Authoritative writes. Coarse outcomes — /forge.new-initiative before tickets"
  - "Out of scope: player/host auth, epic/umbrella issues, identity/chat/rooms/media on Turnur, game-rule engine, Idempotency-Key, action/realtime gameplay"
sequence:
  - "Control plane #1–#4 — Done (PRs #5–#8)"
  - "Game authentication #9–#13 — Done (PRs #14–#18)"
  - "Host attach #19–#23 — Done (PRs #24–#28); milestone Host attach a match closed"
  - "Match authority primitives #29–#35 — Done (PRs #36–#42)"
  - "/forge.new-initiative: Integrate WebSockets (examine; play-lab latency) — not refinement, not a host milestone this event"
  - "After WebSockets intake — /forge.new-initiative: Signed result → Authoritative writes"
dependencies:
  - "Board: #1–#35 Done; zero OPEN issues"
  - "Primitives #29–#35 shipped (PRs #36–#42); WebSockets examine gate is open — initiative first"
  - "HTTP remains authority until an ADR locks a push channel"
  - "Signed result and authoritative writes wait on /forge.new-initiative; do not invent tickets from Icebox"
  - "Host attach (#19–#23) shipped; MatchRegistry stays metadata-only"
  - "Every new route uses requireGameAuth + MatchRegistry ownership"
  - "Identity, chat, rooms, and media stay on the host"
handoffs:
  - "Product → /forge.new-initiative for Integrate WebSockets (examine; play-lab latency)"
  - "Product → /forge.new-initiative on remaining Next queue after WebSockets (Signed result, Authoritative writes)"
---

Board/SCM wins. #29–#35 Done on [Match authority primitives](https://github.com/StacksOnTheRacks/turnur/milestone/3) (milestone closed). Next: `/forge.new-initiative` for Integrate WebSockets.
