---
doc: architecture.decisions
schema_version: 1
updated: 2026-09-12
active_decisions:
  - "ADR-riffle-owned-match — Riffle owns match state and WebSocket notify for new work. Turnur mothballed. Status: Accepted (operator pivot 2026-09-12)."
  - "ADR-standalone-identity — Standalone play uses first-party Riffle session (account or anonymous player-subject). Not Cognito. Not host identity. Status: Accepted (standalone-play-and-embed HLD 2026-09-12)."
  - "ADR-embed-mode — Host attaches via shared play URL at Riffle origin; host keeps chat, rooms, media. Mint/redeem + host seat capability frozen for new work. Status: Accepted (standalone-play-and-embed HLD 2026-09-12)."
  - "ADR-browser-ws-notify — Browser connects to Riffle WS; notify-only public table events; HTTP mutations authoritative; no hidden views on public frames. Status: Accepted (standalone-play-and-embed HLD 2026-09-12)."
  - "ADR-freeze-turnur-http — Freeze shipped host-key + @turnur/sdk paths; replace with new modules (identity/, match-store/, ws/); do not wrap. Status: Accepted (standalone-play-and-embed HLD 2026-09-12)."
  - "ADR-sit-at-table — Guests self-sit via Sit at Table with Riffle session (account or anonymous); host identity is not seat authority; mutable in-game display name. Status: Accepted (standalone-play-and-embed HLD 2026-09-12)."
  - "ADR-rules-in-process — Rules = in-process NLHE library in Riffle runtime. Status: Accepted (carried forward from Turnur era)."
  - "ADR-iframe-embed — Embed play surface = iframe at Riffle origin. Status: Accepted (carried forward)."
superseded:
  - "ADR-rules-in-process (Turnur path) — Runtime called @turnur/sdk for match authority. Superseded by ADR-riffle-owned-match."
  - "ADR-host-seat-capability — Host issued opaque seat capability via RIFFLE_HOST_API_KEY for Turnur-era embed. Superseded by ADR-sit-at-table and ADR-embed-mode."
  - "ADR-host-iframe-bootstrap — Opaque bootstrap token mint/redeem for Turnur-era embed. Superseded by ADR-embed-mode."
  - "ADR-dealer-shoe — dealer_shoe on Turnur system seat. Superseded by MatchStore in-process shoe."
  - "ADR-play-lab-harness — Turnur-backed lab orchestrator. Superseded pending play-lab fate in HLD."
---
