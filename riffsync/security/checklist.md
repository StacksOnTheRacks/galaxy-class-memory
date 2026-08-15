# Secrets

- Host extension must not embed tokens, JWTs, credentials, or API keys. https://github.com/StacksOnTheRacks/riffsync/issues/429 `PUBLIC_API_BASE_URL` is a documented execute-api origin placeholder (`https://xxxx.execute-api.us-east-1.amazonaws.com`), not a credential. Fixture YouTube watch URL / video id remain public catalog fields only.

# Dependencies

- `apps/host-extension/package.json` has no runtime npm dependencies (`node --test` only).

# Authn / authz

- C1 bind only: active tab `/room/:roomId` on `https://riffsync.tv` or `http://localhost:5173`. Catalog is anonymous `GET /v1/catalog` (`Accept: application/json`; no Authorization). No room PATCH and no JWT until #430.

# Data handling

- `roomId` is parsed from the tab path and shown via `textContent`. Catalog titles and status use `textContent` / `createElement` (no `innerHTML` / `eval`). Poster `img.src` is the catalog `posterImageUrl` string (first-party catalog; not XSS). Library selection is panel-local this slice; media-tab open still uses the #428 fixture. No persistence of tab URLs beyond in-memory media `tabId`. Catalog JSON is not persisted.

# Config / defaults

- Manifest `permissions` exactly `["sidePanel","tabs"]`. `host_permissions` exactly the configured `PUBLIC_API_BASE_URL` origin plus `/*` (placeholder: `https://xxxx.execute-api.us-east-1.amazonaws.com/*`). No SPA origins, YouTube, `*://*/*`, or `https://*/*`. No `content_scripts`. No `externally_connectable`. No `tabCapture` / desktopCapture / offscreen capture. Media-tab open only after bind and only for absolute `http:`/`https:` URLs. Replace the placeholder origin in both `config.js` and `manifest.json` before a real environment.

# Release gates

- ADR-001: extension must not capture or supply `host_screen`; page `getDisplayMedia` remains capture SoT. Do not ship capture permissions or capture APIs in this package.
- Do not add JWT, content-script bridge, or room PATCH in this package until #430.
- Do not expand API CORS for `chrome-extension://`.
