---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-02
summary: "First playable NLHE table (play chips): host iframes Riffle-origin UI; browser talks only to Riffle runtime; in-process rules library legalizes moves; runtime alone holds Turnur SDK key and drives seats/turns/views/move log via @turnur/sdk. Identity/room stay on host. Host-issued seat capability binds player↔match↔seat before seat-scoped ops. Signed result out of this HLD."
approach: "Host (RiffSync first) embeds an iframe at Riffle origin with opaque match/room context (not Riffle identity). The iframe client never sees the SDK key — only the Riffle runtime does. Runtime is the trust boundary: in-process NLHE library legalizes; maps actions to opaque Turnur moves; selects game-trusted seatId; designates currentSeat; PUTs seat-scoped hole-card views; reads the move log. Host issues a short-lived seat capability (player↔match↔seat) that Riffle verifies before any seat-scoped Turnur read/write; postMessage is not seat authority. Turnur is seats/turns/views/move log authority only — it does not evaluate poker. Outcome: one complete hand deal→streets→showdown (fold-to-one or non-all-in). Runtime hosting undecided (non-blocking while this shape holds)."
interfaces:
  - "Host → iframe — Riffle-origin URL + opaque match/room context; identity stays on host; no SDK key in the page"
  - "Host → Riffle runtime — short-lived seat capability binding host player subject ↔ matchId ↔ seatId; verified before seat-scoped ops"
  - "Browser UI → Riffle runtime — table actions, seat-scoped views, public board; no direct Turnur calls"
  - "Riffle runtime → rules library (in-process) — deal, legalize, street advance, showdown; no I/O"
  - "Riffle runtime → @turnur/sdk (SDK key server-side only) — match create/probe; seat.create/list; turn.get/set; move.create; view.put/get; moves.list"
  - "Turnur → Riffle — opaque payloads/views; Riffle interprets poker meaning"
structure:
  - "Greenfield riffle-poker: iframe client + Riffle runtime + in-process rules library"
  - "Rules library — NLHE only; pure; no Turnur I/O"
  - "Riffle runtime — sole SDK-key holder; orchestrates rules ↔ Turnur; verifies host seat capabilities"
  - "iframe client — seat-scoped UI; talks to runtime only"
  - "Turnur (external) — MatchRegistry + MatchState + MatchMoveLog; game-trusted seats; no poker rules"
  - "Host (RiffSync first) — identity, room, iframe embed, seat capability issuance; not match authority"
  - "Hosting of Riffle runtime — undecided this HLD"
constraints:
  - "iframe at Riffle origin; host passes opaque match/room context"
  - "Rules = in-process library in Riffle runtime (not client; not a separate rules service this HLD)"
  - "SDK key never in browser/iframe"
  - "Host-issued seat capability required before seat-scoped Turnur reads/writes; postMessage is not seat authority"
  - "After attach, Turnur is state authority; Riffle is not a parallel match engine"
  - "Turnur does not evaluate poker legality; move payloads opaque; private cards in views only"
  - "Identity, chat, rooms, media stay on host"
  - "Prefer TypeScript (soft) for client/runtime/library to consume @turnur/sdk without a second language boundary"
  - "Riffle runtime hosting / IaC undecided — non-blocking if iframe + library + key-boundary hold"
  - "Signed result out of scope this initiative"
  - "Play chips only; NLHE only; no tournaments/SNG"
  - "Side pots, all-in runout, disconnect/rejoin, spectator polish out of scope this HLD"
open_questions: []
---

<!--
Authoring (not validated):
- Architect-owned HLD technical spec under initiatives/<slug>/spec.md.
- Distinct from per-ticket <!-- forge-tech-spec --> comments posted at LLD refinement.
- Bump updated when any frontmatter field changes.
-->

Trust boundary is the Riffle runtime. Turnur consumption mirrors sister match-authority-primitives (seats → turn designate + moves → hidden views → move log → SDK). Riffle maps poker streets onto designate-turn + append-move + view updates. Concurrent illegal turn → Turnur `409 illegal_turn`; runtime reconciles from log/cursor.
