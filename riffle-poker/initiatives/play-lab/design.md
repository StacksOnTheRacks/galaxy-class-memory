---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-03
summary: "HLD play lab is a first-party operator harness in the dedicated riffle-poker Figma file (not RiffSync, not a consumer lobby). Lab-shell frames prebuilt on Screens / Flows below the seated-table row. Existing seated-table / embed-error frames are iframe content only and must not be redesigned. Lab chrome: two labeled Riffle-origin /play slots + host-harness controls (Start session / Deal). Desktop dual-column operator layout is Now. No identity, chat, rooms, cashier."
figma_file: "https://www.figma.com/design/NgpCBblDdJ7cw4TLrH9kUE/Riffle-Poker-Design"
screens:
  - "Play lab / idle — 4012:52"
  - "Play lab / session ready — 4012:70"
  - "Play lab / two seats live — 4012:89"
  - "Play lab / harness error — 4012:142"
  - "Seated table (iframe play surface) — existing; do not redesign — see design/screens.md"
  - "Embed / session error (inside an iframe) — existing; do not redesign — 4005:210 / 4005:215"
states:
  - "lab-idle (no session minted)"
  - "lab-starting (host bootstrap in progress; no secrets on screen)"
  - "lab-ready (session live; two empty seat iframe slots)"
  - "lab-two-seats (both /play iframes redeemed)"
  - "lab-hand-live (iframes show existing felt states; harness may expose Deal)"
  - "lab-harness-error (operator-page failure; distinct from in-iframe embed-error)"
  - "iframe felt states unchanged: loading | waiting-for-deal | hand-in-progress | my-turn | showdown | hand-complete | embed-error"
a11y:
  - "Each iframe has a visible, programmatic name (Seat 1 / Seat 2) so AT can tell the two play surfaces apart without color or position alone"
  - "Harness controls (Start session / Deal) have visible labels and a non-color focus indicator; keyboard operable on the lab page"
  - "Do not present harness actions as on-felt poker actions; keep table actions inside each iframe"
  - "Announce lab session and seat-attach changes to AT (live-region or equivalent intent)"
  - "Never display SDK key, bootstrap token, seat capability, or Turnur secrets in lab chrome"
  - "Lab title/copy must read as an operator harness (Play lab), not a lobby, room list, or RiffSync product shell"
  - "Seat columns distinguishable by text label, not color alone"
  - "Respect reduced-motion for any lab attach/transition chrome"
  - "Do not ship identity, chat, rooms, presence, media, cashier, rake, KYC, HUD, or solver UI as Riffle surfaces"
open_questions: []
---

<!--
Authoring (not validated):
- Designer-owned HLD notes. Leave empty / N/A sign-off when initiative is not user-facing.
- Pre-build Figma screens during HLD before LLD grooming.
- Bump updated when any frontmatter field changes.
-->

The Now surface is a single-operator play lab in riffle-poker. It implements the host attach contract so two browser seats can finish a fold-to-one or showdown hand against live Turnur. It is not RiffSync, not a consumer lobby, and not a standalone client.

Composition: one wide lab shell (1200×720); a harness rail with Start session and Deal; two iframe slots sized to the existing narrow-iframe play surface (360×640). Each slot loads Riffle-origin /play. Felt composition stays the playable-holdem-table screens — one felt after attach, load/error separate from felt. Lab page may additionally show a harness-error when mint/capability/session fails before or outside iframe redeem.

Path locked: same dedicated file (NgpCBblDdJ7cw4TLrH9kUE). Lab-shell frames placed below seated-table row (y≈7600) on Screens / Flows. Designer HLD sign-off stays false until `/forge.initiative-planning` re-checks completeness. Do not flip signoffs in this event.

Lab shell frames (MCP-inventoried):

| Frame | Node id | State |
|---|---|---|
| Play lab / idle | 4012:52 | lab-idle |
| Play lab / session ready | 4012:70 | lab-ready |
| Play lab / two seats live | 4012:89 | lab-two-seats (clone of 4004:50 per slot) |
| Play lab / harness error | 4012:142 | lab-harness-error |

A11y annotation blocks: 4012:67, 4012:86, 4012:139, 4012:156 (one per lab state row).

Confirmed iframe content (do not redesign):

| Surface | Desktop | Narrow-iframe |
|---|---|---|
| loading | 4004:15 | 4004:20 |
| waiting-for-deal | 4004:31 | 4004:50 |
| hand-in-progress | 4004:69 | 4004:100 |
| my-turn | 4005:2 | 4005:40 |
| hand-in-progress (river) | 4010:2 | 4010:39 |
| my-turn (river) | 4010:76 | 4010:117 |
| showdown | 4005:78 | 4005:112 |
| hand-complete | 4005:158 | 4005:184 |
| embed-error | 4005:210 | 4005:215 |

One-seat-attached intermediate state is not required Now — two-empty → two-live is sufficient.
