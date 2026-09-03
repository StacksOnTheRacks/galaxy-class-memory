---
doc: architecture.interfaces
schema_version: 1
updated: 2026-09-02
external_interfaces:
  - "Host → Riffle runtime — POST /v1/bootstrap/mint with Authorization: Bearer <RIFFLE_HOST_API_KEY>; body { matchId }; returns { token, playUrl, expiresIn: 60, jti }"
  - "Host → iframe — Riffle-origin play URL {RIFFLE_PUBLIC_ORIGIN}/play#bt={token} (fragment, never query); no SDK key; not seat authority"
  - "iframe → Riffle runtime — POST /v1/bootstrap/redeem { token } → match attach + Set-Cookie riffle_play; GET /v1/bootstrap/session for reload; table API (same-origin)"
  - "Host → Riffle runtime — seat capability (player↔match↔seat); verify before seat-scoped ops (separate from bootstrap)"
  - "Riffle runtime → @turnur/sdk — match create/probe, seats, turns, views, moves; SDK key server-side only"
internal_boundaries:
  - "iframe UI is untrusted presentation; Riffle runtime is the trust boundary"
  - "Rules library is in-process in runtime; no Turnur I/O from the library itself"
  - "Turnur is match authority; Riffle is not a parallel match engine"
  - "Bootstrap binds match/room attach context only; seat capability binds player↔seat"
  - "Post-redeem riffle_play cookie is match-attach only — not seat authority, not identity, not an SDK key"
contracts_in_flight:
  - "Seat-capability token schema (claims, issuer, crypto, TTL) — LLD; pattern locked"
ownership:
  - "Riffle owns bootstrap mint/redeem, runtime, rules library, and Turnur game credentials"
  - "Host owns identity, room, mint call, iframe embed, and seat capability issuance"
  - "Turnur owns seats, turns, hidden views, and the move log"
---

<!--
Authoring (not validated):
- Frontmatter is source of truth; body is expansion-only.
- Bump updated when any frontmatter field changes. Empty body OK at init.
-->
