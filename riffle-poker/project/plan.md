---
doc: project.plan
schema_version: 1
updated: 2026-09-26
objective: "Now: galaxyclass-riffle-subpath — #89–#91 In Refinement under milestone/8. Shipped: anonymous-table-play #79–#84 Done. Shipped: dashboard-holdem #59–#68 Done. Historical shipped: playable-holdem-table #1–#9, play-lab #19–#24, standalone #36–#43. Closed not planned: #44, artwork #53–#58, integrate-turnur #31–#35. Next after this initiative: Web Site; Multi-Hand Session (coarse; /forge.new-initiative, not tickets)."
in_scope:
  - "Now — galaxyclass-riffle-subpath (milestone/8; #89–#91 In Refinement)"
  - "Shipped — anonymous-table-play #79–#84 Done (milestone/7 open, 0 open issues)"
  - "Shipped — dashboard-holdem #59–#68 Done (milestone/6 closed)"
  - "Shipped — playable-holdem-table #1–#9 Done (historical)"
  - "Shipped — play lab #19–#24 Done (historical)"
  - "Shipped — standalone #36–#43 Done (historical)"
  - "Closed not planned — #44, artwork #53–#58, integrate-turnur-websockets #31–#35"
  - "Next — Web Site; Multi-Hand Session (coarse; new-initiative, not tickets)"
sequence:
  - "1. #89 Extend OIDC deploy role for play-origin S3 and scoped SSM (may parallel #90; blocks real deploy)"
  - "2. #90 Host private play-origin S3, deploy /riffle SPA, publish SSM and PlayUrl (blocks galaxyclass-www #3)"
  - "3. #91 Join and play at /riffle/<table-guid> with no account (after path contract from #90)"
dependencies:
  - "Dashboard Hold'em #59–#68 Done — reuse, no rules rewrite"
  - "Anonymous table play #79–#84 Done — reuse seed, create_table reject, join/sit/play; do not remint seed; do not modify #79–#84"
  - "Existing MatchRuntimeStack may still expose *.cloudfront.net/<uuid> PlayUrl from #80; this initiative adds private play-origin + SSM + PlayUrl=https://galaxyclass.app/riffle/{id} without a new riffle-owned prod CloudFront"
  - "#89 may parallel #90 but blocks real production deploy"
  - "#90 bucket + SSM before galaxyclass-www site stack synth that includes /riffle/* behavior (#3)"
  - "#91 after #90 path/basePath contract"
  - "Turnur mothballed — no new Turnur shipping dependency"
  - "Embed/RiffSync, auth/Cognito, custom DNS, lobby out of this initiative"
handoffs:
  - "After Accept → /forge.plan-refresh then /forge.refinement (Designer attends #91)"
  - "Operator — galaxyclass PlayUrl from #90 is not live until galaxyclass-www #3 routes /riffle/* to the published origin"
---

Board/SCM wins. Milestone/8 Riffle at galaxyclass.app/riffle: #89–#91 In Refinement. Milestone/7 Anonymous table play: #79–#84 Done (milestone open). Milestone/6 Dashboard Hold'em closed (#59–#68 Done).
