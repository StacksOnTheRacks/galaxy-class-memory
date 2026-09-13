---
doc: product.open_questions_index
schema_version: 1
updated: 2026-09-12
items:
  - initiative: standalone-play-and-embed
    id: identity-mechanism
    question: "Standalone identity — first-party Riffle account sign-up/sign-in. Not Cognito. Not host identity."
    blocking: false
    status: answered
  - initiative: standalone-play-and-embed
    id: anonymous-session
    question: "Anonymous play — Riffle anonymous session (anon:{jti}); seat binds on Sit at Table; mutable display name; token not in query strings."
    blocking: false
    status: answered
  - initiative: standalone-play-and-embed
    id: embed-link-shape
    question: "Embed attach — shared play URL; freeze mint/redeem + seat capability for new work."
    blocking: false
    status: answered
  - initiative: standalone-play-and-embed
    id: ws-client-locus
    question: "Browser connects to Riffle WS; notify-only; HTTP mutations authoritative."
    blocking: false
    status: answered
  - initiative: standalone-play-and-embed
    id: host-seat-authority-bind
    question: "Guests self-sit via Sit at Table; no Riffle login in iframe; host identity is not seat authority."
    blocking: false
    status: answered
  - initiative: standalone-play-and-embed
    id: runtime-hosting
    question: "Where does Riffle runtime host (process/platform/IaC)?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: play-lab-fate
    question: "Fate of Turnur-backed play-lab harness — rewrite on MatchStore + shared URLs, or retire?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: turnur-code-migration
    question: "Migration — freeze + replace (do not wrap); new modules identity/, match-store/, ws/"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: anonymous-to-account
    question: "Can an anonymous session become a Riffle account without leaving the current table and seat?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: display-name-rules
    question: "Uniqueness, persistence, and moderation for in-game display names?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: session-credential-transport
    question: "Riffle session transport — cookie vs bearer for standalone + cross-site embed iframe?"
    blocking: true
    status: open
  - initiative: standalone-play-and-embed
    id: missing-auth-frames
    question: "No Figma frames for entry/auth/display-name/Sit at Table chrome — /forge.design-spike required."
    blocking: true
    status: open
  - initiative: standalone-play-and-embed
    id: standalone-viewport
    question: "Desktop-only standalone chrome vs also mobile web?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: embed-error-copy
    question: "Refresh embed-error copy from mint/redeem to shared-URL language?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: csrf-mutation-channel
    question: "CSRF for mutating iframe→Riffle APIs?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: anonymous-upgrade-fixation
    question: "Anonymous→account upgrade rotation to prevent fixation?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: embed-frame-ancestors
    question: "frame-ancestors allowlist and host registration?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: ws-subscribe-auth
    question: "WS subscribe auth and topic ACLs?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: host-spoofing-embed
    question: "Reject spoofed host without treating host chrome as match authority?"
    blocking: false
    status: open
  - initiative: play-lab
    id: lab-runtime-hosting
    question: "Where is the play lab and Riffle runtime served for a human operator (local process only vs a deployed lab URL)?"
    blocking: false
    status: open
  - initiative: playable-holdem-table
    id: stack-blinds-defaults
    question: "Starting stack and blinds defaults for the first playable NLHE table?"
    blocking: false
    status: open
  - initiative: playable-holdem-table
    id: runtime-hosting
    question: "Where does Riffle runtime host (process/platform)? Superseded by standalone-play-and-embed runtime-hosting."
    blocking: false
    status: deferred
  - initiative: artwork
    id: figma-pages-state
    question: "Figma MCP shows Cover-only Alto9 template; do Screens/Flows pages from design/screens.md need rebuild or is MCP access stale?"
    blocking: false
    status: open
  - initiative: artwork
    id: canva-workspace
    question: "Which Canva workspace/account owns the Riffle kit and who publishes?"
    blocking: false
    status: open
  - initiative: artwork
    id: chip-denom-set
    question: "Exact play-chip denomination set and max stack display rules for flat chip art?"
    blocking: false
    status: open
  - initiative: artwork
    id: card-back-wire
    question: "Wire card-back in the running app this initiative or defer until hidden-card UI exists?"
    blocking: false
    status: open
  - initiative: integrate-turnur-websockets
    id: turnur-ws-shipping
    question: "Superseded — Turnur mothballed; initiative abandoned."
    blocking: false
    status: deferred
  - initiative: integrate-turnur-websockets
    id: ws-reconnect-backoff
    question: "Superseded — Turnur mothballed; initiative abandoned."
    blocking: false
    status: deferred
  - initiative: integrate-turnur-websockets
    id: ws-event-wait-timeout
    question: "Superseded — Turnur mothballed; initiative abandoned."
    blocking: false
    status: deferred
---
