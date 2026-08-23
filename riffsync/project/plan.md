---
doc: project.plan
schema_version: 1
updated: 2026-08-23
objective: "Ship product metrics baseline; queue Figma-driven UI redesign as Next."
in_scope:
  - "Now — metrics: instrumentation contract; GA4 custom events for guest join, host broadcast start, catalog→room/solo conversion, Live channel entry; CloudWatch business counters mirroring primary metrics; privacy-policy alignment (GA4 already disclosed)"
  - "Next — Figma redesign: theme bind, design memory, designer-approved adoption pattern; incremental surface rollout after Designer sign-off (no code until frame ready)"
  - "Shipped baseline preserved: catalog, rooms, host broadcast, lobby, chat, friends/DM, SEO, Cast/TV, MV3 host extension, Official Live"
sequence:
  - "Host extension MVP #427–#431 — Done"
  - "Epic #426 — Done (closed 2026-08-20)"
  - "Instrumentation contract — https://github.com/StacksOnTheRacks/riffsync/issues/437 (Refinement)"
  - "GA4 custom product funnel events — https://github.com/StacksOnTheRacks/riffsync/issues/438 (Refinement; after #437)"
  - "CloudWatch RiffSync/Product business counters — https://github.com/StacksOnTheRacks/riffsync/issues/439 (Refinement; after #437)"
  - "Product metrics CloudWatch dashboard widgets — https://github.com/StacksOnTheRacks/riffsync/issues/440 (Refinement; after #439)"
  - "Figma redesign — theme bind + /forge.design-system-audit after metrics ship"
dependencies:
  - "#438 and #439 depend on #437 instrumentation contract"
  - "#440 depends on #439 CloudWatch counters"
  - "Existing GA4 bootstrap + CloudWatch EMF patterns; no new third-party analytics vendor"
  - "Figma file vQ6yHQyiGlOnRG7ngIOxR7 pre-bound for Next; Designer sign-off gate per surface"
handoffs:
  - "Product/Architect/Security: /forge.refinement on #437 first, then #438/#439, then #440"
  - "After metrics ship: Designer → /forge.design-system-audit for Figma redesign Next"
  - "Architecture boundary: metrics are observability-only; redesign is presentation-layer strangler"
---

Reconcile sequence against board — refinement order: #437 → (#438 ∥ #439) → #440.
