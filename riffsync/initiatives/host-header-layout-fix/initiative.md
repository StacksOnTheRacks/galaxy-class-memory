---
doc: product.initiative
schema_version: 1
updated: 2026-09-11
slug: host-header-layout-fix
title: Host Header Layout Fix
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

The watch-party compact header shows Now Playing, brand, and a "Watch Party" subtitle only. It does not match the Figma watch-party standard header: logo on the left, menu on the right.

Outcome: watch-party surfaces use a standard compact header aligned with Figma (logo left; right-side menu affordance). Preserve existing room chrome contracts (no friends person-icon on compact header per presentation.md; ADR-001 host flows unchanged).

This initiative does not create board tickets (LLD grooming does). It does not reopen site-redesign (closed #38). Host Bar Room Control is a separate Next queue item.

Figma file: https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync (file key `vQ6yHQyiGlOnRG7ngIOxR7`). Watch-party host frames are inventoried in design/screens.md (e.g. Watch Party Host / Media Mode `19:1900`). Designer binds the exact header frame during `/forge.initiative-design`.

**Out of scope:**
- Reopening or extending site-redesign
- Host Bar Room Control (separate initiative)
- Board tickets / host milestone until HLD sign-off and LLD grooming
- Host extension capture, find/focus, or lawful-playback policy changes

**HLD scope lock (2026-09-11):**
- **In scope:** `/room/:roomId` **NavigationSlim** reskin to Figma `910:9936` — RiffSync **logo left**, **profile menu right** (reuse ProfileMenu patterns; **no** friends person-icon per presentation.md)
- **Primary component:** `NavigationSlim.tsx` + `riffsync-app.css`; `RoomPage.tsx` props/wiring
- **Reuse:** app-shell logo asset (`/app-shell/topbar/logo.svg`), existing fan auth navigation
- **Preserve:** `--riffsync-room-chrome-height`, expanded-view chrome hide, ADR-001 host theater bar unchanged
- **Out of scope (this initiative):** Host Bar Room Control; Live channel shell header; `SiteHeader compact` dead-path cleanup (LLD fork unless needed)
