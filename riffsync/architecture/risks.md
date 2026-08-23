---
doc: architecture.risks
schema_version: 1
updated: 2026-08-23
structural_risks:
  - "Host Chrome MV3 extension (host control panel + media-tab control per ADR-001) is an unvalidated packaging/distribution surface: Web Store review, host_permissions / tabs APIs, SPA↔extension JWT bridge trust boundaries, and service-worker lifetime can force UX redesign even without media capture APIs"
  - "Navigating a media tab without activating it depends on MV3 tab focus behavior; regressions could steal party-tab focus and reintroduce open-source-tab friction"
coupling_hotspots:
  - "RoomMediaEngine host_screen path stays page-owned (useHostScreenCapture / getDisplayMedia → SFU). Extension must not inject streams, fork SFU WS, token mint, or share_state"
  - "Extension couples to: public catalog GET, host room PATCH (catalogEpisodeId), SPA JWT bridge, and host source URL rules aligned with SPA resolveHostSourceTabUrl"
  - "Host control panel must not become a second YouTube playback controller; it reports media-tab state, shows now playing, and selects catalog titles"
migration_hazards:
  - "Scope creep into tabCapture/offscreen capture would reintroduce dual capture SoT hazards; ADR-001 forbids that path unless a future ADR supersedes it"
  - "JWT bridge must not weaken hostSub checks or expose tokens to untrusted origins"
watch_list:
  - "MV3 minimal permission set for inactive tab create/update + host control panel UI + API host_permissions — never add tabCapture / desktopCapture under ADR-001"
  - "Party-tab remains focused across open/navigate and title-change flows; media-tab open/not reporting stays accurate after tab close"
  - "C1 bind failures (not on /room/:roomId) surface clearly; no silent wrong-room PATCH"
  - "Orthogonality to viewer-local Cast and hostless Live (no shared media-plane coupling via the extension)"
---
