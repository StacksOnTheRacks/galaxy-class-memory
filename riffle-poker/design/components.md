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
---

Table Felt (Riffle) on page Table Felt (Classic). Layered stadium oval: rail, radial felt, vignette, logo watermark. Reference image table_1 (4046:1269) retained above; flat classic vector (4046:1328) deprecated for export.

Dashboard player tile: avatar or camera-off initials, display name, stack, last action, D/SB/BB markers, card backs or folded treatment (desktop/tablet opponents only), local You tile with turn timer on desktop/tablet when acting. Omit Figma Muted badge and all Mic/Camera chrome. Phone opponents region lists other seats only — no card backs, no local You tile; turn timer lives on Action Sheet `4140:420` (#64).
