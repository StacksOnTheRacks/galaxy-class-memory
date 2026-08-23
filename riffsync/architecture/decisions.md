---
doc: architecture.decisions
schema_version: 1
updated: 2026-08-23
active_decisions:
  - "ADR-001: Host Chrome extension — party-tab stay, Room-tab console, no capture — Status: Accepted (amended 2026-08-15: Room tab is the only host control panel; Side Panel retired; page-initiated bridge + host-local Next Up). Context: Hosts need to open/navigate the host media tab and change titles without leaving the watch-party tab, including inside the installed PWA. Capture already lives in the SPA (useHostScreenCapture → getDisplayMedia → RoomMediaEngine → SFU host_screen). Decision: The host Chrome MV3 extension (1) binds the room from the party tab URL /room/:roomId (C1), (2) opens/navigates the host media tab without stealing focus and reports media-tab open/not + play/pause controllability, (3) does not host a Chrome Side Panel — the Room sidebar tab is the sole host control panel. Without extension, Room tab stays compact; with extension, Room tab shows open/broadcast, transport, host-local Next Up, and catalog add. Catalog title changes use SPA PATCH { catalogEpisodeId } (A1); pasted URLs only navigate the media tab. Page↔extension bridge (riffsync-host-bridge v1) supports JWT A and page-initiated ping/media-tab/playback. Packaging: apps/host-extension; permissions tabs + API host_permissions; no sidePanel; no capture APIs. Consequences: Host UI works in normal Chrome and desktop PWA. Extension is tabs/media helper only. Find/focus return-to-share remains Icebox. Next Up is host-local (localStorage), not guest-visible or server-synced."
superseded: []
---
