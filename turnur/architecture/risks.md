---
doc: architecture.risks
schema_version: 1
updated: 2026-09-12
structural_risks:
  - "Mothballed repo — no maintenance may leave shipped API undocumented for Riffle migration"
coupling_hotspots:
  - "Riffle shipped code still references @turnur/sdk — migration TBD on Riffle side"
migration_hazards: []
watch_list:
  - "Do not groom integrate-websockets — abandoned"
  - "Unmothball only via explicit operator decision"
---
