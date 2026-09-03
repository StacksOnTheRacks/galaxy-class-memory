---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-02
summary: "First playable NLHE table (play chips): host iframes Riffle-origin UI via opaque short-lived bootstrap token (mint → URL → redeem); browser talks only to Riffle runtime; in-process rules library legalizes moves; runtime alone holds Turnur SDK key and drives seats/turns/views/move log via @turnur/sdk. Identity/room stay on host. Host-issued seat capability binds player↔match↔seat before seat-scoped ops (separate from bootstrap). Signed result out of this HLD."
approach: "Host (RiffSync first) mints an opaque short-lived bootstrap token at Riffle (authenticated host→runtime via Bearer RIFFLE_HOST_API_KEY), sets iframe.src to the Riffle-origin play URL with fragment #bt={token}, and the iframe redeems once at Riffle runtime to bind match attach context; runtime sets HttpOnly riffle_play cookie (1h) for reload. Bootstrap LLD locked on #1: opaque 32-byte token, SHA-256 store, jti/matchId/iat/exp=iat+60, one-time redeem, fragment never query. Seat capability is a separate host→runtime channel (player↔match↔seat), verified before seat-scoped Turnur reads/writes; postMessage is not seat authority and is not the primary bootstrap. The iframe client never sees the SDK key — only the Riffle runtime does. Runtime is the trust boundary: in-process NLHE library legalizes; maps actions to opaque Turnur moves; selects game-trusted seatId; designates currentSeat; PUTs seat-scoped hole-card views; reads the move log. Turnur is seats/turns/views/move log authority only — it does not evaluate poker. Outcome: one complete hand deal→streets→showdown (fold-to-one or non-all-in). Runtime hosting undecided (non-blocking while this shape holds)."
interfaces:
  - "Host → Riffle runtime (server) — POST /v1/bootstrap/mint with Bearer host API key; returns token + playUrl with #bt= fragment"
  - "Host → iframe — Riffle-origin play URL carrying the bootstrap token in the fragment; identity stays on host; no SDK key; bootstrap is not seat authority"
  - "iframe → Riffle runtime — redeem bootstrap token → match attach + riffle_play cookie; GET session for reload; then table actions"
  - "Host → Riffle runtime — short-lived seat capability binding host player subject ↔ matchId ↔ seatId; verified before seat-scoped ops (separate from bootstrap)"
  - "Browser UI → Riffle runtime — table actions, seat-scoped views, public board; no direct Turnur calls"
  - "Riffle runtime → rules library (in-process) — deal, legalize, street advance, showdown; no I/O"
  - "Riffle runtime → @turnur/sdk (SDK key server-side only) — match create/probe; seat.create/list; turn.get/set; move.create; view.put/get; moves.list"
  - "Turnur → Riffle — opaque payloads/views; Riffle interprets poker meaning"
structure:
  - "Greenfield riffle-poker: iframe client + Riffle runtime + in-process rules library"
  - "Bootstrap mint/redeem — opaque short-lived token; primary iframe attach path"
  - "Rules library — NLHE only; pure; no Turnur I/O"
  - "Riffle runtime — sole SDK-key holder; orchestrates rules ↔ Turnur; verifies host seat capabilities; redeems bootstrap"
  - "iframe client — seat-scoped UI; talks to runtime only"
  - "Turnur (external) — MatchRegistry + MatchState + MatchMoveLog; game-trusted seats; no poker rules"
  - "Host (RiffSync first) — identity, room, bootstrap mint + iframe embed, seat capability issuance; not match authority"
  - "Hosting of Riffle runtime — undecided this HLD"
constraints:
  - "iframe at Riffle origin; primary bootstrap = opaque short-lived token mint → URL → redeem (not postMessage-only, not host-signed URL as primary, not third-party cookie session as primary)"
  - "Rules = in-process library in Riffle runtime (not client; not a separate rules service this HLD)"
  - "SDK key never in browser/iframe"
  - "Host-issued seat capability required before seat-scoped Turnur reads/writes; separate from bootstrap; postMessage is not seat authority"
  - "After attach, Turnur is state authority; Riffle is not a parallel match engine"
  - "Turnur does not evaluate poker legality; move payloads opaque; private cards in views only"
  - "Identity, chat, rooms, media stay on host"
  - "Prefer TypeScript (soft) for client/runtime/library to consume @turnur/sdk without a second language boundary"
  - "Riffle runtime hosting / IaC undecided — non-blocking if iframe + library + key-boundary hold"
  - "Signed result out of scope this initiative"
  - "Play chips only; NLHE only; no tournaments/SNG"
  - "Side pots, all-in runout, disconnect/rejoin, spectator polish out of scope this HLD"
  - "Play-surface UI is iframe-only: compose at desktop and narrow host-embed widths; do not assume full-viewport Riffle chrome. loading and embed-error are the bootstrap mint→URL→redeem session surfaces (missing/invalid/expired/already-used token, redeem reject, host attach failure before match bind). No Riffle identity/login chrome. Seat-capability failure after attach may reuse embed-error this HLD — no new screen. Signed-URL / postMessage-only / cookie session remain non-primary."
open_questions: []
---

<!--
Authoring (not validated):
- Architect-owned HLD technical spec under initiatives/<slug>/spec.md.
- Distinct from per-ticket <!-- forge-tech-spec --> comments posted at LLD refinement.
- Bump updated when any frontmatter field changes.
-->

Trust boundary is the Riffle runtime. Bootstrap is mint → iframe URL token → redeem for match attach; seat capability is orthogonal. Turnur consumption mirrors sister match-authority-primitives (seats → turn designate + moves → hidden views → move log → SDK). Riffle maps poker streets onto designate-turn + append-move + view updates. Concurrent illegal turn → Turnur `409 illegal_turn`; runtime reconciles from log/cursor. Play-surface Figma path is Designer vendor work on the dedicated Riffle Poker Design file — not a runtime-hosting or embed-shape decision.
