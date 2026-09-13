---
doc: project.risks
schema_version: 1
updated: 2026-09-12
risks:
  - "MV3 host extension shipped unpacked; Finish the Host Chrome Extension is Next — Web Store review, packaging, and SPA↔extension bridge still unvalidated"
  - "Watch Party Game Mode couples to sister Riffle standalone-play-and-embed HLD; sequencing across two repos can stall attach"
  - "First operational GA4 + CloudWatch product-funnel read still pending — Live maturity follow-ons remain Later / demand-gated"
issues: []
dependencies:
  - "Site redesign #445–#452 and first-party-fan-auth #461–#465 shipped Done; Next intake is /forge.new-initiative (Host Header Layout Fix first)"
  - "Watch Party Game Mode depends on Riffle embed-mode; Riffle owns match and rules; RiffSync does not own rules"
  - "Metrics baseline #437–#440 Done; first operational read pending"
assumptions:
  - "Shipped GA4/CloudWatch instrumentation matches docs/operations/product-metrics.md contract"
  - "Next queue is operator-locked with Host Header Layout Fix first; do not invent tickets until /forge.new-initiative"
---

See `architecture/risks.md` for structural architecture risks on the host extension slice.
