---
doc: architecture.constraints
schema_version: 1
updated: 2026-09-12
hard_constraints:
  - "Riffle owns match state for new work: seats, turns, hidden views, move log. Turnur is mothballed — no new @turnur/sdk consumption."
  - "Gameplay and rules live in Riffle Poker. Riffle evaluates poker legality in-process."
  - "Standalone play supports account sign-up/sign-in or anonymous session — first-party Riffle bearer session (account id or anon:{jti}); not Cognito; not host identity."
  - "Embed-mode: host loads Riffle play surface as iframe at Riffle origin; host keeps chat, rooms, and media."
  - "Browser connects to Riffle WS for notify-only public table events; HTTP mutations stay authoritative."
  - "Session transport is bearer-only (Authorization or equivalent) on standalone and embed; no ambient cookie."
  - "No real-money wagering, cashier, or KYC."
  - "Riffle is a poker game, not a watch-party, chat, catalog, or media product."
  - "Host does not evaluate poker rules or own match state in embed-mode."
soft_constraints:
  - "First embed host is RiffSync; remain host-agnostic for embed-mode."
  - "Prefer TypeScript when a stack is chosen. Not locked."
  - "Defer runtime hosting / IaC until LLD resolves; in-process rules locus is locked."
  - "Play-surface UI must compose at desktop and narrow embed widths."
  - "Shipped Turnur-backed paths are frozen — freeze + replace (do not wrap); do not extend them."
out_of_bounds:
  - "Turnur as match backend or developer platform GTM."
  - "Rooms, presence, chat, or a media/SFU plane of Riffle's own."
  - "Real-money wagering, cashier, or KYC systems."
  - "Play lab as production lobby or matchmaking (historical harness only)."
  - "Copying RiffSync's Cognito, chat, or SFU/TURN stacks wholesale."
assumptions:
  - "Operator mothballed Turnur; Riffle standalone + embed is the product bet."
  - "Shipped Turnur-backed table/play-lab code is historical proof, not the forward architecture."
  - "Runtime hosting undecided (non-blocking during LLD)."
---
