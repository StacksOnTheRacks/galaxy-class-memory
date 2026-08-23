---
doc: project.plan
schema_version: 1
updated: 2026-08-23
objective: "Pick and sequence the next product bet now that host Chrome MV3 MVP (#426–#431) and Official Live baseline are shipped; board is empty."
in_scope:
  - "Shipped baseline preserved: catalog, rooms, host broadcast, lobby, chat, friends/DM, SEO packaging, viewer-local Cast, PWA install, MV3 host extension, Official Live, TV client"
  - "Next slice TBD via /forge.roadmap-review"
sequence:
  - "Scaffold #427 — Done (PR #432, 2026-08-13)"
  - "Open/navigate host media tab — https://github.com/StacksOnTheRacks/riffsync/issues/428 — Done"
  - "Host control panel catalog library — https://github.com/StacksOnTheRacks/riffsync/issues/429 — Done"
  - "Title change via host PATCH + media navigate — https://github.com/StacksOnTheRacks/riffsync/issues/430 — Done"
  - "Docs: unpacked install + host control panel hosting flow — https://github.com/StacksOnTheRacks/riffsync/issues/431 — Done"
  - "Epic #426 — Done (closed 2026-08-20)"
  - "Next: TBD after roadmap-review"
dependencies:
  - "Roadmap-review picks the next Now theme before new Refinement tickets"
  - "ADR-001 no-capture and Product Decisions A1 / B1 / C1 / JWT A remain locked for extension work"
handoffs:
  - "Product: /forge.roadmap-review to refresh Now/Next/Later and pick next bet"
  - "Then: /forge.backlog-grooming to shape Refinement tickets for chosen theme"
  - "Architecture boundary: RoomMediaEngine / host_screen stay in page; extension does not capture"
---

Reconcile sequence against board — board has zero open issues as of 2026-08-23.
