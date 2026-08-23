---
doc: project.plan
schema_version: 1
updated: 2026-08-23
objective: "Stand up a running control plane: TypeScript / Node 22 / AWS CDK with GET /v1/health. Scaffold #1 Done; implement Ready #2–#4."
in_scope:
  - "CDK app + HTTP API + health Lambda (#2, #3)"
  - "GitHub Actions CI for cdk synth and Vitest on PRs (#4)"
  - "Next (not this slice): game authentication / SDK key"
  - "Later: match-state primitives (seats, turns, hidden views, move log, signed result)"
  - "Out of this slice: match features, host identity/chat/rooms/media, epic issues"
sequence:
  - "#1 Scaffold Turnur CDK workspace — Done (PR #5)"
  - "#2 Add TurnurApi stack with API Gateway HTTP API and Node 22 Lambda — Ready (ai-ready)"
  - "#3 Implement GET /v1/health handler and wire route — Ready (ai-ready)"
  - "#4 Add GitHub Actions CI for cdk synth and Vitest on PRs — Ready (ai-ready)"
  - "After plane is up: game authentication grooming"
dependencies:
  - "Board: #1 Done; Ready #2–#4 on https://github.com/StacksOnTheRacks/turnur"
  - "Shared project linked (https://github.com/users/StacksOnTheRacks/projects/1); labels exist"
  - "Pattern reference: RiffSync infra/cdk (not a runtime dependency)"
  - "Identity, chat, rooms, and media stay on the host"
handoffs:
  - "Engineering: /implement-ticket on #2 → #3 → #4"
  - "Architecture: ADR-001 locked; keep host-vs-engine boundary"
  - "Product: Icebox outcomes for game auth and match primitives after plane lands"
---

Board/SCM wins on ticket status.
