# Product

Turnur is an authoritative turn-based match engine. Hosts attach a match; Turnur owns seats, turns, hidden views, the move log, and a signed result. A host (RiffSync or anything like it) loads a game into a room; users join the game; the game authenticates to Turnur with an SDK key and uses Turnur as the backend state provider. Games supply gameplay and rules. Identity, chat, rooms, and media stay on the host. Turnur authenticates games, not players. Repo: https://github.com/StacksOnTheRacks/turnur

# Problem

There is no running Turnur process to attach to. Before a host can attach a match, or a game can authenticate, the repo needs a deployable control plane. Without that, seats, turns, hidden views, the move log, and a signed result have nowhere to live.

# Who it's for

- Games that will use Turnur as a backend state provider (after auth exists)
- Host platforms (RiffSync first; any similar room/identity/chat/media host) that will attach a match
- Operators who need a health-checkable API before match features land
- Not for people seeking identity, chat, rooms, media, or a first-party Turnur game

# Goals

- A running control plane: TypeScript, Node 22, AWS CDK, API Gateway HTTP + Lambda
- `GET /v1/health` proves the application is up (synth locally; optional deploy)
- After the plane is up: a game authenticates with an SDK key; Turnur authenticates games, not players
- After auth: a host can attach a match; Turnur owns seats, turns, hidden views, the move log, and a signed result
- Host-agnostic attach path: RiffSync is the first expected host, not the only one
- Identity, chat, rooms, and media stay on the host

# Non-goals

- Player or host identity on Turnur
- A first-party game as v1
- Chat, rooms, presence, or media/playback
- Real-time / action games (not turn-based)
- Copying RiffSync’s Cognito, CloudFront SPA, WebSocket chat, or SFU/TURN stacks
- Deciding how a signed result is verified (crypto vs transport) as a first-goal

# Success metrics

- `cdk synth` succeeds for the Turnur API stack
- `GET /v1/health` returns ok from the Lambda (and from a deployed URL if operators deploy)
- After this slice: a game with a valid SDK key can authenticate; missing or invalid keys are rejected
- Quantified product targets TBD (greenfield; no instrumentation yet)

# Current focus

Running control plane: TypeScript / Node 22 / AWS CDK scaffold with API Gateway HTTP + Lambda and `GET /v1/health`. Board is empty of issues; no code beyond the README.
