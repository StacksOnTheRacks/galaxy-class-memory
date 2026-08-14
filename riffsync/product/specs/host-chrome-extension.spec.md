# Problem

Hosts need to drive the media tab and change the room title while hosting without leaving the watch-party tab. Today, open/navigate of the host media tab and title changes force focus away from the party or SPA-only flows. Return-to-share / find-focus-room-tab is not the outcome.

# Users

- Signed-in hosts actively hosting a room on riffsync.tv (Chrome desktop)
- Not for guests, staff admin catalog ops, or hosts seeking extension-based media capture

# Requirements

- Bind room from the **active** tab URL `/room/:roomId` (Decision **C1**)
- **Host control panel** (product UX name; not “side panel”) must:
  - Know whether a **media tab is open or not**
  - Know **now playing** media associated with the bound room
  - Change the running title via **another selection from the library**
- Library = full public RiffSync catalog via public catalog HTTP API (Decision **B1**)
- Title change (Decision **A1**): host-authenticated `PATCH` room `catalogEpisodeId` **and** navigate/reuse the media tab to the matching host source URL; party tab remains focused/active
- Host JWT for room mutations via **SPA↔extension bridge** (Decision **JWT A**); same Cognito host authority as SPA (`JWT.sub === hostSub`); anonymous cannot mutate
- Open/navigate media tab without stealing party focus; reuse one media tab via tracked `tabId` when feasible (#428; absolute URL entry + ported SPA URL helper; no room/catalog HTTP in #428)
- Media tab URL resolution reuses SPA host source rules (YouTube watch vs `/watch/:catalogEpisodeId?partyCapture=1`)
- Extension does **not** capture or supply `host_screen`; no `tabCapture` / desktopCapture; page `getDisplayMedia` remains capture SoT
- Packaging is Chrome MV3; v1 may be unpacked + docs before Web Store
- Host control panel Chrome UI is Side Panel API; product language stays **host control panel**
- Child slices: #427 scaffold; #428 media-tab open/navigate + open/not; #429 library HTTP/UI (Ready: anonymous `GET /v1/catalog` + host control panel browse/select + `host_permissions` for public API origin only); #430 Ready (`ai-ready`: host PATCH `catalogEpisodeId` + media navigate, JWT A content-script/`riffsync-host-bridge` v1 postMessage, minimal now-playing via anonymous `GET /v1/rooms/{roomId}`); #431 docs Ready (`ai-ready`: unpacked install + host control panel hosting flow README; no capture / return-to-share non-goals)

# Acceptance criteria

- With active tab on `/room/:roomId`, extension binds that room for panel state and mutations (C1)
- Host control panel shows media-tab open vs not for the session
- Host control panel shows now playing for the bound room
- Host control panel loads full public catalog (B1) with clear loading / empty / error states
- Choosing another library title PATCHes `catalogEpisodeId` (host-only) and navigates/reuses the media tab (A1); clear success/failure feedback; party tab stays focused
- JWT for mutations comes from SPA↔extension bridge (JWT A)
- No extension path publishes MediaStream / `host_screen`; manual share via page `getDisplayMedia` still works after media-tab navigation
- README/docs cover unpacked install, bridge auth expectations, and non-goals (no capture; return-to-share is not MVP)

# Out of scope

- Extension media capture / `tabCapture` / offscreen capture / replacing RoomMediaEngine capture SoT
- Find/focus room tab + return-to-share as primary MVP
- Web Store listing polish as a blocker for first usable unpacked build
- Staff admin catalog CRUD from the extension
- Firefox/Safari, mobile Chrome
- Changing guest Cast / Link TV behavior

# Constraints

- ADR-001 no-capture
- Decisions: A1, B1, C1, JWT A
- Product term: **host control panel** (do not call the primary UX a side panel)
- Align media URLs with SPA `hostSourceTab` helpers
- Minimal MV3 permissions; #428 `["sidePanel","tabs"]`; #429 Ready adds `host_permissions` for the public HTTP API origin only (`PUBLIC_API_BASE_URL` / SPA `VITE_PUBLIC_API_BASE_URL` semantics); #430 adds `content_scripts` on allowed SPA origins for JWT A (SPA origins not via `host_permissions`); never add capture permissions under ADR-001

# Verification

- Manual host session on production or staging: C1 bind, media-tab awareness, now playing, library title change (PATCH + navigate), party focus preserved, no capture APIs in manifest/code
- Docs walkthrough for unpacked load + one title/media-navigate session
- Child tickets #427–#431 verify their slices when Ready/implemented

# Open questions

None

# Success metrics

- Host can see media-tab state + now playing and change title from the library without leaving the party tab
- Host control panel library + title action works for a signed-in host on a live room in one hosting session
- Zero extension capture APIs in the shipped permission/surface set for this MVP
