---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-25
summary: "HLD security for anonymous-table-play: one seeded DynamoDB table joined only via unguessable GUID path on default CloudFront hostname; no account/Cognito/onramp; no lobby or public create_table. Reuses dashboard-holdem seat-token + seat-scoped holes over API Gateway WebSocket + Lambda. Static SPA on S3+CloudFront is untrusted; Lambda is the trust boundary. Play chips only."
threats:
  - "Table GUID / capability leak — URL is the only join secret; anyone with the GUID can call join_table; predictable or enumerable ids allow unauthorized joins"
  - "Public create_table minting — any WebSocket client can create extra tables and violate the one-seeded-table lock"
  - "Table enumeration — list/discovery API or predictable id space lets attackers find live tables without the GUID"
  - "Secrets or foreign seat data in the static SPA — AWS credentials, other seats' tokens, or hole cards shipped in the S3/CloudFront bundle"
  - "S3 public list/write or over-privileged deploy — bucket world-readable/writable, or GitHub OIDC role broader than S3/CloudFront needed for this SPA"
  - "Seat-token theft via XSS on the static origin — JS-readable token lets attacker act as that seat until expiry/revoke (existing; note only)"
  - "Client-supplied stacks/pots/deals — browser invents chip or deal state (existing)"
  - "Accidental real-money / cashier / KYC surface despite play-chips-only"
mitigations:
  - "Seeded table id MUST be a UUID (or equivalent unguessable random id); join_table only with that id; no lobby"
  - "Deployed handler MUST reject create_table (or otherwise make table creation impossible from the public WebSocket client); tables are seeded out-of-band only"
  - "Unknown tableId → table_not_found; MUST NOT add table list, search, or enumeration APIs"
  - "SPA serves UI + public WebSocket URL config only; no AWS keys, no foreign seat tokens, no hole cards in the bundle"
  - "S3 bucket not publicly listable/writable; CloudFront is the sole public read path; GitHub Actions OIDC deploy role least-privilege for this S3/CloudFront (extend existing stack role, no long-lived keys)"
  - "Sit/act authorize via server-issued seat token bound to matchId+seatId; connectionId alone never authorizes (dashboard-holdem model)"
  - "Lambda rejects client-supplied stacks/pots/deals and illegal actions; play chips only — no cashier/payment/KYC"
  - "XSS on static origin can steal local seat token — accepted residual; do not invent a new auth system in this initiative"
requirements:
  - "The table path segment (GUID) MUST be a UUID or equivalent cryptographically unguessable id. Predictable sequential or short ids are a security finding"
  - "Anyone who possesses the table GUID MAY call join_table for that table. The GUID is the join capability; there is no account gate"
  - "The deployed public WebSocket handler MUST reject create_table (or otherwise make in-product / public-client table creation impossible). Exactly one table is seeded; no lobby"
  - "Unknown tableId MUST return table_not_found. This initiative MUST NOT add a table list, discovery, or enumeration API"
  - "The static SPA MUST NOT contain AWS credentials, other users' seat tokens, or hole cards. The WebSocket URL MAY be public client config"
  - "The S3 origin bucket MUST NOT be publicly listable or writable. CloudFront MUST be the public read path"
  - "Deploy MUST use GitHub Actions OIDC with a least-privilege role for this initiative's S3/CloudFront (and existing runtime stack as already scoped). MUST NOT introduce long-lived AWS access keys in CI or the client"
  - "Sit and act MUST require a valid server-issued seat token for that matchId+seatId. connectionId MUST NOT be sufficient to sit, act, or fetch holes"
  - "Lambda MUST remain the sole match/rules authority. Hole cards MUST stay seat-scoped on every fanout and authorized read path (dashboard-holdem model)"
  - "Clients MUST NOT supply authoritative stacks, pots, or deals; Lambda MUST reject client_supplied_state"
  - "This initiative MUST NOT add account login, Cognito, onramp, custom domain, Turnur, embed/MatchStore HTTP, cashier, payment, or KYC surfaces"
  - "Riffle MUST NOT log hole cards, raw seat tokens, or deploy credentials"
open_questions: []
---

Trust boundary: player browser / CloudFront static SPA (untrusted; GUID in URL is join capability) | API Gateway WebSocket + Lambda (authority; reject create_table) | DynamoDB (one seeded table SoT; Lambda-only) | GitHub Actions OIDC → deploy role (S3/CloudFront + existing runtime).

Join model: `https://<distribution>.cloudfront.net/<table-guid>` — GUID possession ≡ join_table capability. Seat token (post-sit) remains the sit/act authority; do not replace with connectionId or invent a new auth system for XSS.
