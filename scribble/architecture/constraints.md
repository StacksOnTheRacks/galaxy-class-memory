---
doc: architecture.constraints
schema_version: 1
updated: 2026-10-04
hard_constraints:
  - "Never use the Scrabble name, logo, or board art; rules may match, the look is original (enforced by test/brand-guard.test.ts)"
  - "No poker rules or poker UI in Scribble"
  - "Ship only a redistributable word list (ENABLE); never vendor NASPA, Collins, or other copyrighted lists"
  - "Lambda is authoritative; the client never sends board, rack, score, or bag, and such fields are rejected"
  - "Snapshots are seat-scoped; a rack appears only on its owner's connection"
  - "Every turn action requires the seat token; connectionId alone never authorizes"
  - "Serverless only: API Gateway WebSocket + Lambda + DynamoDB + S3/CloudFront via CDK and GitHub Actions OIDC"
  - "Browser-only Phaser 3 static SPA served same-origin at galaxyclass.app/scribble"
soft_constraints:
  - "One Lambda handles $connect, $disconnect, and $default"
  - "Keep TableController free of Phaser so input, draft, camera, and timeline stay unit-testable"
  - "Client-safe rules constants live in rules/limits.ts so the bundle never pulls node:crypto"
  - "Execution policies stay under the 6,144-character managed-policy limit"
  - "A dropped connection never ends a game; only leave or remove_player frees an in-game seat"
  - "The dictionary is never shipped to the browser; the preview asks check_words"
out_of_bounds:
  - "Public create-table and turn timers (not v1)"
  - "Turn notifications (email/push) for away players — later"
  - "Challenges or alternate word lists"
  - "Shared DynamoDB table or WebSocket API with Riffle"
assumptions:
  - "Galaxy Class Cognito access tokens from the studio's same-origin Amplify session"
  - "Profiles table is read-only for the runtime (GetItem); the studio profile API is the only writer"
---
