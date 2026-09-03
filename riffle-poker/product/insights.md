---
doc: product.insights
schema_version: 1
updated: 2026-09-02
themes:
  - "No user or research signal — framing is product-decision only; repo is README-only and the board has zero issues"
  - "Dual-sided attach: host owns identity, chat, rooms, and media; Riffle owns rules and play UI; Turnur owns match authority"
  - "Riffle is the first-party game Turnur explicitly does not ship as v1 — a product-decision answer to sister open Q 'First game pack on RiffSync', not a demand proof"
  - "First host (RiffSync) shows no game-attach demand and is in a Figma redesign; beachhead stays RiffSync until evidence says otherwise"
  - "HLD locks for playable-holdem-table: iframe embed (mint→URL→redeem bootstrap), in-process NLHE library in Riffle runtime, host-issued seat capability"
open_questions:
  - "Is there player or host demand for poker in RiffSync rooms? (no interviews, feedback, or metrics exist)"
evidence:
  - "product/brief.md (2026-09-02) — audience, problem, non-goals; current_focus is HLD→LLD for playable-holdem-table"
  - "initiatives/playable-holdem-table — HLD complete (feature, spec, design, security); status lld"
  - "architecture/constraints.md + architecture/decisions.md — iframe bootstrap, in-process rules, host seat capability locked (ADRs)"
  - "Sister turnur/product/brief.md — Turnur non-goal: a first-party game as v1"
  - "Sister turnur/product/insights.md — dual-sided attach; open Q 'First game pack on RiffSync'; no Turnur user feedback"
  - "Sister riffsync/product/insights.md — no user demand signal; current motion is Figma redesign, not game attach"
  - "gh issue list -R StacksOnTheRacks/riffle-poker --state all — empty; no PRs; README is a one-line title"
  - "Shared GitHub project PVT_kwHOADqiOM4BWitQ — no riffle-poker items"
implications:
  - "Do not invent board tickets from this review — split via /forge.backlog-grooming"
  - "Personas remain hypothesis from brief audience plus sister contracts; not research-validated"
  - "First playable slice is initiative playable-holdem-table (HLD→LLD); demand for poker-in-room stays an open research question"
  - "RiffSync redesign with no attach demand is not a reason to drop the beachhead"
---

Product-decision synthesis only. No interviews, feedback, experiments, competitive scan, or instrumentation exist for this product.
