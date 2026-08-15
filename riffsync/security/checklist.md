# Secrets

- Host extension must not embed tokens, JWTs, credentials, or API keys. https://github.com/StacksOnTheRacks/riffsync/issues/430 `PUBLIC_API_BASE_URL` is a documented execute-api origin placeholder (`https://xxxx.execute-api.us-east-1.amazonaws.com`), not a credential. Fixture YouTube watch URL / video id remain public catalog fields only. Fan access JWT is obtained at runtime via the SPA bridge and must never be written to `chrome.storage`, disk, README, or logs.

# Dependencies

- `apps/host-extension/package.json` has no runtime npm dependencies (`node --test` only). SPA `apps/web/src/hostBridge` adds no new npm packages.

# Authn / authz

- C1 bind only: active tab `/room/:roomId` on `https://riffsync.tv` or `http://localhost:5173`. Unbound refuses PATCH, JWT request, and title-change navigate.
- Catalog remains anonymous `GET /v1/catalog`. Now playing is anonymous `GET /v1/rooms/{roomId}` (`Accept: application/json`; no Authorization).
- Room mutation is host-authenticated `PATCH /v1/rooms/{roomId}` with body only `{ catalogEpisodeId }`, `Authorization: Bearer` fan access JWT, `Content-Type` + `Accept: application/json`. Server remains SoT (`JWT.sub === hostSub`); 403 not-host must not navigate as success.
- JWT A: SW initiates `HOST_JWT_REQUEST` on the bound party tab only; content script origin-checks before relay; SPA accepts `event.source === window`, allowlisted origin, `channel === riffsync-host-bridge`, `v === 1`. Refresh tokens never leave the SPA. Access token ephemeral in SW memory; 401 drops cache and retries JWT+PATCH once.

# Data handling

- `roomId` is parsed from the tab path and shown via `textContent`. Catalog titles, now-playing labels (`displayTitle` / library title / id), and status use `textContent` / `createElement` (no `innerHTML` / `eval`). Poster `img.src` is the catalog `posterImageUrl` string (first-party catalog; not XSS).
- Access tokens are not included in panel `changeTitle` responses or `hostSessionState` broadcasts. Tokens are not logged.
- Catalog JSON and room GET snapshots are not persisted. No persistence of tab URLs beyond in-memory media `tabId`.
- A1 media navigate uses `resolveHostSourceTabUrl` (canonical YouTube watch or bound-origin `/watch/:id?partyCapture=1`) after PATCH 200 only; `active: false`.

# Config / defaults

- Manifest `permissions` exactly `["sidePanel","tabs"]`. `host_permissions` exactly the configured `PUBLIC_API_BASE_URL` origin plus `/*` (placeholder: `https://xxxx.execute-api.us-east-1.amazonaws.com/*`). No SPA origins, YouTube, `*://*/*`, or `https://*/*` in `host_permissions`.
- `content_scripts` matches exactly allowed SPA origins (`https://riffsync.tv/*`, `http://localhost:5173/*`); no `all_frames`; isolated world (not `world: MAIN`); no `externally_connectable`. Keep content-script allowlist, SPA `ALLOWED_HOST_BRIDGE_ORIGINS`, and C1 `ALLOWED_SPA_ORIGINS` in lockstep with `content_scripts.matches`.
- No `tabCapture` / desktopCapture / offscreen capture. Media-tab open only after bind and only for absolute `http:`/`https:` URLs. Replace the placeholder origin in both `config.js` and `manifest.json` before a real environment.

# Release gates

- ADR-001: extension must not capture or supply `host_screen`; page `getDisplayMedia` remains capture SoT. Do not ship capture permissions or capture APIs in this package.
- Do not persist fan JWTs; do not handle refresh tokens in `apps/host-extension`; do not add `externally_connectable` or SPA origins to `host_permissions`.
- Do not expand API CORS for `chrome-extension://`.
- Do not add `/v1/admin/*` or staff catalog clients to this package.
