---
doc: architecture.constraints
schema_version: 1
updated: 2026-09-12
hard_constraints:
  - "Riffle owns match state for new work: seats, turns, hidden views, move log. Turnur is mothballed — no new @turnur/sdk consumption."
  - "Gameplay and rules live in Riffle Poker. Riffle evaluates poker legality in-process."
  - "Standalone play supports account sign-up/sign-in or anonymous session (mechanism TBD in HLD)."
  - "Embed-mode: host loads Riffle play surface as iframe at Riffle origin; host keeps chat, rooms, and media."
  - "Riffle hosts WebSocket notify for match/table updates (client locus TBD in HLD)."
  - "No real-money wagering, cashier, or KYC."
  - "Riffle is a poker game, not a watch-party, chat, catalog, or media product."
  - "Host does not evaluate poker rules or own match state in embed-mode."
soft_constraints:
  - "First embed host is RiffSync; remain host-agnostic for embed-mode."
  - "Prefer TypeScript when a stack is chosen. Not locked."
  - "Defer runtime hosting / IaC until HLD resolves; in-process rules locus is locked."
  - "Play-surface UI must compose at desktop and narrow embed widths."
  - "Shipped Turnur-backed paths may remain until migration strategy is chosen — do not extend them."
out_of_bounds:
  - "Turnur as match backend or developer platform GTM."
  - "Rooms, presence, chat, or a media/SFU plane of Riffle's own."
  - "Real-money wagering, cashier, or KYC systems."
  - "Play lab as production lobby or matchmaking (historical harness only)."
  - "Copying RiffSync's Cognito, chat, or SFU/TURN stacks wholesale."
assumptions:
  - "Operator mothballed Turnur; Riffle standalone + embed is the product bet."
  - "Shipped Turnur-backed table/play-lab code is historical proof, not the forward architecture."
  - "Embed link shape, identity mechanism, anonymous binding, and WS client locus are open in standalone-play-and-embed HLD."
  - "Runtime hosting undecided (non-blocking during HLD)."
---
