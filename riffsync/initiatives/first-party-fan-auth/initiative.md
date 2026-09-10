---
doc: product.initiative
schema_version: 1
updated: 2026-09-10
slug: first-party-fan-auth
title: First-party fan auth
status: hld
user_facing: true
signoffs:
  po: false
  architect: false
  designer: false
  security: false
board_milestone: ""
board_tickets: []
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

HLD package: `features/initiative.feature`, `spec.md`, `design.md`, `security.md`. Next: `/forge.initiative-design`.
