# Assets

- Match state (seats, turns, hidden views, move log) — future
- Signed match results — future
- Game SDK keys (game-to-Turnur auth) — future
- CDK/IaC source under `infra/cdk/` — present (#1, PR #5)

# Trust boundaries

- Host platform (RiffSync or equivalent): identity, chat, rooms, media — external
- Turnur control plane: match engine + HTTP API — future AWS boundary
- Game clients: authenticate via host; games authenticate to Turnur via SDK key — future

# Threats

- Secret leakage in IaC or Lambda env — mitigated at scaffold by no secrets + gitignore baseline
- Over-privileged IAM when stacks deploy — open until API/Lambda stack
- Unauthorized game API access — open until SDK key auth (roadmap Next)

# Mitigations

- Placeholder CDK stack only; no deployable application resources (#1)
- Lockfile + dependency audit baseline
- Product intent: authenticate games, not players; no Cognito/fan stacks

# Open questions

- SDK key format, rotation, and storage (Secrets Manager vs SSM) — product/engineering
- Signed result verification mechanism — roadmap Later
