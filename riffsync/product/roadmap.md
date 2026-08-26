---
doc: product.roadmap
schema_version: 1
updated: 2026-08-26
themes:
  - "Lawful shared watching (catalog + host embed/capture + guest SFU view)"
  - "Host browser tooling (Chrome MV3: media-tab control + Room-tab host console; no capture)"
  - "Anonymous-first participation with signed-in hosting"
  - "Public discovery (catalog IA, SEO packaging, shareable durable URLs)"
  - "Viewer-local presentation (Cast / Link TV / TV client) without room authority — shipped baseline"
  - "Signed-in social layer (friends + 1:1 DMs)"
  - "Official hostless Live hangouts (staff-bound YouTube live) — shipped baseline"
  - "Product observability (GA4 + CloudWatch business metrics)"
  - "Figma-driven UI redesign (incremental adoption)"
now:
  - "Figma redesign program — bind https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync; Designer establishes adoption pattern; incremental surface rollout after Designer sign-off; current red-html chrome stays until each surface swaps"
  - "Treat Chromecast, PWA, catalog playback host, friends/DM, catalog browse IA, public SEO packaging, Official Live, TV client, product metrics baseline (#437–#440), and MV3 host extension (#426–#431) as live product baseline (board Done / closed), not open delivery risk"
next:
  - "Extension & TV distribution polish"
  - "Live maturity follow-ons (Cast on Live viewer-local, multi-channel hub) — demand-gated after first metrics read"
later:
  - "Federated host login and deeper staff catalog/ops tooling beyond current admin baseline"
  - "Lawful non-YouTube playback backends that stay pluggable without a piracy vault"
not_planning:
  - "Piracy vault / communal ripped-file hosting"
  - "Verified Premium entitlement checks"
  - "Indexing ephemeral rooms or lobby instances"
  - "Group DMs, voice/video calls between friends, public social feeds"
  - "Mesh WebRTC or skipping SFU/TURN in any environment"
  - "Host Chrome extension media capture / tabCapture / extension-supplied host_screen (ADR-001)"
  - "Find/focus room tab + return-to-share as the primary hosting UX"
  - "Big-bang UI rewrite or downtime cutover"
---

Board links: epic [#426](https://github.com/StacksOnTheRacks/riffsync/issues/426) closed 2026-08-20; scaffold [#427](https://github.com/StacksOnTheRacks/riffsync/issues/427) closed via PR #432; #428–#431 Done. Metrics baseline **#437–#440** closed Done 2026-08-25 (PRs #441–#444).
