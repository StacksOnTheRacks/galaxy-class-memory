---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-12
summary: "WS is a server-side notify channel only. TURNUR_SDK_KEY stays in the Riffle runtime process; play-lab browser and iframes never receive key or WS URL. Push events carry public match fields only; hole cards and move payloads always via HTTP seat-scoped reads. HTTP mutation responses remain authoritative."
threats:
  - "SDK key exposure via browser WebSocket or lab HTML/JSON — extends play-lab hard constraint that browser NEVER sees TURNUR_SDK_KEY"
  - "Query-token logging on server WS connect — ?token= visible in process logs, proxy logs, or error dumps is a live SDK key"
  - "Push treated as authority — stale, missed, or reordered notify causes wrong hand state if orchestrator skips HTTP confirm"
  - "Cross-seat hidden-view leak — integrator reads view JSON from WS push instead of HTTP seat-scoped GET (Turnur forbids view body on wire; Riffle must not assume otherwise)"
  - "WS URL or SDK key echoed in lab API error responses or session JSON to the browser"
  - "Move payload inferred from WS — rules code trusts push fields beyond public HTTP 201 keys and skips moves.list when payload is required"
mitigations:
  - "WS client instantiated only under src/server/turnur/*; never imported by client bundle, lab page, or /play iframe code paths"
  - "Lab API responses (session start, deal, errors) MUST NOT include TURNUR_WS_URL, raw WS events, SDK key, or connect URL with token"
  - "On view.updated, fetch hidden view via HTTP GET for that seatId only; never parse view JSON from push"
  - "On move.accepted, fetch payload via HTTP moves.list when rules need it; never expect payload on push (Turnur contract)"
  - "After HTTP mutation, confirm success from HTTP status/body; use push only to reduce follow-up reads, not as mutation success signal"
  - "Do not log connect URL with ?token=; structured logs use matchId, event type, seq only — no key material"
  - "Reuse architecture/constraints.md hard constraints: Turnur SDK key held only by Riffle runtime; play-lab browser NEVER sees RIFFLE_HOST_API_KEY or TURNUR_SDK_KEY"
  - "When TURNUR_WS_URL unset or connect fails, degrade to HTTP poll — no partial WS state without HTTP fallback path"
requirements:
  - "WebSocket client MUST run server-side only; play-lab page and /play iframes MUST NOT open WebSocket or receive TURNUR_WS_URL or SDK key"
  - "Lab session and hand API responses MUST NOT echo TURNUR_WS_URL, WS events, SDK key, or connect URL with query token"
  - "HTTP mutation response remains authoritative; push is best-effort notify; orchestrator MUST fall back to HTTP poll on missed/timeout events"
  - "move.accepted handling MUST NOT assume payload on push; MUST fetch moves.list via HTTP when rules need payload"
  - "view.updated handling MUST fetch hidden view via HTTP seat-scoped GET; MUST NOT read view JSON from push"
  - "Structured logs MUST NOT contain TURNUR_SDK_KEY, ?token=, keyHash, or full WS connect URL with query string"
  - "WS modules MUST NOT be importable from client bundle or lab page entry points"
  - "Graceful degradation: when TURNUR_WS_URL unset, runtime MUST retain today's poll behavior (CI fake Turnur unchanged)"
  - "Production SDK key MUST stay in runtime process env; query token on WS connect is server-side carve-out of Turnur #13 pattern, not a browser pattern"
open_questions:
  - "ws-reconnect-backoff"
  - "ws-event-wait-timeout"
---

<!--
HLD security for integrate-turnur-websockets. Sister Turnur spec defines server-side WS and query-token risks. Riffle consumer obligations: server-only client, no key/URL in browser, HTTP authority, no payload/view from push, poll fallback. LLD details reconnect backoff and event-wait timeout in open-questions.md.
-->
