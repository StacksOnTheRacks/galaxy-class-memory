---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-12
summary: "Host theater Share control becomes Settings; Watch Party Settings dialog (RoomSettingsPopup) consolidates party name, URL copy, visibility, and share quality. Chat has no Room tab. Toast confirm is HLD-only (not in Figma)."
figma_file: "https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync"
screens:
  - "Watch Party Host / Media Mode (19:1900)"
  - "Watch Party Host / Media Mode / Room Settings Option (1433:8139)"
  - "RoomSettingsPopup (1642:10935)"
  - "HostTheaterButtonBar (981:1965)"
  - "Chatbox Authenticated=True (913:10332)"
states:
  - "settings-closed — Media Mode 19:1900; Settings gear idle (not pressed)"
  - "settings-open — 1433:8139; RoomSettingsPopup 1642:10936; Settings slot pressed (buttonprimarypress)"
  - "visibility-public — PUBLIC primary / PRIVATE alternate (drawn state on 1642:10935)"
  - "visibility-private — inverse of drawn pair (not a separate Figma frame)"
  - "toast-confirm — party-name save and visibility change; not in Figma (HLD default)"
a11y:
  - "Settings control: accessible name Settings (not Share); aria-haspopup=dialog; aria-expanded true when open; aria-pressed when slot is pressed; return focus to trigger on close"
  - "Dialog: role=dialog, aria-modal=true, aria-labelledby on title Watch Party Settings (1642:10911); focus trap inside RoomSettingsPopup"
  - "Escape and CLOSE (1642:10913) dismiss the dialog; CLOSE accessible name from visible label"
  - "Party Name (1642:10916) labels the name field (1642:10915); SAVE (1642:10914) accessible name Save"
  - "Party URL (1642:10922) labels the URL field (1642:10921); COPY (1642:10920) accessible name Copy"
  - "Visibility (1642:10924) is a radiogroup name; PRIVATE (1642:10926) and PUBLIC (1642:10929) are radio or aria-pressed exclusive options — not color-only selection"
  - "Share Quality (1642:10932) labels the quality value Balanced (24 fps) (1642:10934 / 1642:10931)"
  - "Toast confirm: role=status or aria-live=polite; announce party-name saved and visibility changed; do not steal focus"
open_questions:
  - "toast-confirm-pattern"
---

Figma file `vQ6yHQyiGlOnRG7ngIOxR7`. Primary bind: **Watch Party Host / Media Mode / Room Settings Option** (`1433:8139`) — 1440×1024 desktop. Popup instance **RoomSettingsPopup** (`1642:10936` → component `1642:10935`, 604×364, radius 10). Title **Watch Party Settings** (`1642:10911`).

**Host bar:** **HostTheaterButtonBar** (`981:1965`). Settings is the 7th slot, **ButtonBarMiddleButton** `1053:3080`, inner icon **settings** (`I1053:3080;981:1890` / icon `2:107`). On `1433:8139` that slot uses pressed fill `--buttonprimarypress`. Default Media Mode (`19:1900`) shows the same gear idle. Do not use Share icons `20:2727` or `983:15363` on this slot.

**Dialog fields (all on `1642:10935`):** Party Name + SAVE; Party URL + COPY; Visibility PRIVATE / PUBLIC (PUBLIC selected in the drawn frame); Share Quality "Balanced (24 fps)"; footer CLOSE. CTAs are **CTA Alternate Link** instances; selected visibility uses `--buttonprimary`.

**Chat chrome:** **Chatbox** `913:10332` TabBar `1389:3194` is **Chat / People / Friends** only. Unauthenticated variant `1434:8849` has no Room tab either. No Room button, Room panel, or playlist on Screens `0:1` or Chat `949:10633`.

**Retire in production (absent from Figma, do not invent frames):** Room control at top of chat; playlist; Install host extension; Hosting guide copy/flow; Leave Party; Room panel. Help/? remains on **ButtonBarRightButton** `981:1963` (HelpCircle) — not the retired Hosting Guide.

**Toast (HLD default, no Figma node):** After successful party-name SAVE and after visibility change, show a short toast-like confirm as a polite live region. Reuse existing surface/CTA tokens. Copy and placement are LLD unless PO wants a drawn toast. Not required for HLD exit; no design-spike unless that visual spec becomes a Ready blocker.

**Sibling:** host-header-layout-fix owns NavigationSlim / Leave-in-header (`leave-party-affordance`). This initiative removes Leave from room/chat chrome; it does not place Leave on the profile menu.
