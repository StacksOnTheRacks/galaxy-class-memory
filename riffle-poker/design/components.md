---
doc: design.components
schema_version: 1
updated: 2026-09-25
components:
  - name: Table Felt (Riffle)
    figma_node_id: "4050:14"
    variants: []
    used_in_screens:
      - "Seated table / my-turn — desktop"
      - "Seated table / hand-in-progress — desktop"
      - "Seated table / showdown — desktop"
      - "Seated table / hand-complete — desktop"
  - name: Dashboard player tile
    figma_node_id: "4135:4"
    variants:
      - "Desktop player row — 4135:4"
      - "Tablet player row — 4138:218"
      - "Phone opponents — 4139:321"
    used_in_screens:
      - "Dashboard / your-turn — desktop"
      - "Dashboard / your-turn — tablet"
      - "Dashboard / your-turn — phone"
  - name: Dashboard board
    figma_node_id: "4136:296"
    variants:
      - "Desktop board — 4136:296"
      - "Tablet board — 4138:380"
      - "Phone community — 4139:372"
    used_in_screens:
      - "Dashboard / your-turn — desktop"
      - "Dashboard / your-turn — tablet"
      - "Dashboard / your-turn — phone"
  - name: Dashboard action controls
    figma_node_id: "4136:157"
    variants:
      - "Desktop actions — 4136:157"
      - "Tablet actions — 4138:403"
      - "Phone action sheet — 4140:420"
    used_in_screens:
      - "Dashboard / your-turn — desktop"
      - "Dashboard / your-turn — tablet"
      - "Dashboard / your-turn — phone"
---

Table Felt (Riffle) on page Table Felt (Classic). Layered stadium oval: rail, radial felt, vignette, logo watermark. Reference image table_1 (4046:1269) retained above; flat classic vector (4046:1328) deprecated for export.

Dashboard player tile: avatar or camera-off initials, display name, stack, last action, D/SB/BB markers, card backs or folded treatment (desktop/tablet opponents only), local You tile with turn timer on desktop/tablet when acting. Omit Figma Muted badge and all Mic/Camera chrome. Phone opponents region lists other seats only — no card backs, no local You tile; turn timer lives on Action Sheet `4140:420` (#64).

Dashboard board: desktop/tablet Flop/Turn/River labeled groups with empty river `?`; pot label, amount, players-in-hand, and Action on you on desktop/tablet only. Phone Community header "Board" plus Pot row and five card slots in one row; no street labels, players-in-hand, or Action on you (#63).

Dashboard action controls: desktop/tablet Actions panel with Raise to label, Min / ½ Pot / ¾ Pot / Pot / All-in presets (label + amount), bet slider, Fold / Check / Call / Raise buttons with F/K/C/R hints. Phone Action Sheet with Your turn header, optional timer bar, Raise to + to-call hint, four presets (no Min, labels only), slider, and two-row action buttons (#64).
