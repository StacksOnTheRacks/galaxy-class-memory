---
doc: qa.test_plan
schema_version: 1
updated: 2026-08-23
scope: "Host control panel title change (PATCH + media navigate + JWT A + now playing) in apps/host-extension and apps/web/src/hostBridge (#430)"
acceptance_checks:
  - "C1 bind + selected library row: confirm/apply sends PATCH /v1/rooms/{roomId} with Bearer fan access JWT and body { catalogEpisodeId } only"
  - "PATCH 200 then media navigate/reuse with active: false; party tab remains focused; PATCH failure does not navigate as success"
  - "Unbound / not on room tab: refuse PATCH, no invented room id, clear unbound error"
  - "JWT A: SPA↔extension riffsync-host-bridge v1; access token only; content-script origin allowlist; ephemeral SW memory; no chrome.storage; 401 drops cache and retries JWT once"
  - "Auth/bridge failures (not_signed_in, refresh_failed, timeout, missing content script) surface clearly and do not PATCH successfully"
  - "HTTP 403 / 404 / 400 catalog codes / 409 / network map to distinct panel errors; 409 copy offers retry"
  - "Now playing: anonymous GET /v1/rooms/{roomId}; displayTitle else library title else id; loading / error+retry / missing-room; refresh after successful title change"
  - "Permissions: tabs; host_permissions API origin /* only; content_scripts on allowed SPA origins; no sidePanel; no capture APIs"
  - "Host UI: SPA Room tab (page-initiated bridge ping / media-tab open / playback); host-local Next Up"
  - "Product copy labeled host control panel (not branded as side panel)"
regression_focus:
  - "ADR-001 capture forbid-list greps stay clean except explicit do-not-use docs"
  - "No SFU/signaling, no /v1/admin/catalog, no refresh-token handling in the extension"
  - "host_permissions must not widen to *://*/*, SPA origins, or YouTube"
  - "#429 catalog GET stays anonymous unfiltered GET /v1/catalog; library select alone does not PATCH"
  - "#428 media-tab create/update stays active: false"
out_of_scope:
  - "#431 unpacked install / hosting-flow docs"
  - "Auto-updating room displayTitle on episode change"
  - "Continuous now-playing polling / WebSocket room sync"
  - "Web Store, Firefox/Safari, mobile Chrome"
  - "Extension capture / host_screen"
environments:
  - "Unit: npm test --prefix apps/host-extension (node --test, 45 tests)"
  - "Unit: npm test --prefix apps/web -- src/hostBridge/hostJwtBridge.test.ts (5 tests)"
  - "Static: issue #430 forbid-list, permissions, bridge, refresh-token, and PATCH greps from the riffsync repo root"
  - "Manual Chrome (required for issue Done): unpacked load with real PUBLIC_API_BASE_URL + matching host_permissions; host apply title; party tab stays focused; signed-out / non-host / unbound / offline errors; page getDisplayMedia still works"
---

Issue: [#430](https://github.com/StacksOnTheRacks/riffsync/issues/430)
