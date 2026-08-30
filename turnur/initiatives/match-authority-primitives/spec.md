---
doc: product.initiative_spec
schema_version: 1
updated: 2026-08-30
summary: "After shipped host attach (#19–#23 Done), Turnur becomes match-state authority for seats, a game-designated turn cursor, seat-scoped hidden views, and an append-only move log. New state lives in dedicated DynamoDB tables — MatchRegistry stays metadata-only. All new routes use requireGameAuth and the same gameId ownership check as GET /v1/matches/{matchId}. The authenticated game designates currentSeat; Turnur does not auto-advance. Signed result is out of scope."
approach: "Keep MatchRegistry (PK matchId → gameId, status, createdAt) as the ownership/metadata table from #19; do not add seats, turns, views, or moves there. Add MatchState (PK matchId, SK sk) for CURSOR { currentSeat, seatOrder }, SEAT#{seatId} { seatId, createdAt }, and VIEW#{seatId} { view }. Add MatchMoveLog (PK matchId, SK seq Number) for append-only entries { seatId, payload, createdAt }; IAM is PutItem + Query only. Every new match-scoped handler calls requireGameAuth, then GetItem MatchRegistry and compares gameId (404 match_not_found / 403 match_forbidden, no metadata on 403). Seats: POST /v1/matches/{matchId}/seats issues server UUID seatId (no player ids); currentSeat stays null until the game designates. GET seats returns public roster + currentSeat, never views. Turns: GET /v1/matches/{matchId}/turn returns { currentSeat }. PUT /v1/matches/{matchId}/turn body { seatId } sets currentSeat (404 seat_not_found). POST /v1/matches/{matchId}/moves body { seatId, payload } — payload is opaque JSON public to the owning game; reject missing seatId/payload with 400 invalid_request, unknown seat with 404 seat_not_found, currentSeat null or seatId !== currentSeat with 409 illegal_turn. On accept, PutItem next seq only — currentSeat is unchanged. Views: game PUTs opaque view per seat; GET returns only that seat (view null if never written). View handler GetItem VIEW#{seatId} only — no Query of VIEW#, no views on probe/seats/turn/moves. Move log GET returns full items[] for this HLD. Callers are game SDK key only (game-trusted seat selection). SDK mirrors all new routes; extend authenticatedPost with optional body and add authenticatedPut. Sequence: storage → seats → turn designate + moves → hidden views → move log read → SDK → docs."
interfaces:
  - "POST /v1/matches/{matchId}/seats — requireGameAuth + MatchRegistry ownership — 201 { seatId, currentSeat }; 401 game_auth_*; 404 match_not_found; 403 match_forbidden"
  - "GET /v1/matches/{matchId}/seats — requireGameAuth + ownership — 200 { seats: [{ seatId, createdAt }], currentSeat }; no hidden views; same 401/403/404"
  - "GET /v1/matches/{matchId}/turn — requireGameAuth + ownership — 200 { currentSeat } (null if none designated); same 401/403/404"
  - "PUT /v1/matches/{matchId}/turn — requireGameAuth + ownership — body { seatId } — 200 { currentSeat }; 400 invalid_request; 404 seat_not_found; 401/403/404 match"
  - "POST /v1/matches/{matchId}/moves — requireGameAuth + ownership — body { seatId, payload } — 201 { seq, seatId, createdAt, currentSeat }; 400 invalid_request; 404 seat_not_found; 409 illegal_turn; 401/403/404 match"
  - "PUT /v1/matches/{matchId}/seats/{seatId}/view — requireGameAuth + ownership — body { view } opaque JSON — 200 { seatId }; 400 invalid_request; 404 seat_not_found; 401/403/404 match"
  - "GET /v1/matches/{matchId}/seats/{seatId}/view — requireGameAuth + ownership — 200 { seatId, view } (view null if unset); 404 seat_not_found; MUST NOT return any other seat's view"
  - "GET /v1/matches/{matchId}/moves — requireGameAuth + ownership — 200 { items: [{ seq, seatId, payload, createdAt }] }; 401/403/404 match"
  - "@turnur/sdk — client.match.seat.create/list, turn.get/set, move.create, view.put/get, moves.list; 400/401/403/404/409 → TurnurApiError"
  - "Shipped unchanged: POST /v1/matches → { matchId }; GET /v1/matches/{matchId} → { matchId, status, createdAt } only; GET /v1/health; GET /v1/game/me"
structure:
  - "MatchRegistry — unchanged metadata + ownership source; no seats/turns/views/moves; status remains created this initiative"
  - "MatchState (new) — PK matchId, SK sk; on-demand; outputs MatchStateTableName/Arn; items CURSOR, SEAT#{seatId}, VIEW#{seatId}"
  - "MatchMoveLog (new) — PK matchId, SK seq Number; on-demand; outputs MatchMoveLogTableName/Arn; PutItem + Query only"
  - "Ownership gate — MatchRegistry GetItem then gameId === auth.context.gameId before any MatchState/MoveLog access"
  - "TurnurApiStack factory — matchStateRead/Write + matchMoveLogRead/Write flags; GameRegistry GetItem + MATCH_REGISTRY_TABLE_NAME for ownership"
  - "New Node 22 Lambdas under infra/cdk/lambda/ — seats, turn, moves, view, move-log — colocated TS + Vitest"
  - "View isolation — view GET/PUT use GetItem/PutItem on VIEW#{seatId} only; no BatchGet/Query of views"
  - "@turnur/sdk — authenticatedPost(body?), authenticatedPut; no apiKey/Authorization logging"
  - "Suggested slice order (not tickets): storage → seats → turn designate + moves → hidden views → move log read → SDK → README"
constraints:
  - "TypeScript / Node 22 / AWS CDK v2 (ADR-001); requireGameAuth in-handler (ADR-002 GameRegistry)"
  - "After attach, Turnur is state authority; host does not become match authority"
  - "No player identity, rooms, chat, or media; seats are seatId only"
  - "Do not overload MatchRegistry (#19 AC: metadata only)"
  - "Game designates currentSeat; Turnur does not auto-advance after an accepted move"
  - "Illegal turn = currentSeat is null or seatId !== currentSeat; Turnur does not execute game rules; payload is opaque and public to the owning game"
  - "Hidden views are seat-scoped; private data belongs in views, not in the move log"
  - "Move log is append-only; no UpdateItem/DeleteItem on MatchMoveLog"
  - "Callers are game SDK key only (game-trusted seat selection); no seat tokens or player callers this HLD"
  - "Signed result out of scope; signing mechanism stays deferred"
  - "Host-agnostic; GET /v1/matches/{matchId} success shape stays { matchId, status, createdAt }"
open_questions: []
---

<!--
HLD expansion (not validated). Slice into ticket tech-spec comments at LLD /forge.refinement — do not post from this event.
-->

Shipped baseline (Board/SCM): game auth #9–#13; host attach #19–#23. `MatchRegistry` stays metadata-only. This initiative adds `MatchState` and `MatchMoveLog`.

**Seats.** `POST` issues `randomUUID()` `seatId`; no request body; no player ids. First seat does not set `currentSeat`. Later seats append to `seatOrder`. No max seats, min-seats-before-play, or start-match route this HLD.

**Turns.** Authority is `currentSeat` only. The game sets it with `PUT /turn`. A move for a seat is accepted only when `seatId === currentSeat`. Accept path: conditional `PutItem` next `seq` (`attribute_not_exists`); `currentSeat` unchanged. Concurrent double-submit against a stale cursor → **409** `illegal_turn`. Extra-turn or skip is the game designating the same or another seat.

**Hidden views.** GET may return only `{ seatId, view }` for the path `seatId`. Missing view → `view: null` (200). Unknown seat → 404 `seat_not_found`. Views must not appear on match probe, seats roster, turn probe, or move log. Isolation is per-response. PUT is a separate write.

**Move log.** Complete match-public history for the owning game (`seq`, `seatId`, `payload`, `createdAt`). Hidden state lives only in views. Full `items[]` this HLD.

**Errors.** Reuse `game_auth_required`, `game_auth_invalid`, `match_not_found`, `match_forbidden`. New: `invalid_request` (400), `seat_not_found` (404), `illegal_turn` (409). Same `{ code, message, hint }` shape.

**Out of scope.** Signed result; player/host auth; rooms/chat/media; game-rule engine; Idempotency-Key; client-supplied `matchId`/`seatId`; list/search matches; WebSockets.
