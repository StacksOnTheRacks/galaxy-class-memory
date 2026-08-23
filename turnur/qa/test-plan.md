---
doc: qa.test_plan
schema_version: 1
updated: 2026-08-23
scope: "Issue #1 / PR #5 — CDK v2 TypeScript workspace under infra/cdk/ with placeholder stack, Vitest smoke test, and docs."
acceptance_checks:
  - "infra/cdk/ has bin/, lib/, lambda/ plus configs (package.json, package-lock.json, tsconfig.json, vitest.config.ts, cdk.json, .gitignore, README)"
  - "package.json: scripts build, test, synth, cdk; engines.node >=22; deps aws-cdk-lib, constructs only"
  - "bin/turnur.ts creates cdk.App and one TurnurPlaceholderStack"
  - "Placeholder stack defines no application AWS resources; forbidden-type grep passes on cdk.out/*.template.json"
  - "Vitest smoke test passes (lib/turnur-placeholder-stack.test.ts)"
  - "npm ci && npm run build && npm test && npm run synth exit 0 (local, Node 22)"
  - "infra/cdk/README.md documents Node 22, npm ci, verify commands"
  - "Root README.md points to infra/cdk/README.md"
  - "No Cognito, CloudFront SPA, WebSocket, SFU/TURN, game auth, deploy pipelines, GitHub Actions, or real API/Lambda in PR diff"
regression_focus:
  - "Placeholder stack must stay resource-free until #2+"
  - "No accidental .github/workflows or forbidden CF types in synth output"
out_of_scope:
  - "TurnurApi stack, health route, CI (#2–#4)"
  - "AWS deploy/bootstrap"
environments:
  - "Local: turnur/infra/cdk on Node 22; no AWS credentials required for synth"
  - "CI: none on PR #5 (0 check runs)"
---

Issue: [#1](https://github.com/StacksOnTheRacks/turnur/issues/1) / [PR #5](https://github.com/StacksOnTheRacks/turnur/pull/5)
