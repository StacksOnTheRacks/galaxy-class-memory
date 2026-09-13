---
doc: product.initiative
schema_version: 1
updated: 2026-09-12
slug: host-bar-room-control
title: Host Bar Room Control
status: lld
user_facing: true
signoffs:
  po: true
  architect: true
  designer: true
  security: true
board_milestone: "Host Bar Room Control (#41)"
board_tickets:
  - "#472 Replace host-bar Share with Watch Party Settings dialog"
  - "#473 Remove Room sidebar panel and playlist chrome"
---

The host theater bar still uses a Share control (`aria-label` "Share watch party") that opens a "Share Watch Party" popup with Copy party link, Rename party, and Live Now visibility. Room name, copy-link, visibility, and share quality are also spread across the chat-rail **Room** button, **Room panel**, `RoomHostIconRow`, `RoomRenameModal`, and `TheaterShareQualityControls`. Guests and hosts also reach Leave Party, Install Host Extension, Hosting Guide, and the Next Up / catalog playlist from that panel.

Outcome: the host theater bar Settings control opens one Watch Party Settings screen that consolidates party name (field + Save), party URL (field + Copy), visibility (Private / Public), and host Share Quality. Saving the party name or changing visibility shows a toast-like confirmation. The chat-rail Room button and Room panel are removed. Playlist / Next Up is removed now and deferred to a later initiative. Install Host Extension, Hosting Guide, and Leave Party are removed with the Room panel. **This initiative does not add a replacement Leave Party control.**

This initiative does not create board tickets (LLD grooming does). Host Header Layout Fix remains a separate HLD. Finish the Host Chrome Extension remains a separate Next item: removing the in-room "Install Host Extension" button is in scope; building the extension is not.

Figma file: https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync (file key `vQ6yHQyiGlOnRG7ngIOxR7`). Bound frame: design/screens.md **Watch Party Host / Media Mode / Room Settings Option** node `1433:8139`, titled Watch Party Settings.

**Out of scope:**
- Host Header Layout Fix (separate initiative; do not reopen NavigationSlim / leave-party-affordance work here)
- Finish the Host Chrome Extension (separate Next item)
- Playlist / Next Up / catalog queue (removed now; later initiative — do not create a playlist ticket)
- A new Leave Party control anywhere (header, profile menu, or settings)
- Board tickets / host milestone until HLD sign-off and LLD grooming
- Host extension capture, find/focus, or lawful-playback policy changes
- Live channel shell (already has no Room tab)
- HostTheaterButtonBar Load Media, Broadcast, Cast, AV, room-mode, Play/Pause, or the separate Host help popup (Hide/Show chat)
- `/how-to-host-a-watchparty` public page (only the in-panel buttons go away)

**HLD scope lock (2026-09-12):**
- **In scope:** `/room/:roomId` host theater bar Share → Settings; Watch Party Settings dialog from Figma `1433:8139`; toast-like confirm on party-name save and visibility change; remove chat-rail Room button, Room panel, `RoomHostIconRow`, `HostRoomConsole` playlist (Next Up + catalog add), Install Host Extension, Hosting Guide, and Leave Party in that panel; relocate host `TheaterShareQualityControls` into Settings; replace `RoomRenameModal` with the Settings Party Name field + Save
- **Primary surfaces:** `HostTheaterButtonBar.tsx` (Share popup → Settings / Watch Party Settings); `RoomPageSidebar.tsx` (Room tab/panel removal); `HostRoomConsole.tsx` / `hostNextUpQueue` (playlist removal); `RoomPage.tsx` wiring
- **Preserve:** Chat / People / Friends tabs; Load Media modal; host-bar Load Media / Broadcast / Cast / AV / mode / Play-Pause; Help/? on host bar (Hide/Show chat); `--riffsync-room-chrome-height`; ADR-001 host flows; `/how-to-host-a-watchparty` as a public page
- **Out of scope (this initiative):** Host Header Layout Fix; Finish the Host Chrome Extension; playlist return; inventing a Leave Party replacement
