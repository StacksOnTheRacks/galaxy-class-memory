---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-12
summary: "WebSocket is a read-only notify fanout for the owning game. $connect authenticates with the same SDK-key hash-then-lookup as requireGameAuth via ?token=; HTTP remains match authority. Subscribe is gated by MatchRegistry.gameId === authenticated gameId. Push events are public match-notify only: view.updated is seatId only; move.accepted MUST omit payload (shipped HTTP 201 omits it). ConnectionRegistry stores connectionId, gameId, matchId, connectedAt — no player PII. Production SDK keys stay server-side (Riffle play-lab WS is server-only). Query-token residual: API Gateway access logs and CloudWatch must not emit the token."
threats:
  - "Query-token logging: $connect ?token= is visible to API Gateway access logs, execution logs, CloudWatch Lambda event dumps, and any proxy that records the request URL. Turnur is API Gateway WebSocket (no ALB on this path). A logged token is a live SDK key."
  - "Cross-game subscribe: game A presents a valid SDK key, then { action: subscribe, matchId } for a match owned by game B, and receives that match's events"
  - "Hidden-view and payload echo: view.updated or other push events include another seat's VIEW# JSON; move.accepted echoes request payload (current spec listing payload is leak-adjacent vs shipped HTTP 201, which omits payload)"
  - "Connection flooding: a valid or stolen SDK key opens many WebSocket connections (soft $connect rate limit and hard per-gameId/matchId caps are deferred — residual, non-blocking)"
  - "Stale ConnectionRegistry: PostToConnection 410 Gone is ignored; disconnected rows accumulate and later fanout retries waste quota"
  - "Push treated as authority: integrator applies WS events as match state without HTTP confirm — stale, reordered, or missed notify becomes a second mutation path"
  - "Browser/iframe key placement: production SDK key used from a player-facing bundle or Riffle lab/play iframe (sister spec: lab browser NEVER receives TURNUR_SDK_KEY; WS from server-side orchestrator). Query token is examine/dev only; extends #13."
mitigations:
  - "ws-connect-handler runs the same hash-then-lookup as requireGameAuth on the ?token= query param (format regex, SHA-256, GameRegistry GetItem). Reject missing/invalid connect. Never put key material, keyHash, or token in WS close frames, structured errors, or application logs."
  - "API Gateway WebSocket access-log format and CloudWatch/Lambda logging MUST omit query string and token. Do not log the raw $connect event. Turnur has no ALB on this path — do not invent ALB logging. Mechanism (omit access logs vs custom format without query variables) is LLD; see ws-apigw-access-log-redaction."
  - "Subscribe handler loads MatchRegistry by matchId and requires gameId === authenticated gameId before writing matchId onto the connection row. Reject with match_forbidden or match_not_found. Never attach another game's matchId."
  - "Closed event schema. view.updated is { type, matchId, at, seatId } only. move.accepted is { type, matchId, at, seq, seatId, createdAt, currentSeat } — MUST NOT include payload (Board/SCM: POST /moves HTTP 201 omits payload). Publish module never reads VIEW# items and never copies request body payload onto the wire."
  - "On PostToConnection 410 Gone, delete the ConnectionRegistry row by connectionId. $disconnect also deletes by connectionId."
  - "Connection flooding is accepted residual this HLD. ws-connection-limits remains deferred and non-blocking. Do not invent a soft $connect rate limit as a ship gate."
  - "Integrator README (#13 extension): production keys stay on the game/host server; query token is examine/dev; do not embed production keys in player-facing bundles. Riffle play-lab WS MUST be opened by the server-side orchestrator, not the lab browser or /play iframes."
  - "Document HTTP mutation response as authoritative. Push is best-effort notify. WebSocket $default accepts subscribe only — no moves, turns, or view writes."
requirements:
  - "$connect rejects missing or invalid token with the same validation as requireGameAuth. The connection MUST NOT be usable for subscribe. Close frames, error bodies, and logs MUST NOT contain the token, Bearer material, or keyHash."
  - "API Gateway WebSocket access logs, execution logs, and CloudWatch/Lambda logs MUST NOT emit the $connect query string or token value. Do not log the raw connect event."
  - "Subscribe MUST verify MatchRegistry.gameId === authenticated gameId before storing gameId#matchId on the connection row. Cross-game subscribe MUST fail (match_forbidden or match_not_found)."
  - "Push payloads MUST NOT include hidden-view JSON, VIEW# fields, or cross-seat private fields. view.updated MUST be seatId only."
  - "move.accepted MUST NOT include payload. Push fields are type, matchId, at, seq, seatId, createdAt, currentSeat only — matching shipped HTTP 201 (no payload echo)."
  - "ConnectionRegistry stores connectionId, gameId, matchId, connectedAt only — no player PII, no SDK key, no token, no hidden views."
  - "PostToConnection 410 Gone MUST delete that connection row."
  - "WebSocket MUST NOT accept moves, turns, or view writes. HTTP requireGameAuth and match ownership on existing routes MUST remain unchanged. No player or host authentication on WebSocket."
  - "Production SDK keys MUST stay server-side. Query token is examine/dev. Integrator README MUST say: do not embed production keys in player-facing bundles. Riffle play-lab MUST keep TURNUR_SDK_KEY on the server orchestrator; the lab browser MUST NEVER receive it (sister spec)."
  - "HTTP mutation response remains authoritative. Integrators MUST NOT treat push as a second mutation or state-authority path."
open_questions:
  - "ws-apigw-access-log-redaction"
  - "ws-connection-limits"
---

HLD security for integrate-websockets. WebSocket is notify-only; HTTP remains authority. $connect reuses requireGameAuth hash-then-lookup on ?token=. Subscribe is ownership-gated (gameId === MatchRegistry.gameId). Hidden views stay on HTTP seat-scoped GET; view.updated is seatId only. move.accepted MUST omit payload (shipped HTTP 201 omits it). ConnectionRegistry: connectionId, gameId, matchId, connectedAt — no player PII. 410 Gone deletes the row. Query-token residual: API Gateway WS access logs and CloudWatch must not emit the token (redaction mechanism is a non-blocking LLD question). Connection limits deferred, non-blocking. Production keys server-side; Riffle WS is server-orchestrator only. Do not add player/host auth. Do not copy RiffSync chat WebSocket threat model.
