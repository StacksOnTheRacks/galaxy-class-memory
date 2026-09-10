---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-10
summary: "Figma Auth page (vQ6yHQyiGlOnRG7ngIOxR7) with six default-state desktop frames; standalone auth layout (logo + centered AuthFormCard, no AppShell) using Text Field + CTA Link components."
figma_file: "https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync"
screens:
  - "Auth / Sign In (1617:6584)"
  - "Auth / Sign Up (1617:6621)"
  - "Auth / Verify Email (1617:6660)"
  - "Auth / Forgot Password (1617:6693)"
  - "Auth / Reset Password (1617:6724)"
  - "Auth / Change Password (1617:6763)"
states:
  - "auth-layout-standalone (logo header only — not AppShell) — shipped in Figma default frames"
  - "sign-in-default — 1617:6584"
  - "sign-up-default — 1617:6621"
  - "verify-email-pending — 1617:6660"
  - "forgot-password-default — 1617:6693"
  - "reset-password-code-entry — 1617:6724"
  - "change-password-default — 1617:6763"
  - "sign-in-submitting (LLD — not in Figma yet)"
  - "sign-in-field-error (LLD — not in Figma yet)"
  - "sign-in-form-error (LLD — not in Figma yet)"
  - "sign-up-submitting (LLD — not in Figma yet)"
  - "sign-up-field-error (LLD — not in Figma yet)"
  - "verify-email-resend-sent (LLD — not in Figma yet)"
  - "verify-email-expired-or-invalid-code (LLD — not in Figma yet)"
  - "forgot-password-sent (LLD — not in Figma yet)"
  - "forgot-password-field-error (LLD — not in Figma yet)"
  - "reset-password-submitting (LLD — not in Figma yet)"
  - "reset-password-field-error (LLD — not in Figma yet)"
  - "change-password-submitting (LLD — not in Figma yet)"
  - "change-password-field-error (LLD — not in Figma yet)"
  - "auth-mobile-stacked (LLD — 390px companions not in Figma yet)"
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

Figma page **Auth** (`1617:6583`) on file `vQ6yHQyiGlOnRG7ngIOxR7`. Six desktop frames (1440×1024) in a 3×2 grid. Each uses standalone auth layout: black viewport, Logo component (`2:88`), centered **AuthFormCard** (470px, dark surface), labeled **Text Field** instances (`1486:6621`), primary **CTA Link** (`930:10585`), secondary **CTA Link Slim** links (`1133:3473`).

**Chrome coupling (answered):** standalone auth layout + design-system components — not AppShell, not long-term red-html.

**LLD follow-ons (not blocking HLD exit):** error/submitting state frames, mobile 390 companions, extract shared AuthFormCard + AuthPageLayout components on Components page, bind token variables instead of literal fills.

Cross-refs: Home / Unauthenticated `3:185`, NavigationUnauthenticated `1378:3620`, Brand / Variables `1133:1902`.
