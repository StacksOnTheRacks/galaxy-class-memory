---
doc: project.plan
schema_version: 1
updated: 2026-09-25
objective: "Operator pivot: dashboard-holdem game-first. Now: #59–#67 In Refinement (milestone/6). Shipped: playable-holdem-table #1–#9, play-lab #19–#24, standalone #36–#43 (historical). #44 and artwork #53–#58 closed not planned. Next: Web Site; Multi-Hand Session."
in_scope:
  - "Now — dashboard-holdem #59–#67 In Refinement (milestone/6)"
  - "Shipped — playable-holdem-table #1–#9 Done (Turnur-backed historical)"
  - "Shipped — play lab #19–#24 Done (Turnur-backed historical)"
  - "Shipped — standalone #36–#43 Done (historical MatchStore path)"
  - "Closed not planned — #44, artwork #53–#58, integrate-turnur-websockets #31–#35"
  - "Next — Web Site; Multi-Hand Session"
sequence:
  - "dashboard-holdem #59 serverless runtime → #60 shell → #61–#64 UI surfaces → #65 sit/deal → #66 streets → #67 all-in/settle"
  - "Then /forge.refinement → Ready"
  - "Next — Web Site; Multi-Hand Session"
dependencies:
  - "Turnur mothballed — no new Turnur shipping dependency"
  - "Hosting locked: API Gateway WS + Lambda + DynamoDB + S3/CloudFront CDK/GHA"
  - "Embed/RiffSync out of current initiative"
handoffs:
  - "Product → /forge.refinement on dashboard-holdem tickets (Designer attends user-facing)"
---

Board/SCM wins. Milestone/6 open: #59–#67 In Refinement.
