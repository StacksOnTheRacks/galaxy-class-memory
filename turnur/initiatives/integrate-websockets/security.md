---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-11
summary: "WebSocket is a read-only notify fanout for the owning game. Auth reuses SDK-key validation on $connect query token. Subscriptions are scoped by gameId and matchId ownership. Push payloads are public match events only; hidden views stay on HTTP seat-scoped GET."
threats:
  - "SDK key in query string logged by proxies, browser history, or referrer headers if misused in player-facing clients"
  - "Cross-game subscription: game A subscribes to game B's matchId and receives events"
  - "Hidden-view leak via push: view.updated or other events include another seat's private view JSON"
  - "Connection flooding: attacker opens many WebSocket connections with a valid or stolen SDK key"
  - "Stale connection registry: PostToConnection fails silently; registry grows without cleanup"
  - "SDK key in browser game pack: production key used for WebSocket from iframe amplifies leak impact (accepted residual of game-trusted integration; extends #13 guidance)"
  - "Push as mutation path: client treats WebSocket event as authoritative without HTTP confirm — stale or spoofed delivery if mis-implemented"
mitigations:
  - "Reuse hash-then-lookup GameRegistry validation on $connect token — same codes as requireGameAuth; no key material in WS close frames, error bodies, or logs"
  - "Subscribe handler verifies MatchRegistry gameId === authenticated gameId before attaching matchId; reject with match_forbidden or match_not_found"
  - "Event schema excludes view bodies — view.updated carries seatId only; seat.created, turn.designated, move.accepted mirror HTTP public response shapes"
  - "Publish module never queries VIEW# items or includes hidden-state fields in push payloads"
  - "On PostToConnection 410 Gone, delete connection row from ConnectionRegistry"
  - "Soft rate limit on $connect per gameId (implementation detail at LLD; defer hard limits to open question)"
  - "Integrator README: production SDK keys server-side only; query token for browser WS is dev/examine guidance; do not embed production keys in player-facing bundles (#13 extension)"
  - "Document that HTTP mutation response remains authoritative; push is best-effort notify"
requirements:
  - "$connect rejects missing or invalid token — connection not usable for subscription"
  - "Subscribe verifies match ownership before storing gameId#matchId on the connection row"
  - "Push payloads must not include hidden-view JSON or cross-seat private fields"
  - "ConnectionRegistry stores connectionId, gameId, matchId only — no player PII"
  - "No player or host authentication added on WebSocket routes"
  - "HTTP requireGameAuth and match ownership rules on existing routes unchanged"
  - "Do not log token query param values or push payload hidden-state snapshots"
open_questions: []
---

HLD security notes for integrate-websockets. WebSocket is notify-only; HTTP remains authority. Auth reuses SDK key on connect query token. Match ownership gate on subscribe. Hidden state stays on HTTP seat-scoped GET.
