---
doc: project.risks
schema_version: 1
updated: 2026-09-12
risks:
  - "Mothballed repo drift — shipped Turnur code may diverge from Riffle migration without maintenance"
issues: []
dependencies:
  - "Riffle standalone-play-and-embed may reuse or reimplement Turnur patterns — no Turnur delivery required"
assumptions:
  - "Operator will not unmothball without explicit decision"
  - "Shipped HTTP match authority API remains in repo as reference"
---

See `architecture/risks.md` and `security/threat-model.md` as the stack grows.
