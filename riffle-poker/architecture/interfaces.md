---
doc: architecture.interfaces
schema_version: 1
updated: 2026-09-12
external_interfaces:
  - "Frozen (historical Turnur-backed) — Host → Riffle runtime POST /v1/matches, /v1/bootstrap/mint, /v1/seats/capability/mint, /v1/hands/deal, /v1/hands/betting/open with Bearer RIFFLE_HOST_API_KEY; iframe bootstrap redeem; X-Riffle-Seat-Capability; Riffle runtime → @turnur/sdk. Do not extend for new work."
  - "Current (standalone-play-and-embed) — first-party Riffle account + anonymous session (bearer Authorization or equivalent; playerSubject account id or anon:{jti}; no ambient cookie); shared play URL attach ({origin}/play/{matchId} or join-code); browser WS subscribe (notify-only public table; bearer in handshake or first control frame); host embed = iframe.src only; optional UX postMessage is a pipe only"
internal_boundaries:
  - "Play surface UI is presentation; Riffle runtime is the trust boundary for rules and match writes"
  - "Rules library is in-process; no I/O from the library itself"
  - "Hole cards live in seat-scoped hidden state; public board is shared table state"
  - "New work does not call @turnur/sdk; MatchStore is the match I/O boundary. Frozen host-key routes are not the forward contract."
contracts_in_flight:
  - "standalone-play-and-embed — runtime-hosting, play-lab-fate (non-blocking)"
ownership:
  - "Riffle owns gameplay, rules, match state, WebSocket notify, and play identity (account/anonymous) for new work"
  - "Host owns chat, rooms, media, and room identity in embed-mode; host is not match or seat authority"
  - "Turnur mothballed — no new ownership on Turnur side"
---
