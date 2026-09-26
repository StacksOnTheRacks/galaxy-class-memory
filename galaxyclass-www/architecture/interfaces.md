---
doc: architecture.interfaces
schema_version: 1
updated: 2026-09-26
external_interfaces:
  - "Cognito user pool galaxyclass-players-prod (stack GalaxyClassAuth-prod, us-east-1) — email/password IdP; self sign-up; email alias; email verification required; SES from noreply@galaxyclass.app via UserPoolEmail.withSES; no Hosted UI or OAuth at launch"
  - "CDK CfnOutputs UserPoolId, UserPoolClientId, Region — public build-time values for NEXT_PUBLIC_COGNITO_* (no client secret)"
  - "SES identity galaxyclass.app — verified domain prerequisite for Cognito mail; not created by GalaxyClassAuth-prod"
internal_boundaries:
  - "infra/cdk/ owns pool and client; src/ does not create Cognito resources"
  - "This ticket does not instantiate GalaxyClassSite-prod, GHA, or Amplify UI"
contracts_in_flight:
  - "https://github.com/StacksOnTheRacks/galaxyclass-www/issues/2 — GalaxyClassAuth-prod pool, SRP client, outputs"
  - "https://github.com/StacksOnTheRacks/galaxyclass-www/issues/7 — SES domain galaxyclass.app verification"
ownership:
  - "galaxyclass-www/infra/cdk — GalaxyClassAuth-prod"
---
