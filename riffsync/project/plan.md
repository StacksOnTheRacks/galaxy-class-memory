---
doc: project.plan
schema_version: 1
updated: 2026-09-12
objective: "Pipeline on Refinement. Host Header Layout Fix (#471) and Host Bar Room Control (#472–#473) groomed. Preserve shipped baseline including GA4/CloudWatch metrics and ADR-001 host flows."
in_scope:
  - "Now — idle: zero open issues on StacksOnTheRacks/riffsync"
  - "Shipped — site-redesign: milestone Site redesign (#38) + tickets #445–#452 all CLOSED"
  - "Shipped — first-party-fan-auth: milestone First-party fan auth (#39) + tickets #461–#465 all CLOSED"
  - "Shipped baseline preserved: catalog, rooms, host broadcast, lobby, chat, friends/DM, SEO, Cast/TV, MV3 host extension (#426–#431), Official Live, product metrics (#437–#440), Figma strangler chrome, first-party fan SRP auth"
  - "Refinement — #471 (host-header-layout-fix), #472–#473 (host-bar-room-control)"
  - "Next — operator-locked initiative queue (coarse outcomes; /forge.new-initiative before tickets): Finish the Host Chrome Extension; Develop a Discord App; Watch Party Game Mode"
sequence:
  - "Host extension MVP #427–#431 — Done"
  - "Epic #426 — Done (closed 2026-08-20)"
  - "Product metrics baseline #437–#440 — Done (closed 2026-08-25; PR #441–#444)"
  - "Site redesign — milestone #38 — shipped Done (#445–#452 all CLOSED)"
  - "First-party fan auth — milestone #39 — shipped Done (#461–#465 all CLOSED)"
  - "Host Header Layout Fix — #471 on Refinement (milestone #40)"
  - "Host Bar Room Control — #472–#473 on Refinement (milestone #41)"
  - "Then remaining Next queue: Finish the Host Chrome Extension → Develop a Discord App → Watch Party Game Mode"
dependencies:
  - "Board/SCM wins: zero open issues; milestones #38 and #39 closed on host"
  - "Each host initiative gets one host milestone at LLD grooming — do not combine"
  - "Watch Party Game Mode depends on Riffle embed-mode (iframe link); Riffle owns match and rules; RiffSync does not own rules"
  - "Metrics baseline (#437–#440) Done; first operational GA4/CloudWatch read still pending"
handoffs:
  - "/forge.plan-refresh — sequence #471, #472, #473"
  - "/forge.refinement — #471 first, then #472, then #473"
  - "Do not /forge.implement-ticket until tickets are Ready with ai-ready"
  - "Product → first GA4/CloudWatch metrics read informs demand-gated Live follow-ons"
---

Three host tickets on Refinement. Next command is `/forge.plan-refresh` then `/forge.refinement` starting with #471.
