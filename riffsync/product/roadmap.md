# Themes

- Lawful shared watching (catalog + host embed/capture + guest SFU view)
- Host browser tooling (Chrome MV3: media-tab control + side panel library while hosting; no capture)
- Anonymous-first participation with signed-in hosting
- Public discovery (catalog IA, SEO packaging, shareable durable URLs)
- Viewer-local presentation (Cast / Link TV) without room authority — shipped baseline
- Signed-in social layer (friends + 1:1 DMs)
- Official hostless Live hangouts (staff-bound YouTube live) — future bet

# Now

- Remaining host Chrome MV3 **host control panel** MVP: bind active `/room/:roomId` (C1); media-tab open/not + now playing; full catalog library (B1); title change via PATCH + media navigate (A1); JWT SPA↔extension bridge; no capture
  - Tracking: https://github.com/StacksOnTheRacks/riffsync/issues/426
  - Scaffold shipped: #427 closed (PR #432, `apps/host-extension`)
  - Remaining Ready (`ai-ready`): #428 media-tab, #429 catalog library, #430 title PATCH + media navigate, #431 docs
- Treat Chromecast, PWA, catalog playback host, friends/DM, catalog browse IA, and public SEO packaging as live product baseline (board Done / closed), not open delivery risk

# Next

- After extension v1 lands: pick the next discovery/hangout bet (official Live vs further polish) against an empty-or-thin open board

# Later

- Official Live channels: hostless indexable `/live/:slug` hangouts discovered from Lobby, staff-curated `catalog: live` sources
- Federated host login and deeper staff catalog/ops tooling beyond current admin baseline
- Lawful non-YouTube playback backends that stay pluggable without a piracy vault
- Live and Cast maturity beyond shipped v1 (e.g. Live A/V, Cast on Live, multi-channel Live hub) only if demand justifies

# Not planning

- Piracy vault / communal ripped-file hosting
- Verified Premium entitlement checks
- Indexing ephemeral rooms or lobby instances
- Group DMs, voice/video calls between friends, public social feeds
- Mesh WebRTC or skipping SFU/TURN in any environment
- Host Chrome extension media capture / `tabCapture` / extension-supplied `host_screen` (ADR-001)
- Find/focus room tab + return-to-share as the primary hosting UX
