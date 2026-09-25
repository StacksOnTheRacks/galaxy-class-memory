---
doc: product.initiative
schema_version: 1
updated: 2026-09-25
slug: host-chrome-extension-completion
title: Host Chrome Extension Completion
status: hld
user_facing: true
signoffs:
  po: false
  architect: false
  designer: false
  security: false
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

This is the roadmap Next item "Finish the Host Chrome Extension". The MV3 host extension MVP is already Done (GitHub #426–#431, unpacked load). Outcome of THIS initiative: a signed-in host can install that same extension from the Chrome Web Store, and the Room-tab install path plus host docs point at the public listing instead of unpacked developer-mode load.

In scope: store packaging, Chrome Web Store listing, swap of the in-product install CTA and `/how-to-host-a-watchparty#host-extension` docs from "Load unpacked" to the listing.

Out of scope: new host-console behavior, extension media capture / tabCapture / host_screen (ADR-001), Firefox/Safari/mobile Chrome, Side Panel, Discord app, Watch Party Game Mode, board tickets until LLD.

This initiative does not create board tickets (LLD grooming does).
