---
doc: product.personas
schema_version: 1
updated: 2026-09-02
primary:
  - "Seated poker player in a host room (RiffSync first beachhead) — wants to play no-limit Hold'em with people already in the room, using play chips, without Riffle owning their identity or the room's chat/media"
  - "Host platform integrator — attaches a first-party poker pack to rooms while keeping identity, chat, rooms, and media on the host; does not build in-house match authority"
jobs_to_be_done:
  - "Complete a no-limit Hold'em hand (deal through streets to showdown) with people already in a host room"
  - "Keep hole cards seat-scoped; see the public board with other seated players"
  - "Attach poker to a room without the host becoming match authority for seats, turns, hidden views, or the move log"
  - "Keep player identity, chat, rooms, and media on the host"
not_for:
  - "Real-money operators, rake, cashier, or KYC"
  - "Standalone casino, lobby, or matchmaking builders"
  - "Anyone expecting Riffle to provide identity, chat, rooms, presence, or media"
  - "Poker study, HUD, or solver users"
  - "Tournament or sit-and-go grinders as v1"
  - "Players seeking Omaha, Stud, or mixed games as v1"
---

Personas are hypothesis from brief audience plus sister Turnur/RiffSync product contracts. No user interviews, feedback, or instrumentation exist. Not research-validated. Riffle designs for seated players; Turnur does not — that split is intentional (game vs engine).
