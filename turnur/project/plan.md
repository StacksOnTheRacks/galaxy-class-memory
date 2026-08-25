---
doc: project.plan
schema_version: 1
updated: 2026-08-25
objective: "Ship game authentication on the running control plane: SDK key so a game can authenticate to Turnur before host attach and match primitives."
in_scope:
  - "Game registry + SDK key storage (#9)"
  - "SDK key validation on protected routes (#10)"
  - "Authenticated probe route GET /v1/game/me (#11)"
  - "TypeScript SDK client at packages/turnur-sdk/ (#12)"
  - "Integrator onboarding docs (#13)"
  - "Later: host attach, match-state primitives (seats, turns, hidden views, move log, signed result)"
  - "Out of this slice: player/host auth, epic issues, identity/chat/rooms/media on host"
sequence:
  - "#1–#4 control plane — Done (PRs #5–#8)"
  - "#9 → #10 → #11 → #12 → #13 game authentication (Refinement)"
  - "Host attach a match — icebox; after game auth"
  - "Match primitives (seats → turns → hidden views → move log) — icebox; after host attach"
  - "Signed result — later capability"
dependencies:
  - "Board: #1–#4 Done; Refinement #9–#13 on https://github.com/StacksOnTheRacks/turnur"
  - "Game auth blocks host attach and all match primitives"
  - "Host attach blocks match primitives"
  - "Shared project linked; ADR-001 locked; ADR-002 at refinement on #9"
  - "Identity, chat, rooms, and media stay on the host"
handoffs:
  - "Product/Architecture: /forge.refinement on #9–#13 (start with #9)"
  - "Engineering: /implement-ticket after Ready + ai-ready"
  - "Product: host attach + match primitives stay icebox until auth ships"
---

Board/SCM wins on ticket status.
