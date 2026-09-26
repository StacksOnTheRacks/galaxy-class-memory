---
doc: product.brief
schema_version: 2
updated: 2026-09-26
product_name: "Galaxy Class Gaming"
product_description: "Galaxy Class Gaming makes online table and board games for friends and family. Play anonymously, or sign up for a Galaxy Class account that works across every Galaxy Class game (leaderboards and more). Functional, usable, fun over high-cost art. Riffle Poker is the first game; more are on the way. Domain: galaxyclass.app. Repo: https://github.com/StacksOnTheRacks/galaxyclass-www"
problem: "People discovering Galaxy Class or its games need a studio home that communicates the brand, lets them play anonymously or create one account for advanced features across all Galaxy Class games, and routes them to Riffle and future titles."
audience:
  - "Friends and family who want functional, fun online table and board games"
  - "Players who want anonymous quick play or a Galaxy Class account for leaderboards and cross-game identity"
  - "Prospective players discovering Riffle as the first featured game"
  - "Press, partners, and collaborators looking for brand and product story"
  - "Not for real-money operators or high-cost cinematic art consumers as the primary bet"
goals:
  - "Public studio site at galaxyclass.app with impressive modern design and tasteful motion"
  - "Galaxy Class accounts via Cognito with custom auth UI (sign up, sign in, account)"
  - "Shared identity that will work across all Galaxy Class games"
  - "Cost-effective serverless hosting (S3, CloudFront, Cognito) deployed via CDK and GitHub Actions"
  - "Feature Riffle first with accurate positioning; structure for future games"
non_goals:
  - "Real money, rake, cashier, or KYC"
  - "High-cost graphic art production as the primary investment"
  - "Leaderboards backend on the site (later)"
  - "Riffle token integration in the first initiative (follow-up)"
  - "Turnur or mothballed platforms"
  - "A multi-product store or blog as v1"
success_metrics:
  - metric: "Studio landing"
    target: "galaxyclass.app live with redesigned studio site and Galaxy Class account flows"
  - metric: "Auth"
    target: "Players can sign up, sign in, and manage a Galaxy Class account on custom UI backed by Cognito"
  - metric: "Deploy"
    target: "Site deploys via CDK + GitHub Actions to galaxyclass.app on serverless stack"
  - metric: "Quantified traffic"
    target: "TBD (greenfield)"
current_focus: "Initiative site-redesign-and-accounts in LLD (HLD signed off). Next: ensure-config for board fields, then /forge.backlog-grooming."
---

Host repo [StacksOnTheRacks/galaxyclass-www](https://github.com/StacksOnTheRacks/galaxyclass-www). First featured game is [Riffle](https://github.com/StacksOnTheRacks/riffle-poker) (`riffle-poker`). Route53 hosted zone `galaxyclass.app` exists (profile `me`). Board fields (`projectId`, `statusIds`) deferred until ensure-config before grooming.
