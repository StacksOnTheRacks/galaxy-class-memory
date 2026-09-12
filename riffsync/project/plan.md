---
doc: project.plan
schema_version: 1
updated: 2026-09-11
objective: "Pipeline idle after site-redesign and first-party fan auth shipped Done. Next intake is /forge.new-initiative for Host Header Layout Fix (operator override; no tickets this pass). Preserve shipped baseline including GA4/CloudWatch metrics and ADR-001 host flows."
in_scope:
  - "Now — idle: zero open issues on StacksOnTheRacks/riffsync"
  - "Shipped — site-redesign: milestone Site redesign (#38) + tickets #445–#452 all CLOSED"
  - "Shipped — first-party-fan-auth: milestone First-party fan auth (#39) + tickets #461–#465 all CLOSED"
  - "Shipped baseline preserved: catalog, rooms, host broadcast, lobby, chat, friends/DM, SEO, Cast/TV, MV3 host extension (#426–#431), Official Live, product metrics (#437–#440), Figma strangler chrome, first-party fan SRP auth"
  - "Next — operator-locked initiative queue (coarse outcomes; /forge.new-initiative before tickets; no host milestone this event): Host Header Layout Fix (first); Host Bar Room Control; Finish the Host Chrome Extension; Develop a Discord App; Watch Party Game Mode"
sequence:
  - "Host extension MVP #427–#431 — Done"
  - "Epic #426 — Done (closed 2026-08-20)"
  - "Product metrics baseline #437–#440 — Done (closed 2026-08-25; PR #441–#444)"
  - "Site redesign — milestone #38 — shipped Done (#445–#452 all CLOSED)"
  - "First-party fan auth — milestone #39 — shipped Done (#461–#465 all CLOSED)"
  - "Next — /forge.new-initiative for Host Header Layout Fix (watch-party standard header; logo plus menu on the right). Do not invent tickets. Do not create a host milestone in this event."
  - "Then remaining Next queue: Host Bar Room Control → Finish the Host Chrome Extension → Develop a Discord App → Watch Party Game Mode"
dependencies:
  - "Board/SCM wins: zero open issues; milestones #38 and #39 closed on host"
  - "Host Header Layout Fix has no host milestone and no tickets — /forge.new-initiative then later LLD grooming creates both"
  - "Watch Party Game Mode still depends on Riffle origin + Turnur match authority, not on RiffSync owning rules"
  - "Metrics baseline (#437–#440) Done; first operational GA4/CloudWatch read still pending"
handoffs:
  - "After Accept — /forge.new-initiative for Host Header Layout Fix (operator-locked first Next)"
  - "Do not /forge.refinement, /forge.implement-ticket, or /forge.backlog-grooming-split until that initiative exists and is in lld"
  - "Product → first GA4/CloudWatch metrics read informs demand-gated Live follow-ons"
---

Site-redesign and first-party fan auth are shipped Done. Pipeline idle. Next command is `/forge.new-initiative` for Host Header Layout Fix.
