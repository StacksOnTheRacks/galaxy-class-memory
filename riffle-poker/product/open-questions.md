---
doc: product.open_questions_index
schema_version: 1
updated: 2026-09-12
items:
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
    id: anonymous-upgrade-fixation
    question: "How does anonymous→account upgrade rotate so an attacker-set anonymous session cannot inherit the account?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: embed-frame-ancestors
    question: "frame-ancestors for standalone vs embed — allowlisted hosts only, never *; how are hosts registered?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: ws-subscribe-auth
    question: "How does a WS subscriber prove a Riffle session, and which topic ACLs separate public table state from seat-scoped hidden views?"
    blocking: false
    status: open
  - initiative: standalone-play-and-embed
    id: host-spoofing-embed
    question: "How does the iframe reject a spoofed host (wrong parent, forged postMessage, copied URL on a hostile page) without treating host chrome as match authority?"
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
    question: "Where does Riffle runtime host (process/platform)? Undecided; non-blocking while iframe + in-process library + server-side SDK key hold."
    blocking: false
    status: open
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
    question: "Track Turnur milestone/4 (#44–#49); Riffle LLD grooming may proceed; implement-ticket blocked until Turnur integrate-websockets ships."
    blocking: false
    status: deferred
  - initiative: integrate-turnur-websockets
    id: ws-reconnect-backoff
    question: "Reconnect and resubscribe backoff policy when Turnur WS disconnects mid-hand?"
    blocking: false
    status: deferred
  - initiative: integrate-turnur-websockets
    id: ws-event-wait-timeout
    question: "Default timeout before poll fallback after HTTP mutation when expected push does not arrive?"
    blocking: false
    status: deferred
---
