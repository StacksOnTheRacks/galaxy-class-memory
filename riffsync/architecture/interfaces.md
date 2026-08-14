# External interfaces

- Chrome MV3 extension ↔ Chrome tabs APIs: open/navigate host media tab with party tab remaining focused (`active: false`); reuse via tracked media `tabId` (SPA `riffsync-host-source` window name remains SPA-only); report media-tab open/not.
- Extension **host control panel** UI via Chrome Side Panel API (`side_panel` + `"sidePanel"`; product term stays host control panel): now playing, library browse, title change.
- Extension → anonymous `GET /v1/catalog` (Decision B1; full public library). Optional `GET /v1/catalog/{id}` for single-row refresh / now-playing resolve.
- Extension → anonymous `GET /v1/rooms/{roomId}` for bound-room now playing (#430 Ready).
- Extension → host `PATCH /v1/rooms/{roomId}` with Bearer Cognito fan JWT (via **SPA↔extension bridge**, JWT A) and body `{ catalogEpisodeId }` (Decision A1); same authorizer/`hostSub` rules as SPA.
- **JWT A (locked, #430 Ready):** MV3 content script on allowed SPA origins (`https://riffsync.tv/*` + localhost SPA origins) + origin-checked `window.postMessage` channel `riffsync-host-bridge` v1 (`HOST_JWT_REQUEST` / `HOST_JWT_RESPONSE`); extension SW initiates via bound party tab; SPA answers with fan **access** token only after `refreshFanTokensIfStale` / `getFanAccessToken`; ephemeral SW memory; no refresh tokens; no `externally_connectable` / hardcoded extension id for MVP; SPA origins via `content_scripts.matches` (not `host_permissions`).
- Host media targets: YouTube watch URLs or `https://riffsync.tv/watch/{catalogEpisodeId}?partyCapture=1` per SPA `resolveHostSourceTabUrl`.
- Page (not extension) → `getDisplayMedia` → RoomMediaEngine → SFU `host_screen` (unchanged capture SoT).

# Internal boundaries

- Extension must not inject MediaStreams, mint SFU tokens, open SFU WS, or emit `share_state` / control-plane media signaling.
- Host control panel is catalog browse + now playing + title/episode mutation UX only — not a second YouTube playback controller and not staff admin catalog CRUD.
- Capture and theater publish remain SPA/RoomMediaEngine-owned; extension only positions the media browsing context and reports its open state.
- Party → `roomId` (MVP): parse active tab `/room/:roomId` on allowed origins (C1); refuse mutations if unresolved.

# Contracts in flight

- MV3 permission strings: scaffold allow `["sidePanel"]` (#427); #428 Ready allow `["sidePanel","tabs"]`; #429 Ready adds `host_permissions` for public HTTP API origin only; #430 Ready adds SPA `content_scripts` for JWT A; forbid `tabCapture`, `desktopCapture`, offscreen/extension capture.

# Ownership

- Extension package `apps/host-extension` — Engineer; scaffold #427; media-tab open/navigate + open/not (#428); catalog library fetch/UI (#429); PATCH + JWT bridge + now-playing (#430).
- Public catalog + room GET/PATCH HTTP contracts — existing API/BFF owners (no new endpoints required for MVP).
- SPA JWT bridge surface — SPA page listener + fan token helpers; extension content-script relay + SW cache.
- `host_screen` capture / SFU publish — SPA RoomMediaEngine / `useHostScreenCapture` owners.
- Architecture locks (ADR-001, C1, JWT A, permission forbid, Side Panel packaging) — Architect memory; board/SCM wins on ticket bodies.
