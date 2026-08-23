---
doc: product.spec
schema_version: 1
updated: 2026-08-23
feature: "Host Chrome extension"
problem: "Hosts need to drive the media tab and change titles while hosting without leaving the watch-party tab, including inside the installed desktop PWA. Return-to-share / find-focus-room-tab is not the outcome."
users:
  - "Signed-in hosts actively hosting a room on riffsync.tv (Chrome desktop)"
  - "Not for guests, staff admin catalog ops, or hosts seeking extension-based media capture"
requirements:
  - "Bind room from the party tab URL /room/:roomId (Decision C1)"
  - "Host control panel (product UX name) is the party Room sidebar tab: know whether a media tab is open or not; know now playing / Ready for the room catalog title; host-local Next Up queue (catalog titles + absolute http(s) URLs); catalog browse/add to Next Up; open media tab / start-stop broadcast / play-pause when controllable / fast-forward Next Up"
  - "Without extension: compact Room actions + Install Host Extension CTA; stage keeps Open/Share Source Tab"
  - "With extension: Room tab owns open + broadcast; hide duplicate stage CTAs"
  - "Title change for catalog Next Up items (Decision A1): SPA host PATCH catalogEpisodeId and extension navigate/reuse media tab; pasted URLs navigate media tab only (no room now-playing mutation)"
  - "Page↔extension bridge (riffsync-host-bridge v1) for presence, media-tab state/open, play/pause; JWT A retained for extension-initiated paths"
  - "Extension does not capture or supply host_screen; page getDisplayMedia remains capture SoT"
  - "Packaging is Chrome MV3 unpacked; no Side Panel"
  - "Share quality controls live on Profile (host-only)"
acceptance_criteria:
  - "Party tab on /room/:roomId binds for media-tab helpers (C1)"
  - "Room tab shows media-tab open vs not and Ready / Now Playing for the room catalog title"
  - "Room tab loads full public catalog with search; Next Up persists host-locally per room"
  - "Fast-forward catalog item PATCHes catalogEpisodeId and navigates media tab; URL item navigates only; party tab stays focused"
  - "Play/pause enabled only for party-capture controllable media tabs"
  - "No extension path publishes MediaStream / host_screen"
  - "Side Panel UI and sidePanel permission are removed; toolbar popup points to Room tab"
  - "Docs cover unpacked install + Room-tab hosting (/how-to-host-a-watchparty#host-extension)"
out_of_scope:
  - "Extension media capture / tabCapture / offscreen capture / replacing RoomMediaEngine capture SoT"
  - "Find/focus room tab + return-to-share as primary MVP"
  - "Web Store listing"
  - "Server-synced or guest-visible Next Up"
  - "Custom URL as official room now playing"
  - "Staff admin catalog CRUD from the extension"
  - "Firefox/Safari, mobile Chrome"
constraints:
  - "ADR-001 no-capture; Room-tab-only host console; extension is tabs helper"
  - "Decisions: A1, B1, C1, JWT A"
  - "Product term: host control panel (Room tab; do not brand as side panel)"
  - "Manifest: permissions tabs + API host_permissions; no sidePanel; never capture permissions"
verification: "Manual host session: extension present/absent Room-tab states, media-tab open, Next Up FF catalog + URL, broadcast, PWA Room tab works. Unit tests for Next Up queue + page-initiated bridge client. Extension package tests still pass after Side Panel removal."
open_questions: []
success_metrics:
  - metric: "Room-tab host workflow"
    target: "Host can run open/broadcast/queue/title change from the Room tab without leaving the party, including in the desktop PWA"
  - metric: "No extension capture"
    target: "Zero extension capture APIs; zero Side Panel surface"
---

Ready ticket bodies remain the contract; this spec is an optional memory projection for the host Chrome extension slice.
