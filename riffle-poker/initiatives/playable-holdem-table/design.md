---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-02
summary: "HLD play surface is a dedicated riffle-poker Figma file (not a host/sister/group file). Screens/Flows pre-built for the named seated-table screens and states at desktop + narrow iframe widths, with a11y annotations. One felt composition after attach; separate embed load/error surface for bootstrap redeem. No Riffle lobby, identity, chat, rooms, media, or cashier. Node ids live in design/screens.md."
figma_file: "https://www.figma.com/design/NgpCBblDdJ7cw4TLrH9kUE/Riffle-Poker-Design"
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
open_questions: []
---

<!--
Authoring (not validated):
- Designer-owned HLD notes. Leave empty / N/A sign-off when initiative is not user-facing.
- Pre-build Figma screens during HLD before LLD grooming.
- Bump updated when any frontmatter field changes.
-->

First player-facing slice is the seated table inside a host iframe: one felt composition where the player sees their seat, seat-scoped hole cards, the shared board, pot/streets, and legal actions when it is their turn. Host owns identity/chat/rooms/media chrome; Riffle does not design those. All-in and disconnect/rejoin states are roadmap Next — not required Now screens.

Path locked: dedicated Riffle Poker Design file (`NgpCBblDdJ7cw4TLrH9kUE`), not RiffSync. Frames exist as named states at desktop and narrow iframe widths; attach `loading` / `embed-error` are separate from the felt composition. Real frame node ids are inventoried in `design/screens.md` — do not invent node ids here. Designer HLD sign-off flips in `/forge.initiative-planning` after review.
