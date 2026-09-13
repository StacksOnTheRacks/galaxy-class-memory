---
doc: architecture.risks
schema_version: 1
updated: 2026-09-12
structural_risks:
  - "Migration from shipped Turnur-backed runtime to Riffle MatchStore — freeze + replace; wrap rejected (violates ADR-riffle-owned-match)"
  - "Session credential transport unresolved — cookie vs bearer for cross-site host iframe; blocks Security sign-off"
  - "Missing auth/entry Figma frames — blocks Designer HLD sign-off until /forge.design-spike"
coupling_hotspots:
  - "Shipped play-lab and table modules still call @turnur/sdk — must not extend while migration is open"
  - "Embed-mode uses shared play URL; mint/redeem + capability frozen — RiffSync Watch Party Game Mode depends on this contract"
migration_hazards:
  - "Turnur-backed ADRs and interfaces remain in repo until cutover completes"
  - "Play-lab CI uses fake Turnur — may block or diverge during Riffle-owned match build; frozen host-key tests must not gate MatchStore CI"
watch_list:
  - "Embed shared play URL leakage (Referer, history, logs) — treat as uninvited attach, not hidden-info grant"
  - "Hole-card leakage during migration — seat-scoped views must stay enforced on REST and WS"
  - "Anonymous session abuse (seat squatting, griefing) — security HLD + display-name-rules OQ"
  - "Iframe play surface at desktop and narrow embed widths"
  - "RiffSync Watch Party Game Mode must not make RiffSync match authority"
  - "Third-party cookie blocking in host iframe — session-credential-transport must resolve before embed ships"
---
