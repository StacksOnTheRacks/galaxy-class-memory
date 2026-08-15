# Assets

- Host Chrome MV3 package at `apps/host-extension` (unpacked): host control panel, service worker, in-memory media `tabId`, anonymous public catalog fetch.
- Bound `roomId` and SPA origin from the active tab URL (C1).
- Ability to create or update one inactive media tab to an absolute http(s) URL.
- Chrome `tabs` permission (active-tab URL for bind; create/update plus remove listener for the tracked media tab).
- Chrome `host_permissions` for the configured public HTTP API origin `/*` only (https://github.com/StacksOnTheRacks/riffsync/issues/429).
- Public catalog list JSON (`GET /v1/catalog`) and panel-local library selection.

# Trust boundaries

- Chrome vs extension service worker vs host control panel (same-extension `chrome.runtime` only; no `externally_connectable`; no `content_scripts` yet).
- Active tab URL is browser-supplied; bind only if `url.origin` is in `ALLOWED_SPA_ORIGINS` (`https://riffsync.tv`, `http://localhost:5173`) and path is `/room/:roomId`.
- Media-tab destination is extension-internal this slice (panel fixture + `resolveHostSourceTabUrl`); SW enforces bind + absolute http(s) only, not a destination-origin allow-list.
- First HTTP from this package: panel `fetch` to `{PUBLIC_API_BASE_URL}/v1/catalog` under `host_permissions`. MV3 host permission bypasses CORS; API CORS must not add `chrome-extension://`.
- Catalog JSON is first-party public API data rendered in the panel; treat string fields as untrusted for HTML injection.
- Page `getDisplayMedia` (SPA) remains capture SoT; extension must not capture or supply `host_screen` (ADR-001).
- No JWT, room GET, or room PATCH from this package in https://github.com/StacksOnTheRacks/riffsync/issues/429.

# Threats

- Origin spoof / bind to a non-SPA site: `new URL` + exact origin allow-list + `/room/:roomId` path; `127.0.0.1` and other hosts rejected.
- Bind to an unintended room if the host's active tab is a different allowed-origin room (C1 by design; `roomId` is display-only this slice).
- Open arbitrary URL via `openOrNavigate` `message.url`: SW does not allow-list destination origin; any same-extension sender can pass any http(s) URL once bound. No web-page sender path today. Library selection does not drive navigate this slice.
- `tabs` overreach: permission can read tab URLs/titles; code queries the active tab and tracks one `tabId` (does not persist browsing history).
- Over-scoped `host_permissions` (SPA origins, YouTube, `*://*/*`, `https://*/*`) or capture / injection permissions.
- Catalog fetch abuse: `Authorization` header, `/v1/admin/catalog`, or room PATCH from this package.
- XSS in the host control panel: catalog title / `roomId` / status via `textContent` and `createElement`; poster via `img.src` (not HTML); no `innerHTML` / `eval`; default MV3 CSP.
- Poisoned catalog `posterImageUrl` can load a third-party image (tracking). Not script execution. Residual while catalog is first-party.
- Capture API creep: adding `tabCapture` / desktopCapture / offscreen capture or injection `host_permissions` (SPA/YouTube).

# Mitigations

- Manifest `permissions` exactly `["sidePanel","tabs"]`; `host_permissions` exactly configured API origin `/*`; no capture permissions; no `content_scripts`; no `externally_connectable`.
- `getPublicApiBaseUrl` requires HTTPS origin; `fetchPublicCatalog` is GET `{base}/v1/catalog` with `Accept: application/json` only.
- `parseRoomBind` allow-list + path parse; refuse open/navigate when unbound.
- `isAbsoluteHttpUrl` rejects non-http(s).
- Media tab `create`/`update` uses `active: false`.
- Panel library uses `textContent` / `createElement`; selection is panel-local; media-tab open still uses fixture URL.
- ADR-001: extension does not capture or supply `host_screen`.
- No CORS allowlist change for `chrome-extension://`.

# Open questions

- Before #430 content-script / JWT A: should the SW allow-list `openOrNavigate` destinations (bound origin + YouTube watch) so a future sender cannot open arbitrary http(s) URLs?
