# Objective

Stand up Forge delivery memory for Turnur and sequence the first board around **game authentication**: an SDK key so a game can use Turnur as a backend state provider. No implementation is in flight.

# In scope

- First-pass product and architecture memory from this init
- After Apply: `/forge.backlog-grooming` then `/forge.refinement` until actionable tickets are Ready (`ai-ready` or `human-ready`)
- Coarse Now slice (memory projection): game authentication — SDK key so a loaded game can talk to Turnur
- Later (not this slice): match-state primitives (seats, turns, hidden views, move log, signed result)
- Out of this slice: implementation, host-platform identity/chat/rooms/media, epic/umbrella issues, host milestones (create only when ≥5 related tickets exist)

# Sequence

1. Apply this `forge.init-project` seed (product, architecture, project memory)
2. `/forge.backlog-grooming` — split Icebox outcomes into actionable tickets; move Grooming → Refinement
3. `/forge.refinement` — Intention + AC; promote to Ready + `ai-ready` or `human-ready`
4. Host milestone only if ≥5 related tickets exist; otherwise keep the Now slice as a memory projection
5. `/forge.implement-ticket` only after Ready + `ai-ready` exists — not this event
6. After game authentication is ticketed and Ready: later grooming for match-state primitives

# Dependencies

- Board/SCM is empty: https://github.com/StacksOnTheRacks/turnur has zero issues and no host milestone
- Shared project already linked (https://github.com/users/StacksOnTheRacks/projects/1); labels already created
- Memory is a projection; do not invent ticket numbers or milestone URLs
- Product Icebox outcomes and thin architecture sketch from this same init
- Host path (RiffSync or equivalent): host loads a game → room loads clients → users join game → game talks to Turnur with SDK key
- Identity, chat, rooms, and media stay on the host

# Handoffs

- Product: own Icebox outcomes; run `/forge.backlog-grooming` after this init is Applied, starting with game authentication
- Product → board: `/forge.refinement` produces self-contained Ready tickets (no epics)
- Architecture: keep host-vs-engine boundary; Now is SDK-key auth so a game can attach as a state client
- Engineering: no implement handoff until Ready + `ai-ready`
