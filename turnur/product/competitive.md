---
doc: product.competitive
schema_version: 1
updated: 2026-08-24
alternatives:
  - "Host in-house match authority — the host platform builds seats, turns, hidden views, and move logs instead of attaching Turnur"
  - "Game-owned custom backend — developers roll turn validation, seat-scoped hidden views, and move logs into their own API or datastore"
  - "General game backends (Nakama, PlayFab, etc.) — full-stack multiplayer platforms with player identity, matchmaking, and broader realtime/turn support"
  - "Self-hosted game server frameworks (Colyseus, etc.) — developer-operated rooms and sync; turn authority and per-seat hidden views are DIY"
  - "Defer embedded turn-based play — host stays social/media-only until a game pack justifies integration cost (valid for RiffSync beachhead)"
  - "Vertical board-game platforms (Board Game Arena Studio, etc.) — hosted rules and UI for board games, not a host-attachable engine for arbitrary games"
where_we_win:
  - "Purpose-built turn authority — seats, turns, seat-scoped hidden views, append-only move log, and signed result as first-class primitives vs DIY in a custom backend or realtime framework"
  - "Host attach without social scope creep — hosts keep identity, chat, rooms, and media; Turnur only owns match state vs building in-house or buying a full game backend"
  - "Game-authenticated integration — SDK key for games, not player accounts on Turnur; lighter than Nakama/PlayFab identity and matchmaking stacks"
  - "Reusable across hosts and game packs — host-agnostic attach contract vs vertical board-game platforms or one-off in-house match code per host"
  - "Clear separation of concerns — games supply rules and gameplay; Turnur supplies authoritative state so neither host nor game reimplements turn validation and hidden views"
where_we_lose: []
watch_list: []
implications: []
---
