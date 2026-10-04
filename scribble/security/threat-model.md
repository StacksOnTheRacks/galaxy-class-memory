---
doc: security.threat_model
schema_version: 1
updated: 2026-10-04
assets:
  - "Hidden racks (seat items in DynamoDB, owner-only snapshot field `you.rack`)"
  - "Bag contents and draw order (table META row; never in snapshots, only bagCount)"
  - "Seat tokens (server-minted, returned once in `sat`; stored only as SHA-256 hashes)"
  - "Galaxy Class access tokens presented on sit"
  - "Player subs and connection ids on seat items"
  - "ScribbleRuntimeStack resources and the OIDC deploy path"
trust_boundaries:
  - "Browser and static SPA — untrusted presentation"
  - "API Gateway WebSocket + Lambda — sole rules and state authority"
  - "DynamoDB — no direct client access; runtime has read/write on its own table and GetItem on profiles"
  - "CloudFront /scribble — same-origin with the studio; SCRIBBLE_CSP limits connect-src to self, execute-api wss, and cognito-idp"
  - "GitHub Actions OIDC → cdk-galcls-cfn-exec-role with the Scribble managed policy"
threats:
  - "Opponent reads another rack or the bag from the wire"
  - "Client submits board, rack, score, or bag to forge state"
  - "Acting for another seat or reusing a stale or forged seat token"
  - "Connection hijack: acting from a connection without the seat token"
  - "Forged or expired access token used to claim an account's name and avatar"
  - "One account taking several seats at a table"
  - "Lost update under concurrent actions"
  - "Seat-token theft via XSS on the shared origin"
  - "Deploy role over-scope"
mitigations:
  - "Per-connection snapshots strip other racks, bag, seatTokenHash, playerSub, connectionId (wire-leak tests in runtime and Playwright)"
  - "client_supplied_state rejects board, rack(s), score(s), bag, bagCount, tiles, players, seats, turnOrder, currentSeatId, and game fields"
  - "Every action verifies the seat token against stored hashes (bad-token tests); seat token kept in client memory only"
  - "aws-jwt-verify access-token check; a supplied token that fails is invalid_access_token, never a guest; name and avatar only from the profile"
  - "account_already_seated blocks a second seat per sub"
  - "Version-conditioned TransactWriteItems; a lost race returns version_conflict without fan-out"
  - "CSP with frame-ancestors none, no unsafe-eval, no cognito-identity; no secrets in the bundle (artifact credential scan)"
  - "Scribble exec policy scoped to ScribbleRuntimeStack-* resources"
open_questions: []
---
