---
doc: project.plan
schema_version: 1
updated: 2026-09-03
objective: "Sequence play-lab LLD — six Refinement tickets under host milestone Play lab; next is /forge.refinement. Ready and implement come after all six are Ready + ai-ready."
in_scope:
  - "Now — host milestone Play lab + six actionable tickets on Refinement (#19–#24)"
  - "Shipped on board — playable-holdem-table #1–#9 Done (merged PRs #10–#18); table exists against fake Turnur"
  - "Out of this slice — Ready this event, implementation, runtime hosting / IaC, RiffSync attach, next-hand loop"
sequence:
  - "playable-holdem-table #1–#9 Done — iframe bootstrap, capability, seats, rules, holes, betting, board, hand-complete"
  - "play-lab LLD grooming applied (2026-09-03) — milestone/2; #19–#24 on Refinement (no readiness labels)"
  - "This event — /forge.plan-refresh sequences the six tickets; plan-refresh is no longer a future step"
  - "Next — /forge.refinement: compile AC; #23 gets Designer (user-facing lab shell); do not mark Ready here"
  - "After all six Ready + ai-ready — implement in this order (not started): Wave 1 #19 + #20 (parallel); Wave 2 #21 then #22; Wave 3 #23; Wave 4 #24 (live Turnur success bar)"
dependencies:
  - "playable-holdem-table #1–#9 shipped — lab reuses bootstrap, capability, deal, betting, and /play surfaces"
  - "#19 and #20 have no play-lab predecessor (independent Wave 1)"
  - "#21 depends on #19 — session calls the host match.create wrapper in-process; do not open a second create path"
  - "#22 depends on #21 — deal rejects unknown/unprepared matchId; seats/prep come from session"
  - "#23 depends on #20 (capability pipe) + #21 (playUrls/tokens) + #22 (Deal rail)"
  - "#24 depends on #23 end-to-end; live Turnur is env-only (TURNUR_BASE_URL + TURNUR_SDK_KEY); CI stays fake Turnur"
  - "Lab browser NEVER sees RIFFLE_HOST_API_KEY or TURNUR_SDK_KEY"
  - "lab-exposure-bound and lab-parent-origin remain open LLD forks — resolve at refinement (#21, #23); not blocking this plan"
  - "runtime-hosting open, non-blocking"
  - "Sibling-Ready gate: all six play-lab tickets must be Ready before any /forge.implement-ticket claim"
handoffs:
  - "Product → /forge.refinement on all six (#23 Designer)"
  - "Then Engineering → /forge.implement-ticket in the wave order once all siblings are Ready"
  - "PO later — mark playable-holdem-table shipped (initiative still executing; not this event)"
---

Board/SCM wins. Play-lab milestone/2 and issues #19–#24 In Refinement on StacksOnTheRacks/riffle-poker. Next is /forge.refinement — not Ready this event.
