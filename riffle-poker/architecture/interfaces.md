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
  - "Host → Riffle runtime — POST /v1/hands/deal with Authorization: Bearer <RIFFLE_HOST_API_KEY>; body { matchId, seats: [{ seatId, stack }], buttonSeatId, blinds }; 201 { matchId, seatIds }; no holes; runtime dealHand then game-trusted view.put; 401 unauthorized; 400 invalid_*; 503 turnur_unauthenticated; no CORS; iframe must not call; does not call requireSeatCapability"
  - "Host → Riffle runtime — POST /v1/hands/betting/open with Authorization: Bearer <RIFFLE_HOST_API_KEY>; body { matchId, seats: [{ seatId, stack }], buttonSeatId, blinds } (no holes); 201 { matchId, currentSeat }; game-trusted turn.set then move.create hand_open (public facts only); MUST NOT call requireSeatCapability; no CORS; iframe must not call; second open → 409 betting_already_open"
  - "iframe/test → Riffle runtime — POST /v1/seats/:seatId/actions body { matchId, action } header X-Riffle-Seat-Capability; MUST requireSeatCapability before getClient / legalize / Turnur writes; riffle_play not sufficient; 409 illegal_turn reconciles from moves.list + turn.get"
  - "iframe/test → Riffle runtime — POST /v1/seats/:seatId/actions continues after applyAction when phase is street_complete and street is preflop|flop|turn: game-trusted advanceStreet + move.create street_deal { kind, street, board } + turn.set first postflop actor; iframe/host MUST NOT deal"
  - "iframe/test → Riffle runtime — POST /v1/seats/:seatId/actions continues after applyAction when phase is fold_to_one: game-trusted completeFoldToOne + move.create hand_complete { kind, reason: fold_to_one, winners } (no shownHoles); when phase is showdown_ready: game-trusted showdown + move.create hand_complete { kind, reason: showdown, winners, shownHoles } (still-in seats only); skip turn.set (Turnur PUT cannot designate null); iframe/host MUST NOT complete, reveal, or deal the next hand; Next hand is host POST /v1/hands/deal"
  - "iframe/test → Riffle runtime — GET /v1/table?matchId= public DTO: before hand_open roster + currentSeat only (no stacks/pot/holes/board, no view.get; omit dealer-shoe system seat); after hand_open adds public stack + pot + reconstructed currentSeat; after street_deal also board?: Card[] (length 3|4|5); after hand_complete also completeReason + winners; after showdown hand_complete also shownHoles (still-in only); folded/unshown holes never on public DTO; still no holes via view.get; GET /v1/seats/:seatId/view?matchId= and GET /v1/seats/:seatId/table?matchId= require X-Riffle-Seat-Capability and requireSeatCapability; riffle_play is not sufficient; seat DTO includes only that seat's hole plus shared board; after open seat table may add legalActions only for the capability-bound seat when it is that seat's turn"
  - "Riffle runtime → @turnur/sdk — match create/probe, seats, turns, views, moves; dealer shoe: game-trusted seat.create (one system seat per match) + view.put/get { kind: dealer_shoe, deckRemaining, burns }; never a player HoleView; never on public DTO or move payloads; SDK key server-side only"
internal_boundaries:
  - "iframe UI is untrusted presentation; Riffle runtime is the trust boundary"
  - "Rules library is in-process in runtime; no Turnur I/O from the library itself"
  - "Turnur is match authority; Riffle is not a parallel match engine"
  - "Bootstrap binds match/room attach context only; seat capability binds player↔seat"
  - "Post-redeem riffle_play cookie is match-attach only — not seat authority, not identity, not an SDK key"
  - "Seat capability is verified by SHA-256 ledger lookup (purpose=seat); postMessage may deliver the token but is not authority; riffle_play is never sufficient for the gate"
  - "Hole cards live only in Turnur seat-scoped views; Riffle does not persist HandState or become a parallel match engine"
  - "Betting/street/complete reconstructs HandState in-process from hand_open + action + street_deal + hand_complete moves + player hole views + dealer-shoe view; discard after the request; never persist HandState"
  - "Dealer shoe is a Turnur hidden view on a runtime-created system seat (kind=dealer_shoe). It is not a player hidden view, not public table state, and not a move payload. Public board lives only in street_deal moves (and DTO projection from those moves)."
  - "Public board is shared table state. MUST NOT be stored as a seat hidden view. GET /v1/table MUST NOT view.get player holes or the shoe."
  - "Shown holes are public felt facts on hand_complete (like board on street_deal). Folded/unshown holes stay in player HoleViews only. MUST NOT view.put shown holes onto any player view. GET /v1/table MUST NOT view.get player holes or the shoe — shown holes come from hand_complete."
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
