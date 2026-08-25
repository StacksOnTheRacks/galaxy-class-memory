---
doc: project.plan
schema_version: 1
updated: 2026-08-25
objective: "Launch Figma-driven UI redesign program (Designer availability → design-system-audit → sign-off → incremental surface rollout); preserve shipped product baseline including metrics."
in_scope:
  - "Now — Figma redesign: theme bound (vQ6yHQyiGlOnRG7ngIOxR7); design memory seeded (themes, screens, components, principles); /forge.design-system-audit when Designer is available; Designer adoption pattern; incremental surface rollout after per-surface sign-off (no code until frame ready)"
  - "Shipped baseline preserved: catalog, rooms, host broadcast, lobby, chat, friends/DM, SEO, Cast/TV, MV3 host extension (#426–#431), Official Live, product metrics (#437–#440)"
  - "Next after redesign kickoff — Extension & TV distribution polish; Live maturity follow-ons (Cast on Live, multi-channel hub) demand-gated after first metrics read"
sequence:
  - "Host extension MVP #427–#431 — Done"
  - "Epic #426 — Done (closed 2026-08-20)"
  - "Product metrics baseline #437–#440 — Done (closed 2026-08-25; PR #441–#444)"
  - "Figma redesign — await Designer availability → /forge.design-system-audit (no open board tickets)"
  - "Designer sign-off + surface sequencing — pilot: catalog/home (unauthenticated + authenticated)"
  - "Incremental surface rollout (strangler; red-html chrome until each surface swaps)"
dependencies:
  - "Figma file vQ6yHQyiGlOnRG7ngIOxR7 pre-bound; design memory seeded; audit pending Designer availability"
  - "Designer sign-off gate per surface before Refinement or implementation"
  - "Metrics baseline (#437–#440) Done (2026-08-25); enables demand-gated Live follow-ons after first GA4/CloudWatch read"
  - "Figma redesign preserves docs/operations/product-metrics.md (GA4 event names + CloudWatch RiffSync/Product Routes); amendments only via explicit metrics ticket"
  - "Redesign tickets touching Room-tab host console, extension popup/bridge, or media-tab open/navigate flows require Architect+Security refinement — presentation-only unless separate behavior ticket + ADR supersedes"
  - "Existing GA4 bootstrap + CloudWatch EMF patterns; no new third-party analytics vendor"
handoffs:
  - "Designer → /forge.design-system-audit when available (first gate for Figma redesign Now)"
  - "PO/PM → backlog grooming to slice pilot surface (catalog/home) into Ready tickets after audit + Designer sign-off"
  - "Architect+Security — refinement on ADR-001-adjacent redesign surfaces (Room sidebar host console, riffsync-host-bridge, capture/SFU-adjacent UI)"
  - "Engineer+QA — per-surface: visual strangler + metrics contract regression (events/Routes still fire) + ADR-001 host flows unchanged"
  - "Product → first metrics read from shipped GA4/CloudWatch instrumentation (post-#437–#440)"
  - "Architecture boundary: metrics observability-only; redesign is presentation-layer strangler"
---

Board clear — zero open issues on StacksOnTheRacks/riffsync as of 2026-08-25. Metrics slice complete; redesign is Now (Designer-gated).
