---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-11
summary: "Header reskin reuses existing fan auth/profile surfaces; no new trust boundaries or token handling."
threats:
  - "Profile menu XSS — injected script on room page could read menu DOM or hijack Sign in/out if auth UI uses unsafe rendering (existing SPA risk)"
  - "Open redirect via returnTo on Sign in from room header — same fan auth navigation contract as AppShell ProfileMenu"
mitigations:
  - "Reuse ProfileMenu and navigateToFanAuth same-origin returnTo allowlist (relative paths only)"
  - "No new postMessage surfaces, JWT bridge, or token storage from header work"
  - "Render menu labels and profile display names via safe React text nodes"
requirements:
  - "MUST NOT add friends or DM controls to the room header"
  - "MUST NOT expose refresh tokens or extend hostJwtBridge from header changes"
  - "MUST NOT change host authority checks (JWT.sub === hostSub)"
  - "Sign-in and Sign-out flows MUST remain on first-party-fan-auth baseline"
  - "Header MUST NOT introduce new authenticated API calls beyond existing ProfileMenu fan profile fetch"
open_questions: []
---

<!--
Authoring (not validated):
- Security-owned HLD notes. Required sign-off before HLD → LLD.
- Bump updated when any frontmatter field changes.
-->

Presentation-only change. Threat model unchanged from product baseline; no new assets or trust boundaries.
