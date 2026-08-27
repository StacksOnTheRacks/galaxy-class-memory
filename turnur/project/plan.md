---
doc: project.plan
schema_version: 1
updated: 2026-08-27
objective: "Refine and ship host attach on the running control plane with game authentication live."
in_scope:
  - "Shipped: control plane #1–#4 (PRs #5–#8); game auth #9–#13 (PRs #14–#18)"
  - "Now — host attach slice: match registry (#19), attach route (#20), probe route (#21), SDK (#22), integrator docs (#23)"
  - "Next — match-state primitives: seats, turns, hidden views, move log (icebox until groomed)"
  - "Later — signed result capability"
  - "Out of scope: player/host auth, epic/umbrella issues, identity/chat/rooms/media on Turnur"
sequence:
  - "Control plane #1–#4 — Done (PRs #5–#8)"
  - "Game authentication #9–#13 — Done (PRs #14–#18)"
  - "Refinement — #19 → #20 → #21 → #22 → #23 (host attach milestone)"
  - "Implement — #19 then same order after each ticket reaches Ready + ai-ready"
  - "Grooming — match primitives (seats → turns → hidden views → move log) after host attach ships"
  - "Signed result — later capability"
dependencies:
  - "Board: #19–#23 Refinement on host attach milestone; #1–#13 Done"
  - "Strict ticket order: #19 storage → #20 attach → #21 probe → #22 SDK → #23 docs"
  - "Host attach blocks match primitives; game auth no longer blocks delivery"
  - "ADR-001 locked (control plane); ADR-002 locked (game registry / key storage)"
  - "Architect + Security tech spec (ai-ready) required before /forge.implement-ticket on each host-attach ticket"
  - "Identity, chat, rooms, and media stay on the host"
handoffs:
  - "Product → /forge.refinement on #19–#23 (dependency order starting #19)"
  - "Engineering → /forge.implement-ticket #19 → #23 as tickets reach Ready + ai-ready"
  - "Product → groom match primitives to Refinement after host attach milestone closes"
---

Board/SCM wins. Host attach in Refinement; delivery capacity on refine #19 then implement in dependency order.
