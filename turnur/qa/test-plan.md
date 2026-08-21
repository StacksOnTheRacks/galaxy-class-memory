# Scope

Issue #1 / PR #5 — CDK v2 TypeScript workspace under `infra/cdk/` with placeholder stack, Vitest smoke test, and docs.

# Acceptance checks

- [x] `infra/cdk/` has `bin/`, `lib/`, `lambda/` plus configs (`package.json`, `package-lock.json`, `tsconfig.json`, `vitest.config.ts`, `cdk.json`, `.gitignore`, README)
- [x] `package.json`: scripts `build`, `test`, `synth`, `cdk`; `engines.node` `>=22`; deps `aws-cdk-lib`, `constructs` only (no `@riffsync/infra-cdk`)
- [x] `bin/turnur.ts` creates `cdk.App` and one `TurnurPlaceholderStack`
- [x] Placeholder stack defines no application AWS resources; forbidden-type grep passes on `cdk.out/*.template.json`
- [x] Vitest smoke test passes (`lib/turnur-placeholder-stack.test.ts`)
- [x] `npm ci && npm run build && npm test && npm run synth` exit 0 (local, Node 22)
- [x] `infra/cdk/README.md` documents Node 22, `npm ci`, verify commands
- [x] Root `README.md` points to `infra/cdk/README.md`
- [x] No Cognito, CloudFront SPA, WebSocket, SFU/TURN, game auth, deploy pipelines, GitHub Actions, or real API/Lambda in PR diff

# Regression focus

- Placeholder stack must stay resource-free until #2+
- No accidental `.github/workflows` or forbidden CF types in synth output

# Out of scope

- TurnurApi stack, health route, CI (#2–#4)
- AWS deploy/bootstrap

# Environments

- Local: `turnur/infra/cdk` on Node 22; no AWS credentials required for synth
- CI: none on PR (0 check runs)
