# Assets

- Host Chrome MV3 package at `apps/host-extension` (unpacked): service worker, content-script bridge (JWT A + page-initiated media-tab helpers), in-memory media `tabId`; no Side Panel UI.
- Bound `roomId` and SPA origin from the party tab URL (C1; prefer content-script sender tab).
- Fan Cognito access JWT (ephemeral SW memory) used if extension-initiated PATCH remains; Room-tab catalog skips use SPA `patchRoom`.
- Ability to create or update one inactive media tab to an absolute http(s) URL.
- Chrome `tabs` permission (party-tab URL for bind; create/update plus remove listener for the tracked media tab; `tabs.sendMessage` to media/party tabs).
- Chrome `host_permissions` for the configured public HTTP API origin `/*` only.
- `content_scripts` on allowed SPA origins for `riffsync-host-bridge` v1.
- SPA Room-tab host console: host-local Next Up, catalog browse via SPA `GET /v1/catalog`, open/broadcast/transport.

# Trust boundaries

- Chrome vs extension service worker vs SPA Room-tab console vs isolated-world content script (same-extension `chrome.runtime` only; no `externally_connectable`).
- Content script vs SPA page via origin-checked `window.postMessage` (`riffsync-host-bridge` v1). SPA owns Cognito refresh; extension sees access tokens only.
- Active tab URL is browser-supplied; bind only if `url.origin` is in `ALLOWED_SPA_ORIGINS` (`https://riffsync.tv`, `http://localhost:5173`) and path is `/room/:roomId`. JWT request is sent only to that bound party tab after C1 bind.
- Media-tab destination: generic `openOrNavigate` still accepts any absolute http(s) from a same-extension sender. A1 title-change navigate uses `resolveHostSourceTabUrl` (YouTube canonical watch or bound-origin `/watch/:id?partyCapture=1`) after PATCH 200 only.
- First-party HTTP: panel/SW `fetch` to `{PUBLIC_API_BASE_URL}` under `host_permissions` (anonymous GET catalog/room; Bearer PATCH room). MV3 host permission bypasses CORS; API CORS must not add `chrome-extension://`.
- Catalog JSON and room snapshot are first-party public API data rendered in the panel; treat string fields as untrusted for HTML injection.
- Page `getDisplayMedia` (SPA) remains capture SoT; extension must not capture or supply `host_screen` (ADR-001).
- Server remains room-admin SoT (`JWT.sub === hostSub`); extension does not mint host authority.

# Threats

- Origin spoof / bind to a non-SPA site: `new URL` + exact origin allow-list + `/room/:roomId` path; `127.0.0.1` and other hosts rejected.
- Bind to an unintended room if the host's active tab is a different allowed-origin room (C1 by design).
- Open arbitrary URL via `openOrNavigate` `message.url`: SW does not allow-list destination origin; any same-extension sender can pass any http(s) URL once bound. No web-page sender path today (`externally_connectable` absent).
- Stolen or injected fan access JWT via same-origin `window.postMessage` listeners (other page scripts or other extensions on the SPA tab) during JWT A exchange. Residual of locked JWT A; refresh tokens never cross the bridge. Same-origin XSS already has in-page token access.
- Persist or log access tokens (`chrome.storage`, disk, `console` of token values) or pull refresh tokens into the extension.
- Over-broad `content_scripts.matches` (all URLs, `all_frames`, `world: MAIN`) or adding `externally_connectable` / SPA origins to `host_permissions`.
- `tabs` overreach: permission can read tab URLs/titles; code queries the active tab, messages the bound party tab, and tracks one `tabId` (does not persist browsing history).
- Over-scoped `host_permissions` (SPA origins, YouTube, `*://*/*`, `https://*/*`) or capture / injection permissions.
- Catalog/room fetch abuse: `Authorization` on anonymous GET, `/v1/admin/catalog`, or PATCH fields beyond `{ catalogEpisodeId }`.
- XSS in the host control panel: catalog title / `roomId` / now-playing / status via `textContent` and `createElement`; poster via `img.src` (not HTML); no `innerHTML` / `eval`; default MV3 CSP.
- Poisoned catalog `posterImageUrl` can load a third-party image (tracking). Not script execution. Residual while catalog is first-party.
- Capture API creep: adding `tabCapture` / desktopCapture / offscreen capture or injection `host_permissions` (SPA/YouTube).
- Non-host PATCH: API 403; extension must not treat as success or navigate.

# Mitigations

- Manifest `permissions` exactly `["tabs"]`; `host_permissions` exactly configured API origin `/*`; `content_scripts` matches allowed SPA origins only; no `sidePanel`; no capture permissions; no `externally_connectable`.
- `getPublicApiBaseUrl` requires HTTPS origin; catalog and now-playing GET are anonymous; PATCH uses Bearer access JWT and body `{ catalogEpisodeId }` only; `roomId` is `encodeURIComponent`'d.
- `parseRoomBind` allow-list + path parse; refuse open/navigate/PATCH/JWT when unbound.
- JWT A: SPA `event.source === window` + origin allow-list + channel/v1; content script drops disallowed origins and unmatched `requestId`; SW 5s timeout; ephemeral in-memory cache; 401 drop + one retry; never refresh tokens in the extension; tokens omitted from panel responses.
- `isAbsoluteHttpUrl` rejects non-http(s). A1 navigate goes through `resolveHostSourceTabUrl` (YouTube host parse or bound origin).
- Media tab `create`/`update` uses `active: false`.
- Panel library and now playing use `textContent` / `createElement`.
- ADR-001: extension does not capture or supply `host_screen`.
- No CORS allowlist change for `chrome-extension://`.
- Server enforces `JWT.sub === hostSub` on PATCH.

# Open questions

- Should the SW allow-list generic `openOrNavigate` destinations (bound origin + YouTube watch) so a future same-extension sender cannot open arbitrary http(s) URLs? A1 title-change already resolves via `resolveHostSourceTabUrl`.
