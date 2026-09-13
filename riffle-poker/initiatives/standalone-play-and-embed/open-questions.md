---
doc: product.open_questions
schema_version: 1
updated: 2026-09-12
questions:
  - id: identity-mechanism
    question: "Standalone identity mechanism — first-party auth vs Cognito vs other?"
    blocking: true
    status: open
    owner: architect
  - id: anonymous-session
    question: "How does anonymous play bind a seat/session without an account?"
    blocking: true
    status: open
    owner: architect
  - id: embed-link-shape
    question: "Embed-mode link shape — shared iframe URL vs today's host mint/redeem bootstrap?"
    blocking: true
    status: open
    owner: architect
  - id: ws-client-locus
    question: "WebSocket client locus — browser connects to Riffle WS vs server-only orchestrator?"
    blocking: true
    status: open
    owner: architect
  - id: runtime-hosting
    question: "Where does Riffle runtime host (process/platform/IaC)?"
    blocking: false
    status: open
    owner: architect
  - id: play-lab-fate
    question: "Fate of Turnur-backed play-lab harness — keep, rewrite, or retire?"
    blocking: false
    status: open
    owner: architect
  - id: turnur-code-migration
    question: "Migration strategy for shipped Turnur-backed paths — wrap, replace in place, or freeze?"
    blocking: false
    status: open
    owner: architect
---
