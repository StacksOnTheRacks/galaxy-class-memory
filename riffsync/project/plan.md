---
doc: project.plan
schema_version: 1
updated: 2026-09-12
objective: "Pipeline ready for LLD grooming. Host Header Layout Fix and Host Bar Room Control exited HLD with all sign-offs green. Preserve shipped baseline including GA4/CloudWatch metrics and ADR-001 host flows."
in_scope:
  - "Now — idle: zero open issues on StacksOnTheRacks/riffsync"
  - "Shipped — site-redesign: milestone Site redesign (#38) + tickets #445–#452 all CLOSED"
  - "Shipped — first-party-fan-auth: milestone First-party fan auth (#39) + tickets #461–#465 all CLOSED"
  - "Shipped baseline preserved: catalog, rooms, host broadcast, lobby, chat, friends/DM, SEO, Cast/TV, MV3 host extension (#426–#431), Official Live, product metrics (#437–#440), Figma strangler chrome, first-party fan SRP auth"
  - "LLD — host-header-layout-fix and host-bar-room-control (sign-offs green; awaiting /forge.backlog-grooming; no tickets yet)"
  - "Next — operator-locked initiative queue (coarse outcomes; /forge.new-initiative before tickets): Finish the Host Chrome Extension; Develop a Discord App; Watch Party Game Mode"
sequence:
  - "Host extension MVP #427–#431 — Done"
  - "Epic #426 — Done (closed 2026-08-20)"
  - "Product metrics baseline #437–#440 — Done (closed 2026-08-25; PR #441–#444)"
  - "Site redesign — milestone #38 — shipped Done (#445–#452 all CLOSED)"
  - "First-party fan auth — milestone #39 — shipped Done (#461–#465 all CLOSED)"
  - "Host Header Layout Fix — HLD complete (2026-09-12) → LLD; next /forge.backlog-grooming"
  - "Host Bar Room Control — HLD complete (2026-09-12) → LLD; next /forge.backlog-grooming"
  - "Then remaining Next queue: Finish the Host Chrome Extension → Develop a Discord App → Watch Party Game Mode"
dependencies:
  - "Board/SCM wins: zero open issues; milestones #38 and #39 closed on host"
  - "Each host initiative gets one host milestone at LLD grooming — do not combine"
  - "Watch Party Game Mode still depends on Riffle origin + Turnur match authority, not on RiffSync owning rules"
  - "Metrics baseline (#437–#440) Done; first operational GA4/CloudWatch read still pending"
handoffs:
  - "After Accept — /forge.backlog-grooming for host-header-layout-fix (first per roadmap)"
  - "Then /forge.backlog-grooming for host-bar-room-control"
  - "Do not /forge.refinement or /forge.implement-ticket until grooming creates tickets on Refinement"
  - "Product → first GA4/CloudWatch metrics read informs demand-gated Live follow-ons"
---

Host Header Layout Fix and Host Bar Room Control are LLD. Next command is `/forge.backlog-grooming` for host-header-layout-fix.
