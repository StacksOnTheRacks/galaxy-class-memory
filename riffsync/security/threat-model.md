---
doc: security.threat_model
schema_version: 1
updated: 2026-08-23
assets:
  - "Host Chrome MV3 package at apps/host-extension (unpacked): service worker, content-script bridge (JWT A + page-initiated media-tab helpers), in-memory media tabId; no Side Panel UI"
  - "Bound roomId and SPA origin from the party tab URL (C1; prefer content-script sender tab)"
  - "Fan Cognito access JWT (ephemeral SW memory) used if extension-initiated PATCH remains; Room-tab catalog skips use SPA patchRoom"
  - "Ability to create or update one inactive media tab to an absolute http(s) URL"
  - "Chrome tabs permission; host_permissions for configured public HTTP API origin /* only"
  - "content_scripts on allowed SPA origins for riffsync-host-bridge v1"
  - "SPA Room-tab host console: host-local Next Up, catalog browse via SPA GET /v1/catalog, open/broadcast/transport"
trust_boundaries:
  - "Chrome vs extension service worker vs SPA Room-tab console vs isolated-world content script (same-extension chrome.runtime only; no externally_connectable)"
  - "Content script vs SPA page via origin-checked window.postMessage (riffsync-host-bridge v1). SPA owns Cognito refresh; extension sees access tokens only"
  - "Active tab URL is browser-supplied; bind only if url.origin is in ALLOWED_SPA_ORIGINS and path is /room/:roomId"
  - "Media-tab destination: generic openOrNavigate accepts absolute http(s) from same-extension sender; A1 title-change navigate uses resolveHostSourceTabUrl after PATCH 200 only"
  - "First-party HTTP: panel/SW fetch to PUBLIC_API_BASE_URL under host_permissions; catalog JSON and room snapshot rendered in panel — treat string fields as untrusted for HTML injection"
  - "Page getDisplayMedia (SPA) remains capture SoT; extension must not capture or supply host_screen (ADR-001)"
  - "Server remains room-admin SoT (JWT.sub === hostSub); extension does not mint host authority"
threats:
  - "Origin spoof / bind to a non-SPA site: new URL + exact origin allow-list + /room/:roomId path"
  - "Bind to an unintended room if the host's active tab is a different allowed-origin room (C1 by design)"
  - "Open arbitrary URL via openOrNavigate message.url: SW does not allow-list destination origin"
  - "Stolen or injected fan access JWT via same-origin window.postMessage listeners during JWT A exchange"
  - "Persist or log access tokens (chrome.storage, disk, console) or pull refresh tokens into the extension"
  - "Over-broad content_scripts.matches or adding externally_connectable / SPA origins to host_permissions"
  - "tabs overreach: permission can read tab URLs/titles; code queries active tab and tracks one tabId"
  - "Over-scoped host_permissions or capture / injection permissions"
  - "Catalog/room fetch abuse: Authorization on anonymous GET, /v1/admin/catalog, or PATCH fields beyond { catalogEpisodeId }"
  - "XSS in the host control panel: catalog title / roomId / now-playing via textContent and createElement"
  - "Poisoned catalog posterImageUrl can load a third-party image (tracking)"
  - "Capture API creep: adding tabCapture / desktopCapture / offscreen capture"
  - "Non-host PATCH: API 403; extension must not treat as success or navigate"
mitigations:
  - "Manifest permissions exactly [tabs]; host_permissions exactly configured API origin /*; content_scripts matches allowed SPA origins only; no sidePanel; no capture permissions; no externally_connectable"
  - "getPublicApiBaseUrl requires HTTPS origin; catalog and now-playing GET are anonymous; PATCH uses Bearer access JWT and body { catalogEpisodeId } only"
  - "parseRoomBind allow-list + path parse; refuse open/navigate/PATCH/JWT when unbound"
  - "JWT A: SPA event.source === window + origin allow-list + channel/v1; SW 5s timeout; ephemeral in-memory cache; 401 drop + one retry; never refresh tokens in extension"
  - "isAbsoluteHttpUrl rejects non-http(s). A1 navigate goes through resolveHostSourceTabUrl"
  - "Media tab create/update uses active: false"
  - "Panel library and now playing use textContent / createElement"
  - "ADR-001: extension does not capture or supply host_screen"
  - "No CORS allowlist change for chrome-extension://"
  - "Server enforces JWT.sub === hostSub on PATCH"
open_questions:
  - "Should the SW allow-list generic openOrNavigate destinations (bound origin + YouTube watch) so a future same-extension sender cannot open arbitrary http(s) URLs? A1 title-change already resolves via resolveHostSourceTabUrl."
---

Scope: host Chrome MV3 extension slice (#428–#430).
