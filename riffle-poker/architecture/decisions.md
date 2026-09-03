---
doc: architecture.decisions
schema_version: 1
updated: 2026-09-03
active_decisions:
  - "ADR-iframe-embed — Host embed = iframe at Riffle origin; opaque match/room context; identity stays on host"
  - "ADR-rules-in-process — Rules = in-process library in Riffle runtime; SDK key server-side only; path Host→iframe→runtime→rules→@turnur/sdk→Turnur"
  - "ADR-host-seat-capability — Host issues opaque 15m seat capability (player↔match↔seat) via POST /v1/seats/capability/mint (Bearer RIFFLE_HOST_API_KEY); 32-byte CSPRNG, SHA-256 ledger, claims jti/matchId/seatId/playerSubject/iat/exp/purpose=seat; client presents X-Riffle-Seat-Capability; requireSeatCapability verifies before seat-scoped Turnur ops; reusable until expiry; host remints; postMessage is pipe not authority; riffle_play is not sufficient"
  - "ADR-host-iframe-bootstrap — Opaque short-lived bootstrap token; host mints at Riffle via Bearer RIFFLE_HOST_API_KEY; play URL fragment #bt=; 60s one-time redeem; HttpOnly riffle_play cookie 1h for reload; seat capability separate channel; SDK key never in browser; signed-URL / postMessage-only / third-party-cookie session not primary"
  - "ADR-dealer-shoe — Remaining deck+burns persist as Turnur view { kind: dealer_shoe, deckRemaining, burns } on one runtime-created system seat; not a player HoleView; not a public DTO or move field; not a Riffle HandState ledger. Public board is street_deal { street, board } only. Street deal continues the action request. #8."
superseded: []
---
