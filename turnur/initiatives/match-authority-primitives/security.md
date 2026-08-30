---
doc: product.initiative_security
schema_version: 1
updated: 2026-08-30
summary: "HLD security for seats, game-designated turns, seat-scoped hidden views, and an append-only move log on matches already owned via SDK-key game auth. Signed result is out of scope. Authn stays requireGameAuth with game-trusted seat selection. Cross-game access reuses shipped match_forbidden / match_not_found. Hidden state lives only in seat-scoped views; the move log is public to the owning game."
threats:
  - "Hidden-view leak across seats: a seat-scoped view, public/shared payload, error body, or log line for seat A includes seat B's private state"
  - "Illegal-turn bypass: a move is accepted when it is not that seat's turn, or match state is written outside the turn-authority path (direct store write, replace, or force)"
  - "Move-log tamper/rewrite: historical moves are updated, deleted, reordered, or replaced other than by appending a successful turn"
  - "Cross-game match access: game A reads or mutates game B's seats, turns, hidden views, or move log"
  - "Player PII on Turnur: names, emails, host auth subjects, or other player identity stored on seats or match records"
  - "Authn expansion: player or host login added to exercise seats, turns, or views"
  - "SDK-key leak amplification: a production key in a player-facing client lets any caller act as the owning game for every seat on that game's matches (accepted residual of game-trusted seat selection)"
mitigations:
  - "Reuse requireGameAuth (hash-then-lookup, no key material in errors/logs) on every new match-state route; GET /v1/health remains open"
  - "Reuse shipped ownership: GameAuthContext.gameId must equal the match's gameId; 403 match_forbidden and 404 match_not_found — do not invent a second ownership scheme"
  - "Seat-scoped view responses contain only the requested seat's hidden fields; public/shared match payloads omit hidden state"
  - "Turn designation and turn submission only through the match-authority handlers; reject wrong-seat and illegal turns with a structured error; no force/rewrite/admin override in this initiative"
  - "Move log is append-only: writes only as a side effect of an accepted turn; no update, delete, or replace APIs; table writes confined to the authority Lambda IAM"
  - "Move log stores public-to-owning-game records only (seat, sequence, opaque legal-move payload); hidden state is not written to the log"
  - "Seats and match records store no player PII and no player/host authn fields"
  - "Do not log hidden-view payloads or SDK keys"
  - "Integrator contract (extends #13): production SDK keys stay off player-facing game packs"
  - "Signed result verification/crypto is not designed or exposed in this initiative"
requirements:
  - "Every new seats/turns/hidden-views/move-log route uses requireGameAuth; no player or host authentication is added"
  - "Every new match-state read or write applies the same gameId ownership check as GET /v1/matches/:matchId"
  - "A response for a named seat's hidden view must not include another seat's private fields"
  - "Public/shared views, errors, and operator logs must not include hidden-view payloads"
  - "Turnur rejects a turn that is not the current seat's (including when no seat is designated); there is no API or store path that appends or edits moves while skipping that check"
  - "The move log has no update/delete/replace interface; history is not client-rewritable"
  - "The move log must not store hidden-state snapshots or other-seat private fields"
  - "Match state stores no player PII (names, emails, auth subjects, government IDs, or equivalent)"
  - "Callers remain game SDK key only (game-trusted seat selection); this initiative does not add seat capability tokens"
  - "This initiative does not add signed-result issuance, verification, or crypto"
open_questions: []
---

HLD security notes for match-authority-primitives. Authn remains requireGameAuth (SDK key). Seat selection is game-trusted. Match ownership reuses shipped 403 match_forbidden / 404 match_not_found. Move log is public to the owning game; hidden state lives only in seat-scoped views. Signed result is out of scope.
