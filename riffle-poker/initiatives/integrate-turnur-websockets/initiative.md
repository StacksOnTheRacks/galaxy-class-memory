---
doc: product.initiative
schema_version: 1
updated: 2026-09-12
slug: integrate-turnur-websockets
title: "Integrate Turnur WebSockets — server-side notify for match orchestrators"
status: hld
user_facing: false
signoffs:
  po: false
  architect: false
  designer: "na"
  security: false
board_milestone: ""
board_tickets: []
---

<!--
Authoring (not validated):
- status: intake | hld | lld | executing | shipped
- signoffs: true | false | "na" (designer "na" when not user-facing)
- board_tickets: issue id/title strings after LLD grooming
- Bump updated when any frontmatter field changes.
-->

Play-lab and shared server paths poll Turnur HTTP after every mutation — operator-visible latency during seated play. Turnur is building a WebSocket notify channel (integrate-websockets #44–#49); this initiative adopts it on the Riffle runtime so server-side orchestrators react to push events instead of blind poll-after-every-move loops.

**Problem:** Play-lab and shared server paths poll Turnur HTTP after every mutation (`submit.ts`, `advance.ts`, `public.ts`) — operator-visible latency during seated play.

**Approach (HLD stub):** Riffle runtime holds `TURNUR_SDK_KEY` server-side; subscribe to match events via Turnur `createTurnurWsClient`; on `move.accepted`, `turn.designated`, `seat.created`, `view.updated` — refresh local state with targeted HTTP reads only when needed (not blind poll loops).

Locked for this initiative:
- Server-side integrator only — **no browser WebSocket**, no SDK key in lab page or `/play` iframes (matches Turnur security constraint)
- HTTP mutations unchanged — WS does not replace POST/PUT authority
- First surface: **play-lab orchestrator**; shared table/server paths in same initiative unless HLD splits
- **Hard dependency** on Turnur milestone [#44–#49](https://github.com/StacksOnTheRacks/turnur/milestone/4) shipping

Out of scope:
- Player-facing realtime UI
- Host (RiffSync) WebSocket
- Replacing Turnur HTTP client
- Tournaments / multi-hand scope creep

Success bar (coarse): Two-seat play-lab hand completes with measurably fewer post-mutation HTTP round-trips; orchestrator reacts to Turnur push events instead of poll-after-every-move.
