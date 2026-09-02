---
doc: product.insights
schema_version: 1
updated: 2026-09-02
themes:
  - "No user or research signal — framing is product-decision only; repo is README-only and the board has zero issues"
  - "Dual-sided attach: host owns identity, chat, rooms, and media; Riffle owns rules and play UI; Turnur owns match authority"
  - "Riffle is the first-party game Turnur explicitly does not ship as v1 — a product-decision answer to sister open Q 'First game pack on RiffSync', not a demand proof"
  - "First host (RiffSync) shows no game-attach demand and is in a Figma redesign; beachhead stays RiffSync until evidence says otherwise"
open_questions:
  - "Is there player or host demand for poker in RiffSync rooms? (no interviews, feedback, or metrics exist)"
  - "How a host embeds the play surface (architecture/constraints: undecided)"
  - "Where poker rules execute — in-process library vs dedicated service vs client (architecture assumption; undecided)"
evidence:
  - "product/brief.md (2026-08-30) — audience, problem, non-goals; who/problem unchanged this review"
  - "architecture/constraints.md — Turnur is post-attach authority; identity/chat/rooms/media stay on the host; embed shape and rules-execution undecided"
  - "Sister turnur/product/brief.md — Turnur non-goal: a first-party game as v1"
  - "Sister turnur/product/insights.md (2026-08-25) — dual-sided attach; open Q 'First game pack on RiffSync'; no Turnur user feedback"
  - "Sister turnur/product/personas.md — designs for game-pack developers and host integrators, not end players"
  - "Sister turnur/product/roadmap.md (2026-08-30) — control plane, game auth, and host attach shipped; match primitives #29–#35 in Refinement"
  - "Sister riffsync/product/insights.md (2026-08-25) — no user demand signal in the prior 30 days; current motion is Figma redesign, not game attach"
  - "Sister riffsync/product/personas.md — empty"
  - "gh issue list -R StacksOnTheRacks/riffle-poker --state all — empty; no PRs; README is a one-line title; repo created 2026-08-31"
  - "Shared GitHub project PVT_kwHOADqiOM4BWitQ — no riffle-poker items"
  - "product/competitive.md, experiments.md, open-questions.md — empty; no initiatives/"
implications:
  - "Do not promote Icebox outcomes to tickets from this review — nothing is user- or research-validated"
  - "Fill personas as hypothesis from brief audience plus sister contracts; they are not research-validated"
  - "Leave brief.md and backlog.md unchanged — who/problem is stable; Icebox outcomes are not disproved"
  - "RiffSync redesign with no attach demand is not a reason to drop the beachhead; demand for poker-in-room stays an open research question"
  - "First playable slice remains a large idea for /forge.new-initiative — not invented here"
---

Product-decision synthesis only. No interviews, feedback, experiments, competitive scan, or instrumentation exist for this product.
