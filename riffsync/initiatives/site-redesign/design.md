---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-07
summary: "HLD design bind to RiffSync Figma (vQ6yHQyiGlOnRG7ngIOxR7); 19 desktop Screens frames inventoried in design/screens.md; missing states documented as HLD defaults for LLD."
figma_file: "https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync"
screens:
  - "Home / Unauthenticated (3:185)"
  - "Home / Authenticated (1309:2385)"
  - "Home / Your Parties (1450:10247)"
  - "Channel / MST3K (15:913)"
  - "Channel / RiffTrax (1135:4101)"
  - "Channel / Live Now (1429:3399)"
  - "Channel / Movies (1433:5811)"
  - "Channel / TV Shows (1433:6129)"
  - "Channel / Community (1434:8290)"
  - "Watch Party Host / Media Mode (19:1900)"
  - "Watch Party Host / Select Media Option (1387:3764)"
  - "Watch Party Host / Broadcast Option (1433:7834)"
  - "Watch Party Host / TV Option (1433:7985)"
  - "Watch Party Host / Share Option (1433:8139)"
  - "Watch Party Host / Camera and Audio On (1441:9139)"
  - "Watch Party Host with Extension (1053:3252)"
  - "Solo Live View Authenticated (1433:7256)"
  - "Solo Live View Unauthenticated (1433:7407)"
  - "Solo Watch Page (966:1065)"
states:
  - "sidebar-expanded (240px SidebarAuthenticated / SidebarUnauthenticated)"
  - "sidebar-collapsed (~56px icon rail with tooltips — HLD default, not in Figma)"
  - "global-search-closed"
  - "global-search-open-dropdown (results, empty, error — HLD default, not in Figma)"
  - "channel-view-cards (Figma View=Table / DesktopCardRow)"
  - "channel-view-list (Figma View=List — list/table rows; LLD adds list component if missing)"
  - "load-media-closed"
  - "load-media-open (LoadMediaFrame 1387:3912 + SidebarMediaSelector + MediaCatalogTable)"
  - "auth-signed-out (NavigationUnauthenticated)"
  - "auth-signed-in (NavigationAuthenticated profile menu 7:93)"
  - "mobile-drawer-nav (overlay sidebar — HLD default, no Figma mobile frames)"
a11y:
  - "Sidebar hamburger: aria-expanded; collapsed icons retain accessible names (tooltip or aria-label)"
  - "Global search: WAI-ARIA combobox with listbox; ArrowUp/Down + Enter; Escape closes; aria-activedescendant"
  - "Cards | List toggle: toggle button group with aria-pressed; not color-only active state"
  - "Load Media modal: role=dialog, aria-modal, focus trap, Escape dismiss, labelledby title"
  - "Channel and home carousels: preserve visible focus rings and keyboard reachability for cards"
  - "Preserve sr-only h1 patterns on indexable routes during reskin (presentation.md contract)"
  - "WatchPartyCard and MediaTableRow: title text exposed to assistive tech; poster alt from catalog title"
open_questions: []
---

<!--
Authoring (not validated):
- Designer-owned HLD notes. Leave empty / N/A sign-off when initiative is not user-facing.
- Pre-build Figma screens during HLD before LLD grooming.
- Bump updated when any frontmatter field changes.
-->

Navigation components live on Figma page **Navigation** (`966:1840`): Navigations (7:111), NavigationSlim (910:9936), SearchBox (7:49), SidebarAuthenticated (8:114), SidebarMediaSelector (1387:4171). Channel layout template on **Layouts** (`1429:3942`): Channel Layout (1429:4580), ChannelHero variants, ViewToggle (1452:5407).

**UI copy:** ship **Cards | List** (not Table). Figma `View=Table` maps to Cards grid.

**Mobile HLD (no Figma frames):** below ~768px, sidebar becomes overlay drawer opened from hamburger; top bar keeps search + profile; channel rows stack single-column; host theater chat may collapse to tab or bottom sheet in LLD — not blocking HLD.

Real frame node ids are canonical in `design/screens.md`. Tokens/components refresh via `/forge.design-system-audit` before first Ready implementation ticket.
