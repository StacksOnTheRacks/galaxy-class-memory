---
doc: architecture.interfaces
schema_version: 1
updated: 2026-09-12
external_interfaces:
  - "Chrome MV3 extension ↔ Chrome tabs APIs: open/navigate host media tab with party tab remaining focused (active: false); reuse via tracked media tabId"
  - "SPA host theater bar owns Load Media / broadcast / transport; Watch Party Settings owns displayTitle, copy URL, visibility, share-quality preset; Next Up UI hidden this initiative"
  - "SPA → anonymous GET /v1/catalog for catalog browse (Decision B1)"
  - "SPA → host PATCH /v1/rooms/{roomId} with Bearer Cognito fan JWT and body { displayTitle }, { visibility }, or { catalogEpisodeId } (Decision A1); share quality is not PATCHed"
  - "JWT A: MV3 content script + origin-checked window.postMessage channel riffsync-host-bridge v1; SPA answers with fan access token only"
  - "Page-initiated bridge: HOST_EXTENSION_PING/PONG, HOST_MEDIA_TAB_GET_STATE/OPEN/STATE, HOST_MEDIA_PLAYBACK/RESULT"
  - "Host media targets: YouTube watch URLs or https://riffsync.tv/watch/{catalogEpisodeId}?partyCapture=1"
  - "Page (not extension) → getDisplayMedia → RoomMediaEngine → SFU host_screen (unchanged capture SoT)"
  - "GA4 product funnel: room_join, host_broadcast_start, host_room_create, solo_watch_start, live_channel_view with allowlisted low-cardinality params; no-op when VITE_GA_MEASUREMENT_ID unset (docs/operations/product-metrics.md)"
internal_boundaries:
  - "Extension must not inject MediaStreams, mint SFU tokens, open SFU WS, or emit share_state / control-plane media signaling"
  - "Extension must not ship Side Panel / host-control-panel HTML; toolbar popup only points hosts to the party tab / host bar"
  - "Capture and theater publish remain SPA/RoomMediaEngine-owned; extension only positions the media browsing context"
  - "Party → roomId (MVP): parse party tab /room/:roomId on allowed origins (C1); refuse mutations if unresolved"
  - "RiffSync/Product EMF is product funnel only; ops namespaces (RiffSync/Realtime, RiffSync/Media, RiffSync/Api) must not substitute for product KPIs"
contracts_in_flight:
  - "MV3 permission strings: permissions tabs + host_permissions for public HTTP API origin only; SPA content_scripts for bridge; forbid sidePanel, tabCapture, desktopCapture, offscreen/extension capture"
ownership:
  - "Extension package apps/host-extension — Engineer (tabs helper + bridge)"
  - "Host theater bar + Watch Party Settings — SPA apps/web HostTheaterButtonBar / RoomPage"
  - "Public catalog + room GET/PATCH HTTP contracts — existing API/BFF owners"
  - "SPA JWT + page-initiated bridge — apps/web/src/hostBridge + extension content script"
  - "host_screen capture / SFU publish — SPA RoomMediaEngine / useHostScreenCapture owners"
  - "Product metrics contract — Engineer + PO; docs/operations/product-metrics.md"
  - "Architecture locks (ADR-001) — Architect memory; board/SCM wins on ticket bodies"
---

See `product/specs/host-chrome-extension.spec.md` for feature-level acceptance detail.
