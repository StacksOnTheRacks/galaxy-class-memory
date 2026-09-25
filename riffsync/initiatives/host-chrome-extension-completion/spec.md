---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-25
summary: "Ship the existing MV3 RiffSync Host extension (apps/host-extension/, v0.2.0, ADR-001 no-capture) to the Chrome Web Store and replace unpacked-install guidance with the public listing URL on the how-to page. Runtime bridge behavior is unchanged; this is packaging, distribution, and install-surface wiring only."
approach: "Add a deterministic store zip packager (prod API + riffsync.tv content_scripts; exclude tests/dev-only files). Add manifest icons (128 required for listing; 16/48/128 in package). Point CWS privacy policy at https://riffsync.tv/privacy. Introduce VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL (non-secret, build-time, deploy-prod wired after listing exists) consumed by HowToHostWatchPartyPage only; fallback to neutral copy when unset. Keep prod API origin baked in config.js + manifest host_permissions (store build = prod only; local dev stays unpacked with manual sync). Align version source-of-truth to manifest 0.2.0. Document extension artifact in build_packaging.md. Split LLD: ai-ready repo/SPA changes vs human-ready CWS dashboard submission/review."
interfaces:
  - "Chrome Web Store listing URL → SPA how-to install section via VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL (getChromeWebStoreExtensionUrl() helper; unset → no external store link)"
  - "CWS Developer Dashboard privacy policy field → https://riffsync.tv/privacy (existing PrivacyPolicyPage; no new backend)"
  - "Store zip artifact → operator upload to Chrome Web Store (no CI publish in MVP); npm run package:store or equivalent under apps/host-extension/"
  - "manifest.json icons (16/48/128) + default_icon — required store listing assets; derive from existing RiffSync brand mark"
  - "config.js PUBLIC_API_BASE_URL + manifest host_permissions — prod HttpApiUrl only in store zip; must match SPA VITE_PUBLIC_API_BASE_URL on riffsync.tv"
  - "Unchanged riffsync-host-bridge v1 — HOST_EXTENSION_PING/PONG, media-tab, JWT A; content_scripts https://riffsync.tv/* (+ localhost:5173/* in unpacked dev only unless store-build strips localhost)"
  - "deploy-prod.yml — export PROD_CHROME_WEB_STORE_EXTENSION_URL (GitHub repo variable) as VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL after first publish (same posture as VITE_CAST_RECEIVER_APP_ID)"
structure:
  - "apps/host-extension/manifest.json — icons/default_icon; version 0.2.0; store-oriented host_permissions"
  - "apps/host-extension/icons/ — 16.png, 48.png, 128.png (new)"
  - "apps/host-extension/scripts/package-store-zip.mjs + package.json script package:store — zip manifest + runtime files; exclude *.test.js, node_modules"
  - "apps/host-extension/config.js + README.md — prod store build vs unpacked local dev; remove no Web Store copy from public-facing sections"
  - "apps/web/src/config/chromeWebStoreExtensionUrl.ts (new) — trim/validate chrome.google.com or chromewebstore.google.com URL"
  - "apps/web/src/pages/HowToHostWatchPartyPage.tsx — #host-extension section: Chrome Web Store install steps + Add to Chrome when env set"
  - "apps/web/.env.development.example — document optional VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL"
  - "riffsync/.ai/operations/build_packaging.md — Host Chrome extension artifact row (zip source, manual CWS publish, env wiring)"
  - ".github/workflows/deploy-prod.yml — optional VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL from repo variable (non-blocking when unset pre-listing)"
  - "apps/web unit tests — HowToHostWatchPartyPage store-link vs fallback behavior"
constraints:
  - "ADR-001 unchanged — no tabCapture/desktopCapture/offscreen capture; no Side Panel; permissions tabs + API host_permissions only"
  - "Store listing targets production only — prod API origin in store zip; no multi-env CWS listing in this initiative"
  - "No automated Chrome Web Store publish in CI — operator manual upload + review; zip script is the code deliverable"
  - "Bridge contract and extension runtime behavior unchanged from MVP (#426–#431)"
  - "VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL is public/non-secret; missing pre-listing must not fail SPA build or room deploys"
  - "Privacy policy URL must resolve on canonical origin https://riffsync.tv/privacy before CWS submission"
  - "Version alignment — manifest version 0.2.0 is SoT for store package; reconcile package.json 0.1.0 drift"
  - "Do not modify HostRoomConsole install CTA — how-to page only per HLD scope lock; host-bar-room-control #473 Room panel removal stands"
open_questions:
  - "store-zip-localhost-matches"
  - "extension-version-source-of-truth"
  - "contributor-unpacked-fallback"
  - "privacy-policy-extension-section"
---

<!--
Authoring (not validated):
- Architect-owned HLD technical spec under initiatives/<slug>/spec.md.
- Distinct from per-ticket <!-- forge-tech-spec --> comments posted at LLD refinement.
- Bump updated when any frontmatter field changes.
-->

**Outcome:** A signed-in host on Chrome desktop installs **RiffSync Host** from the public Chrome Web Store listing instead of Developer mode → Load unpacked. `/how-to-host-a-watchparty#host-extension` references the listing when `VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL` is set.

**Store zip packaging:** Deterministic script produces `dist/riffsync-host-{version}.zip` from `apps/host-extension/` including manifest, service worker, content script, popup HTML, icons, and `config.js`. Exclude `*.test.js`, `package.json`, and test harness files. Document operator steps in README. Extend `build_packaging.md` with an extension artifact row parallel to SPA.

**Manifest store assets:** Add `icons` / `action.default_icon` (16, 48, 128). Chrome Web Store requires 128×128 for listing tile. No new permissions beyond current `tabs` + prod `host_permissions`.

**Privacy policy:** CWS dashboard **Privacy policy** field → `https://riffsync.tv/privacy`. Extension discloses tabs permission + HTTPS API calls carrying host JWT (via SPA bridge); no new collection surface beyond existing product privacy page.

**SPA env wiring:** `VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL` — full Chrome Web Store detail URL. Prod deploy reads `PROD_CHROME_WEB_STORE_EXTENSION_URL` GitHub variable after first publish. Unset → how-to shows preparatory copy without external store link.

**Environment strategy (prod API baked):** Store zip ships prod `PUBLIC_API_BASE_URL` + matching `host_permissions`. Unpacked local dev continues manual `config.js` / manifest sync with `localhost:5173` content_scripts. No staging CWS listing.

**LLD split (human-ready vs ai-ready):**

- **ai-ready:** zip script, manifest icons, README + build_packaging docs, SPA env helper + HowToHostWatchPartyPage link behavior, tests, deploy-prod env export stub.
- **human-ready:** Chrome Web Store developer account, listing title/description/screenshots, category, single-purpose justification, privacy practices questionnaire, manual zip upload, review wait, publish, then set `PROD_CHROME_WEB_STORE_EXTENSION_URL` and redeploy SPA so CTAs resolve.

**Verification:** Extension `npm test` still passes; store zip loads unpacked smoke (bridge ping); SPA tests for store URL present/absent; post-publish manual: install from listing, open `/room/:roomId`, extension-present workflow works.
