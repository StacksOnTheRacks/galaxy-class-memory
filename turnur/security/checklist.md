---
doc: security.checklist
schema_version: 1
updated: 2026-08-23
secrets:
  - "infra/cdk/.gitignore excludes node_modules/, cdk.out, dist/; no secrets in repo (#1, PR #5)."
  - "Add .env* to gitignore when CDK/Lambda env config is introduced."
dependencies:
  - "infra/cdk/package-lock.json committed; npm audit clean (0 vulns) as of 2026-08-20 (#1, PR #5)."
  - "Baseline: aws-cdk-lib ^2.173.4, constructs ^10.4.2, Node >=22."
authn_authz:
  - "Not in scope until API + game SDK key work (roadmap Next)."
data_handling:
  - "Not in scope; placeholder stack only (#1, PR #5)."
config_defaults:
  - "CDK newStyleStackSynthesis enabled; synth is local-only (no AWS creds required)."
  - "Real-stack hardening (IAM least privilege, no public resources by default) deferred to API/Lambda ticket."
release_gates:
  - "Per-release dependency audit not yet automated; first infra baseline established (#1)."
---

Issue context: [#1](https://github.com/StacksOnTheRacks/turnur/issues/1) / [PR #5](https://github.com/StacksOnTheRacks/turnur/pull/5)
