---
doc: product.open_questions
schema_version: 1
updated: 2026-09-25
questions:
  - id: stack-blinds-defaults
    question: "Starting stack and blinds defaults for the dashboard NLHE table?"
    blocking: false
    status: open
    owner: product-owner
  - id: max-seats
    question: "Maximum seats at the v1 dashboard table?"
    blocking: false
    status: open
    owner: product-owner
  - id: turn-timer-expiry
    question: "Turn timer duration and what happens on expiry (auto-fold, auto-check where legal, or soft prompt only)?"
    blocking: false
    status: open
    owner: product-owner
  - id: hand-strength-outs-bar
    question: "Accuracy bar for hand strength and outs shown in My Hand (exact combinatorial vs approximate)?"
    blocking: false
    status: open
    owner: product-owner
  - id: session-delta-baseline
    question: "What is the baseline for session delta in My Hand (buy-in, session start stack, or table join)?"
    blocking: false
    status: open
    owner: product-owner
  - id: table-discovery
    question: "How do players meet a table — create+share link, short join code, or in-app list?"
    blocking: false
    status: open
    owner: product-owner
  - id: disconnect-policy
    question: "Mid-hand disconnect: auto-fold timer vs sit-out vs leave seat immediately?"
    blocking: false
    status: open
    owner: architect
---

Side pots: in scope when required for correct all-in settlement — not an open question. Embed / RiffSync later: out of initiative. Hosting platform: operator-locked (WS APIGW + Lambda + DynamoDB + CDK/GHA). Seat identity: settled — anonymous display name + server-issued seat token.
