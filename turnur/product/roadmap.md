---
doc: product.roadmap
schema_version: 1
updated: 2026-09-11
themes:
  - "Running control plane: TypeScript, Node 22, AWS CDK, health-checkable HTTP API"
  - "Host attach: a host attaches a match; identity, chat, rooms, and media stay on the host"
  - "Game authentication: SDK key so a game can talk to Turnur"
  - "Backend state provider: games supply gameplay and rules; Turnur owns match state"
  - "Stay out of identity, chat, rooms, and media; authenticate games, not players"
  - "Instant match communication — examine a push channel after HTTP primitives exist"
now: []
next:
  - "Integrate WebSockets — play lab was too slow; examine WebSockets for instant match communication (not action/realtime gameplay; HTTP remains authority until an ADR locks a push channel)"
  - "Signed result as a capability (verification mechanism undecided)"
  - "Authoritative writes — atomic move + per-seat hidden views; move-log pagination"
later:
  - "Host path polish (RiffSync or equivalent) without Turnur owning rooms or identity"
  - "Additional host platforms beyond the first attach"
  - "Additional games / game packs that reuse the same auth and state-provider contract"
not_planning:
  - "A first-party Turnur game as v1"
  - "Player or host authentication on Turnur"
  - "Identity, chat, rooms, or media on Turnur"
  - "Becoming a social, lobby, or watch-party product"
  - "Real-time / action (non-turn-based) gameplay"
  - "Cloning RiffSync's media plane, chat WebSocket, or fan/staff Cognito stacks"
---

Next items are operator-locked coarse outcomes — `/forge.new-initiative` before tickets. WebSockets is an examine slice (play-lab latency), not a locked ADR. Board: primitives [#29–#35](https://github.com/StacksOnTheRacks/turnur/milestone/3) shipped (closed). Control plane, game auth, host attach, and match authority primitives are shipped. Now is empty pending `/forge.new-initiative`. WebSockets remains the recommended first intake (examine slice; not a locked ADR).
