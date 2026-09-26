---
doc: architecture.overview
schema_version: 1
updated: 2026-09-26
system: "Galaxy Class Gaming public studio site at galaxyclass.app — static Next.js export on S3/CloudFront plus Cognito user pool for Galaxy Class accounts (custom UI, SRP). GitHub Actions OIDC deploys CDK stacks."
context: "Redesign from marketing-only site to studio home with shared cross-game accounts. Riffle Poker is first featured game; Riffle token integration is a follow-up initiative."
data_flow: "1. Browser loads static site from CloudFront/S3. 2. Sign up/sign in via custom UI → Cognito SRP. 3. Account pages read Cognito session/JWT client-side. 4. Future games consume same pool tokens (follow-up)."
deployment_shape: "CDK TypeScript: cert (us-east-1 ACM), auth (Cognito pool + app client), site (S3 + CloudFront + Route53). GitHub Actions OIDC; local AWS CLI profile me."
current_focus: "site-redesign-and-accounts initiative in HLD."
major_components:
  - "Static studio SPA — S3 + CloudFront at galaxyclass.app"
  - "Cognito user pool — Galaxy Class accounts"
  - "Custom auth UI — sign up, sign in, account (no Hosted UI)"
  - "CDK + GitHub Actions — deploy and invalidation"
  - "Route53 — hosted zone Z02927871LCJW2KMZGKOP (galaxyclass.app)"
---
