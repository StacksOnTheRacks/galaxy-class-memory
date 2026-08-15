# Active decisions

## ADR-001: Host Chrome extension — party-tab stay, Room-tab console, no capture

- **Status:** Accepted (amended 2026-08-15: Room tab is the only host control panel; Side Panel retired; page-initiated bridge + host-local Next Up)
- **Context:** Hosts need to open/navigate the host media tab and change titles without leaving the watch-party tab, including inside the installed PWA (Chrome Side Panel cannot attach to `app` windows). Capture already lives in the SPA (`useHostScreenCapture` → `getDisplayMedia` → RoomMediaEngine → SFU `host_screen`).
- **Decision:** The host Chrome MV3 extension (1) binds the room from the party tab URL `/room/:roomId` (**C1**, sender tab when messages come from the content script), (2) opens/navigates the host **media** tab without stealing focus (`active: false`) and reports media-tab open/not + play/pause controllability for party-capture URLs, (3) does **not** host a Chrome Side Panel or other extension UI chrome — the **Room** sidebar tab is the sole **host control panel**. Without the extension, Room tab stays compact (copy / visibility / rename + install CTA); with the extension present (content-script ping), Room tab shows open/broadcast, transport, host-local **Next Up** queue (catalog + http(s) URLs), and catalog add. Catalog title changes use SPA `PATCH` `{ catalogEpisodeId }` (**A1**); pasted URLs only navigate the media tab (no room now-playing mutation). Share quality lives on the Profile tab (host-only). Page↔extension bridge (`riffsync-host-bridge` v1) supports JWT A (extension→page) and page-initiated ping / media-tab state / open / playback. Packaging: `apps/host-extension`; permissions `"tabs"` + API `host_permissions`; no `sidePanel`; no capture APIs. SPA named window `riffsync-host-source` remains the no-extension fallback.
- **Consequences:** Host UI works in normal Chrome and in the desktop PWA. Extension is a tabs/media helper only. Find/focus return-to-share remains Icebox. Next Up is host-local (`localStorage`), not guest-visible or server-synced.

# Superseded

-
