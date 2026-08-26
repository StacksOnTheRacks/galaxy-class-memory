---
doc: architecture.decisions
schema_version: 1
updated: 2026-08-25
active_decisions:
  - "ADR-001: TypeScript, Node 22, AWS CDK control plane — Status: Accepted. Context: Turnur is a greenfield backend. Decision: Ship Turnur as a serverless control plane: AWS CDK v2 in TypeScript under infra/cdk; Lambda runtime Node 22; API Gateway HTTP API; first route GET /v1/health. Reuse RiffSync's CDK/Lambda/test/synth habits. Do not copy RiffSync's Cognito, SPA, WebSocket, or media plane. Consequences: The first development slice is app is up, not game can authenticate. Game auth, match storage, and signed results need later tickets. Node 22 is locked even though RiffSync Lambdas currently use Node 24."
  - "ADR-002: Game registry and SDK key storage — Status: Accepted. Context: Games authenticate to Turnur via SDK keys; keys must not live in git. Decision: DynamoDB GameRegistry table with partition key keyHash (SHA-256 lowercase hex of full SDK key) and gameId attribute; SDK key format turnur_sk_ + 32 lowercase hex chars; on-demand billing; dev fixture (gameId dev-fixture) seeded via CDK Custom Resource using hash-only constant; plaintext fixture key confined to test-fixtures/. Consequences: #10 validates keys against this table; rotation/revocation deferred."
superseded: []
---
