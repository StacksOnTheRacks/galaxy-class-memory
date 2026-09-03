---
doc: architecture.constraints
schema_version: 1
updated: 2026-09-03
hard_constraints:
  - "After a match is attached, Turnur is state authority for seats, turns, hidden views, and the move log. Riffle must not become a parallel match engine."
  - "Gameplay and rules live in Riffle Poker. Turnur does not evaluate poker legality."
  - "Identity, chat, rooms, and media stay on the host. Riffle does not own player accounts."
  - "Riffle is a game, not a host, lobby, chat, catalog, or media product."
  - "Riffle is the registered Turnur game; its runtime holds the SDK key. The host never becomes match authority."
  - "Host embeds the play surface as an iframe at Riffle origin; identity stays on the host."
  - "Primary iframe bootstrap is an opaque short-lived token: host mints at Riffle, iframe URL carries the token, runtime redeems for match attach. Primary bootstrap is not postMessage-only, not host-signed URL, and not a third-party cookie session."
  - "Poker rules execute as an in-process library inside Riffle runtime (not in the iframe client; not a separate rules service for this shape)."
  - "Turnur SDK key is held only by Riffle runtime — never in browser/iframe client."
  - "Host-issued seat capability (player↔match↔seat) is verified by Riffle before seat-scoped Turnur reads/writes; separate from bootstrap; postMessage is not seat authority."
  - "Play-lab browser NEVER sees RIFFLE_HOST_API_KEY or TURNUR_SDK_KEY (not in HTML, bundles, cookies, query, fragment, or JSON)."
  - "Play lab does not widen RIFFLE_FRAME_ANCESTORS for this initiative."
  - "Play lab implements the host contract and must not make Riffle a lobby, identity, chat, rooms, or consumer-client product."
soft_constraints:
  - "First host is RiffSync; remain host-agnostic so another host can attach later."
  - "Prefer TypeScript when a stack is chosen, to consume @turnur/sdk without a second language boundary. Not locked."
  - "Defer Riffle runtime hosting / IaC until a slice needs it; rules locus, iframe embed, and bootstrap token path are locked."
  - "Play-surface UI must compose inside a host iframe at both a desktop embed width and a narrow host-panel width; Riffle does not assume full-viewport app chrome."
  - "CI remains fake Turnur; live Turnur is env-configured for lab/manual use only."
out_of_bounds:
  - "Player login, accounts, or identity as a Riffle concern."
  - "Rooms, presence, chat, or a media/SFU plane of its own."
  - "Forking or replacing Turnur."
  - "Inventing a full control-plane or AWS stack at init."
  - "Real-money wagering, cashier, or KYC systems."
  - "Play lab as production lobby, matchmaking, or standalone consumer client."
  - "CI/hosting program for Riffle runtime."
  - "RiffSync attach work (RiffSync remains first product host; play-lab is a first-party harness)."
assumptions:
  - "First-party game, Turnur authority, host-attachable is the working sketch."
  - "Turnur match primitives (SDK key, seats, turns, hidden views, move log) will be consumable by a first-party game."
  - "Iframe bootstrap is settled: opaque short-lived token mint → URL → redeem (ADR-host-iframe-bootstrap)."
  - "Seat capability LLD locked on #3: mint via Bearer RIFFLE_HOST_API_KEY; opaque 32-byte token (SHA-256 stored); claims jti/matchId/seatId/playerSubject/iat/exp=iat+900/purpose=seat; header X-Riffle-Seat-Capability; reusable until expiry; no refresh/revocation list; riffle_play is not sufficient."
  - "Bootstrap LLD locked on #1: mint via Bearer RIFFLE_HOST_API_KEY; opaque 32-byte token (SHA-256 stored); claims jti/matchId/iat/exp=iat+60/purpose=bootstrap; play URL fragment #bt=; one-time redeem; HttpOnly riffle_play cookie 1h (SameSite=Lax, match attach only)."
  - "Betting reconstruction LLD locked on #7: host POST /v1/hands/betting/open writes turn + public hand_open move; player POST /v1/seats/:seatId/actions is capability-gated; runtime reconstructs HandState from move log + views and discards it; no Riffle HandState ledger."
  - "Public board LLD locked on #8: remaining deck+burns persist as Turnur hidden view { kind: dealer_shoe, deckRemaining, burns } on one runtime-created system seat (not a player HoleView; not on PublicTable/SeatTable or move payloads; not a Riffle HandState ledger). PublicTable/SeatTable add board?: Card[] after street_deal. Street deal continues POST /v1/seats/:seatId/actions after applyAction when phase is street_complete on preflop/flop/turn (game-trusted advanceStreet + public street_deal + turn.set). iframe/host do not deal. GET /v1/table still MUST NOT view.get."
  - "Hand-complete LLD locked on #9: same POST /v1/seats/:seatId/actions continues after applyAction when phase is fold_to_one (completeFoldToOne) or showdown_ready (showdown). Persist public hand_complete { kind, reason, winners, shownHoles? }. shownHoles only on showdown (still-in seats); fold-to-one reveals no holes. Reconstruct from the move log; no Riffle HandState ledger. GET /v1/table still MUST NOT view.get. After complete: DTO currentSeat is null, pot awarded in reconstructed stacks, no legalActions; skip turn.set. Next hand is host POST /v1/hands/deal, not this ticket."
  - "Runtime hosting undecided (non-blocking while iframe + in-process library + server-side SDK key hold)."
  - "Host-facing POST /v1/matches wraps client.match.create(); lab page talks only to /v1/lab/*; synthetic playerSubject lab:{seatId}; fixed two-seat play-chip defaults (exact numbers LLD); /play accepts capability postMessage as pipe only."
---
