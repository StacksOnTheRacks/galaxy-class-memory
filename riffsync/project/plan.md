# Objective

Ship an MVP host Chrome MV3 extension so hosts stay on the party tab, open/navigate the media tab, and change room title from a side panel that loads the full public catalog. Capture stays in the SPA.

# In scope

- Board work in Refinement: epic #426 and #427–#431 (not Ready until `/refinement`)
- MV3 scaffold, media-tab navigate without leaving party, host control panel library (B1) + now playing + media-tab open/not, title change via host PATCH + media navigate (A1), SPA JWT bridge, docs
- Preserve ADR-001 no-capture: extension does not capture or supply `host_screen`
- Preserve shipped baseline: catalog, rooms, host broadcast, lobby, chat, friends/DM, SEO packaging, viewer-local Cast, PWA install
- Out of this Now slice: Official Live channels and other Later themes until ticketed

# Sequence

1. ADR-001 product story amended (party-tab stay + panel library/title; no capture) — done with prior groom Apply
2. Board tickets cut (#426–#431) — done; land/remain in Refinement (not Ready)
3. `/refinement` on #427–#431 under epic #426 → promote to Ready only when agent-ready checklist passes
4. Implement MVP from Ready only: scaffold (#427) → media-tab navigate (#428) → host control panel library (#429) → title PATCH + media navigate (#430) → docs (#431)
5. Verify against host hosting flows
6. Later: Official Live channels and deeper host/ops bets as product picks them

# Dependencies

- Product Decisions A1/B1 locked; ADR-001 no-capture
- Existing host playback + broadcast stack; page `getDisplayMedia` remains capture SoT; SPA host source URL helpers
- Board as SoT: #426–#431 stay Refinement until `/refinement`; `/implement-ticket` only takes Ready

# Handoffs

- Product: run `/refinement` on #427–#431 (epic #426) → Ready when checklist passes
- Product → Engineering: Ready tickets only; then `/implement-ticket` in sequence above
- Engineering → QA: extension MVP ready for verify (party stays focused; library; title PATCH; no capture)
- Architecture boundary: RoomMediaEngine / `host_screen` stay in page; extension does not capture
