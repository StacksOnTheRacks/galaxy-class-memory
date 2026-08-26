---
doc: project.risks
schema_version: 1
updated: 2026-08-26
risks:
  - "Figma redesign program has no board tickets until Designer completes /forge.design-system-audit — delivery idle on design track"
  - "MV3 host extension shipped unpacked; Web Store review, distribution packaging, and SPA↔extension bridge trust boundaries unvalidated (detail: architecture/risks.md)"
  - "Post-ship metrics read not yet performed — Live maturity follow-ons remain demand-gated until GA4 + CloudWatch funnel validation (~1 week post-ship)"
issues: []
dependencies:
  - "Designer availability → /forge.design-system-audit (first Figma redesign gate)"
  - "Designer sign-off per surface before Refinement or implementation (pilot: catalog/home)"
  - "Metrics baseline #437–#440 Done (2026-08-25); first operational read pending"
assumptions:
  - "Shipped GA4/CloudWatch instrumentation matches docs/operations/product-metrics.md contract"
  - "Figma surface rollout (strangler) preserves event fire sites — amendments only via explicit metrics ticket"
---

See `architecture/risks.md` for structural architecture risks on the host extension slice.
