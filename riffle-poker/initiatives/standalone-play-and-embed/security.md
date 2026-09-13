---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-12
summary: "HLD security for standalone NLHE plus embed. Riffle runtime is the sole match and rules authority; play identity is a Riffle account or anonymous session (first-party, bearer-only). Hole cards are seat-scoped on every REST and WS path except legal showdown reveal. Embed is an iframe at Riffle origin; host (RiffSync first) keeps identity, chat, rooms, and media and MUST NOT become match authority. Host identity is not Riffle seat authority — guests self-sit via Sit at Table with a Riffle anonymous session. No real money — play-chip integrity and hidden information still matter. Historical host API key, bootstrap mint/redeem, and seat-capability are Turnur-era residuals, not the forward design."
threats:
  - "Hole-card cross-seat leak — seat A's holes appear in seat B or spectator REST, WS topics, shared DTOs, error bodies, cache, or UI"
  - "Client or host as match authority — iframe, host page, or forged API writes stacks, pot, deal, streets, or accepted illegal actions"
  - "Host identity spoofed as seat authority — host JWT, room membership, or postMessage treated as hidden-view or move grant without a Riffle session bind"
  - "Embed locator leakage — shared play URL in Referer, history, chat, logs; uninvited attach if URL is treated as a secret"
  - "Clickjacking / hostile framing — play surface framed by a non-allowlisted origin; victim clicks become moves or reveal holes"
  - "Bearer theft via XSS — JS-readable bearer on Riffle origin lets an attacker act as the victim's seat"
  - "Anonymous session fixation / upgrade hijack — attacker plants an anonymous session; victim upgrades to an account; attacker keeps the seat"
  - "Anonymous session theft — token in query string or XSS-readable storage; holder is the seat"
  - "WS subscribe without session or topic ACL — client binds a hidden-view topic, another seat's notify, or a write channel"
  - "WS treated as write authority or hole-card pipe — stale/reordered push overwrites HTTP-confirmed state, or holes ride a public topic"
  - "postMessage spoof — parent, sibling, or injected script forges host→embed messages as attach, sit, or seat grant"
  - "Credential / token / hole logging — passwords, session tokens, embed secrets, or hidden views in logs, APM, analytics, or client reporters"
  - "Play-chip integrity abuse — illegal action accepted, stack/pot tamper, replay, or unbounded anonymous table/seat squat (grief, not cash-out)"
  - "Historical host-key residual — live RIFFLE_HOST_API_KEY or capability mint after the pivot lets any key holder mint seats for every match"
  - "Account credential theft on Riffle origin XSS — passwords, reset codes, or session tokens on the standalone app (provider unset; do not copy RiffSync Cognito)"
mitigations:
  - "Riffle server runtime is the only rules evaluator and match writer; play-surface UI and host page are presentation"
  - "Seat authority is a Riffle bearer session (account or anonymous). Host identity, room membership, and postMessage are not sufficient for seat grants"
  - "Every hidden-view read, hole-card field, and seat-scoped move is authorized for that matchId+seatId against the bound Riffle bearer; fail closed"
  - "Public table state, move log, and WS public topics omit hole cards and other-seat private fields except cards legally revealed at showdown"
  - "Shared play URL is match attach or locator only — never seat authority and never a hidden-view grant"
  - "CSP frame-ancestors is an explicit allowlist (standalone 'none' or 'self'; embed adds registered host origins). Never *"
  - "Mutating iframe→Riffle APIs and hidden-view reads use explicit Authorization (or equivalent); no ambient cookie that can mutate or fetch holes"
  - "Anonymous session is unguessable, not placed in query strings, and rotated on account upgrade"
  - "WS subscribe requires the same Riffle bearer as HTTP (handshake or first control frame). Topic ACLs separate public table notify from seat-scoped channels. Push is not mutation success"
  - "postMessage: allowlist event.origin; closed schema; ignore unknown types; never attach, sit, or seat-authorize"
  - "Do not log, sample, or export hole cards, hidden views, raw session/embed tokens, passwords, or host keys"
  - "Play chips only — no cashier, KYC, or real-money rails. Still reject illegal actions and client-supplied stacks/pots/deals"
  - "Do not extend RIFFLE_HOST_API_KEY, bootstrap mint/redeem, or X-Riffle-Seat-Capability as the default forward design"
  - "Auth UI (when a provider is chosen) is high-trust: no secrets in the client bundle; do not copy RiffSync Cognito/SRP/pool contracts"
requirements:
  - "Riffle runtime MUST be the only match writer and rules evaluator. Host and iframe MUST NOT evaluate poker legality or persist match state"
  - "A response or push MUST NOT include another seat's hole cards or hidden fields, except cards legally revealed at showdown"
  - "Seat-scoped HTTP and WS operations MUST authorize the caller as the Riffle bearer bound to that matchId+seatId. Host JWT, room id, and postMessage MUST NOT suffice"
  - "Account and anonymous sessions MUST be first-class Riffle play identities. Provider is first-party Riffle (identity-mechanism answered). MUST NOT copy RiffSync Cognito client, pool, or SRP contracts"
  - "Session transport MUST be bearer-only (Authorization or equivalent) on standalone and embed. No ambient cookie that can mutate or fetch holes. Historical riffle_play HttpOnly SameSite=Lax is NOT the forward channel"
  - "Bearer token MUST NOT appear in URL query strings (HTTP or WS). WS subscribe MUST prove the same bearer in the handshake or first control frame"
  - "Anonymous bind MUST be unguessable and MUST NOT appear in URL query strings. Account upgrade MUST rotate or rebind so a pre-upgrade anonymous token cannot keep the account's seats"
  - "Embed MUST be an iframe at Riffle origin. The shared play URL MUST NOT be seat authority. Shared-link leakage MUST be treated as uninvited attach risk, not a hidden-info grant"
  - "Play surface MUST set CSP frame-ancestors to an allowlist; MUST NOT use *. Standalone SHOULD deny foreign framing; embed MAY add registered host origins only"
  - "Cross-site framing MUST NOT submit moves or fetch hole cards for a victim bearer session"
  - "If WS is browser-facing, subscribe MUST prove the Riffle bearer and MUST enforce topic ACLs. Push MUST NOT be write authority and MUST NOT carry unauthorized hidden views"
  - "postMessage handlers MUST allowlist origin and use a closed schema; spoofed messages MUST be dropped; postMessage MUST NOT attach, sit, or grant seats"
  - "Riffle MUST NOT log hole cards, hidden-view payloads, raw session/embed tokens, passwords, or host keys"
  - "Client-supplied stack, pot, deal, or illegal action MUST be rejected. This initiative MUST NOT add real-money, cashier, or KYC surfaces"
  - "New work MUST NOT require RIFFLE_HOST_API_KEY or X-Riffle-Seat-Capability. Live historical host-key routes MUST NOT stay an unauthenticated public mint of seats after cutover"
  - "LLD tickets MUST slice forge-tech-spec AC from this doc at refinement"
open_questions:
  - anonymous-upgrade-fixation
  - embed-frame-ancestors
  - ws-subscribe-auth
  - host-spoofing-embed
---

Trust boundary: player browser / Riffle-origin iframe (untrusted UI) | host page (RiffSync first; untrusted for match writes; owns host identity/chat/rooms/media) | Riffle runtime (rules + match store + WS notify + play session) | hostile framers. A compromised runtime still sees all holes (accepted SoT). No cash-out reduces theft-to-money; hidden info and play-chip integrity remain in scope. Bearer storage in the iframe is LLD.
