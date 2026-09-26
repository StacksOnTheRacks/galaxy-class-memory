---
doc: architecture.constraints
schema_version: 1
updated: 2026-09-26
hard_constraints:
  - "Serverless only: S3, CloudFront, Cognito — no always-on compute for the site"
  - "Custom Cognito auth UI — not Cognito Hosted UI"
  - "CDK TypeScript deploy via GitHub Actions OIDC"
  - "AWS CLI profile me for local/operator; region us-east-1"
  - "Domain galaxyclass.app — Route53 hosted zone Z02927871LCJW2KMZGKOP"
  - "Play chips / social play positioning — no real-money, cashier, or KYC on the studio site"
soft_constraints:
  - "Reuse riffle-poker and riffsync CDK/GHA patterns where applicable"
  - "Next.js static export for the site artifact"
  - "Framer Motion or equivalent for motion; honor prefers-reduced-motion"
out_of_bounds:
  - "Always-on servers or containers for site hosting"
  - "Riffle first-party identity store as account SoT (superseded by Galaxy Class Cognito — Riffle integration follow-up)"
  - "Real-money wagering or KYC flows"
assumptions:
  - "ACM certificate for galaxyclass.app will be issued in us-east-1 during implement"
  - "GitHub OIDC deploy role will be created/configured during implement"
---
