---
doc: product.roadmap
schema_version: 1
updated: 2026-08-30
themes:
  - "Running control plane: TypeScript, Node 22, AWS CDK, health-checkable HTTP API"
  - "Host attach: a host attaches a match; identity, chat, rooms, and media stay on the host"
  - "Game authentication: SDK key so a game can talk to Turnur"
  - "Backend state provider: games supply gameplay and rules; Turnur owns match state"
  - "Stay out of identity, chat, rooms, and media; authenticate games, not players"
now:
  - "Match authority primitives: seats, turns, hidden views, and the move log — Refinement #29–#35 (not Ready)"
next:
  - "Host path polish (RiffSync or equivalent) without Turnur owning rooms or identity"
later:
  - "Signed result as a capability (verification mechanism undecided)"
  - "Additional host platforms beyond the first attach"
  - "Additional games / game packs that reuse the same auth and state-provider contract"
not_planning:
  - "A first-party Turnur game as v1"
  - "Player or host authentication on Turnur"
  - "Identity, chat, rooms, or media on Turnur"
  - "Becoming a social, lobby, or watch-party product"
  - "Real-time / action (non-turn-based) gameplay"
  - "Cloning RiffSync's media plane or fan/staff Cognito stacks"
---

Board: control plane #1–#4, game auth #9–#13, host attach #19–#23 Done (PRs #5–#28). Primitives [#29–#35](https://github.com/StacksOnTheRacks/turnur/milestone/3) In Refinement — not Ready.
