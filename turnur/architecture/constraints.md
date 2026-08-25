---
doc: architecture.constraints
schema_version: 1
updated: 2026-08-25
hard_constraints:
  - "Implementation language is TypeScript. Toolchain and Lambda runtime are Node 22."
  - "Infrastructure is AWS CDK v2 (TypeScript), in the same family as RiffSync's infra/cdk."
  - "After a host attaches a match, Turnur is state authority for seats, turns, hidden views, the move log, and the signed result. The host does not become match authority."
  - "Turnur does not own player identity. Identity, chat, rooms, and media stay on the host."
  - "Turnur is a match engine, not a social app or game catalog, and must not grow rooms, presence, chat, media, or a store of its own."
soft_constraints:
  - "Prefer RiffSync control-plane patterns: colocated Lambda TS handlers, Vitest, cdk synth on PRs, /v1 HTTP routes."
  - "Stay host-agnostic: RiffSync is one host, not the only host."
  - "Game-auth slice (#9–#13) adds DynamoDB registry + SDK-key validation only — no player/host auth, match tables, or attach APIs in this slice."
  - "Defer signing-mechanism and match-protocol choices until there is a reason to lock them."
out_of_bounds:
  - "Player login, accounts, or identity as a Turnur concern."
  - "Becoming a watch-party, lobby, chat, catalog, or identity product."
  - "Re-hosting or redistributing host media."
  - "Copying RiffSync's Cognito, CloudFront SPA, WebSocket chat, SFU/TURN, or SES stacks."
  - "Treating SDK-key auth or signed-result mechanism as locked ADRs (product intent only until an ADR says otherwise)."
assumptions:
  - "A host can attach a match later. How attach works is undecided."
  - "Product Now is game authentication via SDK key (#9–#13 Refinement). Storage/validation mechanism resolves at #9 (ADR-002)."
  - "How a result is signed, and how a host or game verifies it, is undecided."
---
