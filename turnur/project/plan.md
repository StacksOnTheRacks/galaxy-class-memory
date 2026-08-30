---
doc: project.plan
schema_version: 1
updated: 2026-08-30
objective: "Refine and sequence match authority primitives so Turnur is match-state authority after shipped host attach."
in_scope:
  - "Shipped: control plane #1–#4 (PRs #5–#8); game auth #9–#13 (PRs #14–#18); host attach #19–#23 (PRs #24–#28)"
  - "Now — match authority primitives: MatchState + MatchMoveLog storage (#29), seats (#30), turn designate + moves (#31), hidden views (#32), move-log read (#33), SDK (#34), integrator docs (#35)"
  - "Later — signed result capability"
  - "Out of scope: player/host auth, epic/umbrella issues, identity/chat/rooms/media on Turnur, game-rule engine, Idempotency-Key"
sequence:
  - "Control plane #1–#4 — Done (PRs #5–#8)"
  - "Game authentication #9–#13 — Done (PRs #14–#18)"
  - "Host attach #19–#23 — Done (PRs #24–#28); milestone Host attach a match closed"
  - "Refinement — #29 → #30 → #31 → #32 → #33 → #34 → #35 (Match authority primitives)"
  - "Implement — #29 then same order after each ticket reaches Ready + ai-ready"
  - "Signed result — later capability"
dependencies:
  - "Board: #29–#35 In Refinement on Match authority primitives; #1–#23 Done"
  - "Strict ticket order: #29 storage → #30 seats → #31 turns/moves → #32 views → #33 move-log → #34 SDK → #35 docs"
  - "Host attach (#19–#23) shipped; MatchRegistry stays metadata-only"
  - "Game auth no longer blocks; every new route uses requireGameAuth + MatchRegistry ownership"
  - "Architect + Security tech spec (ai-ready) required before /forge.implement-ticket"
  - "Identity, chat, rooms, and media stay on the host"
handoffs:
  - "Product → /forge.refinement on #29–#35 (dependency order starting #29)"
  - "Engineering → /forge.implement-ticket #29 → #35 as tickets reach Ready + ai-ready"
  - "Signed result remains later; not this milestone"
---

Board/SCM wins. #29–#35 In Refinement on [Match authority primitives](https://github.com/StacksOnTheRacks/turnur/milestone/3). Next: `/forge.refinement` starting at #29. Not Ready.
