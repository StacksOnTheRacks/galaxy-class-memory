---
doc: security.threat_model
schema_version: 1
updated: 2026-09-12
assets:
  - "Seat-scoped hidden hole cards / hidden views (except legal showdown reveal)"
  - "Match state — seats, stacks, pot, board, turn, move log (play chips; no cash)"
  - "Riffle play session — account and anonymous (first-party; bearer-only; no ambient cookie)"
  - "Embed attach locator — shared play URL (not seat authority)"
  - "WebSocket subscribe credentials and topic ACLs"
  - "In-process NLHE rules authority on the Riffle runtime"
  - "Host embed allowlist (frame-ancestors / registered host origins)"
  - "Historical residual — RIFFLE_HOST_API_KEY, bootstrap tokens, seat-capability tokens (frozen; do not extend)"
trust_boundaries:
  - "Player browser and Riffle-origin play iframe — untrusted UI; presentation only"
  - "Host page (RiffSync first) — owns host identity, chat, rooms, media; untrusted for match writes and, by default, seat grants"
  - "Riffle server runtime — sole match authority, rules evaluator, hidden-view issuer, WS notify owner"
  - "Identity — first-party Riffle bearer session; Riffle verifies bearer before seat-scoped ops"
  - "WS notify plane — browser-facing; notify-only; never a second match writer"
  - "Open internet / hostile framers — clickjacking and embed-URL leakage"
threats:
  - "Cross-seat or spectator hole-card leak via REST, WS, errors, cache, or logs"
  - "Iframe or host writes match state or evaluates rules"
  - "Host identity or postMessage used as seat authority without a Riffle session bind"
  - "Shared play URL leaked and treated as a secret/capability"
  - "Hostile framing / clickjacking of the play surface"
  - "Bearer theft via XSS on Riffle origin — JS-readable bearer lets attacker act as victim seat"
  - "Anonymous session fixation on account upgrade; anonymous token theft"
  - "Unauthenticated or over-broad WS subscribe (hidden topics, write channel)"
  - "WS push used as mutation success or hole-card delivery"
  - "Logging of holes, sessions, embed secrets, or host keys"
  - "Play-chip integrity / anonymous grief (illegal action, stack tamper, seat squat)"
  - "Live historical host-key mint after the Turnur pivot"
mitigations:
  - "Runtime-only rules and match writes; host is not match authority"
  - "Riffle bearer session (account or anonymous) is seat authority; host bind is absent by design (ADR-sit-at-table)"
  - "Seat-scoped authorization on HTTP and WS; public payloads omit hidden fields"
  - "Shared play URL is locator/attach only; frame-ancestors allowlist, never *"
  - "Bearer-only session transport — no ambient cookie; CSRF-via-cookie out of scope"
  - "Anonymous token unguessable, not in query; rotate on upgrade"
  - "WS bearer + topic ACL; HTTP mutations authoritative; no hidden views on public topics"
  - "postMessage origin allowlist + closed schema; not authority"
  - "No hole/token/host-key logging; no real-money rails"
  - "Do not extend host API key / seat-capability for new work"
open_questions:
  - "anonymous-upgrade-fixation, embed-frame-ancestors, ws-subscribe-auth, host-spoofing-embed — see initiative security.md"
---
