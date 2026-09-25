---
doc: architecture.decisions
schema_version: 1
updated: 2026-09-25
active_decisions:
  - "ADR-serverless-ws-stack — Forward runtime is Amazon API Gateway WebSocket API + Lambda + DynamoDB; static SPA on S3 + CloudFront; infra as CDK deployed from GitHub Actions (OIDC). Client actions and seat-scoped fan-out over the WebSocket. Replaces unlocked runtime-hosting and embed-first product direction for new work. Status: Accepted (operator 2026-09-25)."
  - "ADR-riffle-owned-match — Riffle owns match state and WebSocket notify for new work. Turnur mothballed. Status: Accepted (operator pivot 2026-09-12)."
  - "ADR-rules-in-process — Rules = in-process NLHE library in Lambda. Status: Accepted (carried forward)."
  - "ADR-dashboard-ui — Play surface is dashboard composition (Table / Your Turn), not felt. Status: Accepted (dashboard-holdem 2026-09-25)."
  - "ADR-no-live-av — Player tiles are avatar or initials; no live mic/camera. Status: Accepted (dashboard-holdem 2026-09-25)."
  - "ADR-seat-token — Anonymous display name + server-issued seat token is seat authority for dashboard-holdem v1. Status: Accepted (dashboard-holdem 2026-09-25)."
superseded:
  - "ADR-embed-mode — Host attaches via shared play URL. Superseded for forward work by ADR-serverless-ws-stack (embed later, not current initiative)."
  - "ADR-browser-ws-notify — Notify-only WS + HTTP mutations authoritative. Superseded by WS-authoritative actions + seat-scoped snapshots."
  - "ADR-iframe-embed — Embed play surface = iframe at Riffle origin. Superseded for forward work (embed later)."
  - "ADR-standalone-identity — First-party account/anon bearer session. Historical; dashboard-holdem v1 uses seat token (account optional later)."
  - "ADR-bearer-session — Bearer-only session transport. Historical for MatchStore path; dashboard-holdem uses seat token over WSS."
  - "ADR-sit-at-table — Guests self-sit via Sit at Table with Riffle session. Historical MatchStore path."
  - "ADR-freeze-turnur-http — Freeze Turnur HTTP paths. Still valid; Turnur mothballed."
  - "ADR-rules-in-process (Turnur path) — Runtime called @turnur/sdk. Superseded by ADR-riffle-owned-match."
  - "ADR-host-seat-capability — Host issued seat capability for Turnur-era embed. Superseded."
  - "ADR-host-iframe-bootstrap — Bootstrap mint/redeem for Turnur-era embed. Superseded."
  - "ADR-dealer-shoe — dealer_shoe on Turnur system seat. Superseded by Lambda in-process shoe."
  - "ADR-play-lab-harness — Turnur-backed lab orchestrator. Historical only."
---
