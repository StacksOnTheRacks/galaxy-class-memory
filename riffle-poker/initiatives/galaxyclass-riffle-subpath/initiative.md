---
doc: product.initiative
schema_version: 1
updated: 2026-09-26
slug: galaxyclass-riffle-subpath
title: "Riffle at galaxyclass.app/riffle subpath"
status: executing
user_facing: true
signoffs:
  po: true
  architect: true
  designer: true
  security: true
board_milestone: "[Riffle at galaxyclass.app/riffle](https://github.com/StacksOnTheRacks/riffle-poker/milestone/8)"
board_tickets:
  - "[#89 Extend OIDC deploy role for play-origin S3 and SSM](https://github.com/StacksOnTheRacks/riffle-poker/issues/89)"
  - "[#90 Host private play-origin S3, deploy /riffle SPA, publish SSM and PlayUrl](https://github.com/StacksOnTheRacks/riffle-poker/issues/90)"
  - "[#91 Join and play at /riffle/<table-guid> with no account](https://github.com/StacksOnTheRacks/riffle-poker/issues/91)"
---

**Outcome:** A player opens `https://galaxyclass.app/riffle/<table-guid>`, joins the one seeded table, sits with a display name, and plays NLHE in play chips — no account, onramp, or login.

**URL (locked):** `https://galaxyclass.app/riffle/<table-guid>` — table GUID is the path segment after `/riffle/`. No riffle-owned prod CloudFront hostname.

**Start state:** MatchRuntimeStack WS + Lambda + DynamoDB live from dashboard-holdem. anonymous-table-play defines runtime contracts (one-table seed, create_table reject, join/sit/play) but this initiative owns galaxyclass.app hosting path.

**In scope:** Private S3 play-origin bucket (no prod CloudFront in riffle stack); SSM publish `/galaxyclass/riffle/play-origin-bucket`; dashboard play SPA with `basePath: /riffle`; client path parsing `/riffle/<uuid>`; PlayUrl output; OIDC role for S3 + SSM; reuse anonymous-table-play runtime (seed, join, sit, create_table reject).

**Out:** galaxyclass CloudFront `/riffle/*` behavior definition (galaxyclass-www GalaxyClassSite-prod); Cognito/token integration; lobby; standalone `*.cloudfront.net` prod PlayUrl; modifying anonymous-table-play board tickets (#79–#84).

**Depends on:** galaxyclass-www `GalaxyClassSite-prod` `/riffle/*` behavior reading SSM param (deploy riffle bucket + SSM before first site stack synth that includes behavior).

Suggested next: `/forge.implement-ticket` on #90 or #91 (`ai-ready`). #89 Ready (`human-ready`).
