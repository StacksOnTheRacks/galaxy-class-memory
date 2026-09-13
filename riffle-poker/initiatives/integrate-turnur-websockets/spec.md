---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-12
summary: "Riffle runtime adds an optional server-side Turnur WS subscriber beside the existing HTTP @turnur/sdk client. Play-lab session lifecycle owns subscribe/unsubscribe per matchId. Shared hand modules replace blind post-mutation moves.list + turn.get pairs with event-driven targeted HTTP reads. HTTP mutations and responses remain authoritative."
approach: "New env TURNUR_WS_URL (wss URL from Turnur stack WebSocketApiUrl) alongside TURNUR_BASE_URL + TURNUR_SDK_KEY in turnur/session.ts. When TURNUR_WS_URL is set: after Turnur HTTP auth probe succeeds, create createTurnurWsClient({ wsUrl, apiKey }) (Turnur #48); one long-lived connection per runtime process; resubscribe all active matchIds on reconnect. Match subscription registry (ws-subscription.ts): ensureSubscribed(matchId) called from lab session start and before hand orchestration; tracks last-known currentSeat, highest seq, pending refresh flags. Event→HTTP read matrix (v1 locked): seat.created — use seatId/currentSeat from event when HTTP 201 already returned same; no extra fetch if caller has seatId. turn.designated — use currentSeat from event; skip immediate turn.get; fetch moves.list only when rules path needs full log. move.accepted — use seq/currentSeat/seatId/createdAt from event; fetch moves.list once when payload needed for rules (event has no payload). view.updated — seatId only on wire; GET hidden view for that seat via HTTP. Missed/best-effort push: Turnur fanout is best-effort; after mutation HTTP success, if expected event not observed within short timeout (LLD: ws-event-wait-timeout), fall back to today's poll; never treat push as mutation success. CI/fake Turnur: TURNUR_WS_URL unset; zero behavior change. Scope: play-lab owns subscribe lifecycle and shared orchestration modules in same slice; RiffSync host attach out of scope."
interfaces:
  - "TURNUR_WS_URL env — optional wss://…/$default from Turnur WebSocketApiUrl stack output; when absent WS disabled"
  - "ensureTurnurWsSubscription(matchId) — idempotent subscribe for runtime process; called from lab session start"
  - "waitForMatchEvent(matchId, filter, timeoutMs) — orchestrator await helper (LLD shape); falls back to HTTP poll on timeout"
  - "@turnur/sdk createTurnurWsClient({ wsUrl, apiKey }) — connect with ?token=; subscribe(matchId); onEvent(callback); consumer of Turnur #48"
  - "Turnur push events (v1): seat.created, turn.designated, move.accepted, view.updated — envelope { type, matchId, at, …publicHttpFields } per Turnur integrate-websockets spec"
structure:
  - "src/server/turnur/ws-client.ts — factory + connect/reconnect wrapper around createTurnurWsClient"
  - "src/server/turnur/ws-subscription.ts — per-match subscribe state, event dispatch, last-known cursor/seq"
  - "src/server/turnur/session.ts — extend to hold optional WS client beside HTTP TurnurClient"
  - "src/server/lab/session.ts — call ensureTurnurWsSubscription(matchId) after createMatch in startLabSession"
  - "Refactor poll sites — submit.ts, advance.ts, complete.ts, open.ts, table/public.ts, table/seat.ts — use subscription helper instead of unconditional moves.list + turn.get pairs"
  - "Suggested LLD slice order (not tickets): (1) ws-client + env gate (2) ws-subscription + ensureSubscribed (3) lab session wire-up (4) refactor submit/advance poll paths (5) remaining hand/table poll paths (6) integration test against live Turnur with WS"
constraints:
  - "Server-side only; no browser WebSocket path; play-lab page and /play iframes never import turnur/ws-*"
  - "HTTP authority unchanged; WS notify-only; mutations stay POST/PUT on existing routes"
  - "No hidden-view bodies or move payload from WS events; payload via HTTP moves.list; views via HTTP seat-scoped GET"
  - "Do not log TURNUR_SDK_KEY, ?token=, or full WS connect URL with query string"
  - "Bump @turnur/sdk vendor copy only after Turnur #48 merged; until then HLD references Turnur integrate-websockets spec interface"
  - "TURNUR_WS_URL optional — when unset retain today's HTTP poll paths (CI fake Turnur unchanged)"
  - "Hard dependency: Turnur integrate-websockets #44–#49 must ship before Riffle LLD execution"
  - "Not player-facing realtime UI; not RiffSync host WS; not replacing HTTP client"
open_questions: []
---

<!--
HLD expansion (not validated). Slice into ticket tech-spec comments at LLD /forge.refinement — do not post from this event.
-->

Shipped baseline: Riffle runtime authenticates to Turnur via `turnur/session.ts` (`TURNUR_BASE_URL`, `TURNUR_SDK_KEY`, `createTurnurClient`, HTTP probe via `game.me()`). Play-lab and hand orchestration poll `moves.list` and `turn.get` after mutations in `submit.ts`, `advance.ts`, `complete.ts`, `open.ts`, `table/public.ts`, and `table/seat.ts`. `@turnur/sdk` vendor copy is HTTP-only today — no `createTurnurWsClient`. Turnur sister initiative integrate-websockets (#44–#49) adds WS infrastructure and SDK client.

**Event→HTTP read matrix (v1 locked).**

| Event | Use event fields directly | Still HTTP-fetch |
| --- | --- | --- |
| `seat.created` | `seatId`, `currentSeat` when HTTP 201 already returned same | None if caller already has `seatId` |
| `turn.designated` | `currentSeat` — skip immediate `turn.get` | `moves.list` only when rules path needs full log |
| `move.accepted` | `seq`, `currentSeat`, `seatId`, `createdAt` | **`moves.list` once** when payload needed for rules |
| `view.updated` | `seatId` only | **GET view** for that seat via existing HTTP hidden-view route |

**WS client lifecycle.**

1. Runtime starts; `authenticateTurnurSession()` probes HTTP as today.
2. If `TURNUR_WS_URL` set and HTTP auth OK → `createTurnurWsClient({ wsUrl, apiKey })` connects with `?token=` (server-side only).
3. On lab session start → `ensureTurnurWsSubscription(matchId)` sends `{ action: subscribe, matchId }`.
4. Hand orchestration after HTTP mutation → optionally `waitForMatchEvent` with timeout; on event, apply matrix above; on timeout/miss, fall back to poll.
5. On disconnect → reconnect with backoff (LLD: `ws-reconnect-backoff`); resubscribe all active matchIds.

**Poll reduction target.** Today a seated action path may call both `moves.list` and `turn.get` unconditionally after mutation. With WS, `turn.designated` and `move.accepted` events carry `currentSeat` — skip redundant `turn.get` when event arrives within timeout. `move.accepted` still needs one `moves.list` for payload (Turnur omits payload on push). Qualitative success: play-lab two-seat hand completes with measurably fewer HTTP round-trips vs poll-only baseline.
