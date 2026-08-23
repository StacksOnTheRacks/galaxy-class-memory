---
doc: architecture.interfaces
schema_version: 1
updated: 2026-08-23
external_interfaces:
  - "Chrome MV3 extension ↔ Chrome tabs APIs: open/navigate host media tab with party tab remaining focused (active: false); reuse via tracked media tabId"
  - "SPA Room tab is the host control panel: now playing / Ready, Next Up (host-local), catalog add, open media tab, start/stop broadcast, transport when media tab open"
  - "SPA → anonymous GET /v1/catalog for Room-tab catalog browse (Decision B1)"
  - "SPA → host PATCH /v1/rooms/{roomId} with Bearer Cognito fan JWT and body { catalogEpisodeId } (Decision A1)"
  - "JWT A: MV3 content script + origin-checked window.postMessage channel riffsync-host-bridge v1; SPA answers with fan access token only"
  - "Page-initiated bridge: HOST_EXTENSION_PING/PONG, HOST_MEDIA_TAB_GET_STATE/OPEN/STATE, HOST_MEDIA_PLAYBACK/RESULT"
  - "Host media targets: YouTube watch URLs or https://riffsync.tv/watch/{catalogEpisodeId}?partyCapture=1"
  - "Page (not extension) → getDisplayMedia → RoomMediaEngine → SFU host_screen (unchanged capture SoT)"
internal_boundaries:
  - "Extension must not inject MediaStreams, mint SFU tokens, open SFU WS, or emit share_state / control-plane media signaling"
  - "Extension must not ship Side Panel / host-control-panel HTML; toolbar popup only points hosts to the Room tab"
  - "Capture and theater publish remain SPA/RoomMediaEngine-owned; extension only positions the media browsing context"
  - "Party → roomId (MVP): parse party tab /room/:roomId on allowed origins (C1); refuse mutations if unresolved"
contracts_in_flight:
  - "MV3 permission strings: permissions tabs + host_permissions for public HTTP API origin only; SPA content_scripts for bridge; forbid sidePanel, tabCapture, desktopCapture, offscreen/extension capture"
ownership:
  - "Extension package apps/host-extension — Engineer (tabs helper + bridge)"
  - "Room-tab host console — SPA apps/web room sidebar"
  - "Public catalog + room GET/PATCH HTTP contracts — existing API/BFF owners"
  - "SPA JWT + page-initiated bridge — apps/web/src/hostBridge + extension content script"
  - "host_screen capture / SFU publish — SPA RoomMediaEngine / useHostScreenCapture owners"
  - "Architecture locks (ADR-001) — Architect memory; board/SCM wins on ticket bodies"
---

See `product/specs/host-chrome-extension.spec.md` for feature-level acceptance detail.
