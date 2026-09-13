---
doc: architecture.interfaces
schema_version: 1
updated: 2026-09-12
external_interfaces:
  - "Historical (shipped Turnur-backed) — Host → Riffle runtime POST /v1/matches, /v1/bootstrap/mint, /v1/seats/capability/mint, /v1/hands/deal, /v1/hands/betting/open with Bearer RIFFLE_HOST_API_KEY; iframe bootstrap redeem; X-Riffle-Seat-Capability; Riffle runtime → @turnur/sdk. Do not extend for new work."
  - "Current-focus (TBD in standalone-play-and-embed HLD) — standalone auth (account + anonymous); Riffle-owned match CRUD; table WebSocket subscribe; embed-mode iframe link; host embed contract for RiffSync"
internal_boundaries:
  - "Play surface UI is presentation; Riffle runtime is the trust boundary for rules and match writes"
  - "Rules library is in-process; no I/O from the library itself"
  - "Hole cards live in seat-scoped hidden state; public board is shared table state"
  - "Turnur integration in shipped code is historical — migration TBD"
contracts_in_flight:
  - "standalone-play-and-embed — identity, anonymous session, embed link, WS protocol (HLD)"
ownership:
  - "Riffle owns gameplay, rules, match state, WebSocket notify, and play identity (account/anonymous) for new work"
  - "Host owns chat, rooms, media, and room identity in embed-mode"
  - "Turnur mothballed — no new ownership on Turnur side"
---
