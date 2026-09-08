---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-07
summary: "Figma-aligned SPA shell and channel IA; reusable host parties via GET /v1/rooms/mine; Load Media modal replaces Open Media Tab for title selection; tv_shows catalog enum and /catalog/tv-shows; incremental surface rollout preserving GA4/CloudWatch."
approach: "Strangler by surface: (1) shared AppShell/layout + design tokens, (2) home and catalog channel pages, (3) Your Parties page + rooms/mine API, (4) room host Load Media modal + extension bridge, (5) mobile breakpoints. Reuse cached GET /v1/catalog for global search and Load Media filter; no dedicated search microservice in HLD."
interfaces:
  - "GET /v1/rooms/mine — fan Cognito JWT required; returns { rooms: [{ roomId, displayTitle, catalogEpisodeId, lastActivityAt, visibility }] } sorted by lastActivityAt desc; hostSub === JWT.sub only; omit hostSub from response; exclude live-* system rooms"
  - "POST /v1/rooms — unchanged; card-start seeds catalogEpisodeId and visibility"
  - "PATCH /v1/rooms/{roomId} — unchanged host gate; body { catalogEpisodeId } for Load Media apply (Decision A1)"
  - "Load Media apply — SPA host PATCH then extension openHostMediaTab(resolveHostSourceTabUrl(...)) or window.open(url) for new-tab path"
  - "Global search — client-side title filter over cached catalog; combobox dropdown in AppShell navigates to /watch/{id} or channel routes; v1 catalog titles only"
  - "Catalog IA — add tv_shows to enum/schema/seed/admin; public /catalog/tv-shows; rename public Movies path to /catalog/movies with redirect from /catalog/movie-night"
  - "GET /v1/live + /live/{slug} — Live Now channel links here; no new Live list API for redesign HLD"
structure:
  - "AppShell — fixed left Sidebar (240px expanded / ~56px icon rail collapsed), TopBar (search combobox, profile menu), main content outlet"
  - "YourPartiesPage — WatchPartyCard grid from GET /v1/rooms/mine; links to /room/{roomId}"
  - "ChannelLayout — shared ChannelHero + DesktopCardRow + ViewToggle (Cards | List); per-channel route filters"
  - "LoadMediaModal — LoadMediaFrame overlay: SidebarMediaSelector categories + MediaCatalogTable; port filter/PATCH patterns from PartyCaptureMediaPicker and HostRoomConsole catalog section"
  - "Host theater — reskin NavigationSlim, Chatbox, HostTheaterButtonBar(+Extension); replace Open Media Source Tab with Load Media entry"
  - "Dynamo Rooms — HostSubRoomsIndex GSI (hostSub PK, lastActivityAt SK) for /v1/rooms/mine; backfill hostSub on existing rows"
  - "Incremental rollout — feature-flag or route-level adoption per surface after Designer sign-off; old chrome coexists until each surface swaps"
constraints:
  - "ADR-001: extension is tabs/media helper only; Room tab remains host console; no capture APIs"
  - "Rooms always have a current catalogEpisodeId; no create-without-title"
  - "Product metrics events unchanged during reskin (apps/web/src/config/googleAnalytics.ts + server EMF)"
  - "No big-bang downtime cutover"
  - "Public browse and SEO rules unchanged except new /catalog/tv-shows and /catalog/movies canonicals"
open_questions: []
---

<!--
Authoring (not validated):
- Architect-owned HLD technical spec under initiatives/<slug>/spec.md.
- Distinct from per-ticket <!-- forge-tech-spec --> comments posted at LLD refinement.
- Bump updated when any frontmatter field changes.
-->

Trust boundary unchanged: Cognito fan JWT for host mutations; anonymous catalog/lobby reads; extension bridge C1 bind on /room/:roomId. Load Media is a UX consolidation — same PATCH + navigate contract as today’s HostRoomConsole catalog add / Open Media Source Tab flow. Your Parties is the main new control-plane read surface (HostSubRoomsIndex). TV Shows requires catalog schema migration + staff tagging before the channel goes live.

Suggested LLD slice order: AppShell → one pilot channel (Home or MST3K) → tv_shows data + channel → /v1/rooms/mine + Your Parties → Load Media modal → remaining channels + mobile → host theater reskin.
