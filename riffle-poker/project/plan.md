---
doc: project.plan
schema_version: 1
updated: 2026-09-03
objective: "Sequence LLD for play-lab — one host milestone, six Refinement tickets; Ready and implement come after /forge.refinement."
in_scope:
  - "Now — host milestone Play lab + six actionable tickets on Refinement (#19–#24)"
  - "Out of this slice — Ready, implementation, runtime hosting / IaC, RiffSync attach, next-hand loop"
sequence:
  - "/forge.backlog-grooming Apply (2026-09-03) — created milestone/2; landed six tickets on Refinement"
  - "After Apply — /forge.plan-refresh (sequence board_tickets once the board exists)"
  - "Then /forge.refinement — compile AC; #23 gets Designer; do not mark Ready in grooming"
  - "After all six Ready + ai-ready — implement in post-refinement order (not started): Wave 1 #19 + #20; Wave 2 #21 → #22; Wave 3 #23; Wave 4 #24 (live Turnur success bar)"
dependencies:
  - "playable-holdem-table #1–#9 shipped — lab reuses bootstrap, capability, deal, betting, and play surfaces"
  - "Turnur game-auth (SDK key) on runtime; live Turnur env-only for #24"
  - "lab-exposure-bound and lab-parent-origin LLD forks resolve at refinement (#21, #23)"
  - "runtime-hosting open, non-blocking"
  - "Sibling-Ready gate: all six play-lab tickets must be Ready before any /forge.implement-ticket claim"
handoffs:
  - "After grooming Apply → /forge.plan-refresh"
  - "Then Product → /forge.refinement on all six"
  - "Then Engineering → /forge.implement-ticket in post-refinement order once all siblings are Ready"
---

Board/SCM wins. Play-lab milestone/2 and issues #19–#24 In Refinement on StacksOnTheRacks/riffle-poker. Next is plan-refresh then refinement — not Ready this event.
