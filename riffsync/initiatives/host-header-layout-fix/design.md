---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-14
summary: "Bind room header to Figma NavigationSlim — logo left at 24px inset, NavigationAuthenticated right; episode title sr-only H1 (not visible in slim strip); Leave party retired."
figma_file: "https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync"
screens:
  - "NavigationSlim (910:9936)"
  - "Watch Party Host / Media Mode (19:1900)"
  - "Watch Party Host with Extension (1053:3252)"
  - "Solo Watch Page (966:1065)"
states:
  - "signed-in-default"
  - "signed-out-default"
  - "profile-menu-open"
  - "mobile-narrow"
a11y:
  - "Logo control: aria-label for RiffSync home navigation"
  - "Profile trigger: aria-expanded toggles when menu open; Escape closes menu and returns focus to trigger"
  - "Sign in button: visible label or aria-label when signed out"
  - "Room title: sr-only H1 for episode/room title; no visible title in slim header strip"
open_questions: []
---

<!--
Authoring (not validated):
- Designer-owned HLD notes. Leave empty / N/A sign-off when initiative is not user-facing.
- Pre-build Figma screens during HLD before LLD grooming.
- Bump updated when any frontmatter field changes.
-->

Figma NavigationSlim (`910:9936`, 1440×56): Logo instance (`910:9881`) left inside Navigations/Yt-Button at x=24; NavigationAuthenticated (`910:9883`) right at x=1220. Watch Party Host / Media Mode (`19:1900`) places NavigationSlim full-width at top.

**HLD defaults (no Figma mobile frames):** same two-column header at narrow widths; profile menu panel width matches AppShell ProfileMenu; no friends icon on room header.

**Mobile-narrow:** logo and menu remain on one row; menu panel uses AppShell dropdown width conventions.

**LLD locks (2026-09-14):** episode/room title is sr-only H1 only (not visible in slim strip; not in stage chrome, HostTheaterButtonBar, or a second header row). Leave party is retired from NavigationSlim and not added to the profile menu.
