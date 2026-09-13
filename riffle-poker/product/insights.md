---
doc: product.insights
schema_version: 1
updated: 2026-09-12
themes:
  - "Operator pivot: Turnur mothballed; Riffle owns match state and WebSockets"
  - "Standalone app (account or anonymous) plus embed-mode iframe link for hosts"
  - "Now: standalone-play-and-embed HLD — no board tickets yet"
  - "Shipped Turnur-backed table and play-lab are historical proof; new work does not consume Turnur"
  - "Artwork and Web Site remain Next after HLD exit"
open_questions:
  - "Identity mechanism for standalone play (first-party vs Cognito vs other)?"
  - "Embed link shape — shared iframe URL vs today's host mint/redeem?"
  - "Is there player or host demand for poker in RiffSync rooms? (no interviews, feedback, or metrics exist)"
evidence:
  - "Operator decision: mothball Turnur; Riffle owns play"
  - "playable-holdem-table #1–#9 Done; play-lab #19–#24 Done (Turnur-backed)"
  - "integrate-turnur-websockets #31–#35 closed not planned"
  - "Sister riffsync Next includes Watch Party Game Mode (Riffle embed-mode)"
implications:
  - "Do not groom integrate-turnur-websockets — superseded by standalone-play-and-embed"
  - "Complete NLHE Hand and Multi-Hand Session stay in-process rules on Riffle-owned match state"
  - "RiffSync Watch Party Game Mode attaches Riffle embed-mode; RiffSync does not own rules or match state"
---

Product-decision synthesis only. No interviews, feedback, experiments, competitive scan, or instrumentation exist for this product.
