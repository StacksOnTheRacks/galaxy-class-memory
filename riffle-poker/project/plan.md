---
doc: project.plan
schema_version: 1
updated: 2026-09-02
objective: "Sequence LLD for the first playable NLHE table — one host milestone, nine Refinement tickets; Ready and implement come after /forge.refinement."
in_scope:
  - "Now — one host milestone Playable no-limit Hold'em table + nine actionable tickets on Refinement"
  - "Out of this slice — Ready, implementation, signed result, side pots, all-in runout, Icebox outcomes"
sequence:
  - "/forge.backlog-grooming Apply (this event) — create host milestone; land nine tickets on Refinement; assign all to the milestone"
  - "After Apply — /forge.plan-refresh (sequence board_tickets once the board exists)"
  - "Then /forge.refinement — compile AC; UF tickets get Designer; do not mark Ready in grooming"
  - "After all nine Ready + ai-ready — implement in post-refinement order (not started): Wave 1 iframe-bootstrap + runtime-turnur-auth + nlhe-rules-library; Wave 2 table-seats + host-seat-capability; Wave 3 hole-cards-hidden-views; Wave 4 betting-turns-moves; Wave 5 public-board-streets; Wave 6 hand-complete"
dependencies:
  - "Turnur match-authority-primitives is executing (#29–#35 on turnur milestone/3); Riffle consumes @turnur/sdk — couples later implement of seats/turns/views/moves; does not block this grooming"
  - "Turnur game-auth (SDK key) already shipped; Riffle runtime holds the key"
  - "RiffSync is the first attach host; identity, chat, rooms, media stay on the host"
  - "runtime-hosting open, non-blocking"
  - "Shared board PVT_kwHOADqiOM4BWitQ; sibling-Ready gate: all nine must be Ready before any /forge.implement-ticket claim"
handoffs:
  - "After grooming Apply → /forge.plan-refresh"
  - "Then Product → /forge.refinement on all nine"
  - "Then Engineering → /forge.implement-ticket in the post-refinement order once all siblings are Ready"
---

Board/SCM wins. Host milestone and nine issues In Refinement on StacksOnTheRacks/riffle-poker. Next is plan-refresh then refinement — not Ready this event.
