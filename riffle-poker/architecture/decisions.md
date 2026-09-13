---
doc: architecture.decisions
schema_version: 1
updated: 2026-09-12
active_decisions:
  - "ADR-riffle-owned-match — Riffle owns match state and WebSocket notify for new work. Turnur mothballed. Status: Accepted (operator pivot 2026-09-12)."
  - "ADR-standalone-identity — Standalone play supports account or anonymous session. Mechanism TBD in standalone-play-and-embed HLD. Status: Proposed."
  - "ADR-embed-mode — Host attaches via shared iframe link at Riffle origin; host keeps chat, rooms, media. Link shape TBD in HLD. Status: Proposed."
  - "ADR-rules-in-process — Rules = in-process NLHE library in Riffle runtime. Status: Accepted (carried forward from Turnur era)."
  - "ADR-iframe-embed — Embed play surface = iframe at Riffle origin. Status: Accepted (carried forward; link mint/redeem may change in HLD)."
superseded:
  - "ADR-rules-in-process (Turnur path) — Runtime called @turnur/sdk for match authority. Superseded by ADR-riffle-owned-match."
  - "ADR-host-seat-capability — Host issued opaque seat capability via RIFFLE_HOST_API_KEY for Turnur-era embed. Superseded pending embed-mode HLD."
  - "ADR-host-iframe-bootstrap — Opaque bootstrap token mint/redeem for Turnur-era embed. Superseded pending embed-mode HLD."
  - "ADR-dealer-shoe — dealer_shoe on Turnur system seat. Superseded pending Riffle-owned match migration."
  - "ADR-play-lab-harness — Turnur-backed lab orchestrator. Superseded pending play-lab fate in HLD."
---
