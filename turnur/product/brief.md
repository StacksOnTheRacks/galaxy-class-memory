---
doc: product.brief
schema_version: 2
updated: 2026-08-24
product_name: "Turnur"
product_description: "Authoritative turn-based match engine. Hosts attach a match; Turnur owns seats, turns, hidden views, the move log, and a signed result. A host (RiffSync or anything like it) loads a game into a room; users join the game; the game authenticates to Turnur with an SDK key and uses Turnur as the backend state provider. Games supply gameplay and rules. Identity, chat, rooms, and media stay on the host. Turnur authenticates games, not players. Repo: https://github.com/StacksOnTheRacks/turnur"
problem: "Host platforms want to attach turn-based games to rooms without building authoritative match state in-house. Game developers need seat-scoped hidden views, turn validation, and a signed move log without rolling a custom backend or adopting full-stack platforms that own player identity, chat, and matchmaking."
audience:
  - "Turn-based game developers integrating Turnur as the authoritative match backend"
  - "Host platforms attaching turn-based play to rooms while keeping identity, chat, and media (RiffSync first beachhead)"
  - "Not for end players, real-time/action games, social hosts expecting identity or chat from Turnur, or buyers of a turnkey first-party game"
goals:
  - "A running control plane: TypeScript, Node 22, AWS CDK, API Gateway HTTP + Lambda"
  - "GET /v1/health proves the application is up (synth locally; optional deploy)"
  - "After the plane is up: a game authenticates with an SDK key; Turnur authenticates games, not players"
  - "After auth: a host can attach a match; Turnur owns seats, turns, hidden views, the move log, and a signed result"
  - "Host-agnostic attach path: RiffSync is the first expected host, not the only one"
  - "Identity, chat, rooms, and media stay on the host"
non_goals:
  - "Player or host identity on Turnur"
  - "A first-party game as v1"
  - "Chat, rooms, presence, or media/playback"
  - "Real-time / action games (not turn-based)"
  - "Copying RiffSync's Cognito, CloudFront SPA, WebSocket chat, or SFU/TURN stacks"
  - "Deciding how a signed result is verified (crypto vs transport) as a first-goal"
success_metrics:
  - metric: "CDK synth"
    target: "cdk synth succeeds for the Turnur API stack"
  - metric: "Health endpoint"
    target: "GET /v1/health returns ok from the Lambda (and from a deployed URL if operators deploy)"
  - metric: "Game authentication"
    target: "After auth slice: a game with a valid SDK key can authenticate; missing or invalid keys are rejected"
  - metric: "Quantified targets"
    target: "TBD (greenfield; no instrumentation yet)"
current_focus: "Running control plane: TypeScript / Node 22 / AWS CDK scaffold with API Gateway HTTP + Lambda and GET /v1/health. Ready tickets #2–#4 on board; scaffold #1 Done (PR #5)."
---

Repo: [github.com/StacksOnTheRacks/turnur](https://github.com/StacksOnTheRacks/turnur). First expected host: [RiffSync](https://github.com/StacksOnTheRacks/riffsync).
