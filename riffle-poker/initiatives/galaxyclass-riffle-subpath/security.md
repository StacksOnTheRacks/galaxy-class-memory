---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-26
summary: "HLD security for galaxyclass-riffle-subpath: one seeded DynamoDB table joined via unguessable GUID at galaxyclass.app/riffle/<guid>; no account/Cognito/Amplify on play path; S3 origin + SSM publish; no riffle prod CloudFront. Reuses dashboard-holdem seat-token model. Same-origin with studio — Riffle must not read Amplify storage."
threats:
  - "Table GUID / capability leak — URL is join secret; predictable ids allow unauthorized joins"
  - "Public create_table minting extra tables"
  - "Table enumeration via list/discovery API"
  - "Secrets or foreign seat data in static SPA bundle"
  - "S3 public list/write or over-privileged OIDC deploy role"
  - "SSM param tampering — overly broad PutParameter scope"
  - "Same-origin XSS on galaxyclass.app — malicious script in studio or Riffle bundle reading Amplify localStorage"
  - "Seat-token theft via XSS on static origin (existing residual)"
  - "Client-supplied stacks/pots/deals"
mitigations:
  - "Seeded table id MUST be unguessable UUID; join_table only with that id; no lobby"
  - "Deployed handler MUST reject create_table; exactly one seeded table"
  - "Unknown tableId → table_not_found; no enumeration APIs"
  - "SPA: UI + public webSocketUrl only; no AWS keys, foreign tokens, or hole cards in bundle"
  - "Riffle bundle excludes Amplify; does not read Cognito localStorage keys"
  - "S3 block public access; galaxyclass CloudFront OAC is public read path for /riffle/*"
  - "OIDC least-privilege: S3 on play bucket + ssm:PutParameter on /galaxyclass/riffle/play-origin-bucket only"
  - "Seat token bound to matchId+seatId for sit/act (dashboard-holdem model)"
  - "Strict CSP on galaxyclass /riffle/* behavior (galaxyclass-www stack)"
requirements:
  - "Table GUID MUST be cryptographically unguessable"
  - "GUID possession ≡ join_table capability; no account gate"
  - "Public WS handler MUST reject create_table"
  - "Static SPA MUST NOT contain AWS credentials, foreign seat tokens, or hole cards"
  - "Riffle SPA MUST NOT import Amplify or read Cognito localStorage keys"
  - "SSM write scoped to single param name /galaxyclass/riffle/play-origin-bucket"
  - "S3 origin MUST NOT be publicly listable or writable"
  - "Sit/act MUST require valid server-issued seat token"
  - "No Cognito, onramp, cashier, payment, or KYC on play path"
  - "Riffle MUST NOT log hole cards, raw seat tokens, or deploy credentials"
open_questions: []
---

Trust boundary: player browser / galaxyclass CloudFront /riffle/* static SPA (untrusted) | API Gateway WebSocket + Lambda (authority) | DynamoDB (one seeded table) | SSM (infra wiring only, not join secret).

Join model: `https://galaxyclass.app/riffle/<table-guid>` — GUID possession ≡ join capability. Same-origin with studio Amplify session is not a trust relationship until explicit integration initiative.
