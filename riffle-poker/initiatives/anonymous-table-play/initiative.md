---
doc: product.initiative
schema_version: 1
updated: 2026-09-25
slug: anonymous-table-play
title: "Anonymous table play"
status: executing
user_facing: true
signoffs:
  po: true
  architect: true
  designer: true
  security: true
board_milestone: "[Anonymous table play](https://github.com/StacksOnTheRacks/riffle-poker/milestone/7)"
board_tickets:
  - "[#79 Extend production GitHub OIDC deploy role for S3 and CloudFront](https://github.com/StacksOnTheRacks/riffle-poker/issues/79)"
  - "[#80 Host the dashboard play SPA on S3 and CloudFront](https://github.com/StacksOnTheRacks/riffle-poker/issues/80)"
  - "[#81 Seed exactly one unguessable table and export the play URL](https://github.com/StacksOnTheRacks/riffle-poker/issues/81)"
  - "[#82 Reject create_table on the deployed public WebSocket handler](https://github.com/StacksOnTheRacks/riffle-poker/issues/82)"
  - "[#83 Join from /<table-guid> and fail closed otherwise](https://github.com/StacksOnTheRacks/riffle-poker/issues/83)"
  - "[#84 Sit with a display name and no account, then play on the dashboard surface](https://github.com/StacksOnTheRacks/riffle-poker/issues/84)"
---

**Outcome:** A player opens the deployed play surface on the default CloudFront hostname, joins the one database-backed table by its GUID path, and plays NLHE in play chips with no account, onramp, or login.

**URL (locked):** `https://<distribution>.cloudfront.net/<table-guid>` — the table GUID is the path segment that joins that table. No custom domain in this initiative.

**Start state:** Exactly one table record in the database. No lobby and no in-product way to create more tables.

**Hosting reuse:** Static play SPA on S3 + CloudFront; match runtime stays API Gateway WebSocket + Lambda + DynamoDB (already deployed for Dashboard Hold'em). This initiative wires the page to that runtime and to the GUID table.

**In scope:** Deploy play surface to `*.cloudfront.net`; one seeded table with a GUID; anonymous open-URL → join → sit → play on that table.

**Out:** Authentication, Cognito, and user onramp; custom DNS; marketing site; Turnur; embed / RiffSync; multi-table discovery; felt artwork; real money.

Suggested next: `/forge.implement-ticket` (all milestone tickets Ready).
