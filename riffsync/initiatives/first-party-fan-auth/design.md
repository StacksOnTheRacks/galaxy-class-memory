---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-10
summary: "Bind Figma vQ6yHQyiGlOnRG7ngIOxR7; pre-build six Auth/ frames (missing today); standalone auth layout (logo + centered card, no AppShell) using redesign tokens/components."
figma_file: "https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync"
screens:
  - "Auth / Sign In (HLD pre-build — node TBD)"
  - "Auth / Sign Up (HLD pre-build — node TBD)"
  - "Auth / Verify Email (HLD pre-build — node TBD)"
  - "Auth / Forgot Password (HLD pre-build — node TBD)"
  - "Auth / Reset Password (HLD pre-build — node TBD)"
  - "Auth / Change Password (HLD pre-build — node TBD)"
states:
  - "auth-layout-standalone (logo header only — not AppShell)"
  - "sign-in-default"
  - "sign-in-submitting"
  - "sign-in-field-error (invalid credentials, unverified email)"
  - "sign-in-form-error (network / service unavailable)"
  - "sign-up-default"
  - "sign-up-submitting"
  - "sign-up-field-error (email taken, weak password, mismatch)"
  - "sign-up-success → verify-email-prompt"
  - "verify-email-pending (check inbox copy + resend)"
  - "verify-email-resend-sent"
  - "verify-email-expired-or-invalid-code"
  - "forgot-password-default"
  - "forgot-password-submitting"
  - "forgot-password-sent (non-enumerating success copy)"
  - "forgot-password-field-error"
  - "reset-password-code-entry"
  - "reset-password-new-password (confirm field)"
  - "reset-password-submitting"
  - "reset-password-field-error (code invalid/expired, password policy)"
  - "reset-password-success → sign-in with banner"
  - "change-password-default (signed-in, from /account)"
  - "change-password-submitting"
  - "change-password-field-error (wrong current password, policy)"
  - "change-password-success"
  - "auth-mobile-stacked (HLD default — single column, 16px gutters)"
  - "auth-return-to preserved (returnPath query visible in copy or post-auth redirect only)"
a11y:
  - "One visible h1 per auth route (Sign in, Create account, Verify email, etc.); match sr-only h1 contract on indexable routes if any auth URL is public/crawlable"
  - "Every input has an associated label; placeholders are supplementary only"
  - "Primary submit is a real button type=submit; loading state disables control and exposes aria-busy"
  - "Field errors: aria-invalid on input + aria-describedby to error id; form-level errors in role=alert or aria-live=polite region"
  - "Password fields: policy hints linked via aria-describedby; optional show/hide toggle with aria-pressed and accessible name"
  - "Focus order: logo link → fields → primary action → secondary links; on submit error, move focus to first invalid field"
  - "Forgot/verify/resend links remain keyboard reachable with visible focus rings (tokenized, not color-only)"
  - "Mobile: no horizontal scroll; touch targets ≥44px on primary/secondary actions"
  - "Non-enumerating copy on forgot-password success must still be announced to screen readers without implying failure"
  - "Change-password on /account: integrate with existing account page heading hierarchy (no duplicate h1)"
open_questions:
  - "password-field-component"
  - "auth-marketing-consent"
---

<!--
Authoring (not validated):
- Designer-owned HLD notes. Leave empty / N/A sign-off when initiative is not user-facing.
- Pre-build Figma screens during HLD before LLD grooming.
- Bump updated when any frontmatter field changes.
-->

Existing Figma anchors: Home / Unauthenticated `3:185`, NavigationUnauthenticated `1378:3620`, Text Field `1486:6621`, CTA Link `930:10585`, CTA Link Slim `1133:3473`, Brand / Variables `1133:1902`. No dedicated auth screen frames on Screens page today.

**Chrome coupling (answered):** standalone auth layout + Figma tokens/components — not AppShell (sidebar/search add noise and couple to #445 rollout), not long-term red-html. Interim red-html acceptable only if tokens blocked and operator accepts a second visual pass.

**HLD layout defaults** (until Figma frames land): full-viewport centered card (~470px content width); minimal header with RiffSync logo → `/`; primary CTA uses CTA Link; secondary actions as text links; tokenized dark surface background.

Each pre-build frame: desktop 1440×1024 + mobile 390 companion. Extract shared AuthFormCard + AuthPageLayout on Components page before LLD grooming.

**Designer sign-off gate:** six Auth frames on Screens with default + error states and shared AuthFormCard; until then HLD proceeds on documented defaults with designer sign-off blocked at Refinement for user-facing tickets.
