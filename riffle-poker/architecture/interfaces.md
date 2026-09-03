---
doc: architecture.interfaces
schema_version: 1
updated: 2026-09-03
external_interfaces:
  - "Host → Riffle runtime — POST /v1/bootstrap/mint with Authorization: Bearer <RIFFLE_HOST_API_KEY>; body { matchId }; returns { token, playUrl, expiresIn: 60, jti }"
  - "Host → iframe — Riffle-origin play URL {RIFFLE_PUBLIC_ORIGIN}/play#bt={token} (fragment, never query); no SDK key; not seat authority"
  - "iframe → Riffle runtime — POST /v1/bootstrap/redeem { token } → match attach + Set-Cookie riffle_play; GET /v1/bootstrap/session for reload; table API (same-origin)"
  - "Host → Riffle runtime — POST /v1/seats with Authorization: Bearer <RIFFLE_HOST_API_KEY>; body { matchId }; 201 { seatId, currentSeat }; POST /v1/seats/list same auth/body → 200 { seats: [{ seatId, createdAt }], currentSeat }; 401 unauthorized; 400 invalid_match_id; 503 turnur_unauthenticated; no player ids; no CORS; iframe must not call; currentSeat stays null; does not call requireSeatCapability"
  - "Host → Riffle runtime — POST /v1/seats/capability/mint with Authorization: Bearer <RIFFLE_HOST_API_KEY>; body { matchId, seatId, playerSubject }; 200 { token, expiresIn: 900, jti }; 401 unauthorized; 400 invalid_match_id | invalid_seat_id | invalid_player_subject; no CORS; not called from the iframe"
  - "iframe/test → Riffle runtime — header X-Riffle-Seat-Capability: <token> on seat-scoped requests; POST /v1/seats/capability/probe is the #3 stub (calls requireSeatCapability only; no Turnur)"
  - "Riffle runtime → @turnur/sdk — match create/probe, seats, turns, views, moves; SDK key server-side only"
internal_boundaries:
  - "iframe UI is untrusted presentation; Riffle runtime is the trust boundary"
  - "Rules library is in-process in runtime; no Turnur I/O from the library itself"
  - "Turnur is match authority; Riffle is not a parallel match engine"
  - "Bootstrap binds match/room attach context only; seat capability binds player↔seat"
  - "Post-redeem riffle_play cookie is match-attach only — not seat authority, not identity, not an SDK key"
  - "Seat capability is verified by SHA-256 ledger lookup (purpose=seat); postMessage may deliver the token but is not authority; riffle_play is never sufficient for the gate"
contracts_in_flight: []
ownership:
  - "Riffle owns bootstrap mint/redeem, seat-capability mint/verify, runtime, rules library, and Turnur game credentials"
  - "Host owns identity, room, mint call, iframe embed, and seat capability issuance"
  - "Turnur owns seats, turns, hidden views, and the move log"
---

<!--
Authoring (not validated):
- Frontmatter is source of truth; body is expansion-only.
- Bump updated when any frontmatter field changes. Empty body OK at init.
-->
