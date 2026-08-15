# Assets

- Host Chrome MV3 package at `apps/host-extension` (unpacked): host control panel, service worker, in-memory media `tabId`.
- Bound `roomId` and SPA origin from the active tab URL (C1).
- Ability to create or update one inactive media tab to an absolute http(s) URL.
- Chrome `tabs` permission (active-tab URL for bind; create/update plus remove listener for the tracked media tab).

# Trust boundaries

- Chrome vs extension service worker vs host control panel (same-extension `chrome.runtime` only; no `externally_connectable`; no `content_scripts` yet).
- Active tab URL is browser-supplied; bind only if `url.origin` is in `ALLOWED_SPA_ORIGINS` (`https://riffsync.tv`, `http://localhost:5173`) and path is `/room/:roomId`.
- Media-tab destination is extension-internal this slice (panel fixture + `resolveHostSourceTabUrl`); SW enforces bind + absolute http(s) only, not a destination-origin allow-list.
- Page `getDisplayMedia` (SPA) remains capture SoT; extension must not capture or supply `host_screen` (ADR-001).
- No HTTP API, JWT, or room PATCH from this package in https://github.com/StacksOnTheRacks/riffsync/issues/428.

# Threats

- Origin spoof / bind to a non-SPA site: `new URL` + exact origin allow-list + `/room/:roomId` path; `127.0.0.1` and other hosts rejected.
- Bind to an unintended room if the host's active tab is a different allowed-origin room (C1 by design; `roomId` is display-only this slice).
- Open arbitrary URL via `openOrNavigate` `message.url`: SW does not allow-list destination origin; any same-extension sender can pass any http(s) URL once bound. No web-page sender path today.
- `tabs` overreach: permission can read tab URLs/titles; code queries the active tab and tracks one `tabId` (does not persist browsing history).
- XSS in the host control panel: `roomId` via `textContent`; no `innerHTML` / `eval`; default MV3 CSP.
- `roomId` shown in the local panel and on same-extension messages; not sent to the network this slice.
- Capture API creep: adding `tabCapture` / desktopCapture / offscreen capture or injection `host_permissions`.

# Mitigations

- Manifest permissions exactly `["sidePanel","tabs"]`; no `host_permissions`; no capture permissions; no `content_scripts`; no `externally_connectable`.
- `parseRoomBind` allow-list + path parse; refuse open/navigate when unbound.
- `isAbsoluteHttpUrl` rejects non-http(s).
- Media tab `create`/`update` uses `active: false`.
- Panel uses fixture catalog fields only (no catalog/room HTTP).
- ADR-001: extension does not capture or supply `host_screen`.

# Open questions

- Before #430 content-script / JWT A: should the SW allow-list `openOrNavigate` destinations (bound origin + YouTube watch) so a future sender cannot open arbitrary http(s) URLs?
