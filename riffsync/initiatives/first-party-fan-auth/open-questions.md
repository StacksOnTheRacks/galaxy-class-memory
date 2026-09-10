---
doc: product.open_questions
schema_version: 1
updated: 2026-09-10
questions:
  - id: auth-pages-scope
    question: "Besides sign-in, sign-up, and forgot-password, are email-verify / reset-confirm / change-password also first-party HTML, or do those stay on Hosted UI?"
    blocking: true
    status: open
    owner: product
  - id: hosted-ui-cutover
    question: "After first-party pages ship, do fans lose Hosted UI entirely, or does *.amazoncognito.com remain as a fallback?"
    blocking: true
    status: open
    owner: product
  - id: redesign-chrome-coupling
    question: "Do first-party auth pages adopt the executing site-redesign Figma chrome, or ship on current red-html until those surfaces land?"
    blocking: false
    status: open
    owner: designer
---

<!--
Authoring (not validated):
- questions: [{ id, question, blocking, status, owner }]
- status: open | answered | deferred
- Remove answered items; defer with status deferred rather than deleting if still relevant.
- Bump updated when any frontmatter field changes.
-->
