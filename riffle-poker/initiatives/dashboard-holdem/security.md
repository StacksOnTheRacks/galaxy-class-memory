---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-25
summary: "HLD security for dashboard-holdem: browser NLHE over API Gateway WebSocket + Lambda + DynamoDB; static play UI on S3/CloudFront; CDK via GitHub Actions OIDC. No embed, no RiffSync, no live A/V, no Turnur. Play chips only. Sit with an anonymous display name plus a server-issued seat token (account login out of this initiative). Lambda is the sole match/rules authority; hole cards stay seat-scoped on every fanout and DynamoDB read path."
threats:
  - "Hole-card cross-seat leak — seat A's holes appear in another seat's WS fanout, shared table DTO, error body, CloudWatch/APM log, or DynamoDB read outside legal showdown reveal"
  - "Unauthorized action on another seat's turn — caller presents a foreign seatId or forges an action while it is not their turn"
  - "Connection hijack / reconnect abuse — attacker steals or races a connectionId, rebinds without the seat token, or keeps a stale connection live after victim reconnect"
  - "GitHub OIDC deploy over-scope — workflow assumes a role that can mutate unrelated accounts/resources"
  - "Secrets in the client — AWS keys, DynamoDB IAM, signing secrets, or seat-token mint credentials ship in the static bundle"
  - "Accidental real-money surface — cashier, payments, KYC, or cash-out paths introduced despite play-chips-only"
  - "Seat-token theft via XSS on the static origin — JS-readable token lets attacker act as that seat until expiry/revoke"
  - "Public DynamoDB or over-privileged Lambda IAM — client or compromised function reads all seats' holes or writes arbitrary match state"
mitigations:
  - "Lambda is the only rules evaluator and match writer; browser is presentation; clients never hold DynamoDB or AWS credentials"
  - "Sit: anonymous display name + server-issued unguessable seat token bound to matchId+seatId; token is seat authority for this initiative"
  - "Every seat-scoped read/write authorizes the presented seat token for that matchId+seatId; fail closed; turn actions also require current-turn seat match"
  - "Public WS fanout and public DynamoDB projections omit hole cards except cards legally revealed at showdown"
  - "DynamoDB access only via Lambda IAM least privilege; no public table; hole fields not exposed on GSIs used for public reads"
  - "Reconnect: seat token re-binds connectionId; prior connection invalidated or ignored for that seat; connectionId alone never authorizes actions or hole reads"
  - "GitHub Actions OIDC: trust limited to this repo (and environment); deploy role least-privilege for this stack only"
  - "Static site serves UI only — no secrets in bundle; seat tokens obtained from server over WSS after sit"
  - "Play chips only — reject client-supplied stacks/pots/deals and illegal actions; no payment/cashier/KYC surfaces"
  - "Do not log hole cards, raw seat tokens, or deploy credentials"
requirements:
  - "Lambda MUST be the only match writer and rules evaluator. Browser MUST NOT evaluate poker legality or persist authoritative match state"
  - "A response or WS push MUST NOT include another seat's hole cards or hidden fields, except cards legally revealed at showdown"
  - "DynamoDB reads that can return hole cards MUST be authorized in Lambda for the caller's bound matchId+seatId"
  - "Seat-scoped actions MUST require a valid server-issued seat token for that matchId+seatId AND that it is that seat's turn"
  - "Sitting MUST work with anonymous display name + server-issued seat token. Account login MUST NOT be required for this initiative"
  - "Seat tokens MUST be unguessable, MUST NOT appear in URL query/hash, and MUST NOT ship in the static bundle"
  - "Reconnect MUST re-bind via seat token; connectionId MUST NOT be sufficient to act or fetch holes"
  - "Clients MUST NOT hold AWS credentials, DynamoDB access, or CDK/deploy secrets"
  - "GitHub Actions OIDC MUST assume a role scoped to this repo/environment with least privilege for this CDK stack"
  - "This initiative MUST NOT add real-money, cashier, payment, or KYC surfaces"
  - "Riffle MUST NOT log hole cards, raw seat tokens, or deploy credentials"
  - "This initiative's path MUST NOT depend on embed, RiffSync, live A/V, or Turnur"
open_questions: []
---

Trust boundary: player browser / CloudFront static UI (untrusted) | API Gateway WebSocket + Lambda (authority) | DynamoDB (SoT, Lambda-only) | GitHub Actions OIDC → deploy role.
