---
doc: product.open_questions
schema_version: 1
updated: 2026-09-12
questions:
  - id: identity-mechanism
    question: "Standalone identity mechanism — first-party Riffle account sign-up/sign-in. Not Cognito. Not host (RiffSync) identity."
    blocking: false
    status: answered
    owner: architect
  - id: anonymous-session
    question: "Anonymous play — Riffle issues an unguessable anonymous session (anon:{jti} player-subject + Riffle session). Seat binds on Sit at Table. Anonymous players can change in-game display name. Token not in query strings."
    blocking: false
    status: answered
    owner: architect
  - id: embed-link-shape
    question: "Embed attach — shared play URL ({origin}/play/{matchId} or join-code alias). Standalone and host iframe.src use the same URL. Freeze #bt= mint/redeem and X-Riffle-Seat-Capability for new work."
    blocking: false
    status: answered
    owner: architect
  - id: ws-client-locus
    question: "WebSocket client locus — browser connects to Riffle WS. Notify-only public table events. HTTP mutations stay authoritative. Public frames must not carry hole cards."
    blocking: false
    status: answered
    owner: architect
  - id: host-seat-authority-bind
    question: "Embed seating — guests self-sit via Sit at Table with a Riffle anonymous session when unauthenticated. No Riffle login chrome in iframe. Host room identity is not seat authority."
    blocking: false
    status: answered
    owner: security
  - id: runtime-hosting
    question: "Where does Riffle runtime host (process/platform/IaC)?"
    blocking: false
    status: open
    owner: architect
  - id: play-lab-fate
    question: "Fate of Turnur-backed play-lab harness — rewrite on MatchStore + shared URLs, or retire?"
    blocking: false
    status: open
    owner: architect
  - id: turnur-code-migration
    question: "Migration strategy for shipped Turnur-backed paths — freeze + replace (do not wrap); new modules identity/, match-store/, ws/"
    blocking: false
    status: open
    owner: architect
  - id: anonymous-to-account
    question: "Can an anonymous session become a Riffle account without leaving the current table and seat?"
    blocking: false
    status: open
    owner: product-owner
  - id: display-name-rules
    question: "Uniqueness, persistence, and moderation for in-game display names?"
    blocking: false
    status: open
    owner: product-owner
  - id: session-credential-transport
    question: "Riffle session transport — HttpOnly cookie vs bearer (or both)? Embed is a cross-site iframe; third-party cookies are widely blocked. Historical riffle_play SameSite=Lax is not assumed to work in a host iframe."
    blocking: true
    status: open
    owner: security
  - id: missing-auth-frames
    question: "No Figma frames for standalone entry (account vs anonymous), sign-in, sign-up, auth error/submitting, display-name edit, or Sit at Table chrome. Pre-build via /forge.design-spike before Designer HLD sign-off."
    blocking: true
    status: open
    owner: designer
  - id: standalone-viewport
    question: "Does standalone table use desktop frames only, with narrow-iframe reserved for embed? Mobile-web standalone viewport unscoped."
    blocking: false
    status: open
    owner: designer
  - id: embed-error-copy
    question: "Embed-error frames (4005:210/215) still say host session mint/redeem. Refresh copy to shared-URL language when embed-link-shape ships?"
    blocking: false
    status: open
    owner: designer
  - id: csrf-mutation-channel
    question: "CSRF for mutating iframe→Riffle APIs — SameSite + Fetch metadata vs CSRF token vs bearer-only (no ambient cookie)?"
    blocking: false
    status: open
    owner: security
  - id: anonymous-upgrade-fixation
    question: "How does anonymous→account upgrade rotate so an attacker-set anonymous session cannot inherit the account?"
    blocking: false
    status: open
    owner: security
  - id: embed-frame-ancestors
    question: "frame-ancestors for standalone vs embed — allowlisted hosts only, never *; how are hosts registered?"
    blocking: false
    status: open
    owner: security
  - id: ws-subscribe-auth
    question: "How does a WS subscriber prove a Riffle session, and which topic ACLs separate public table state from seat-scoped hidden views?"
    blocking: false
    status: open
    owner: security
  - id: host-spoofing-embed
    question: "How does the iframe reject a spoofed host (wrong parent, forged postMessage, copied URL on a hostile page) without treating host chrome as match authority?"
    blocking: false
    status: open
    owner: security
---
