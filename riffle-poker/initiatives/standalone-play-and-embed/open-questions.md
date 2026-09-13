---
doc: product.open_questions
schema_version: 1
updated: 2026-09-12
questions:
  - id: runtime-hosting
    question: "Where does Riffle runtime host (process/platform/IaC)?"
    blocking: false
    status: open
    owner: architect
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
  - id: embed-frame-ancestors
    question: "frame-ancestors for standalone vs embed — allowlisted hosts only, never *; how are hosts registered?"
    blocking: false
    status: open
    owner: security
  - id: ws-subscribe-auth
    question: "How does a WS subscriber prove a Riffle session, and which topic ACLs separate public table state from seat-scoped hidden views?"
    blocking: false
    status: open
    owner: security
  - id: host-spoofing-embed
    question: "How does the iframe reject a spoofed host (wrong parent, forged postMessage, copied URL on a hostile page) without treating host chrome as match authority?"
    blocking: false
    status: open
    owner: security
---
