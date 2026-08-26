---
doc: security.checklist
schema_version: 1
updated: 2026-08-26
secrets:
  - "infra/cdk/.gitignore excludes node_modules/, cdk.out, dist/; no secrets in repo (#1, PR #5)."
  - "Add .env* to gitignore when CDK/Lambda env config is introduced."
  - "GameRegistry (#9): SDK keys stored as SHA-256 hashes only; dev fixture plaintext in test-fixtures/ with non-production banner."
  - "Integrator docs (#13): no production SDK keys in README; dev fixture or $TURNUR_SDK_KEY placeholders only; non-production banner on any concrete example key."
dependencies:
  - "infra/cdk/package-lock.json committed; npm audit clean (0 vulns) as of 2026-08-20 (#1, PR #5)."
  - "Baseline: aws-cdk-lib ^2.173.4, constructs ^10.4.2, Node >=22."
authn_authz:
  - "Game registry storage Ready (#9); route validation #10; no player/host auth."
  - "Integrator docs (#13) describe Bearer auth and games-not-players boundary."
data_handling:
  - "Not in scope; placeholder stack only (#1, PR #5)."
config_defaults:
  - "CDK newStyleStackSynthesis enabled; synth is local-only (no AWS creds required)."
  - "Real-stack hardening (IAM least privilege, no public resources by default) deferred to API/Lambda ticket."
release_gates:
  - "Per-release dependency audit not yet automated; first infra baseline established (#1)."
---

Issue context: [#1](https://github.com/StacksOnTheRacks/turnur/issues/1) / [PR #5](https://github.com/StacksOnTheRacks/turnur/pull/5)
