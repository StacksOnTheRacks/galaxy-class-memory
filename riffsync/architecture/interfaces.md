# External interfaces

- Chrome MV3 extension ↔ Chrome tabs APIs: open/navigate host media tab with party tab remaining focused (`active: false`); reuse via tracked media `tabId` (SPA `riffsync-host-source` window name remains the no-extension fallback); report media-tab open/not + play/pause controllability.
- SPA **Room** tab is the **host control panel** (product term): now playing / Ready, Next Up (host-local), catalog add, open media tab, start/stop broadcast, transport when media tab open.
- SPA → anonymous `GET /v1/catalog` for Room-tab catalog browse (Decision B1).
- SPA → host `PATCH /v1/rooms/{roomId}` with Bearer Cognito fan JWT and body `{ catalogEpisodeId }` (Decision A1) when fast-forwarding a catalog Next Up item; pasted URLs navigate the media tab only.
- **JWT A:** MV3 content script on allowed SPA origins + origin-checked `window.postMessage` channel `riffsync-host-bridge` v1 (`HOST_JWT_REQUEST` / `HOST_JWT_RESPONSE`); extension SW may still initiate via party tab; SPA answers with fan **access** token only; ephemeral SW memory; no refresh tokens; no `externally_connectable`.
- **Page-initiated bridge:** `HOST_EXTENSION_PING` / `HOST_EXTENSION_PONG`, `HOST_MEDIA_TAB_GET_STATE` / `HOST_MEDIA_TAB_OPEN` / `HOST_MEDIA_TAB_STATE`, `HOST_MEDIA_PLAYBACK` / `HOST_MEDIA_PLAYBACK_RESULT` (content script ↔ service worker).
- Host media targets: YouTube watch URLs or `https://riffsync.tv/watch/{catalogEpisodeId}?partyCapture=1` per SPA `resolveHostSourceTabUrl`.
- Page (not extension) → `getDisplayMedia` → RoomMediaEngine → SFU `host_screen` (unchanged capture SoT).

# Internal boundaries

- Extension must not inject MediaStreams, mint SFU tokens, open SFU WS, or emit `share_state` / control-plane media signaling.
- Extension must not ship Side Panel / host-control-panel HTML; toolbar popup only points hosts to the Room tab.
- Capture and theater publish remain SPA/RoomMediaEngine-owned; extension only positions the media browsing context and reports its open state.
- Party → `roomId` (MVP): parse party tab `/room/:roomId` on allowed origins (C1); refuse mutations if unresolved.

# Contracts in flight

- MV3 permission strings: `"permissions": ["tabs"]` + `host_permissions` for public HTTP API origin only; SPA `content_scripts` for bridge; forbid `sidePanel`, `tabCapture`, `desktopCapture`, offscreen/extension capture.

# Ownership

- Extension package `apps/host-extension` — Engineer (tabs helper + bridge).
- Room-tab host console — SPA `apps/web` room sidebar.
- Public catalog + room GET/PATCH HTTP contracts — existing API/BFF owners.
- SPA JWT + page-initiated bridge — `apps/web/src/hostBridge` + extension content script.
- `host_screen` capture / SFU publish — SPA RoomMediaEngine / `useHostScreenCapture` owners.
- Architecture locks (ADR-001) — Architect memory; board/SCM wins on ticket bodies.
