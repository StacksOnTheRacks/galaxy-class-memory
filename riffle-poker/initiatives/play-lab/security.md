---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-04
summary: "HLD security for a first-party play lab / embed harness in riffle-poker. The lab implements the host contract (match attach, two /play iframes, bootstrap mint→redeem, seat-capability mint, deal/open) against live Turnur so two seats can finish a hand without RiffSync. The lab is a host page, not a new product (not lobby, identity, chat, or rooms). New attach is the lab itself: RIFFLE_HOST_API_KEY and TURNUR_SDK_KEY MUST stay on the Riffle server runtime — never in lab HTML/JS, public env, or iframe bundles. Lab session-start MUST run server-side behind an authz boundary so the lab is not an unauthenticated public match factory. Seat capability tokens may appear in lab-parent memory for per-iframe postMessage delivery (accepted residual; pipe not authority). The two play iframes MUST be isolated so one seat's JS cannot read the other's holes, capability, or riffle_play. Inherits playable-holdem-table: bootstrap leak, hole leak, CSRF/clickjacking, logging, play chips only. RiffSync out of scope. Not a CI/hosting program."
threats:
  - "Lab secret leak: RIFFLE_HOST_API_KEY or TURNUR_SDK_KEY / TURNUR_BASE_URL in lab HTML/JS/CSS, Vite/public env, lab bundles, or browser-accessible config — any caller acts as the Riffle host and game against live Turnur"
  - "Unauthenticated lab match factory: a browser-facing start/session route creates Turnur matches and mints bootstrap + seat capabilities without an authz boundary — anyone who can reach the process (or the process if later exposed beyond localhost) burns live Turnur credentials and produces attachable tables"
  - "Same-origin two-iframe cross-seat read: lab parent and both /play iframes share an origin (or unsandboxed sibling frames) so seat A's JS reads seat B's hole-card DOM, capability token, or riffle_play cookie jar"
  - "Capability token over-exposure: lab parent broadcasts both seat tokens (postMessage to *, shared global, query string) so the wrong iframe presents the other seat's X-Riffle-Seat-Capability (residual: parent holding both tokens to deliver them is accepted for a host page)"
  - "Lab XSS confused deputy: script injection on the lab page steals both capability tokens and drives both seats (host key still off-page)"
  - "Inherited — bootstrap token leak or replay (query, Referer, history, logs, reuse after redeem)"
  - "Inherited — hole-card cross-seat leak via public DTO, logs, or wrong capability"
  - "Inherited — CSRF / clickjacking of the embed or of the lab start control"
  - "Inherited — logging/telemetry of holes, raw bootstrap tokens, raw capability tokens, host key, or SDK key"
  - "Inherited — postMessage spoofing treated as bootstrap or seat authority"
mitigations:
  - "Lab orchestrates host APIs only on the Riffle server runtime (same process that already holds RIFFLE_HOST_API_KEY and TURNUR_SDK_KEY); lab browser code never sends Bearer host key and never imports @turnur/sdk"
  - "Browser-facing lab start is POST /v1/lab/session behind default-off RIFFLE_LAB_ENABLED (enabled only for trimmed 1 or true) plus loopback remote address (not X-Forwarded-For); no lab shared secret; GET of the lab page MUST NOT create a match or mint tokens"
  - "Two Riffle-origin /play iframes; each iframe.src is a distinct host-minted playUrl (#bt= fragment); each receives only its own seat capability via targeted postMessage (origin allowlist + closed schema); postMessage is delivery not authority"
  - "Iframe isolation: seat A's browsing context MUST NOT read seat B's DOM, storage, or tokens (distinct-origin lab parent and/or sandbox without allow-same-origin — mechanism LLD, see lab-parent-origin); riffle_play remains HttpOnly match-attach only"
  - "Extend existing no-sdk-key-leak / security-leak greps to lab HTML/JS/CSS and any lab client source; do not weaken those tests"
  - "Lab page CSP: no third-party scripts; frame-ancestors none (lab is not embeddable); if lab parent origin ≠ Riffle public origin, play iframe frame-ancestors includes that origin and MUST NOT become *"
  - "Do not log, sample, or export hole cards, hidden views, raw bootstrap tokens, raw capability tokens, RIFFLE_HOST_API_KEY, or TURNUR_SDK_KEY"
  - "Inherit playable-holdem-table mitigations: mint→URL→redeem bootstrap; requireSeatCapability; play chips only; embed CSRF/SameSite; CSP on /play"
requirements:
  - "TURNUR_SDK_KEY, TURNUR_BASE_URL, and RIFFLE_HOST_API_KEY MUST exist only on the Riffle server runtime. They MUST NOT appear in lab HTML, lab JS/CSS, iframe bundles, public/Vite env, or any browser-accessible config."
  - "Lab browser code MUST NOT call host-authenticated routes (/v1/bootstrap/mint, /v1/seats, /v1/seats/capability/mint, /v1/hands/deal, /v1/hands/betting/open) and MUST NOT call Turnur."
  - "A server-side lab orchestrator MAY call those host routes with the process-held RIFFLE_HOST_API_KEY. Responses to the lab browser MUST NOT include the host key or the SDK key."
  - "Lab session start MUST NOT be a side-effect of GET. POST /v1/lab/session MUST have an authz boundary: default-off RIFFLE_LAB_ENABLED (enabled only for trimmed 1 or true) plus loopback remote address (not X-Forwarded-For); no lab shared secret. GET of the lab page MUST NOT create a match or mint tokens."
  - "The lab MUST mint one bootstrap token per iframe and set each iframe.src to the returned playUrl (#bt= fragment, never query). postMessage MUST NOT be bootstrap."
  - "The lab MUST mint one seat capability per seat. Delivery to the matching iframe MAY use postMessage. postMessage MUST target that iframe, allowlist event.origin to the Riffle public origin, and use a closed schema. postMessage MUST NOT be seat authority; requireSeatCapability on X-Riffle-Seat-Capability remains the only gate. riffle_play MUST NOT be sufficient."
  - "The lab parent MAY hold both capability tokens in memory for delivery (accepted residual). It MUST NOT expose both tokens to both iframes (no wildcard postMessage, no shared same-origin global both frames can read)."
  - "Seat A's browsing context MUST NOT read seat B's hole cards, capability token, or riffle_play. Same-origin parent + two unsandboxed /play iframes MUST NOT be the default. Isolation mechanism is LLD pending lab-parent-origin."
  - "Existing no-sdk-key-leak and security-leak tests MUST keep passing and MUST be extended to lab client artifacts. This initiative MUST NOT weaken them."
  - "Lab and play surfaces MUST NOT log raw host keys, SDK keys, bootstrap tokens, capability tokens, hole cards, or hidden-view payloads."
  - "The lab page MUST NOT be third-party frameable (CSP frame-ancestors 'none' or equivalent). Play iframe frame-ancestors MUST stay an allowlist; if the lab parent is not Riffle origin, that origin MAY be added; frame-ancestors MUST NOT be *."
  - "Cross-site CSRF MUST NOT start a lab session or submit moves / fetch holes for a victim session (inherit embed CSRF/SameSite)."
  - "Play chips only. This initiative MUST NOT add real-money rails, Riffle-owned identity, or a RiffSync host. The lab implements the host contract; it does not make Riffle a host/lobby/chat/rooms product."
  - "This initiative does not add a second match authority beside Turnur and does not replace playable-holdem-table attach or capability contracts."
open_questions: []
---

<!--
Authoring (not validated):
- Security-owned HLD notes. Required sign-off before HLD → LLD.
- Bump updated when any frontmatter field changes.
-->

HLD security for play-lab. Trust boundary: lab parent (first-party host chrome; may hold capability tokens for delivery) | /play iframes (untrusted UI, one per seat) | Riffle server runtime (lab orchestrator + rules + RIFFLE_HOST_API_KEY + TURNUR_SDK_KEY) | Turnur (match authority). Residual: a compromised runtime key still amplifies to all seats (accepted Turnur game-trust model); a compromised lab page can drive both lab seats via stolen capabilities. Mitigate by keeping host/SDK keys off every browser surface, isolating the two iframes, and gating session-start so the lab is not a public match factory.
