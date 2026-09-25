---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-25
summary: "HLD security for Chrome Web Store distribution of the existing RiffSync Host MV3 extension. No new runtime trust boundaries; primary new risks are store disclosure accuracy, supply-chain integrity of the upload artifact, and install-link hygiene. ADR-001 no-capture, JWT A bridge, C1 bind, and checklist permission set remain unchanged."
threats:
  - "Store review permission creep — listing or review feedback pressures adding capture, Side Panel, storage, scripting, or broader host_permissions beyond today's minimal MV3 set"
  - "Misleading store metadata — title, description, screenshots, or category imply screen/tab capture, Side Panel host UI, or permissions the extension does not use (ADR-001 violation by user expectation and review risk)"
  - "Inaccurate single-purpose / privacy disclosures — Chrome Web Store justification or privacy policy over-claims (capture, persistent storage, cross-site tracking) or under-discloses tabs URL access and ephemeral JWT relay"
  - "Supply-chain compromise of store upload zip — tampered build artifact, unsigned or wrong-version package uploaded, or compromised Chrome Web Store developer account publishes malicious update"
  - "Version skew — store build diverges from apps/host-extension source (manifest permissions, bridge v1 contract, host_permissions origin) while SPA/docs assume store install equals unpacked MVP"
  - "Install-link tabnabbing / opener leakage — external chrome.google.com / chromewebstore.google.com links opened without rel=noopener noreferrer expose party-tab opener to store origin"
  - "Phishing / typosquat listing — users install a non-RiffSync extension because how-to CTA or docs lack publisher verification cues (official store URL, extension name, publisher identity)"
  - "JWT bridge regression during packaging — store build accidentally bundles debug origins, adds chrome.storage token persistence, or changes riffsync-host-bridge v1 without HLD review"
  - "False capture narrative in host docs — /how-to-host-a-watchparty copy conflates extension install with Share Source Tab / getDisplayMedia capture SoT"
mitigations:
  - "Ship the same MV3 package already validated unpacked: permissions exactly [tabs]; host_permissions exactly configured PUBLIC_API_BASE_URL /*; content_scripts matches allowed SPA origins only; no sidePanel; no tabCapture / desktopCapture / offscreen; no externally_connectable; no chrome.storage for tokens"
  - "Store listing copy mirrors manifest description and ADR-001: background media-tab helper; host UI in Room tab; does not capture media. Permission justifications cite inactive tab create/update and bound-party-tab bridge only"
  - "Privacy policy states single purpose (host media-tab helper for riffsync.tv parties), ephemeral in-memory access JWT via SPA bridge (JWT A), no refresh tokens in extension, no chrome.storage persistence of tokens/URLs, tabs used for active party tab bind and one tracked media tabId"
  - "Build store zip from reproducible npm test + zip script from apps/host-extension/; record content hash and manifest version in release notes; restrict upload to named maintainers with Chrome Web Store 2FA"
  - "Pre-upload gate: manifest.json diff empty vs main except version bump; npm test --prefix apps/host-extension; checklist release gates grep (no capture APIs, no storage writes for JWT)"
  - "SPA how-to external store links use target=_blank with rel=noopener noreferrer; prefer chromewebstore.google.com/detail/... canonical URL once extension ID is known"
  - "How-to names publisher + extension title (RiffSync Host) and links only to the official listing when env is set; docs retire Load unpacked as primary path but may keep contributor-only dev note in README separate from host-facing how-to"
  - "No runtime code changes required for distribution beyond packaging; do not add externally_connectable or SPA runtime ID pinning unless a future ADR opens it"
  - "Host docs preserve capture SoT separation: Share Source Tab / getDisplayMedia is SPA-owned; extension install enables Open Media Source Tab / Next Up / catalog navigate only"
requirements:
  - "Chrome Web Store package MUST be built from apps/host-extension/ without adding permissions, host_permissions entries, content_scripts matches, or capture-related APIs beyond the shipped unpacked MVP"
  - "Store listing title, description, category, and screenshots MUST NOT claim or imply tabCapture, desktopCapture, screen recording, Side Panel host console, or extension-supplied host_screen (ADR-001)"
  - "Chrome Web Store single-purpose statement and linked privacy policy MUST accurately describe: tabs permission (read active tab URL/title for C1 bind and media-tab tracking), host_permissions (HTTPS API origin for anonymous catalog/room GET and host PATCH), content_scripts (SPA origin bridge only), ephemeral access JWT via JWT A, no refresh tokens in extension, no persistent token storage"
  - "Privacy policy URL MUST be reachable on a first-party riffsync.tv page before public listing; policy MUST NOT claim data sale or unrelated purposes"
  - "Store upload artifact MUST pass apps/host-extension tests and security checklist release gates before submission; version in manifest MUST monotonically increase per store release"
  - "Supply chain: store zip MUST be produced by documented automation or maintainer runbook; upload credentials MUST use Chrome Web Store developer account with 2FA; release MUST record manifest version + package hash"
  - "/how-to-host-a-watchparty#host-extension MUST link to the official Chrome Web Store listing (not Load unpacked) for host-facing install guidance when VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL is set"
  - "All external links to chrome.google.com or chromewebstore.google.com from riffsync.tv SPA MUST use rel=noopener noreferrer (and target=_blank when opening a new browsing context)"
  - "JWT A bridge contract MUST remain unchanged: SPA-owned refresh; extension access-only ephemeral SW memory; origin-checked riffsync-host-bridge v1 postMessage; no chrome.storage, disk, or console logging of tokens"
  - "C1 bind, room PATCH authority (JWT.sub === hostSub), and resolveHostSourceTabUrl navigate rules MUST remain unchanged — this initiative MUST NOT alter API CORS for chrome-extension:// origins"
  - "Implementation MUST NOT weaken existing threat-model mitigations or checklist items for extension bridge, tabs permission scope, or ADR-001 no-capture"
open_questions:
  - "developer-account-custody"
---

<!--
Authoring (not validated):
- Security-owned HLD notes. Required sign-off before HLD → LLD.
- Bump updated when any frontmatter field changes.
-->

Runtime trust boundaries are unchanged from the shipped unpacked MVP (#426–#431); existing threat model (extension bridge, tabs permission, JWT A, ADR-001 no capture) remains authoritative. New surface is distribution and disclosure: store metadata, privacy policy, install-link hygiene, and upload supply chain.
