---
doc: product.open_questions_index
schema_version: 1
updated: 2026-09-25
items:
  - initiative: host-bar-room-control
    id: leave-party-remaining-surface
    question: "After this initiative removes Leave Party from the Room panel, the only remaining in-room leave control is NavigationSlim. host-header-layout-fix OQ leave-party-affordance owns whether that stays, moves, or retires. This initiative must not add a replacement leave control. Confirm accepted: if the header OQ retires Leave Party, hosts and guests may have no in-room leave affordance until a later decision."
    blocking: false
    status: open
  - initiative: host-bar-room-control
    id: guest-copy-link
    question: "Guests today copy the party URL from the Room tab (RoomHostIconRow). After Room panel removal they have no in-room copy control (they still have /room/:id in the address bar). Accept loss of guest copy, or add a guest-facing copy later?"
    blocking: false
    status: open
  - initiative: host-bar-room-control
    id: toast-confirm-pattern
    question: "Operator wants toast-like confirm on name save and visibility change. No toast/snackbar/confirmation frame exists in Figma. HLD default: polite live region (role=status) after Save and visibility change. Optional design-spike only if a drawn toast is required before Ready."
    blocking: false
    status: open
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
  - initiative: host-chrome-extension-completion
    id: store-zip-localhost-matches
    question: "Should the store zip strip localhost:5173 from content_scripts matches, leaving only https://riffsync.tv/* for the published package?"
    blocking: false
    status: open
  - initiative: host-chrome-extension-completion
    id: extension-version-source-of-truth
    question: "Reconcile manifest version 0.2.0 vs package.json 0.1.0 — which is SoT for store releases and zip filenames?"
    blocking: false
    status: open
  - initiative: host-chrome-extension-completion
    id: contributor-unpacked-fallback
    question: "Keep Load unpacked instructions only in apps/host-extension/README.md, or add a collapsed for-developers note on the how-to page?"
    blocking: false
    status: open
  - initiative: host-chrome-extension-completion
    id: privacy-policy-extension-section
    question: "Does https://riffsync.tv/privacy need an extension-specific paragraph for Chrome Web Store disclosure (tabs permission, ephemeral JWT relay)?"
    blocking: false
    status: open
  - initiative: host-chrome-extension-completion
    id: developer-account-custody
    question: "Named owner and 2FA backup access for the Chrome Web Store developer account used to publish RiffSync Host."
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

Rollup from initiative-planning 2026-09-25. host-chrome-extension-completion HLD signed off; status lld.
