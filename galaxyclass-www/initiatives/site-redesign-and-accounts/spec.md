---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-26
summary: "Redesigned static studio site at apex galaxyclass.app plus Galaxy Class Cognito accounts (custom SRP UI, email/password only at launch). CDK TypeScript in galaxyclass-www/infra/cdk/; GitHub Actions OIDC deploy; local AWS CLI profile me."
approach: "CDK app at infra/cdk/bin/galaxyclass.ts in us-east-1 (CDK_DEFAULT_ACCOUNT). Two stacks: (1) GalaxyClassAuth-prod — Cognito user pool galaxyclass-players-prod with selfSignUpEnabled, email sign-in alias, app client USER_SRP_AUTH + refresh tokens, no OAuth/Hosted UI at launch, password policy min 8 with upper/lower/number, email verification required, SES sender noreply@galaxyclass.app via UserPoolEmail.withSES (riffsync fan pool pattern); outputs UserPoolId, UserPoolClientId, Region. (2) GalaxyClassSite-prod — private S3 + CloudFront OAC; ACM cert in us-east-1 for galaxyclass.app + www.galaxyclass.app; Route53 alias A records in zone Z02927871LCJW2KMZGKOP; canonical hostname galaxyclass.app with CloudFront Function 301 from www; SPA fallback 403/404 to /index.html; security headers (HSTS, CSP baseline for static + Cognito endpoints); BucketDeployment of Next.js out/ artifact with distribution invalidation. GitHub Actions .github/workflows/deploy.yml: push main + workflow_dispatch; environment production; vars.AWS_DEPLOY_ROLE_ARN and vars.AWS_REGION; Node 22; npm ci && npm run build with NEXT_PUBLIC_COGNITO_* from stack outputs; cdk deploy both stacks; no long-lived keys. Frontend: Next.js 15 App Router static export; add aws-amplify v6 auth only; routes /, /sign-in, /sign-up, /account, /confirm, /forgot-password, /reset-password; build-time public Cognito config only; client session via Amplify; /account redirects when unauthenticated. Redesign evolves existing components — studio positioning, Riffle featured, replace HostEmbedSection with external Play Riffle CTA; retain Framer Motion with prefers-reduced-motion. Cross-game tokens: parent-domain Amplify session only; *.galaxyclass.app handoff deferred to Riffle integration initiative."
interfaces:
  - "Browser → CloudFront/S3 — static HTML/JS/CSS; deep links for /, /sign-in, /sign-up, /account, /confirm, /forgot-password, /reset-password"
  - "Browser → Cognito IdP — SRP signUp, signIn, signOut, confirmSignUp, resetPassword, confirmResetPassword via Amplify Auth (custom UI, not Hosted UI)"
  - "GitHub Actions → AWS OIDC — cdk deploy GalaxyClassAuth-prod and GalaxyClassSite-prod; BucketDeployment publishes out/"
  - "CDK → Route53/ACM — DNS-validated cert and alias A records for apex and www"
  - "CDK → SES — verified galaxyclass.app domain for Cognito verification and reset emails"
structure:
  - "infra/cdk/bin/galaxyclass.ts — CDK app entry"
  - "infra/cdk/lib/galaxy-class-auth-stack.ts — Cognito pool + app client"
  - "infra/cdk/lib/galaxy-class-site-stack.ts — S3, CloudFront OAC, ACM, Route53, BucketDeployment"
  - "src/app/ — marketing home + auth route pages"
  - "src/lib/auth/ — Amplify configure + SRP wrappers (pattern: riffsync fanSrpAuth.ts)"
  - ".github/workflows/deploy.yml — OIDC build and deploy"
  - "Out of this HLD — Riffle JWT validation, leaderboards API, Hosted UI domain, social IdP, backend Lambda"
constraints:
  - "Serverless only: S3, CloudFront, Cognito — no always-on compute for the site"
  - "Custom Cognito auth UI — not Hosted UI; no OAuth callbacks at launch"
  - "Email + password only at launch"
  - "Apex galaxyclass.app canonical; www redirects to apex"
  - "AWS CLI profile me for local operator; GitHub OIDC for CI"
  - "No Riffle token consumption in this initiative"
open_questions: []
---

Trust boundary: static SPA is untrusted; Cognito is auth authority. Build pipeline reads Cognito pool/client IDs from CDK outputs at deploy time — never bake secrets. SES domain verification for galaxyclass.app is a deploy prerequisite (human-ready step if not automated). Deploy order is locked: deploy GalaxyClassAuth-prod, read Cognito CfnOutputs into NEXT_PUBLIC_COGNITO_*, run the Next.js static export, then deploy GalaxyClassSite-prod so BucketDeployment publishes out/ (no SSM for build-time Cognito config).
