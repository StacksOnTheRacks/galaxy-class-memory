# Primary metrics

- Control plane health: `GET /v1/health` succeeds (synth locally; deployed URL when operators deploy)
- Game authentication success (valid SDK key; game can talk to Turnur) — after auth slice
- Authentication rejection (missing or invalid SDK key) — after auth slice
- After auth exists: matches that an authenticated game can run to seats / turns / hidden views / move log
- Signed-result issuance for finished matches (later; capability only)

# Supporting metrics

- `cdk synth` green on the default branch
- Unauthenticated calls rejected (player or host treated as a game) — after auth slice
- Host-attach → user-join → game-auth completions on the first host (RiffSync), when measurable

# Targets

- TBD after first metrics-review (no product yet; README-only repo, empty issue board)
- This slice: health returns ok; synth passes
- Later: a game with an SDK key can authenticate; games without one cannot; Turnur does not authenticate players

# Current read

- Stub: https://github.com/StacksOnTheRacks/turnur is public, created 2026-08-14, default branch main. README only. No issues. Labels `ai-ready` / `human-ready` exist; repo is on shared GitHub Project https://github.com/users/StacksOnTheRacks/projects/1. No instrumentation. First expected host: RiffSync (https://github.com/StacksOnTheRacks/riffsync). Stack intent: TypeScript, Node 22, AWS CDK, RiffSync-like serverless control plane (not its media/identity stacks).
