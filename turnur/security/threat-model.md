---
doc: security.threat_model
schema_version: 1
updated: 2026-08-25
assets:
  - "Match state (seats, turns, hidden views, move log) — future"
  - "Signed match results — future"
  - "Game SDK keys (game-to-Turnur auth) — present (#9 Ready); hashed at rest in DynamoDB GameRegistry"
  - "CDK/IaC source under infra/cdk/ — present (#1, PR #5)"
trust_boundaries:
  - "Host platform (RiffSync or equivalent): identity, chat, rooms, media — external"
  - "Turnur control plane: match engine + HTTP API — AWS boundary (health shipped; registry #9 Ready)"
  - "Game clients: authenticate via host; games authenticate to Turnur via SDK key — storage Ready (#9); validation #10"
threats:
  - "Secret leakage in IaC or Lambda env — mitigated by hash-only registry storage; dev fixture plaintext confined to test-fixtures/"
  - "Over-privileged IAM on seed Custom Resource — scoped to GameRegistry table ARN (#9 tech spec SR-004)"
  - "Unauthorized game API access — open until SDK key validation (#10)"
mitigations:
  - "GameRegistry stores SHA-256 key hashes only; ADR-002 locked at #9 refinement"
  - "Lockfile + dependency audit baseline"
  - "Product intent: authenticate games, not players; no Cognito/fan stacks"
open_questions:
  - "Key rotation/revocation — out of scope v1; manual re-provision later"
  - "Signed result verification mechanism — roadmap Later"
---

Scope: game-auth storage slice (#9 Ready). Revisit when #10 validation lands.
