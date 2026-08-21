# Objective

Stand up Forge delivery memory for Turnur and sequence the first board around a **running control plane**: TypeScript / Node 22 / AWS CDK with `GET /v1/health`. No implementation is in flight.

# In scope

- First-pass product, architecture, and project memory from this init
- After Apply: `/forge.backlog-grooming` then `/forge.refinement` until actionable tickets are Ready (`ai-ready` or `human-ready`)
- Coarse Now slice (memory projection): CDK app + HTTP API + health Lambda
- Next (not this slice): game authentication / SDK key
- Later: match-state primitives (seats, turns, hidden views, move log, signed result)
- Out of this slice: match features, host identity/chat/rooms/media, epic issues, host milestones (create only when 5+ related tickets exist)

# Sequence

1. Apply this `forge.init-project` seed
2. `/forge.backlog-grooming` — split the running-control-plane Icebox outcome into actionable tickets; move Grooming → Refinement
3. `/forge.refinement` — Intention + AC; promote to Ready + `ai-ready` or `human-ready`
4. Host milestone only if 5+ related tickets exist; otherwise keep the Now slice as a memory projection
5. `/forge.implement-ticket` only after Ready + `ai-ready` exists — not this event
6. After the plane is ticketed and Ready: later grooming for game authentication

# Dependencies

- Board/SCM is empty: https://github.com/StacksOnTheRacks/turnur has zero issues and no host milestone
- Shared project already linked (https://github.com/users/StacksOnTheRacks/projects/1); labels already created
- Memory is a projection; do not invent ticket numbers or milestone URLs
- Pattern reference: RiffSync `infra/cdk` (not a runtime dependency)
- Identity, chat, rooms, and media stay on the host

# Handoffs

- Product: own Icebox outcomes; run `/forge.backlog-grooming` after this init is Applied, starting with the running control plane
- Product → board: `/forge.refinement` produces self-contained Ready tickets (no epics)
- Architecture: ADR-001 is locked; keep host-vs-engine boundary; do not copy RiffSync media/identity
- Engineering: no implement handoff until Ready + `ai-ready`
