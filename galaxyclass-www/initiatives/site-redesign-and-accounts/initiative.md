---
doc: product.initiative
schema_version: 1
updated: 2026-09-26
slug: site-redesign-and-accounts
title: "Site redesign and Galaxy Class accounts"
status: lld
user_facing: true
signoffs:
  po: true
  architect: true
  designer: true
  security: true
board_milestone: "[Site redesign and Galaxy Class accounts](https://github.com/StacksOnTheRacks/galaxyclass-www/milestone/1)"
board_tickets:
  - "[#1 Configure GitHub OIDC deploy role for galaxyclass-www CDK and static deploy](https://github.com/StacksOnTheRacks/galaxyclass-www/issues/1)"
  - "[#2 Author GalaxyClassAuth-prod Cognito stack (SES wiring, SRP client, outputs)](https://github.com/StacksOnTheRacks/galaxyclass-www/issues/2)"
  - "[#7 Verify SES domain galaxyclass.app in us-east-1 (noreply@galaxyclass.app)](https://github.com/StacksOnTheRacks/galaxyclass-www/issues/7)"
  - "[#3 Deploy GalaxyClassSite-prod (ACM, Route53, S3, CloudFront OAC, www→apex)](https://github.com/StacksOnTheRacks/galaxyclass-www/issues/3)"
  - "[#4 Add GitHub Actions OIDC deploy workflow (build + CDK + BucketDeployment)](https://github.com/StacksOnTheRacks/galaxyclass-www/issues/4)"
  - "[#5 Redesign studio home and navigation (Riffle featured, external play CTA)](https://github.com/StacksOnTheRacks/galaxyclass-www/issues/5)"
  - "[#6 Implement Galaxy Class custom auth UI (sign-up through reset + account)](https://github.com/StacksOnTheRacks/galaxyclass-www/issues/6)"
---

**Outcome:** galaxyclass.app ships as a redesigned studio site with Galaxy Class sign up, sign in, and account on a shared Cognito pool, deployed via CDK and GitHub Actions.

**Domain (locked):** `galaxyclass.app` — Route53 hosted zone `Z02927871LCJW2KMZGKOP` (profile `me`). ACM cert to be issued in us-east-1 during implement.

**Start state:** Existing Next.js 15 static-export marketing site (dark space theme, Framer Motion). No CDK, no CI, no Cognito. Figma unbound.

**In scope:** Studio site redesign (impressive modern craft, tasteful motion); custom Cognito auth UI (not Hosted UI); Cognito user pool for Galaxy Class accounts; ACM + DNS; CDK stacks; GitHub Actions OIDC deploy (pattern: riffle-poker / riffsync).

**Out:** Riffle token integration (follow-up initiative); leaderboards backend; real money; high-cost art production pipeline; game runtime on the studio site.

Suggested next: `/forge.refinement` (#3 site stack). `/forge.implement-ticket` blocked until #3–#6 are Ready.
