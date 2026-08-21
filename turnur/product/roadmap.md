# Themes

- Running control plane: TypeScript, Node 22, AWS CDK, health-checkable HTTP API
- Host attach: a host attaches a match; identity, chat, rooms, and media stay on the host
- Game authentication: SDK key so a game can talk to Turnur
- Backend state provider: games supply gameplay and rules; Turnur owns match state
- Stay out of identity, chat, rooms, and media; authenticate games, not players

# Now

- Scaffold the repo like RiffSync’s control plane (`infra/cdk`, Lambda TypeScript, Vitest, `cdk synth` on PRs)
- One stack: API Gateway HTTP API + Node 22 Lambda
- `GET /v1/health` so the application is observably running
- Greenfield: https://github.com/StacksOnTheRacks/turnur — public, README only, empty issue board

# Next

- Game authentication / SDK key on the running API so a game can talk to Turnur
- Host attach + match authority: seats, turns, hidden views, and the move log
- Host path polish (RiffSync or equivalent) without Turnur owning rooms or identity

# Later

- Signed result as a capability (verification mechanism undecided)
- Additional host platforms beyond the first attach
- Additional games / game packs that reuse the same auth and state-provider contract

# Not planning

- A first-party Turnur game as v1
- Player or host authentication on Turnur
- Identity, chat, rooms, or media on Turnur
- Becoming a social, lobby, or watch-party product
- Real-time / action (non-turn-based) gameplay
- Cloning RiffSync’s media plane or fan/staff Cognito stacks
