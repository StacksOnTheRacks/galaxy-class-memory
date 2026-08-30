---
doc: product.open_questions_index
schema_version: 1
updated: 2026-08-30
items:
  - initiative: match-authority-primitives
    id: match-status-lifecycle
    question: "MatchRegistry.status stays created for this initiative. When (if ever) should it move to in_progress / completed, and does GET /v1/matches/{matchId} stay additive-only?"
    blocking: false
    status: deferred
  - initiative: match-authority-primitives
    id: extra-turn-and-skip
    question: "HLD uses game designation of currentSeat (including extra-turn by redesignating the same seat, or skip by designating another). Do later games need engine-side extra-turn or skip helpers?"
    blocking: false
    status: deferred
  - initiative: match-authority-primitives
    id: atomic-move-and-views
    question: "Views are a separate PUT (possible stale read). Should a later slice TransactWrite move + per-seat views?"
    blocking: false
    status: deferred
  - initiative: match-authority-primitives
    id: move-log-pagination
    question: "HLD returns the full move list. When do we add cursor pagination?"
    blocking: false
    status: deferred
  - initiative: match-authority-primitives
    id: seat-capacity-and-start
    question: "No max seats, min seats, or explicit start this HLD (currentSeat stays null until designated). Lock capacity or a start-match route later?"
    blocking: false
    status: deferred
---

<!--
Authoring (not validated):
- Rollup of initiatives/*/open-questions.md for /forge.initiative-planning.
- items: [{ initiative, id, question, blocking, status }]
- Maintained by open-questions-rollup skill — do not hand-edit as SoT.
- Bump updated when any frontmatter field changes.
-->
