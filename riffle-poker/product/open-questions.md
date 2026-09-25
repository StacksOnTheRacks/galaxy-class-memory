---
doc: product.open_questions_index
schema_version: 1
updated: 2026-09-25
items:
  - initiative: dashboard-holdem
    id: stack-blinds-defaults
    question: "Starting stack and blinds defaults for the dashboard NLHE table?"
    blocking: false
    status: answered
  - initiative: dashboard-holdem
    id: max-seats
    question: "Maximum seats at the v1 dashboard table?"
    blocking: false
    status: answered
  - initiative: dashboard-holdem
    id: turn-timer-expiry
    question: "Turn timer duration and what happens on expiry?"
    blocking: false
    status: open
  - initiative: dashboard-holdem
    id: hand-strength-outs-bar
    question: "Accuracy bar for hand strength and outs in My Hand?"
    blocking: false
    status: open
  - initiative: dashboard-holdem
    id: session-delta-baseline
    question: "Baseline for session delta in My Hand?"
    blocking: false
    status: open
  - initiative: dashboard-holdem
    id: table-discovery
    question: "How do players meet a table — share link, join code, or list?"
    blocking: false
    status: open
  - initiative: dashboard-holdem
    id: disconnect-policy
    question: "Mid-hand disconnect behavior?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: runtime-hosting
    question: "Where does Riffle runtime host?"
    blocking: false
    status: answered
  - initiative: standalone-play-and-embed
    id: play-lab-fate
    question: "Fate of Turnur-backed play-lab harness?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: anonymous-to-account
    question: "Can an anonymous session become a Riffle account without leaving the table?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: display-name-rules
    question: "Uniqueness, persistence, and moderation for in-game display names?"
    blocking: false
    status: open
  - initiative: artwork
    id: figma-pages-state
    question: "Figma MCP shows Cover-only Alto9 template?"
    blocking: false
    status: deferred
  - initiative: artwork
    id: canva-workspace
    question: "Which Canva workspace owns the Riffle kit?"
    blocking: false
    status: deferred
  - initiative: artwork
    id: chip-denom-set
    question: "Exact play-chip denomination set for flat chip art?"
    blocking: false
    status: deferred
  - initiative: artwork
    id: card-back-wire
    question: "Wire card-back in the running app?"
    blocking: false
    status: deferred
  - initiative: integrate-turnur-websockets
    id: turnur-ws-shipping
    question: "Turnur WS shipping dependency?"
    blocking: false
    status: deferred
---

runtime-hosting answered: API Gateway WebSocket + Lambda + DynamoDB + S3/CloudFront CDK/GHA (operator lock 2026-09-25). stack-blinds-defaults answered: stack 2000, blinds 1/2 (#65 refinement 2026-09-25). max-seats answered: 8 (#65 refinement 2026-09-25).
