---
doc: design.principles
schema_version: 1
updated: 2026-08-23
principles:
  - "Incremental adoption: no big-bang UI cutover"
  - "Designer sign-off gate per surface before Refinement or implementation"
  - "Token bridge: map Figma variables to existing CSS custom properties where possible before wholesale replacement"
  - "Behavior preservation: redesign is presentation-layer; room/Live/host/extension behavior unchanged unless explicitly ticketed"
  - "Figma wins over stale design memory; production wins over WIP Figma until Designer sign-off"
a11y_rules: []
interaction_patterns: []
anti_patterns:
  - "Replacing all chrome at once without a pilot surface"
  - "Implementing from WIP Figma frames before Designer sign-off"
  - "Breaking shipped room, Live, or host extension flows during visual refresh"
---

Redesign program is Next, after metrics baseline ships.
