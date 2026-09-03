---
doc: architecture.risks
schema_version: 1
updated: 2026-09-03
structural_risks: []
coupling_hotspots: []
migration_hazards: []
watch_list:
  - "Bootstrap token URL leakage (Referer, history, logs) — mitigate with fragment #bt= only, 60s TTL, one-time jti, history.replaceState strip after redeem, SHA-256-only store, never log raw tokens"
  - "Missing seated-table Screens/Flows (or unbound Figma) blocks designer HLD exit for playable-holdem-table (user_facing); theme is bound and frames pre-built — keep inventory current when frames change"
  - "Play-lab shell frames prebuilt on Screens / Flows (4012:52–4012:142) — keep inventory current when lab chrome changes"
  - "Iframe play surface must remain usable at desktop and narrow host-embed widths; frames that assume full-viewport Riffle chrome will break host attach"
  - "/v1/lab/* can become an unauthenticated live-Turnur match factory if a reachable runtime ships without a gate — Security owns the gate before Ready"
  - "Same-origin play lab (required for FRAME_ANCESTORS 'self') does not prove cross-origin host isolation"
  - "Two same-origin /play iframes share riffle_play (OK: same matchId); capability MUST stay per-iframe memory, never a shared cookie"
---

<!--
Authoring (not validated):
- Frontmatter is source of truth; body is expansion-only.
- Bump updated when any frontmatter field changes. Empty body OK at init.
-->
