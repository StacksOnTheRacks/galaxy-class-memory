---
doc: project.plan
schema_version: 1
updated: 2026-09-26T14:32:00Z
objective: "Ship galaxyclass.app redesign with Galaxy Class Cognito accounts and CDK/GHA deploy"
in_scope:
  - "site-redesign-and-accounts initiative (#1–#6)"
sequence:
  - "oidc-deploy-role-galaxyclass-www (#1)"
  - "cognito-auth-stack (#2)"
  - "static-site-stack (#3)"
  - "github-actions-deploy (#4)"
  - "studio-home-redesign (#5) ∥ custom-auth-ui (#6)"
dependencies:
  - "#4 depends on #1–#3"
  - "ACM cert and OIDC deploy role (implement tickets)"
handoffs:
  - "Riffle token integration → follow-up initiative after site ships"
---
