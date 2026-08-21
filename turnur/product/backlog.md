# In progress

- (none)

# Ready

- [#1 Scaffold Turnur CDK workspace under infra/cdk](https://github.com/StacksOnTheRacks/turnur/issues/1) (`ai-ready`)

# Refinement

- [#2 Add TurnurApi stack with API Gateway HTTP API and Node 22 Lambda](https://github.com/StacksOnTheRacks/turnur/issues/2)
- [#3 Implement GET /v1/health handler and wire route](https://github.com/StacksOnTheRacks/turnur/issues/3)
- [#4 Add GitHub Actions CI for cdk synth and Vitest on PRs](https://github.com/StacksOnTheRacks/turnur/issues/4)

# Blocked

- (none)

# Icebox

- Game authentication: a game authenticates to Turnur with an SDK key and can talk to it as a backend state provider
- Host attaches a match; identity, chat, rooms, and media stay on the host
- Seats are created and owned by Turnur (who sits where)
- Turn order is authoritative (whose turn; illegal-turn rejected)
- Hidden views are seat-scoped (private information does not leak)
- Move log is complete and append-only for the match
- Match ends with a signed result (capability; not a first-goal)
