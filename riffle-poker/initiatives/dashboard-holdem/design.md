---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-25
summary: "Dashboard Hold'em play surface (not felt). Pre-built Your Turn at desktop/tablet/phone in bound Riffle Poker Design file. Avatars or camera-off initials only — no live mic/camera. Omit top-bar Mic/Camera and tile muted badges. No felt, chip-stack art, or Canva. Missing waiting / not-your-turn / showdown / empty-seat frames are visual gaps; Your Turn is enough to build a playable hand."
figma_file: "https://www.figma.com/design/NgpCBblDdJ7cw4TLrH9kUE/Riffle-Poker-Design?node-id=4132-44"
screens:
  - "Table / Your Turn — canvas 4132:44"
  - "Desktop / Your Turn — 4132:45 (1280×832)"
  - "Tablet / Your Turn — 4132:795 (834×1194)"
  - "Phone / Your Turn — 4132:796 (402×874); Action Sheet with timer"
states:
  - "EXIST — your-turn (primary): pocket faces, bank, hand-strength meter + outs, action log, board flop/turn/empty-river, pot, raise presets + slider, Fold/Check/Call/Raise"
  - "EXIST — opponent-folded tile treatment (dimmed + Folded last action) inside Your Turn"
  - "EXIST — camera-off initials tile (e.g. SK) vs avatar tiles"
  - "EXIST — D / SB / BB markers, stacks, last action, hole-card backs, your-turn highlight + timer"
  - "EXIST — phone Action Sheet your-turn with countdown"
  - "MISSING — waiting for players"
  - "MISSING — not your turn (actions hidden / no turn chrome)"
  - "MISSING — self-folded (compose from opponent-folded + hide actions)"
  - "MISSING — showdown / hole-card reveal"
  - "MISSING — empty seat (Players 6/8 meta only; no empty-seat tile)"
a11y:
  - "Turn, legal actions, and public board obvious without color alone; Check disabled when facing a bet must be name + state, not color only"
  - "Hole cards (your faces) vs opponents' backs distinguishable without color alone; suits not color-only"
  - "Action controls: visible labels; keyboard shortcuts shown (F/K/C/R) must have equivalent named controls"
  - "Hand-strength meter + outs: text label (made hand / tier / outs count) required — meter is supplementary"
  - "Turn timer: not color-only; announce your-turn to assistive tech (live region or equivalent)"
  - "Confirm Leave table and irreversible all-in before commit"
  - "Respect reduced-motion for deal/timer animations where present"
  - "No live mic/camera; do not ship media controls that imply capability"
open_questions:
  - "NON-BLOCKING — Pre-build not-your-turn / showdown / waiting / empty-seat frames before Ready on those tickets, or accept compose-from-Your-Turn."
  - "NON-BLOCKING — Hand-strength + outs panel sits in dashboard My Hand (intentional). Reconcile with principles anti-pattern 'HUD/solver overlays on the table' at planning: dashboard panel in-scope; felt overlays still out."
---

Dashboard composition replaces felt for this initiative. One Your Turn story across three breakpoints: top bar (table identity, hand meta, controls), player tiles (avatar or camera-off initials), My Hand (pocket, bank, strength + outs, action log), board + pot, betting chrome. Phone collapses opponents + board and puts betting in an Action Sheet with timer.

**Media (locked):** no live mic/camera. Figma still shows Mic/Camera in Controls and a Muted badge on a tile — **omit**, not disabled.

**Out of initiative:** felt table, chip-stack art initiative, Canva.
