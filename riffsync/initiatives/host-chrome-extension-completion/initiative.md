---
doc: product.initiative
schema_version: 1
updated: 2026-09-25
slug: host-chrome-extension-completion
title: Host Chrome Extension Completion
status: lld
user_facing: true
signoffs:
  po: true
  architect: true
  designer: true
  security: true
board_milestone: ""
board_tickets: []
---

<!--
Authoring (not validated):
- status: intake | hld | lld | executing | shipped
- signoffs: true | false | "na" (designer "na" when not user-facing)
- board_tickets: issue id/title strings after LLD grooming
- Bump updated when any frontmatter field changes.
-->

This is the roadmap Next item "Finish the Host Chrome Extension". The MV3 host extension MVP is already Done (GitHub #426–#431, unpacked load). Outcome of THIS initiative: a signed-in host can install that same extension from the Chrome Web Store, and host docs point at the public listing instead of unpacked developer-mode load.

In scope: store packaging, Chrome Web Store listing, swap of `/how-to-host-a-watchparty#host-extension` docs from "Load unpacked" to the listing.

Out of scope: new host-console behavior, extension media capture / tabCapture / host_screen (ADR-001), Firefox/Safari/mobile Chrome, Side Panel, Discord app, Watch Party Game Mode, board tickets until LLD.

This initiative does not create board tickets (LLD grooming does).

**HLD scope lock (2026-09-25):**

- **In scope:** store zip packaging + manifest icons; Chrome Web Store listing (human submit); how-to `#host-extension` copy swap; `VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL` wiring in deploy-prod; `apps/host-extension/README.md` + `build_packaging.md` artifact row
- **Install surface:** how-to page only — **do not** reintroduce Room-panel or HostRoomConsole install CTAs (host-bar-room-control #473 removal stands)
- **CTA gating:** when env unset, how-to keeps neutral copy (no broken external link); when set, primary **Add to Chrome** links to listing
- **Out of scope (unchanged):** capture / Side Panel / new host features; Firefox / Safari; automated CWS CI publish
