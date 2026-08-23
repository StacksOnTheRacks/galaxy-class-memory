---
doc: security.checklist
schema_version: 1
updated: 2026-08-23
secrets:
  - "Host extension must not embed tokens, JWTs, credentials, or API keys. PUBLIC_API_BASE_URL is a documented execute-api origin placeholder, not a credential. Fan access JWT is obtained at runtime via the SPA bridge and must never be written to chrome.storage, disk, README, or logs."
dependencies:
  - "apps/host-extension/package.json has no runtime npm dependencies (node --test only). SPA apps/web/src/hostBridge adds no new npm packages."
authn_authz:
  - "C1 bind only: active tab /room/:roomId on https://riffsync.tv or http://localhost:5173. Unbound refuses PATCH, JWT request, and title-change navigate."
  - "Catalog remains anonymous GET /v1/catalog. Now playing is anonymous GET /v1/rooms/{roomId}."
  - "Room mutation is host-authenticated PATCH /v1/rooms/{roomId} with body only { catalogEpisodeId }, Authorization: Bearer fan access JWT. Server remains SoT (JWT.sub === hostSub); 403 not-host must not navigate as success."
  - "JWT A: SW initiates HOST_JWT_REQUEST on the bound party tab only; content script origin-checks before relay; SPA accepts event.source === window, allowlisted origin, channel === riffsync-host-bridge, v === 1. Refresh tokens never leave the SPA."
data_handling:
  - "roomId is parsed from the tab path and shown via textContent. Catalog titles, now-playing labels, and status use textContent / createElement (no innerHTML / eval)."
  - "Access tokens are not included in panel changeTitle responses or hostSessionState broadcasts. Tokens are not logged."
  - "Catalog JSON and room GET snapshots are not persisted. No persistence of tab URLs beyond in-memory media tabId."
  - "A1 media navigate uses resolveHostSourceTabUrl after PATCH 200 only; active: false."
config_defaults:
  - "Manifest permissions exactly [tabs]. host_permissions exactly the configured PUBLIC_API_BASE_URL origin plus /*. No SPA origins, YouTube, *://*/*, or https://*/* in host_permissions. No sidePanel."
  - "content_scripts matches exactly allowed SPA origins; no all_frames; isolated world; no externally_connectable."
  - "No tabCapture / desktopCapture / offscreen capture. Media-tab open only after bind and only for absolute http:/https: URLs."
release_gates:
  - "ADR-001: extension must not capture or supply host_screen; page getDisplayMedia remains capture SoT"
  - "Do not persist fan JWTs; do not handle refresh tokens in apps/host-extension; do not add externally_connectable or SPA origins to host_permissions"
  - "Do not expand API CORS for chrome-extension://"
  - "Do not add /v1/admin/* or staff catalog clients to this package"
---

Issue context: [#430](https://github.com/StacksOnTheRacks/riffsync/issues/430)
