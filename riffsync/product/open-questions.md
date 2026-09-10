---
doc: product.open_questions_index
schema_version: 1
updated: 2026-09-10
items:
  - initiative: first-party-fan-auth
    id: fan-sign-out-revocation
    question: "On first-party sign-out, require GlobalSignOut (server invalidates refresh) or is clearFanTokens() alone sufficient for MVP?"
    blocking: false
    status: open
  - initiative: first-party-fan-auth
    id: new-password-required-ux
    question: "When SignIn returns NEW_PASSWORD_REQUIRED, handle inline on sign-in page vs dedicated /auth/set-new-password route?"
    blocking: false
    status: open
  - initiative: first-party-fan-auth
    id: srp-only-enforcement
    question: "Can CDK disable ALLOW_USER_PASSWORD_AUTH on the fan client once first-party SRP ships, or must password auth stay for Hosted UI fallback compatibility?"
    blocking: false
    status: open
  - initiative: first-party-fan-auth
    id: verification-email-template-urls
    question: "Will Cognito email templates point to riffsync.tv routes (requiring pool template/CDK changes) or continue to Hosted UI pages with redirect back?"
    blocking: false
    status: open
  - initiative: first-party-fan-auth
    id: auth-marketing-consent
    question: "Sign-up collects marketing opt-in or terms checkbox?"
    blocking: false
    status: open
  - initiative: first-party-fan-auth
    id: cognito-advanced-security
    question: "Is Advanced Security Mode or edge rate limiting in scope for this initiative, or accepted deferral with Cognito default lockout only?"
    blocking: false
    status: open
  - initiative: first-party-fan-auth
    id: global-sign-out-on-password-change
    question: "Should change-password invalidate other refresh tokens / GlobalSignOut or only rotate current session?"
    blocking: false
    status: open
---

<!--
Authoring (not validated):
- Rollup of initiatives/*/open-questions.md for /forge.initiative-planning.
- items: [{ initiative, id, question, blocking, status }]
- Maintained by open-questions-rollup skill — do not hand-edit as SoT.
- Bump updated when any frontmatter field changes.
-->

Rollup from first-party-fan-auth 2026-09-10 initiative-planning. All items non-blocking LLD forks; no blocking open questions.
