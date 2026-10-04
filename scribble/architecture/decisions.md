---
doc: architecture.decisions
schema_version: 1
updated: 2026-10-04
active_decisions:
  - "ADR-own-runtime — Scribble has its own WebSocket API, Lambda, DynamoDB table, and play-origin bucket (ScribbleRuntimeStack). Nothing is shared with MatchRuntimeStack, so a Scribble deploy cannot break Riffle. Status: Accepted."
  - "ADR-riffle-session-shape — join_table, sit, leave, server-minted seat token (stored as SHA-256 hash), seat-scoped snapshots, copied from Riffle rather than shared code. Status: Accepted."
  - "ADR-shared-verifier — The Cognito access-token verifier and resolveSitIdentity live in @galaxyclass/accounts/player-verifier; Riffle re-exports them. A supplied token must verify; no token is a guest. Status: Accepted."
  - "ADR-enable-dictionary — ENABLE (public domain) ships in packages/scribble/dictionary and is copied beside the Lambda bundle (DICTIONARY_PATH). No challenges: dictionary check only. Status: Accepted."
  - "ADR-phaser-spa — Browser-only Phaser 3 static SPA; tiles, board, and decorations painted with Canvas 2D into textures; HiDPI via Scale.NONE with zoom 1/unit. Status: Accepted."
  - "ADR-themes-as-data — Themes are data objects that change only board accents, room backdrop, and scored-word emphasis; theme id is table state, set by any seated player. Status: Accepted."
  - "ADR-leave-and-disconnect — Leaving or disconnecting between turns drops the seat; on your turn it auto-passes first. No seat resume in v1. Status: Accepted."
  - "ADR-seeded-tables-only — v1 lobby lists three seeded public tables from config.json; create_table is rejected; table records carry visibility/listed/createdBy for later private invite-only tables. Status: Accepted."
  - "ADR-separate-exec-policy — Scribble deploy permissions are a separate managed policy (packages/infra/iam/scribble-runtime-cfn-exec.json) because the site policy is at the 6,144-character limit. Status: Accepted."
superseded: []
---
