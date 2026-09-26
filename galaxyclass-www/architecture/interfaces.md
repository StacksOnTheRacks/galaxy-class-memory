---
doc: architecture.interfaces
schema_version: 1
updated: 2026-09-26
external_interfaces:
  - "Cognito user pool galaxyclass-players-prod (stack GalaxyClassAuth-prod, us-east-1) — email/password IdP; self sign-up; email alias; email verification required; SES from noreply@galaxyclass.app via UserPoolEmail.withSES; no Hosted UI or OAuth at launch"
  - "CDK CfnOutputs UserPoolId, UserPoolClientId, Region — public build-time values for NEXT_PUBLIC_COGNITO_* (no client secret)"
  - "SES identity galaxyclass.app — verified domain prerequisite for Cognito mail; not created by GalaxyClassAuth-prod"
  - "GalaxyClassSite-prod (us-east-1) — private S3 + CloudFront OAC; in-stack DNS-validated ACM for galaxyclass.app + www.galaxyclass.app; Route53 alias A in Z02927871LCJW2KMZGKOP; apex canonical; BucketDeployment of Next out/"
internal_boundaries:
  - "infra/cdk/ owns Cognito pool/client and site hosting (S3, CloudFront, ACM, Route53, BucketDeployment); src/ does not create AWS resources"
  - "Site stack work does not add GHA deploy workflow or Amplify UI — those are later tickets"
contracts_in_flight:
  - "https://github.com/StacksOnTheRacks/galaxyclass-www/issues/2 — GalaxyClassAuth-prod pool, SRP client, outputs"
  - "https://github.com/StacksOnTheRacks/galaxyclass-www/issues/3 — GalaxyClassSite-prod ACM/Route53/S3/CloudFront"
  - "https://github.com/StacksOnTheRacks/galaxyclass-www/issues/7 — SES domain galaxyclass.app verification"
ownership:
  - "galaxyclass-www/infra/cdk — GalaxyClassAuth-prod and GalaxyClassSite-prod"
---
