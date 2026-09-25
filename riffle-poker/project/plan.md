---
doc: project.plan
schema_version: 1
updated: 2026-09-25
objective: "Now: anonymous-table-play — #79–#84 In Refinement under milestone/7. Shipped: dashboard-holdem #59–#68 Done. Historical shipped: playable-holdem-table #1–#9, play-lab #19–#24, standalone #36–#43. Closed not planned: #44, artwork #53–#58, integrate-turnur #31–#35. Next after this initiative: Web Site; Multi-Hand Session (coarse; /forge.new-initiative, not tickets)."
in_scope:
  - "Now — anonymous-table-play (milestone/7; #79–#84 In Refinement)"
  - "Shipped — dashboard-holdem #59–#68 Done (milestone/6 closed)"
  - "Shipped — playable-holdem-table #1–#9 Done (historical)"
  - "Shipped — play lab #19–#24 Done (historical)"
  - "Shipped — standalone #36–#43 Done (historical)"
  - "Closed not planned — #44, artwork #53–#58, integrate-turnur-websockets #31–#35"
  - "Next — Web Site; Multi-Hand Session (coarse; new-initiative, not tickets)"
sequence:
  - "1. #79 Extend production GitHub OIDC deploy role for S3/CloudFront (human-leaning; may parallel #80–#81; blocks real deploy)"
  - "2. #80 Host the dashboard play SPA on S3 and CloudFront"
  - "3. #81 Seed exactly one unguessable table; export SeededTableId + PlayUrl"
  - "4. #82 Reject create_table on the deployed public WebSocket handler"
  - "5. #83 Join from /<table-guid>; fail closed on unknown GUID and on /"
  - "6. #84 Sit with a display name and no account, then play on the dashboard surface"
dependencies:
  - "Dashboard Hold'em #59–#68 Done — reuse, no rules rewrite"
  - "Hosting locked: extend MatchRuntimeStack with S3/CloudFront; API Gateway WS + Lambda + DynamoDB already live"
  - "#79 may parallel #80–#81 but blocks real deploy"
  - "#80–#81 before the operator can form PlayUrl (PlayUrl needs distribution domain + SeededTableId)"
  - "Do not share PlayUrl or treat public play as live until #82 (create_table reject) is deployed"
  - "#83 before #84"
  - "Turnur mothballed — no new Turnur shipping dependency"
  - "Embed/RiffSync, auth/Cognito, custom DNS, lobby out of this initiative"
handoffs:
  - "After Accept → /forge.refinement (Designer attends user-facing #83 and #84; #79 may compile as human-ready OIDC)"
  - "Operator — PlayUrl from #81 is not shareable until #82 is live (one-table lock)"
---

Board/SCM wins. Milestone/7 Anonymous table play: #79–#84 In Refinement. Milestone/6 Dashboard Hold'em closed (#59–#68 Done).
