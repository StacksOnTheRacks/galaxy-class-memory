---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-03
summary: "First-party same-origin play lab in riffle-poker that implements the existing host contract so two browser seats can finish a fold-to-one or showdown hand against live Turnur. Fills the missing host-facing match.create. Lab server sequences seats, bootstrap mint, capability mint, deal, and betting/open. Lab browser NEVER sees RIFFLE_HOST_API_KEY or TURNUR_SDK_KEY. Not a consumer client, lobby, identity, chat, or rooms product. Not a CI/hosting program. RiffSync is out. Runtime hosting remains undecided (non-blocking)."
approach: "Serve GET /lab from the Riffle runtime (same origin as /play) so RIFFLE_FRAME_ANCESTORS stays 'self' — do not widen frame-ancestors for this initiative. The lab page is untrusted presentation (the host page). It must never send or receive the host key or SDK key. Add host-facing POST /v1/matches (Authorization: Bearer RIFFLE_HOST_API_KEY, no CORS, iframe/lab browser must not call) that wraps client.match.create() → 201 { matchId } — the critical host-contract gap (createSeat/deal already require an existing matchId). Add a lab orchestrator in the same runtime that calls that function in-process (plus existing host functions) so the browser never holds the host key: POST /v1/lab/session creates the Turnur match, two seats, two bootstrap mints, two capability mints with synthetic playerSubject lab:{seatId} (not accounts), and returns { matchId, seats: [{ seatId, playUrl, capabilityToken, playerSubject }] } — no deal yet. Lab page embeds two /play iframes at those playUrls (#bt=), then postMessages each capability token into its iframe (pipe not authority; riffle_play is never sufficient). /play must accept capability postMessage into per-iframe memory and send X-Riffle-Seat-Capability on seat-scoped fetches; it must continue to reject postMessage bootstrap. After both iframes are attached, POST /v1/lab/deal { matchId } runs existing POST /v1/hands/deal + POST /v1/hands/betting/open with fixed two-seat play-chip defaults (exact stack/blind numbers are LLD). Players then finish the hand through the existing iframe action path. CI stays on the in-memory fake Turnur (fake must implement match.create); live Turnur is env-only (TURNUR_BASE_URL + TURNUR_SDK_KEY). Leak tests extend to lab HTML/JS. One hand is the success bar; next-hand/remint/lobby/identity are out."
interfaces:
  - "GET /lab — first-party lab page + assets from Riffle origin; same origin as /play; no secrets in HTML/JS"
  - "POST /v1/matches — Bearer RIFFLE_HOST_API_KEY; 201 { matchId }; 401 unauthorized; 503 turnur_unauthenticated; no CORS; iframe/lab browser MUST NOT call; runtime client.match.create() only"
  - "POST /v1/lab/session — lab page only; no host key, no SDK key in request or response; server: match.create → two seat.create → two bootstrap mints → two capability mints; 201 playUrls + capability tokens; MUST NOT deal or betting/open"
  - "POST /v1/lab/deal — lab page only; body { matchId }; no keys; server: existing deal + betting/open with fixed play-chip defaults; 201 { matchId, currentSeat }"
  - "Lab page → /play iframes — iframe.src = playUrl (#bt=); postMessage capability token per iframe (pipe not authority)"
  - "/play iframe → Riffle runtime — existing redeem + riffle_play; new: in-memory capability from parent postMessage → X-Riffle-Seat-Capability on seat-scoped GET/POST; reject postMessage bootstrap"
  - "Reuse unchanged — POST /v1/seats, POST /v1/bootstrap/mint, POST /v1/seats/capability/mint, POST /v1/hands/deal, POST /v1/hands/betting/open, iframe actions/table (orchestrator calls these in-process; browser never uses host-key HTTP)"
  - "Riffle runtime → @turnur/sdk — match.create now on the live path; SDK key server-side only"
structure:
  - "Lab page (GET /lab) — two-iframe host chrome; Start session → embed → Deal; not a lobby"
  - "Lab orchestrator (runtime) — sole lab caller of host-key + SDK-key operations"
  - "Host POST /v1/matches — missing contract step; lab uses it in-process"
  - "/play capability receive — complete the locked postMessage pipe"
  - "Existing host APIs + rules + Turnur — unchanged locus"
  - "CI fake Turnur — implement match.create; no live network in CI"
  - "Runtime hosting / IaC — still undecided this HLD"
constraints:
  - "Lab browser NEVER receives RIFFLE_HOST_API_KEY or TURNUR_SDK_KEY (not in HTML, bundles, cookies, query, fragment, or JSON)"
  - "Capability tokens MAY appear in the lab page (it is the host); they are not seat authority until requireSeatCapability"
  - "postMessage is a delivery pipe only; riffle_play is not sufficient"
  - "RIFFLE_FRAME_ANCESTORS stays 'self'; do not widen for the lab"
  - "Lab implements the host contract; Riffle does not become a host, lobby, identity, chat, rooms, or consumer-client product"
  - "Synthetic playerSubject lab:{seatId} — not accounts"
  - "Two seats, one hand (fold-to-one or showdown); play chips only"
  - "CI = fake Turnur; live Turnur = env-configured lab/manual only"
  - "RiffSync attach, signed result, next-hand loop, remint UX, spectator, side pots / all-in runout, disconnect/rejoin — out"
  - "Runtime hosting undecided — non-blocking"
open_questions: []
---

<!--
Authoring (not validated):
- Architect-owned HLD technical spec under initiatives/<slug>/spec.md.
- Distinct from per-ticket <!-- forge-tech-spec --> comments posted at LLD refinement.
- Bump updated when any frontmatter field changes.
-->

Trust boundary stays the Riffle runtime. The lab is a first-party implementation of the host role, not a new product surface. Same-origin is required for 'self' embeds and does not prove cross-origin host isolation (that remains a future host / RiffSync concern). Two same-origin /play iframes may share riffle_play because both bind the same matchId; capability MUST stay per-iframe memory, never a shared cookie. Isolation of the two browsing contexts is a MUST (mechanism LLD — lab-parent-origin).
