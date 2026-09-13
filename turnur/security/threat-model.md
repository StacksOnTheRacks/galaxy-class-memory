---
doc: security.threat_model
schema_version: 1
updated: 2026-09-12
assets:
  - "Match state (seats, turns, hidden views, move log) — present (#29–#35 Done)"
  - "Signed match results — future"
  - "Game SDK keys (game-to-Turnur auth) — present (#9 Done); hashed at rest in DynamoDB GameRegistry"
  - "Match metadata (matchId, gameId, status, createdAt) — present (#19–#23 Done)"
  - "WebSocket notify channel (API Gateway WebSocket $connect?token= + ConnectionRegistry) — examine HLD; read-only fanout; HTTP remains authority"
  - "CDK/IaC source under infra/cdk/ — present (#1, PR #5)"
  - "Integrator onboarding docs (infra/cdk/README.md) — #13 Done; public doc surface for auth guidance"
trust_boundaries:
  - "Host platform (RiffSync or equivalent): identity, chat, rooms, media — external"
  - "Turnur control plane: match engine + HTTP API — AWS boundary (health shipped; registry #9 Ready; in-handler auth #10 Ready)"
  - "Game clients: authenticate via host; games authenticate to Turnur via SDK key — storage Ready (#9); validation Ready (#10)"
threats:
  - "Secret leakage in IaC or Lambda env — mitigated by hash-only registry storage; dev fixture plaintext confined to test-fixtures/"
  - "Secret leakage via integrator docs — mitigated by #13: placeholders or dev fixture with non-production banner only; no production keys in README"
  - "SDK key on $connect query string logged by API Gateway access logs, CloudWatch, or Lambda event dumps — token is a live key (integrate-websockets HLD)"
  - "Over-privileged IAM on seed Custom Resource — scoped to GameRegistry table ARN (#9 tech spec SR-004)"
  - "Unauthorized game API access — mitigated by #10 in-handler SDK key validation on protected routes; health remains open"
mitigations:
  - "GameRegistry stores SHA-256 key hashes only; ADR-002 locked at #9 refinement"
  - "In-handler auth: hash-then-lookup, distinct missing/invalid codes, no key material in errors or logs (#10)"
  - "WS $connect: hash-then-lookup; no key in close frames/errors/logs; access-log format omits query string; production keys server-side (#13 extension)"
  - "Integrator docs: env-var placeholders, dev fixture non-production banner, no key logging guidance (#13)"
  - "Lockfile + dependency audit baseline"
  - "Product intent: authenticate games, not players; no Cognito/fan stacks"
open_questions:
  - "Key rotation/revocation — out of scope v1; manual re-provision later"
  - "Signed result verification mechanism — roadmap Later"
  - "API Gateway WS access-log redaction of $connect query string — non-blocking LLD (ws-apigw-access-log-redaction)"
---

Scope: game-auth (#9–#13 Done). Match authority primitives (#29–#35 Done). WebSocket notify examine (integrate-websockets HLD). Signed result still Later.
