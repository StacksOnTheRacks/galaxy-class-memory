---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-25
summary: "Replace unpacked developer-mode install UX with Chrome Web Store install on `/how-to-host-a-watchparty#host-extension` only. No in-room install CTA. Post-install behavior stays bound to Watch Party Host with Extension (1053:3252)."
figma_file: "https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync"
screens:
  - "How to Host a Watch Party / #host-extension (production — no Figma frame; riffsync-legal prose + gen-button)"
  - "Watch Party Host with Extension (1053:3252) — post-install reference; extension-bar unchanged"
states:
  - "how-to-extension-cws-gated — env set → Add to Chrome primary CTA links to Chrome Web Store listing"
  - "how-to-extension-pre-listing — env unset → no external store link; neutral preparatory copy"
  - "extension-present — unchanged; host bar matches 1053:3252 / HostTheaterButtonBarWithExtension (1053:3392)"
a11y:
  - "Preserve id=host-extension on the how-to section for deep links from sidebar, footer, and in-app anchors"
  - "Chrome Web Store links: use visible link/button text (Add to Chrome); target=_blank with rel=noopener noreferrer"
  - "External links: do not rely on opens in new tab alone; accessible name matches visible label"
  - "How-to primary CTA: use a real link or button element with gen-button (not div-onClick); existing template focus/hover states apply"
  - "After copy swap, remove contradictory no-store-yet prose when env is set; screen readers should not hear developer-mode-only requirements on the public help page"
open_questions:
  - "store-listing-url"
---

<!--
Authoring (not validated):
- Designer-owned HLD notes. Leave empty / N/A sign-off when initiative is not user-facing.
- Pre-build Figma screens during HLD before LLD grooming.
- Bump updated when any frontmatter field changes.
-->

**No new Figma frames required** for HLD. Reuse production `gen-button` and the `riffsync-legal` / `riffsync-how-to-host-page` prose pattern (same family as Terms/Privacy).

### How-to page — `#host-extension` (`HowToHostWatchPartyPage`)

Replace the developer-mode block (Chrome + Developer mode + Load unpacked + repo folder path + "no listing yet") with:

| Element | Direction |
|--------|-----------|
| Section title | Keep **Install the Host extension** (`id="host-extension"`) |
| Intro | Host extension opens/retargets the media tab from the **Room** tab without leaving the party; requires **Chrome desktop** |
| Primary CTA (env set) | **`gen-button`**: **Add to Chrome** → `{VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL}` |
| Steps (`ol`) | (1) Click **Add to Chrome** and confirm in Chrome, (2) Return to your party tab and reload if needed, (3) Open **Room** — extension controls appear |
| Pre-listing (env unset) | Neutral copy that store install is coming; no broken external link |
| Remove | Load unpacked, `chrome://extensions`, repo path, "no Chrome Web Store listing yet" (when env set) |
| Keep | PWA note (host UI in page, not side panel) if still accurate |

### In-room install CTA

**Out of scope.** host-bar-room-control #473 removed the Room panel Install Host Extension CTA. Do not reintroduce HostRoomConsole or other in-room install surfaces in this initiative.

### Post-install reference

**Watch Party Host with Extension** (`1053:3252`, 1440×1024) and **HostTheaterButtonBarWithExtension** (`1053:3392`) remain unchanged. This initiative does not alter extension-present chrome.
