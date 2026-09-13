---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-12
summary: "Standalone NLHE app plus host embed of the same Riffle-origin play surface. Riffle owns first-party identity (account or anonymous session), match state (seats, turns, hidden views, move log), in-process rules, and browser WebSocket notify. Host (RiffSync first) loads a shared play URL in an iframe and keeps chat, rooms, media, and room identity — host is not match or seat authority. Guests self-sit via Sit at Table with a Riffle anonymous session when unauthenticated. Shipped Turnur-backed host HTTP (mint/redeem, seat capability, @turnur/sdk) is frozen historical code; new work does not wrap or extend it."
approach: "Replace Turnur as match authority with a Riffle MatchStore in the existing Hono/TypeScript runtime. Carry forward the in-process NLHE library and /play UI. First-party Riffle sessions (not Cognito): HttpOnly session cookie or equivalent; playerSubject is account id or anon:{jti}. Sit at Table binds occupant; display name is seat-visible metadata, not identity. Primary attach is a shared play URL ({publicOrigin}/play/{matchId} or join-code alias) used by standalone navigation and host iframe.src alike — no #bt= fragment for new work. Browsers connect to Riffle WS for notify-only public table events; HTTP mutations stay authoritative; hole cards stay on seat-scoped HTTP. Freeze shipped Bearer RIFFLE_HOST_API_KEY routes and vendor/turnur-sdk; new modules (identity/, match-store/, ws/). Play-lab: rewrite against MatchStore + shared URLs + anonymous lab subjects, or retire. Runtime hosting / durable persistence remain non-blocking (process-local store is enough to start)."
interfaces:
  - "Player → Riffle identity — first-party account sign-up/sign-in and anonymous session; HttpOnly Riffle session; stable playerSubject (account id or anon:{jti}); not Cognito; not host playerSubject"
  - "Player/iframe → Riffle play URL — shared {origin}/play/{matchId} or join-code URL (standalone navigate or host iframe.src); optional ?embed=1 chrome; no #bt= fragment for new work"
  - "Browser → Riffle WS — same-origin (or Riffle-origin iframe) subscribe by matchId using Riffle session; notify-only public table cursor; no hidden-view bodies on public frames"
  - "Browser → Riffle runtime HTTP — table actions, public table, seat-scoped hidden view; mutations authoritative; 409 on illegal turn"
  - "Riffle runtime → rules library (in-process) — deal, legalize, apply, street advance, showdown; no I/O from the library"
  - "Riffle runtime → MatchStore — seats, currentSeat/turn, hidden views, append-only move log, in-process shoe; replaces @turnur/sdk match/seat/turn/move/view"
  - "Host → Riffle embed — iframe.src = shared play URL; optional UX postMessage (resize / table-changed toast) is a pipe only; host MUST NOT mint bootstrap, mint seat capability, or call frozen /v1/matches|/v1/bootstrap/*|/v1/seats/capability/*|/v1/hands/* for new work"
  - "Frozen (do not extend) — Host → Riffle POST /v1/matches, /v1/bootstrap/mint, /v1/seats/capability/mint, /v1/hands/deal, /v1/hands/betting/open + Bearer RIFFLE_HOST_API_KEY; iframe #bt= redeem; X-Riffle-Seat-Capability; runtime → @turnur/sdk"
structure:
  - "Play surface — existing /play UI (table shell, holes, actions, streets, complete); standalone chrome + embed iframe at Riffle origin"
  - "Identity (new) — first-party account + anonymous session store; seat occupant = Riffle playerSubject; display name per seat"
  - "MatchStore (new) — Riffle-owned seats, turn, hidden views, move log, shoe; process-local until hosting is chosen"
  - "Rules library — carry forward src/rules (pure NLHE)"
  - "Riffle runtime — Hono trust boundary; HTTP mutations; browser WS notify"
  - "Host (RiffSync first, Watch Party Game Mode is Next in that repo) — chat, rooms, media, room identity; iframe attach only"
  - "Play lab — Turnur-backed harness frozen; rewrite against MatchStore + shared URLs, or retire"
  - "Frozen historical — bootstrap mint/redeem, seat capability, vendor/turnur-sdk, lab orchestrator host-key path"
constraints:
  - "Riffle owns match state and WS notify for new work; no new @turnur/sdk consumption; do not wrap Turnur behind new routes"
  - "Rules = in-process NLHE library in Riffle runtime (not client, not a separate rules service this HLD)"
  - "Standalone supports account or anonymous; first-party Riffle session is seat authority"
  - "Embed play surface = iframe at Riffle origin; host is not match or seat authority; guests self-sit via Sit at Table"
  - "Do not extend shipped Turnur-backed HTTP contracts for new work"
  - "Do not copy RiffSync Cognito, chat, or SFU/TURN wholesale"
  - "No real-money, cashier, or KYC"
  - "Hole cards seat-scoped; public board shared; WS public frames must not carry hidden views"
  - "Prefer TypeScript (soft); runtime hosting undecided (non-blocking)"
  - "Play chips only; NLHE only; no tournaments/SNG; no production lobby or matchmaking this HLD"
  - "CSP frame-ancestors: standalone 'none' or 'self'; embed adds registered host origins; never *"
open_questions:
  - runtime-hosting
  - play-lab-fate
  - turnur-code-migration
  - session-credential-transport
  - display-name-rules
  - anonymous-to-account
---

Trust boundary is the Riffle runtime. The iframe/browser is untrusted presentation. Host postMessage is never seat or match authority.

**Identity.** First-party Riffle pages + session store (sister pattern from RiffSync first-party-fan-auth, not the IdP). Account and anonymous share one playerSubject namespace. Anonymous is a first-class occupant (anon:{jti}), not a missing user. Embed guests sit as Riffle sessions — host room identity does not bind seats. Display name is editable seat metadata visible to the table. Upgrade-anon-to-account is LLD.

**MatchStore.** Required by ADR-riffle-owned-match. Entities: match, seats (seatId + playerSubject + displayName + stack), currentSeat, hidden views (hole cards), append-only move log (payload kinds hand_open / action / street_deal / hand_complete so src/server/hands/reconstruct.ts + src/rules can carry forward), in-process shoe. Illegal concurrent turn → 409. Persistence backend is LLD under runtime-hosting.

**WS.** Browser locus: standalone two-device play and cross-origin host embed cannot rely on same-origin lab postMessage relay. Mutations stay HTTP. Public WS frames = table cursor / refresh only. Seat-scoped views stay HTTP.

**Embed link.** Shared play URL is canonical for standalone and host iframe. Supersedes ADR-host-iframe-bootstrap and ADR-host-seat-capability for new work. Join-code vs raw matchId (leakage) is LLD detail under embed-link-shape answer.

**Host embed contract (RiffSync).** Host MUST load the shared iframe URL and keep chat/rooms/media/room identity. Host MUST NOT evaluate rules, store hole cards, mint bootstrap/capability, call frozen host-key routes for new work, or treat RiffSync identity as Riffle seat authority. Watch Party Game Mode stays in the RiffSync repo.

**Migration: freeze + replace, do not wrap.** New modules rather than silently swapping Turnur behind frozen host routes. Wrapping Turnur would violate ADR-riffle-owned-match.
