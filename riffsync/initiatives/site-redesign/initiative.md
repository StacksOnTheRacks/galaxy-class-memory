---
doc: product.initiative
schema_version: 1
updated: 2026-09-07
slug: site-redesign
title: Site redesign
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

The live site still ships the old red-html chrome. Fans and hosts cannot use the Figma IA (fixed left vertical nav, top-bar search and Your Parties, channel cards/list including TV Shows) or host reusable parties through Load Media. Rooms already have a mutable `catalogEpisodeId` (seeded at `POST /v1/rooms`, changeable via host PATCH) — they are not permanently bound to a title — but the UX still creates a new room from a title card. Open Media Tab is the host media helper (ADR-001); find/focus stays Icebox.

Success bar: fans browse the Figma-aligned chrome (left nav, search dropdown, channel cards/list including TV Shows); signed-in hosts open Your Parties, reuse parties they own, and Load Media (default-select the title when started from a movie card; open in a new tab, or in the host-extension-owned movie tab when the extension is present). Chrome is intended to work on mobile. Preserve existing GA4/CloudWatch product-metrics instrumentation.

This initiative is the Figma redesign **plus** the functional changes listed below. It is not a big-bang downtime cutover. It does not create board tickets (LLD grooming does). It does not make find/focus the primary hosting UX, does not turn the extension into a capture source, and does not change lawful-playback policy.

Figma file: https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync (file key `vQ6yHQyiGlOnRG7ngIOxR7`). Screens are desktop 1440×1024 only; no mobile frames; missing states documented in `design.md` as HLD defaults.

**HLD decisions (2026-09-07):**
- **TV Shows:** new catalog enum `tv_shows` + public route `/catalog/tv-shows` (staff tag rows explicitly).
- **Movies channel:** Figma Channel / Movies maps to existing `movie_night` data at **`/catalog/movies`** (rename public route from `/catalog/movie-night`; keep Dynamo enum `movie_night`; redirect old path for SEO).
- **Live Now:** Figma Channel / Live Now maps to the official Live hub (`GET /v1/live`, `/live/:slug`) — not a catalog subcategory.
- **View toggle:** ship **Cards | List** in UI; Figma `View=Table` = **Cards** (card grid); `View=List` = **List** (table/list rows).
- **Load Media:** modal chooser replaces **Open Media Source Tab** for title selection; on apply → host `PATCH { catalogEpisodeId }` then extension `openHostMediaTab(resolveHostSourceTabUrl(...))` or `window.open` for new-tab path; broadcast/transport/Next Up stay on Room tab (ADR-001 unchanged).
- **Your Parties:** new **`GET /v1/rooms/mine`** (fan JWT; rooms where `hostSub === JWT.sub`; exclude system Live rooms).

Locked for this initiative:
- Main nav fixed left, vertical; hamburger collapses to icons-only
- Top bar has a vertical right floating menu that navigates to a new Your Parties page
- Top bar search lists results in a custom dropdown (HLD default in design.md)
- Channel pages include TV Shows at `/catalog/tv-shows`
- Channel pages have a cards vs list view toggle
- Party reuse: Your Parties lists rooms the signed-in host owns; Load Media changes the current title; starting from a movie card preselects that title when Load Media opens; rooms always have a current title (no create-without-title)
- Mobile is in scope: adapt the desktop system during HLD; missing Figma states are HLD/implementation work, not a stop
- Incremental surface adoption after Designer sign-off; no downtime cutover
- ADR-001 stays: extension is media-tab helper; Room tab is host console; no capture; find/focus remains Icebox

HLD package: `features/initiative.feature`, `spec.md`, `design.md`, `security.md`. Next: `/forge.initiative-planning` for sign-off review and HLD → LLD gate.
