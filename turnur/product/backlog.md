# In progress

- (none)

# Ready

- (none)

# Refinement

- (none)

# Blocked

- (none)

# Icebox

- Running control plane: TypeScript / Node 22 / AWS CDK, HTTP API, `GET /v1/health`
- Game authentication: a game authenticates to Turnur with an SDK key and can talk to it as a backend state provider
- Host attaches a match; identity, chat, rooms, and media stay on the host
- Seats are created and owned by Turnur (who sits where)
- Turn order is authoritative (whose turn; illegal-turn rejected)
- Hidden views are seat-scoped (private information does not leak)
- Move log is complete and append-only for the match
- Match ends with a signed result (capability; not a first-goal)
