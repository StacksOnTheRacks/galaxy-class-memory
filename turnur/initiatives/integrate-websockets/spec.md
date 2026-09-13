---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-12
summary: "Add an optional WebSocket notify channel beside the shipped HTTP match-authority API. Successful mutations fan out match events to connections subscribed by the owning game. HTTP request/response remains the source of truth; no new mutation semantics; no hidden-view bodies and no move payload on the wire."
approach: "Add an API Gateway WebSocket API to TurnurApiStack alongside the existing HTTP API (no RiffSync chat or SFU copy). $connect reads ?token= and runs the same hash-then-lookup as requireGameAuth; deny the handshake with HTTP 401 (connection never opens). $disconnect deletes the ConnectionRegistry row. After connect, the client sends { action: subscribe, matchId } on $default; verify MatchRegistry ownership (gameId match); store matchId on the row. After a successful HTTP mutation write, publish-match-event PostToConnection to all connections on (gameId, matchId); delete on 410. Fanout is best-effort: HTTP 201/200 is unchanged if publish fails. Event envelope { type, matchId, at } plus public HTTP fields only. move.accepted has no payload (mirrors shipped POST /moves 201). view.updated is seatId only. Extend @turnur/sdk with createTurnurWsClient({ wsUrl, apiKey }); HTTP client unchanged. v1 WS client is a server-side integrator (Riffle play-lab orchestrator); do not design a browser WS path as a v1 requirement."
interfaces:
  - "WSS $connect?token=<sdk-key> — same SDK key format as HTTP Bearer — $connect Lambda returns HTTP 401 on missing (game_auth_required) or invalid (game_auth_invalid) token; API Gateway denies the handshake; connection never opens; no ConnectionRegistry row; not a WebSocket close frame"
  - "Client → server on $default: { action: subscribe, matchId } → { ok: true } or { ok: false, code, message, hint } with code match_not_found | match_forbidden | invalid_request (same codes/shape as HTTP match errors)"
  - "Unknown $default action or malformed subscribe → { ok: false, code: invalid_request, message, hint }; connection stays open; no mutation"
  - "Server → client envelope { type, matchId, at } where at is ISO-8601 publish time (not a rename of HTTP createdAt)"
  - "Server → client push seat.created — { type, matchId, at, seatId, currentSeat } after POST /v1/matches/{matchId}/seats 201 { seatId, currentSeat } (shipped currentSeat is null on create; mirror HTTP, do not invent a live cursor)"
  - "Server → client push turn.designated — { type, matchId, at, currentSeat } after PUT /v1/matches/{matchId}/turn 200 { currentSeat }"
  - "Server → client push move.accepted — { type, matchId, at, seq, seatId, createdAt, currentSeat } after POST /v1/matches/{matchId}/moves 201. Public fields are exactly the HTTP 201 body. No payload. createdAt is the move-log field from HTTP. at is the envelope timestamp in addition to createdAt. Clients that need payload use GET /v1/matches/{matchId}/moves"
  - "Server → client push view.updated — { type, matchId, at, seatId } after PUT /v1/matches/{matchId}/seats/{seatId}/view 200 { seatId } — no view JSON"
  - "Shipped HTTP routes unchanged (12 routes today); WebSocket is notify-only — no moves, turns, or view writes on WS"
  - "@turnur/sdk — createTurnurWsClient({ wsUrl, apiKey }) — connect with ?token= — subscribe(matchId) — onEvent(callback). createTurnurClient HTTP surface unchanged"
structure:
  - "TurnurApiStack — add WebSocketApi (apigwv2.WebSocketApi, construct id WebSocketApi) + WebSocketStage (construct id WebSocketStage, stageName $default) beside existing HttpApi; routes $connect, $disconnect, $default only"
  - "lambda/ws-connect-handler.ts — WsConnectFn — read queryStringParameters.token; authenticate via shared hash-then-lookup (extract authenticateSdkKey from requireGameAuth or a sibling); 200 persist ConnectionRegistry { connectionId, gameId, matchId absent, connectedAt }; 401 deny handshake"
  - "lambda/ws-disconnect-handler.ts — WsDisconnectFn — DeleteItem ConnectionRegistry PK connectionId; ignore missing row"
  - "lambda/ws-message-handler.ts — WsMessageFn — $default; subscribe only; MatchRegistry GetItem ownership (same match_not_found / match_forbidden as HTTP); UpdateItem matchId + GSI gameId#matchId; one matchId per connection (resubscribe updates after ownership check; same matchId is idempotent { ok: true })"
  - "ConnectionRegistry DynamoDB — construct id ConnectionRegistry — PK connectionId (S); attributes gameId, matchId (nullable until subscribe), connectedAt; GSI gameIdMatchId (PK gameId#matchId S, SK connectionId S) for fanout Query"
  - "lib/ws/publish-match-event.ts — publishMatchEvent({ gameId, matchId, event }) — Query GSI gameId#matchId; ApiGatewayManagementApi PostToConnection per connectionId; on GoneException/410 DeleteItem that row; catch/log other errors; no-op if CONNECTION_REGISTRY_TABLE_NAME or WEBSOCKET_MANAGEMENT_ENDPOINT unset (keeps existing HTTP handler tests green until wired)"
  - "Mutation handlers call publishMatchEvent after successful write, then return today's HTTP body — matches-seats (POST only), matches-turn (PUT only), matches-moves (POST only), matches-view (PUT only). GET routes do not publish. Await fanout with try/catch so Lambda does not freeze mid-post; still return HTTP success if fanout fails"
  - "IAM — WsConnectFn/WsDisconnectFn/WsMessageFn: GameRegistry GetItem + ConnectionRegistry Put/Update/Delete + MatchRegistry GetItem (message). Mutation handlers that publish: ConnectionRegistry Query+Delete on table+GSI, execute-api:ManageConnections on the WebSocket API"
  - "Env — GAME_REGISTRY_TABLE_NAME (connect); MATCH_REGISTRY_TABLE_NAME (message); CONNECTION_REGISTRY_TABLE_NAME; WEBSOCKET_MANAGEMENT_ENDPOINT=https://{apiId}.execute-api.{region}.amazonaws.com/$default (publishers)"
  - "Stack outputs — WebSocketApiUrl (wss://…/$default), ConnectionRegistryTableName, ConnectionRegistryTableArn. HttpApiUrl and existing table outputs unchanged"
  - "Suggested LLD slice order (not tickets): (1) ConnectionRegistry + GSI + outputs + $connect/$disconnect auth persist/delete (2) $default subscribe + ownership error codes (3) publish-match-event + 410 delete + wire one mutation (POST seats) (4) remaining publishers turn/moves/view (5) @turnur/sdk createTurnurWsClient (6) infra/cdk README: WebSocketApiUrl, $connect token carve-out, server-side key, play-lab orchestrator, event catalog, HTTP authority, best-effort fanout, no CORS"
constraints:
  - "HTTP authority unchanged — mutations and reads stay on existing HTTP routes; WebSocket does not accept moves, turns, or view writes"
  - "Game-auth only via SDK key on $connect query token; no player or host authentication on WebSocket"
  - "$connect deny is API Gateway handshake 401, not a WebSocket close. Denied connects never reach $default or $disconnect"
  - "No hidden-view bodies, no move payload, and no cross-seat private fields on push payloads. move.accepted mirrors POST /moves 201 keys only. Payload remains HTTP GET /v1/matches/{matchId}/moves"
  - "Publish is after successful write and best-effort — HTTP 201/200 is the success contract even if fanout fails or no subscribers exist"
  - "WebSocket handshake is not subject to browser CORS; v1 does not enforce Origin. Query ?token= is a leak surface (proxy/API Gateway logs, process lists). Do not log token values. Integrator README: production keys stay server-side (#13); $connect query token is the WS carve-out of the current 'no query-string keys' HTTP rule, not a new HTTP pattern"
  - "v1 WS client is server-side. Riffle play-lab holds TURNUR_SDK_KEY in the runtime orchestrator and must never put it in the lab page or /play iframes. Do not design a browser WS path as a v1 requirement"
  - "Not realtime or action gameplay; not a second mutation path"
  - "Examine slice — ADR for push channel deferred (ws-adr-lock). Do not treat this HLD as locking WebSocket transport"
  - "Do not copy RiffSync chat WebSocket, SFU, or presence stacks"
  - "Connection limits deferred (ws-connection-limits); no max pinned this HLD"
  - "Typical attach flow is HTTP POST /v1/matches then subscribe — matchId is server-generated; v1 catalog does not emit match.created"
open_questions: []
---

<!--
HLD expansion (not validated). Slice into ticket tech-spec comments at LLD /forge.refinement — do not post from this event.
-->

Shipped baseline: HTTP match authority (#29–#35 Done). Twelve HTTP routes, four DynamoDB tables, in-handler requireGameAuth. No WebSocket infrastructure in `turnur/infra/cdk` today (`TurnurApiStack` is HTTP API only). `@turnur/sdk` is HTTP-only (`createTurnurClient`). Riffle play lab polls turn.get and moves.list after every mutation — operator evidence that HTTP-only is too slow for seated play. Play-lab WS consumption, when added, is the **server-side orchestrator** (process-held `TURNUR_SDK_KEY`), not the browser.

**$connect deny (API Gateway WebSocket handshake).**

`$connect` is the HTTP Upgrade. The Lambda returns an HTTP status to API Gateway:

- Missing `token` query param → **401** `{ code: game_auth_required, message, hint }` — same code as missing `Authorization` on HTTP.
- Empty / wrong format / unknown hash → **401** `{ code: game_auth_invalid, message, hint }` — same as HTTP invalid Bearer.
- Valid key → **200**, PutItem ConnectionRegistry, handshake completes.

API Gateway then **refuses the WebSocket upgrade** on non-200. The client sees a failed handshake (HTTP 401). The socket is never open, so this is **not** a close code (1008 / 4401 / etc.) and **`$disconnect` does not run**. Do not persist a registry row on deny. Handshake response bodies are best-effort for clients that surface them; the SDK treats a failed open as a connect error, not `onEvent`.

Reuse `hashSdkKey` + GameRegistry `GetItem(PK=keyHash)`. Extract a shared `authenticateSdkKey(token)` so HTTP Bearer and WS query token stay one lookup. Do not add player/host auth.

**Subscribe (`$default`).**

Already-authenticated connection. Message `{ action: subscribe, matchId }`.

| Condition | Reply (JSON on the open socket, not HTTP) |
| --- | --- |
| MatchRegistry miss | `{ ok: false, code: "match_not_found", message, hint }` |
| `MatchRegistry.gameId !==` connection `gameId` | `{ ok: false, code: "match_forbidden", message, hint }` |
| Missing/empty `matchId`, unknown `action`, non-JSON | `{ ok: false, code: "invalid_request", message, hint }` |
| Ownership OK | `{ ok: true }` — set `matchId`, GSI `gameId#matchId` |

Codes and `{ code, message, hint }` match HTTP match errors. Subscribe is the only accepted action. A move/turn/view message on `$default` is `invalid_request` and must not write match state.

**Envelope and event catalog (v1).**

Every push: `{ type, matchId, at, ...publicHttpFields }`.

- `type` — one of the four below.
- `matchId` — the match the subscriber attached to.
- `at` — ISO-8601 **envelope** timestamp at publish time. **Not** a rename of HTTP `createdAt`. `move.accepted` carries **both** `at` and `createdAt`.

| HTTP mutation (success only) | `type` | Fields after the envelope |
| --- | --- | --- |
| POST `/v1/matches/{matchId}/seats` 201 `{ seatId, currentSeat }` | `seat.created` | `seatId`, `currentSeat` (shipped create always returns `currentSeat: null`) |
| PUT `/v1/matches/{matchId}/turn` 200 `{ currentSeat }` | `turn.designated` | `currentSeat` |
| POST `/v1/matches/{matchId}/moves` 201 `{ seq, seatId, createdAt, currentSeat }` | `move.accepted` | `seq`, `seatId`, `createdAt`, `currentSeat` — **no `payload`**. SCM tests assert `Object.keys(body) === ['seq','seatId','createdAt','currentSeat']` and `not.toHaveProperty('payload')`. Payload stays on HTTP GET `/v1/matches/{matchId}/moves`. |
| PUT `/v1/matches/{matchId}/seats/{seatId}/view` 200 `{ seatId }` | `view.updated` | `seatId` only — **no view JSON** |

Do not publish on GET, 4xx, or 5xx. Do not query `VIEW#` items in the publish module. Do not emit `match.created` — `matchId` is server-generated on POST `/v1/matches`; typical flow is HTTP 201 then subscribe.

**Publish timing (best-effort).**

1. Mutation handler completes its DynamoDB write (today's success path).
2. Build today's HTTP response body.
3. `await publishMatchEvent(...)` inside try/catch (so the Lambda does not freeze before posts flush).
4. Return the same HTTP 201/200 as today.

If there are no subscribers, PostToConnection throws, or env is unset: **still return HTTP success**. GoneException/410 → delete that connection row, continue other connections. Integrators must treat HTTP as authority; a missed push is recovered by HTTP GET (turn, seats, moves list, view).

**CORS / Origin / token leak.**

WebSocket Upgrade is not an XHR CORS request. API Gateway WebSocket APIs do not emit `Access-Control-*`. v1 does not check `Origin`. Residual: `wss://…?token=turnur_sk_…` can appear in API Gateway access logs, process lists, and any client that logs the URL. Do not log `queryStringParameters.token`. `infra/cdk/README.md` today says do not pass SDK keys in query strings — document a **`$connect`-only** exception; HTTP routes stay Bearer-only. Production keys remain server-side (#13). Riffle play-lab: orchestrator holds the key; lab page and `/play` iframes never open Turnur WS.

**Out of scope.** Signed result; player/host auth; rooms/chat/media; replacing HTTP routes; hidden-view bodies or move payload on push; connection limits (deferred OQ); realtime gameplay; browser-embedded production WS; WebSocket ADR lock; match.created push.
