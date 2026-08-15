# Scope

- Host control panel catalog library in `apps/host-extension` ([#429](https://github.com/StacksOnTheRacks/riffsync/issues/429))

# Acceptance checks

- Anonymous `GET {PUBLIC_API_BASE_URL}/v1/catalog` (no auth, no carousel/spotlight) renders a usable list from `entries`
- Rows show `title` keyed by `id`; select stores id/row in panel-local state; no room PATCH; no JWT
- Clear loading while in flight; `entries: []` shows empty (not blank or forever spinner)
- Network / HTTP / malformed / invalid base shows error and retry without reloading the extension
- `permissions` include `sidePanel` and `tabs`; `host_permissions` is the configured API origin `/*` only; no capture APIs
- No `/v1/admin/catalog` CRUD client; no seed JSON as prod catalog SoT
- Product copy is labeled host control panel (not branded as side panel)

# Regression focus

- ADR-001 capture forbid-list greps stay clean except explicit do-not-use docs
- `host_permissions` must not widen to `*://*/*`, SPA origins, or YouTube
- Catalog fetch stays anonymous unfiltered `GET /v1/catalog`

# Out of scope

- #430 PATCH / JWT / now-playing
- #428 media-tab behavior except that this slice must not add capture, PATCH, or JWT
- Web Store, Firefox/Safari, mobile Chrome

# Environments

- Unit: `npm test --prefix apps/host-extension` (`node --test`, mocked fetch)
- Static: issue #429 forbid-list and permissions greps from the riffsync repo root
- Manual Chrome (required for issue Done): unpacked load with real `PUBLIC_API_BASE_URL` + matching `host_permissions`; loading then list or true-empty; select without room change; error + retry; no capture prompts
