---
doc: architecture.interfaces
schema_version: 1
updated: 2026-09-26
external_interfaces:
  - "Current (dashboard-holdem) — Browser ↔ API Gateway WebSocket (join_table, sit/leave, start_hand, action, snapshot); GitHub Actions OIDC → AWS CDK deploy"
  - "galaxyclass-riffle-subpath (HLD) — Browser ↔ galaxyclass.app CloudFront /riffle/* → Riffle S3 play origin; PlayUrl https://galaxyclass.app/riffle/{SeededTableId}; riffle deploy writes SSM /galaxyclass/riffle/play-origin-bucket; galaxyclass-www GalaxyClassSite-prod reads SSM for /riffle/* behavior"
  - "Frozen (historical) — Host → Riffle runtime POST /v1/matches, bootstrap, capability, hands/* with Bearer RIFFLE_HOST_API_KEY; GET /v1/ws notify-only; iframe embed; @turnur/sdk. Do not extend for new work."
  - "Frozen (anonymous-table-play) — *.cloudfront.net/<table-guid> prod URL; superseded for galaxyclass.app prod by galaxyclass-riffle-subpath when shipped"
internal_boundaries:
  - "Play surface UI is presentation; Lambda is the trust boundary for rules and match writes"
  - "Rules library is in-process inside Lambda; no I/O from the library itself"
  - "Hole cards live in seat-scoped storage and snapshots; public board is shared table state"
  - "Static SPA and browser are untrusted; seat token + Lambda authorization is the trust boundary"
  - "galaxyclass-www owns CloudFront /riffle/* routing; riffle-poker owns S3 origin content + SSM publish"
contracts_in_flight:
  - "dashboard-holdem — table-discovery, disconnect-policy (non-blocking)"
  - "galaxyclass-riffle-subpath — SSM /galaxyclass/riffle/play-origin-bucket write; basePath /riffle SPA; PlayUrl output shape"
  - "galaxyclass-www site-redesign-and-accounts — GalaxyClassSite-prod /riffle/* behavior consuming SSM param"
ownership:
  - "Riffle owns SPA artifact, WS API, Lambda rules/state, DynamoDB, play-origin S3, SSM publish for forward galaxyclass subpath work"
  - "galaxyclass-www owns studio CloudFront distribution and /riffle/* behavior"
  - "Turnur mothballed — no new ownership on Turnur side"
  - "Embed/RiffSync host ownership is historical / later — not forward path"
---
