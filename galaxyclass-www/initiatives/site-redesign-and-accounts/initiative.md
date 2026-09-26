---
doc: product.initiative
schema_version: 1
updated: 2026-09-26
slug: site-redesign-and-accounts
title: "Site redesign and Galaxy Class accounts"
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

**Outcome:** galaxyclass.app ships as a redesigned studio site with Galaxy Class sign up, sign in, and account on a shared Cognito pool, deployed via CDK and GitHub Actions.

**Domain (locked):** `galaxyclass.app` — Route53 hosted zone `Z02927871LCJW2KMZGKOP` (profile `me`). ACM cert to be issued in us-east-1 during implement.

**Start state:** Existing Next.js 15 static-export marketing site (dark space theme, Framer Motion). No CDK, no CI, no Cognito. Figma unbound.

**In scope:** Studio site redesign (impressive modern craft, tasteful motion); custom Cognito auth UI (not Hosted UI); Cognito user pool for Galaxy Class accounts; ACM + DNS; CDK stacks; GitHub Actions OIDC deploy (pattern: riffle-poker / riffsync).

**Out:** Riffle token integration (follow-up initiative); leaderboards backend; real money; high-cost art production pipeline; game runtime on the studio site.

Suggested next: `/forge.initiative-design`.
