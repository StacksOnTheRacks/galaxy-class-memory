# Primary metrics

- Game authentication success (valid SDK key; game can talk to Turnur)
- Authentication rejection (missing or invalid SDK key)
- After auth exists: matches that an authenticated game can run to seats / turns / hidden views / move log
- Signed-result issuance for finished matches (later; capability only)

# Supporting metrics

- Unauthenticated calls rejected (player or host treated as a game)
- Host-load → user-join → game-auth completions on the first host (RiffSync), when measurable
- Abandoned / never-authenticated game loads (if lifecycle exists)

# Targets

- TBD after first metrics-review (no product yet; README-only repo, empty issue board)
- Directional: a game with an SDK key can authenticate; games without one cannot; Turnur does not authenticate players

# Current read

- Stub: https://github.com/StacksOnTheRacks/turnur is public, created 2026-08-14, default branch main. README only. No issues. Labels `ai-ready` / `human-ready` exist; repo is on shared GitHub Project https://github.com/users/StacksOnTheRacks/projects/1. No instrumentation. First expected host: RiffSync (https://github.com/StacksOnTheRacks/riffsync).
