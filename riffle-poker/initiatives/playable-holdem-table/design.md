---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-02
summary: "HLD intent for the seated-player no-limit Hold'em play surface embedded in a host iframe (RiffSync first). One composition: felt + seat-private hole cards + public board + turn/actions. No Riffle lobby, identity, chat, rooms, media, or cashier. Figma unbound — screens/states/a11y are logical names only until theme-bind and pre-built frames exist."
figma_file: ""
screens:
  - "Seated table (iframe play surface)"
  - "Between-hands / waiting for deal"
  - "My-turn action controls (on-felt)"
  - "Showdown / hand complete"
  - "Embed load / session error"
states:
  - "loading"
  - "waiting-for-deal"
  - "hand-in-progress (not my turn)"
  - "my-turn (actionable)"
  - "showdown"
  - "hand-complete"
  - "embed-error (invalid session / host attach failure)"
a11y:
  - "Turn, legal actions, and public table state must be obvious without color alone"
  - "Hole cards (seat-private) vs public board distinguishable by more than color"
  - "Suits and win/lose not encoded by color alone"
  - "Action controls: visible labels + non-color focus indicator; keyboard operable inside iframe"
  - "Announce whose turn and street changes to assistive tech (live region or equivalent intent)"
  - "Confirm irreversible chip commits and table-exit before they fire"
  - "Respect reduced-motion for chip/deal animations where present"
  - "Do not ship identity, chat, rooms, presence, media, cashier, rake, KYC, HUD, or solver UI as Riffle surfaces"
open_questions:
  - "theme-bind-riffle-poker"
  - "prebuild-seated-table-figma"
---

<!--
Authoring (not validated):
- Designer-owned HLD notes. Leave empty / N/A sign-off when initiative is not user-facing.
- Pre-build Figma screens during HLD before LLD grooming.
- Bump updated when any frontmatter field changes.
-->

First player-facing slice is the seated table inside a host iframe: one felt composition where the player sees their seat, seat-scoped hole cards, the shared board, pot/streets, and legal actions when it is their turn. Host owns identity/chat/rooms/media chrome; Riffle does not design those. All-in and disconnect/rejoin states are roadmap Next — not required Now screens. Until a Figma theme is bound, this doc is HLD intent only — logical screen and state names, no frames. Prefer pre-built Screens/Flows frames for the seated table (desktop + narrow iframe widths) before leaving HLD. `design/screens.md` stays empty until bind + inventory.
