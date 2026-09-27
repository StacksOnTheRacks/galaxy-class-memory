---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-27
summary: "Anonymous play-chip NLHE at galaxyclass.app/riffle/<table-guid> via private S3 play-origin + SSM; no riffle-owned prod CloudFront. SPA basePath /riffle; galaxyclass CloudFront serves /riffle/*. Bare /riffle shows Open tables list from config.json."
approach: "Extend MatchRuntimeStack in the existing CDK app: add private S3 play-origin bucket (block public access, OAC-ready for galaxyclass CloudFront OAC); BucketDeployment of dashboard play SPA built with basePath '/riffle'. On deploy write SSM StringParameter /galaxyclass/riffle/play-origin-bucket = bucket name (overwrite each deploy). No CloudFront distribution in riffle stack for prod play — galaxyclass-www GalaxyClassSite-prod adds /riffle/* behavior pointing at this bucket via SSM lookup at synth. Reuse WS API + Lambda + DynamoDB from dashboard-holdem; idempotent one-table seed (unguessable UUID, do not remint on update); deployed Lambda rejects create_table on public path. Runtime config at /riffle/config.json with public webSocketUrl and a tables[] array listing the seeded table (id, name, hostLabel, variantLabel, blindsLabel, buyInLabel, maxSeats) — never bake AWS credentials. Client parseTableIdFromPath matches /^\\/riffle\\/([uuid])\\/?$/i; bare /riffle or /riffle/ → table list (loads config.json, renders Open tables UI); invalid non-list paths → table-not-found. Stack outputs: SeededTableId, PlayUrl = https://galaxyclass.app/riffle/{id}, PlayOriginBucketName, WebSocketUrl. OIDC deploy role: extend for S3 put on play bucket + ssm:PutParameter scoped to /galaxyclass/riffle/play-origin-bucket. Deploy order: riffle bucket + SSM before galaxyclass site stack synth that includes /riffle behavior."
interfaces:
  - "Browser → galaxyclass.app CloudFront /riffle/* — static play SPA; GET /riffle (table list); GET /riffle/<table-guid>; GET /riffle/config.json (public webSocketUrl + tables[])"
  - "Browser → API Gateway WebSocket — connect; join_table; sit/leave; start_hand; action; never create_table on public path"
  - "riffle-poker deploy → S3 — BucketDeployment of /riffle-prefixed SPA artifact"
  - "riffle-poker deploy → SSM — publish /galaxyclass/riffle/play-origin-bucket"
  - "galaxyclass-www GalaxyClassSite-prod → SSM — read play-origin bucket at synth for /riffle/* behavior"
  - "API Gateway → Lambda — $connect, $disconnect, $default (create_table rejected)"
  - "Lambda → DynamoDB — one seeded TABLE item; join/sit/play"
  - "GitHub Actions → AWS OIDC — cdk deploy MatchRuntimeStack; no long-lived keys"
structure:
  - "MatchRuntimeStack (+ play-origin S3 bucket, BucketDeployment, SSM param, seed custom resource; no prod CloudFront)"
  - "Dashboard play SPA — basePath /riffle; pathname /riffle/<table-guid>"
  - "src/client/dashboard-play/route.ts — parseTableIdFromPath for /riffle/<uuid>; isTableListPath for bare /riffle"
  - "src/client/dashboard-play/table-list.ts — Open tables list UI at /riffle root"
  - "Public runtime config — /riffle/config.json (webSocketUrl + tables[])"
  - "Out of this HLD — galaxyclass CloudFront behavior CDK (galaxyclass-www); NLHE rules redesign; lobby; Cognito; Amplify"
constraints:
  - "Prod URL locked: https://galaxyclass.app/riffle/<table-guid>"
  - "No riffle-owned prod CloudFront distribution"
  - "SPA basePath /riffle mandatory"
  - "Riffle bundle must not import Amplify or read Cognito localStorage keys"
  - "Exactly one seeded table; create_table rejected on public WS"
  - "SSM param /galaxyclass/riffle/play-origin-bucket written on every riffle deploy"
  - "Deploy order: riffle bucket + SSM before galaxyclass site stack with /riffle behavior"
  - "Reuse dashboard-holdem for NLHE, seat-scoped snapshots, dashboard UI — do not re-specify rules"
open_questions: []
---

HTTP REST for gameplay is not required. galaxyclass CloudFront serves static assets from riffle S3 origin; SPA fallback for /riffle/* handled on galaxyclass distribution (403/404 → /riffle/index.html).

**Client routes:** Bare `/riffle` or `/riffle/` → load `/riffle/config.json`, render Open tables list from `tables[]` (one seeded table today; search/filter/sort inert). `/riffle/<table-guid>` → load config, connect WS, `join_table` with that id, then sit. Unknown or malformed GUID paths → table-not-found.

**Ownership boundary:** dashboard-holdem owns rules and play UI composition. galaxyclass-www owns CloudFront routing. This initiative owns S3 origin, SSM publish, basePath /riffle, and PlayUrl output shape.

**Success bar:** Operator reads PlayUrl from stack outputs; player opens `https://galaxyclass.app/riffle/<table-guid>`, joins seeded table, sits with display name, completes play-chip NLHE hands with no account.
