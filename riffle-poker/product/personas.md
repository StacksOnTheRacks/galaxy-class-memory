---
doc: product.personas
schema_version: 1
updated: 2026-09-12
primary:
  - "Standalone poker player — wants to play no-limit Hold'em with play chips; creates an account or plays anonymously on riffle-poker"
  - "Embedded player in a host room (RiffSync first) — plays via Riffle embed-mode iframe link while the host keeps chat, rooms, and media"
  - "Host platform integrator — attaches Riffle embed-mode to a room; does not build match authority or evaluate poker rules"
jobs_to_be_done:
  - "Complete a no-limit Hold'em hand (deal through streets to showdown)"
  - "Sign up, sign in, or play anonymously without leaving the poker product"
  - "Keep hole cards seat-scoped; see the public board with other seated players"
  - "Attach poker to a host room via embed iframe without the host owning match state"
not_for:
  - "Real-money operators, rake, cashier, or KYC"
  - "Standalone casino or matchmaking builders expecting Riffle to provide chat, rooms, or media"
  - "Poker study, HUD, or solver users"
  - "Tournament or sit-and-go grinders as v1"
  - "Players seeking Omaha, Stud, or mixed games as v1"
---

Personas are hypothesis from brief audience. No user interviews, feedback, or instrumentation exist. Not research-validated. Turnur is mothballed — Riffle owns match state for new work.
