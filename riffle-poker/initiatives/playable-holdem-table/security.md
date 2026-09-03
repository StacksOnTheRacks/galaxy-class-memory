---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-02
summary: "HLD security for an iframe-embedded no-limit Hold'em table: poker rules and Turnur SDK calls run in the Riffle server runtime; the iframe is presentation only. Production Turnur SDK keys never reach the iframe or host. Hole cards stay in Turnur seat-scoped hidden views and are delivered only to the client bound to that seat. Host owns identity; Riffle verifies a host-issued seat capability before any seat-scoped Turnur read/write. Play chips only — no real-money threat model. Inherits Turnur baseline: requireGameAuth, game-trusted seats, hidden views absent from the move log, production keys off player-facing clients."
threats:
  - "SDK key leak to iframe/client/host: a production Turnur SDK key embedded in iframe JS, host packs, or browser storage lets any caller act as the Riffle game for every seat on every match (Turnur residual: game-trusted seat amplification)"
  - "Hole-card cross-seat leak: seat A's hole cards appear in seat B's UI, shared/public match payloads, WebSocket/broadcast fanout, error bodies, or CDN-cached responses"
  - "Host/iframe postMessage spoofing: a malicious parent, sibling frame, or injected script forges host→embed messages (session, seat assignment, move intent) because origin/schema/auth on postMessage is missing or weak"
  - "Player forging another seat's moves: without a verified host player↔seat binding, a seated player (or anyone who can hit the Riffle server) induces the runtime to submit Turnur turns or fetch hidden views for a different seat"
  - "CSRF / clickjacking of the embed: a hostile page frames the Riffle surface or triggers cookie-authenticated mutations so the victim's session acts without intent"
  - "Logging or telemetry of hidden cards: hole cards or full hidden-view payloads land in Riffle logs, APM, analytics, client error reporters, or support dumps"
mitigations:
  - "Turnur SDK key exists only on the Riffle server runtime; iframe and host never receive production keys; all Turnur SDK traffic originates server-side"
  - "Poker rules execute in-process on that same server runtime; the iframe does not evaluate authority or call Turnur as the game"
  - "Seat-scoped hole cards: Riffle fetches Turnur hidden views only for the capability-bound seat and returns only that seat's private fields to that client; public/shared table state omits hole cards"
  - "Move log and public streams never include hidden-view snapshots or other-seat private fields (Turnur contract + Riffle must not re-inject them)"
  - "postMessage: allowlist event.origin to registered host origins; typed message schema; ignore unsigned/unknown types; do not treat postMessage alone as seat authority"
  - "Host-issued seat capability: short-lived token (or equivalent) binding host player subject ↔ matchId ↔ seatId, verified by Riffle server before hidden-view reads and turn submits; reject missing/expired/wrong-seat capabilities"
  - "Embed framing: CSP frame-ancestors (and/or equivalent) restricted to allowlisted host origins; deny default open framing"
  - "Mutating iframe→Riffle APIs require an authenticated, origin-checked channel (SameSite cookies and/or CSRF token / Fetch metadata); no ambient cross-site mutation"
  - "Do not log, sample, or export hole cards, hidden-view payloads, or SDK keys (errors, metrics, client reporters included)"
  - "Play chips only: no cashier, KYC, or real-money payment surfaces in this initiative's threat model"
requirements:
  - "Production Turnur SDK keys MUST NOT ship in iframe bundles, host client code, public env, or browser-accessible config"
  - "Only the Riffle server runtime may call Turnur with requireGameAuth; iframe clients MUST NOT hold game credentials"
  - "Before any seat-scoped Turnur operation (hidden view read, turn submit for a seat), Riffle MUST verify a host-issued capability for that matchId+seatId and the current host player binding"
  - "A response or push to a client MUST NOT include another seat's hole cards or hidden fields"
  - "Riffle MUST NOT write hole cards or hidden-view payloads into logs, move-facing UI dumps, analytics, or error reports"
  - "postMessage handlers MUST enforce an allowlisted origin and a closed message schema; spoofed or cross-origin messages MUST be dropped"
  - "The embed MUST set CSP frame-ancestors (or equivalent) to registered host origins only"
  - "Cross-site framing or CSRF MUST NOT be able to submit moves or fetch hole cards for a victim session"
  - "This initiative does not add Riffle-owned player identity, real-money rails, or a second match authority beside Turnur"
open_questions:
  - "Seat-capability token schema (claims, issuer, signature/MAC, TTL, refresh, revocation) — HLD locks the pattern; concrete format is LLD"
---

<!--
Authoring (not validated):
- Security-owned HLD notes. Required sign-off before HLD → LLD.
- Bump updated when any frontmatter field changes.
-->

HLD security for playable-holdem-table. Trust boundary: host (identity) | iframe (untrusted UI) | Riffle server runtime (rules + SDK key) | Turnur (match authority). Residual: a compromised Riffle server key still amplifies to all seats (accepted Turnur game-trust model); mitigate by keeping the key off every player-facing surface and binding seats via host capabilities before use.
