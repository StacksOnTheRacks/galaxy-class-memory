---
doc: product.open_questions
schema_version: 1
updated: 2026-09-11
questions:
  - id: redesign-chrome-coupling
    question: "Do first-party auth pages adopt site-redesign Figma chrome, or ship on current red-html until browse surfaces land?"
    blocking: false
    status: answered
    owner: designer
  - id: fan-sign-out-revocation
    question: "On first-party sign-out, require GlobalSignOut (server invalidates refresh) or is clearFanTokens() alone sufficient for MVP?"
    blocking: false
    status: open
    owner: architect
  - id: new-password-required-ux
    question: "When SignIn returns NEW_PASSWORD_REQUIRED, handle inline on sign-in page vs dedicated /auth/set-new-password route?"
    blocking: false
    status: open
    owner: architect
  - id: srp-only-enforcement
    question: "Can CDK disable ALLOW_USER_PASSWORD_AUTH on the fan client once first-party SRP ships, or must password auth stay for Hosted UI fallback compatibility?"
    blocking: false
    status: open
    owner: architect
  - id: verification-email-template-urls
    question: "Will Cognito email templates point to riffsync.tv routes (requiring pool template/CDK changes) or continue to Hosted UI pages with redirect back?"
    blocking: false
    status: open
    owner: architect
  - id: auth-marketing-consent
    question: "Sign-up collects marketing opt-in or terms checkbox?"
    blocking: false
    status: open
    owner: product
  - id: cognito-advanced-security
    question: "Is Advanced Security Mode or edge rate limiting in scope for this initiative, or accepted deferral with Cognito default lockout only?"
    blocking: false
    status: open
    owner: security
  - id: global-sign-out-on-password-change
    question: "Should change-password invalidate other refresh tokens / GlobalSignOut or only rotate current session?"
    blocking: false
    status: answered
    owner: security
---

<!--
Authoring (not validated):
- questions: [{ id, question, blocking, status, owner }]
- status: open | answered | deferred
- Remove answered items; defer with status deferred rather than deleting if still relevant.
- Bump updated when any frontmatter field changes.
-->

Intake forks resolved 2026-09-10 HLD pass: auth-pages-scope = full lifecycle first-party HTML; hosted-ui-cutover = soft fallback (in-app CTAs first-party only; Hosted UI for legacy links). redesign-chrome-coupling answered: standalone auth layout + Figma tokens, not AppShell, not long-term red-html. Remaining items are LLD/design forks.
