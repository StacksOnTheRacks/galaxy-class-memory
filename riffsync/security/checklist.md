# Secrets

- Host extension must not embed tokens, JWTs, credentials, or API keys. https://github.com/StacksOnTheRacks/riffsync/issues/428 fixture YouTube watch URL / video id are public catalog fields only.

# Dependencies

- `apps/host-extension/package.json` has no runtime npm dependencies (`node --test` only).

# Authn / authz

- C1 bind only: active tab `/room/:roomId` on `https://riffsync.tv` or `http://localhost:5173`. No room PATCH and no JWT until #430.

# Data handling

- `roomId` is parsed from the tab path and shown in the host control panel via `textContent`. No catalog/room HTTP. No persistence of tab URLs beyond in-memory media `tabId`.

# Config / defaults

- Manifest `permissions` exactly `["sidePanel","tabs"]`. No `host_permissions`. No `content_scripts`. No `tabCapture` / desktopCapture / offscreen capture. Media-tab open only after bind and only for absolute `http:`/`https:` URLs.

# Release gates

- ADR-001: extension must not capture or supply `host_screen`; page `getDisplayMedia` remains capture SoT. Do not ship capture permissions or capture APIs in this package.
