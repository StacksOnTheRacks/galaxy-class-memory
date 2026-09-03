---
doc: architecture.risks
schema_version: 1
updated: 2026-09-02
structural_risks: []
coupling_hotspots: []
migration_hazards: []
watch_list:
  - "Bootstrap token URL leakage (Referer, history, logs) — mitigate with short TTL, one-time redeem, prefer fragment or strip after redeem; never log tokens"
---

<!--
Authoring (not validated):
- Frontmatter is source of truth; body is expansion-only.
- Bump updated when any frontmatter field changes. Empty body OK at init.
-->
