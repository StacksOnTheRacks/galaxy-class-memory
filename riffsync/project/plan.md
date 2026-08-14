# Objective

Ship the remaining host Chrome MV3 **host control panel** MVP so hosts stay on the party tab, open/navigate the media tab, browse the public catalog, and change room title from the panel. Capture stays in the SPA.

# In scope

- Remaining Ready + `ai-ready`: #428, #429, #430, #431
- Tracking only (not implement-ready): #426
- Done this slice: #427 scaffold (closed 2026-08-13 via merged PR #432)
- Preserve ADR-001 no-capture: extension does not capture or supply `host_screen`
- Preserve shipped baseline: catalog, rooms, host broadcast, lobby, chat, friends/DM, SEO packaging, viewer-local Cast, PWA install, MV3 scaffold
- Out of this Now slice: Official Live channels and other Later themes until ticketed

# Sequence

1. Scaffold #427 — Done (PR #432, 2026-08-13)
2. Open/navigate host media tab without leaving the party tab — https://github.com/StacksOnTheRacks/riffsync/issues/428 (Ready, `ai-ready`)
3. Host control panel catalog library (B1) — https://github.com/StacksOnTheRacks/riffsync/issues/429 (Ready, `ai-ready`)
4. Title change via host PATCH + media navigate (A1), JWT A, now playing — https://github.com/StacksOnTheRacks/riffsync/issues/430 (Ready, `ai-ready`)
5. Docs: unpacked install + host control panel hosting flow — https://github.com/StacksOnTheRacks/riffsync/issues/431 (Ready, `ai-ready`)
6. Epic #426 Done when #427–#431 are Done — https://github.com/StacksOnTheRacks/riffsync/issues/426
7. Later: Official Live channels and deeper host/ops bets as product picks them

# Dependencies

- Product Decisions A1 / B1 / C1 / JWT A locked; ADR-001 no-capture
- #427 in tree (`apps/host-extension`); page `getDisplayMedia` remains capture SoT; SPA host source URL helpers
- Board as SoT: #428–#431 Ready + `ai-ready`; `/implement-ticket` only those; do not implement #426

# Handoffs

- Engineering: `/implement-ticket` in sequence #428 → #429 → #430 → #431
- Engineering → QA: extension MVP ready for verify (party stays focused; library; title PATCH; no capture)
- Architecture boundary: RoomMediaEngine / `host_screen` stay in page; extension does not capture
- Product: #426 remains tracking-only; Ready children do not need further refinement
