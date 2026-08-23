---
doc: product.roadmap
schema_version: 1
updated: 2026-08-23
themes:
  - "Running control plane: TypeScript, Node 22, AWS CDK, health-checkable HTTP API"
  - "Host attach: a host attaches a match; identity, chat, rooms, and media stay on the host"
  - "Game authentication: SDK key so a game can talk to Turnur"
  - "Backend state provider: games supply gameplay and rules; Turnur owns match state"
  - "Stay out of identity, chat, rooms, and media; authenticate games, not players"
now:
  - "Scaffold the repo like RiffSync's control plane (infra/cdk, Lambda TypeScript, Vitest, cdk synth on PRs) — #1 Done (PR #5)"
  - "One stack: API Gateway HTTP API + Node 22 Lambda — Ready #2"
  - "GET /v1/health so the application is observably running — Ready #3"
  - "GitHub Actions CI for cdk synth and Vitest on PRs — Ready #4"
next:
  - "Game authentication / SDK key on the running API so a game can talk to Turnur"
  - "Host attach + match authority: seats, turns, hidden views, and the move log"
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

Board: [#1](https://github.com/StacksOnTheRacks/turnur/issues/1) Done; Ready [#2](https://github.com/StacksOnTheRacks/turnur/issues/2), [#3](https://github.com/StacksOnTheRacks/turnur/issues/3), [#4](https://github.com/StacksOnTheRacks/turnur/issues/4).
