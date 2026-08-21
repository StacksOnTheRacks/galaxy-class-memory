# Active decisions

## ADR-001: TypeScript, Node 22, AWS CDK control plane

- **Status:** Accepted
- **Context:** Turnur is a greenfield backend. The orchestrator chose TypeScript, Node 22, and AWS CDK, and asked to follow RiffSync patterns at a basic running level without taking on match auth yet.
- **Decision:** Ship Turnur as a serverless control plane: AWS CDK v2 in TypeScript under `infra/cdk`; Lambda runtime Node 22; API Gateway HTTP API; first route `GET /v1/health`. Reuse RiffSync’s CDK/Lambda/test/synth habits. Do not copy RiffSync’s Cognito, SPA, WebSocket, or media plane.
- **Consequences:** The first development slice is “app is up,” not “game can authenticate.” Game auth, match storage, and signed results need later tickets. Node 22 is locked even though RiffSync Lambdas currently use Node 24.

# Superseded

-
