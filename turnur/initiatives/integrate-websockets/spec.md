---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-11
summary: "Add an optional WebSocket notify channel beside the shipped HTTP match-authority API. Successful mutations fan out match events to connections subscribed by the owning game. HTTP request/response remains the source of truth; no new mutation semantics; no hidden-view bodies on the wire."
approach: "Add an API Gateway WebSocket API to TurnurApiStack alongside the existing HTTP API (no RiffSync chat or SFU copy). $connect reads token query param and runs the same hash-then-lookup as requireGameAuth; reject invalid connects. $disconnect removes the row from ConnectionRegistry DynamoDB. After connect, the client sends { action: subscribe, matchId } on the $default route; verify MatchRegistry ownership (gameId match); store connectionId, gameId, matchId. After successful HTTP mutation in existing handlers (matches-attach, matches-seats, matches-turn, matches-moves, matches-view), call ApiGatewayManagementApi PostToConnection for all connections on that (gameId, matchId). Event envelope: { type, matchId, at, ... } where type is match.created | seat.created | turn.designated | move.accepted | view.updated. view.updated payload is { seatId } only — no view JSON on push. Swallow 410 Gone on post and delete stale connection rows. Extend @turnur/sdk with optional createTurnurWsClient({ wsUrl, apiKey }) and subscribe(matchId); HTTP client unchanged."
interfaces:
  - "WSS $connect?token=<sdk-key> — same SDK key format as HTTP Bearer — reject missing/invalid token on connect"
  - "Client → server on $default: { action: subscribe, matchId } → { ok: true } or structured error (match_not_found, match_forbidden, invalid_request)"
  - "Server → client push match.created — { type, matchId, at } after POST /v1/matches"
  - "Server → client push seat.created — { type, matchId, at, seatId, currentSeat } after POST /v1/matches/{matchId}/seats"
  - "Server → client push turn.designated — { type, matchId, at, currentSeat } after PUT /v1/matches/{matchId}/turn"
  - "Server → client push move.accepted — { type, matchId, at, seq, seatId, payload, currentSeat } after POST /v1/matches/{matchId}/moves (public fields only; mirrors HTTP 201)"
  - "Server → client push view.updated — { type, matchId, at, seatId } only after PUT /v1/matches/{matchId}/seats/{seatId}/view — no view body"
  - "Shipped HTTP routes unchanged (12 routes today); WebSocket is notify-only"
  - "@turnur/sdk — createTurnurWsClient({ wsUrl, apiKey }) — connect with ?token= — subscribe(matchId) — onEvent(callback)"
structure:
  - "TurnurApiStack — add WebSocket API (ApiGatewayV2 WebSocketApi) with routes $connect, $disconnect, $default"
  - "ws-connect-handler — validate token query param; persist connectionId + gameId in ConnectionRegistry"
  - "ws-disconnect-handler — delete ConnectionRegistry row by connectionId"
  - "ws-message-handler — handle subscribe action; MatchRegistry ownership gate; attach matchId to connection row"
  - "ConnectionRegistry DynamoDB — PK connectionId; attributes gameId, matchId (nullable until subscribe), connectedAt; GSI gameIdMatchId (PK gameId#matchId, SK connectionId) for fanout lookup"
  - "publish-match-event.ts — shared module: query GSI by gameId#matchId; PostToConnection per connectionId; delete on 410"
  - "Mutation handlers — import publish-match-event after successful DynamoDB write (matches-attach, matches-seats, matches-turn, matches-moves, matches-view)"
  - "Stack outputs — WebSocketApiUrl, ConnectionRegistryTableName"
  - "Suggested LLD slice order (not tickets): ConnectionRegistry + connect/disconnect → subscribe message handler → publish from one mutation handler → remaining handlers → SDK WS client → README"
constraints:
  - "HTTP authority unchanged — mutations and reads stay on existing HTTP routes; WebSocket does not accept moves, turns, or view writes"
  - "Game-auth only via SDK key on $connect query token; no player or host authentication on WebSocket"
  - "No hidden-view bodies or cross-seat private fields on push payloads"
  - "Not realtime or action gameplay; not a second mutation path"
  - "Examine slice — ADR for push channel deferred until this HLD exits"
  - "Do not copy RiffSync chat WebSocket, SFU, or presence stacks"
  - "Production SDK keys stay server-side per integrator contract (#13); query token is browser-friendly but increases leak surface if misused"
open_questions: []
---

<!--
HLD expansion (not validated). Slice into ticket tech-spec comments at LLD /forge.refinement — do not post from this event.
-->

Shipped baseline: HTTP match authority (#29–#35 Done). Twelve HTTP routes, four DynamoDB tables, in-handler requireGameAuth. No WebSocket infrastructure in code today. Riffle play lab polls turn.get and moves.list after every mutation — operator evidence that HTTP-only is too slow for seated play.

**Mutation → event mapping.**

| HTTP route | Event type | Push payload (public only) |
| --- | --- | --- |
| POST /v1/matches | match.created | matchId, at |
| POST /v1/matches/{matchId}/seats | seat.created | seatId, currentSeat, at |
| PUT /v1/matches/{matchId}/turn | turn.designated | currentSeat, at |
| POST /v1/matches/{matchId}/moves | move.accepted | seq, seatId, payload, currentSeat, at |
| PUT /v1/matches/{matchId}/seats/{seatId}/view | view.updated | seatId, at (no view body) |

**Connect auth.** Operator confirmed SDK key on $connect query string `?token=turnur_sk_...` — same game-auth contract as HTTP Bearer, browser-friendly for iframe game packs.

**Out of scope.** Signed result; player/host auth; rooms/chat/media; replacing HTTP routes; hidden-view bodies on push; connection limits (deferred OQ); realtime gameplay.
