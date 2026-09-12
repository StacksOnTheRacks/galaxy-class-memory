---
doc: product.initiative
schema_version: 1
updated: 2026-09-11
slug: first-party-fan-auth
title: First-party fan auth
status: shipped
user_facing: true
signoffs:
  po: true
  architect: true
  designer: true
  security: true
board_milestone: "First-party fan auth (#39)"
board_tickets:
  - "#461 Add fan auth SRP foundation, layout, and routes"
  - "#463 Ship sign-in, sign-up, and verify-email pages"
  - "#462 Ship forgot-password and reset-password pages"
  - "#464 Ship change-password page"
  - "#465 Migrate in-app fan auth CTAs off Hosted UI"
---

<!--
Authoring (not validated):
- status: intake | hld | lld | executing | shipped
- signoffs: true | false | "na" (designer "na" when not user-facing)
- board_tickets: issue id/title strings after LLD grooming
- Bump updated when any frontmatter field changes.
-->

Fans leave riffsync.tv for Cognito Hosted UI (`*.amazoncognito.com`) to sign in, sign up, or reset a password. That origin/chrome break is the problem.

Outcome: fans complete those flows on first-party HTML pages we own and stay on riffsync.tv. Tokens and `JWT.sub === hostSub` stay. Staff remains on Cognito Hosted UI. This is not federated / Facebook login (Icebox later).

This initiative does not create board tickets (LLD grooming does). It does not change token issuance or host authority. Staff auth stays on Hosted UI.

**HLD decisions (2026-09-10):**
- **Scope:** full fan auth lifecycle on first-party HTML — sign-in, sign-up, email verify, forgot-password, reset confirm, and change-password. Fan pool, token shape, and `JWT.sub === room.hostSub` host authority stay unchanged.
- **Routes:** `/auth/sign-in`, `/auth/sign-up`, `/auth/verify-email`, `/auth/forgot-password`, `/auth/reset-password`, `/auth/change-password`; keep `/auth/callback` for legacy Hosted UI OAuth returns only.
- **In-app CTAs:** catalog, header, account gates, and room host prompts navigate to first-party `/auth/*` with `returnTo` (same-origin fan paths; auth handoff routes and off-origin values normalize to a safe default such as `/catalog`).
- **Soft Hosted UI fallback:** `*.amazoncognito.com` stays for legacy bookmarks and emailed links; this initiative does not redirect in-app CTAs to Hosted UI and does not hard-cut existing callback allowlists.
- **Out of scope:** staff stays on Cognito Hosted UI (`/admin/login`, `/admin/auth/callback`); no Facebook or federated IdP; no token-issuance or host-authority model changes.

**HLD sign-off (2026-09-10):** PO (Gherkin scenarios), Architect (spec.md), Designer (six default-state Figma frames on Auth page; error/mobile LLD follow-ons), Security (security.md). No blocking open questions. Status → `lld`.

Groomed 2026-09-10: five tickets under milestone #39. All five #461–#465 shipped Done 2026-09-11. Host milestone #39 closed. Not `/forge.implement-ticket`.
