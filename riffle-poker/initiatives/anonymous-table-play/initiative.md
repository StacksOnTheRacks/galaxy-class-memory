---
doc: product.initiative
schema_version: 1
updated: 2026-09-25
slug: anonymous-table-play
title: "Anonymous table play"
status: hld
user_facing: true
signoffs:
  po: false
  architect: false
  designer: false
  security: false
board_milestone: ""
board_tickets: []
---

**Outcome:** A player opens the deployed play surface on the default CloudFront hostname, joins the one database-backed table by its GUID path, and plays NLHE in play chips with no account, onramp, or login.

**URL (locked):** `https://<distribution>.cloudfront.net/<table-guid>` — the table GUID is the path segment that joins that table. No custom domain in this initiative.

**Start state:** Exactly one table record in the database. No lobby and no in-product way to create more tables.

**Hosting reuse:** Static play SPA on S3 + CloudFront; match runtime stays API Gateway WebSocket + Lambda + DynamoDB (already deployed for Dashboard Hold'em). This initiative wires the page to that runtime and to the GUID table.

**In scope:** Deploy play surface to `*.cloudfront.net`; one seeded table with a GUID; anonymous open-URL → join → sit → play on that table.

**Out:** Authentication, Cognito, and user onramp; custom DNS; marketing site; Turnur; embed / RiffSync; multi-table discovery; felt artwork; real money.

Suggested next: `/forge.initiative-design` (Designer attends — user-facing).
