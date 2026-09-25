---
doc: project.plan
schema_version: 1
updated: 2026-09-25
objective: "Now: anonymous-table-play LLD → six Refinement tickets under host milestone Anonymous table play. Shipped: dashboard-holdem #59–#68 Done (milestone/6). Historical: playable-holdem-table #1–#9, play-lab #19–#24, standalone #36–#43. Closed not planned: #44, artwork #53–#58, integrate-turnur #31–#35. Next after this initiative: Web Site; Multi-Hand Session."
in_scope:
  - "Now — anonymous-table-play (six Refinement tickets; milestone/7)"
  - "Shipped — dashboard-holdem #59–#68 Done (milestone/6)"
  - "Shipped — playable-holdem-table #1–#9 Done (historical)"
  - "Shipped — play lab #19–#24 Done (historical)"
  - "Shipped — standalone #36–#43 Done (historical)"
  - "Closed not planned — #44, artwork #53–#58, integrate-turnur-websockets #31–#35"
  - "Next — Web Site; Multi-Hand Session"
sequence:
  - "1. Extend production OIDC deploy role for S3/CloudFront (human-leaning; can parallel CDK; blocks real deploy)"
  - "2. Host dashboard play SPA on S3+CloudFront (default hostname, config.json, SPA fallback)"
  - "3. Seed exactly one UUID table; export SeededTableId + PlayUrl"
  - "4. Reject public WebSocket create_table"
  - "5. Client join path /<table-guid> with not-found on unknown GUID and on /"
  - "6. Anonymous sit + display name on existing dashboard play surface (no rules rewrite)"
  - "After Apply — /forge.plan-refresh then /forge.refinement → Ready"
dependencies:
  - "Dashboard Hold'em runtime + SPA composition shipped (#59–#68 Done) — reuse, no rules rewrite"
  - "Hosting locked: extend MatchRuntimeStack with S3/CloudFront; API Gateway WS + Lambda + DynamoDB already live"
  - "OIDC role extension (#79) can parallel CDK (#80–#81) but blocks real deploy"
  - "Tickets #80–#81 before operator PlayUrl; #82 before public WS is safe; #83 before #84"
  - "Turnur mothballed — no new Turnur shipping dependency"
  - "Embed/RiffSync, auth/Cognito, custom DNS, lobby out of this initiative"
handoffs:
  - "Product → /forge.refinement (Designer attends user-facing join path and anonymous sit tickets)"
---

Board/SCM wins. Milestone/7 Anonymous table play: #79–#84 In Refinement. Milestone/6 Dashboard Hold'em: #59–#68 Done.
