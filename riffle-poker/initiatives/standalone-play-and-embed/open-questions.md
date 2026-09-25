---
doc: product.open_questions
schema_version: 1
updated: 2026-09-25
questions:
  - id: runtime-hosting
    question: "Where does Riffle runtime host (process/platform/IaC)?"
    blocking: false
    status: answered
    owner: architect
    answer: "API Gateway WebSocket + Lambda + DynamoDB + S3/CloudFront CDK/GHA (operator lock 2026-09-25)."
  - id: play-lab-fate
    question: "Fate of Turnur-backed play-lab harness — rewrite on MatchStore + shared URLs, or retire?"
    blocking: false
    status: open
    owner: architect
  - id: anonymous-to-account
    question: "Can an anonymous session become a Riffle account without leaving the current table and seat?"
    blocking: false
    status: open
    owner: product-owner
  - id: display-name-rules
    question: "Uniqueness, persistence, and moderation for in-game display names?"
    blocking: false
    status: open
    owner: product-owner
  - id: anonymous-upgrade-fixation
    question: "How does anonymous→account upgrade rotate so an attacker-set anonymous session cannot inherit the account?"
    blocking: false
    status: open
    owner: security
---
