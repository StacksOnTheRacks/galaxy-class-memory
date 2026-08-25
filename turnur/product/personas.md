---
doc: product.personas
schema_version: 1
updated: 2026-08-25
primary:
  - "Game pack developer — builds turn-based games that authenticate to Turnur with an SDK key and use it as the authoritative backend for seats, turns, seat-scoped hidden views, and the move log; supplies rules and gameplay UI while the host owns player-facing identity and rooms"
  - "Host platform integrator — operates a social/media host (RiffSync first beachhead) that attaches Turnur matches to rooms, loads game packs for users to join, and keeps identity, chat, rooms, and media on the host; does not build in-house match authority"
jobs_to_be_done:
  - "Ship turn-based multiplayer without rolling a custom backend for turn validation, seat-scoped hidden views, and an append-only move log"
  - "Integrate Turnur as backend state provider via SDK key while players never authenticate to Turnur directly"
  - "Embed turn-based play in host rooms without the host becoming authoritative for seats, turns, hidden views, or move logs"
  - "Delegate match state and signed results to Turnur while retaining full control of social surface, discovery, and media"
not_for:
  - "End players and room guests — Turnur authenticates games, not players"
  - "Real-time and action game developers (non-turn-based gameplay)"
  - "Social hosts expecting Turnur to provide player identity, chat, rooms, presence, or media"
  - "Buyers of a turnkey first-party Turnur game or consumer game storefront"
  - "Teams seeking full-stack game backends with player accounts, lobbies, and matchmaking (Nakama, PlayFab, etc.)"
  - "Vertical board-game platform operators wanting hosted rules and UI for one genre (Board Game Arena Studio model)"
  - "Host platforms that defer embedded turn-based play and stay social/media-only — valid alternative, not a design target"
---

Personas are hypothesis until game-auth and host-attach slices ship on RiffSync.
