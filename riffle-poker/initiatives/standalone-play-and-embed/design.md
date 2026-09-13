---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-12
summary: "Standalone + embed UX inventory built on Screens / Flows (y>11000). Standalone entry/auth/chrome at desktop 960×640; unseated Sit at Table + display-name edit at desktop and narrow-iframe; seated hand states reuse existing frames. No lobby; no Riffle login in embed iframe. Loading and embed-error copy refreshed to shared-URL language."
figma_file: "https://www.figma.com/design/NgpCBblDdJ7cw4TLrH9kUE/Riffle-Poker-Design"
screens:
  - "Standalone app chrome / signed-out — 4038:28"
  - "Standalone entry / choose-path — 4038:35"
  - "Standalone app chrome / signed-in — 4038:49"
  - "Auth / sign-in — default 4038:56; validation-error 4038:73; auth-failure 4038:91; submitting 4038:109"
  - "Auth / sign-up — default 4038:125; validation-error 4038:145; auth-failure 4038:166; submitting 4038:187"
  - "Table / open — unseated — desktop 4038:206; narrow-iframe 4038:217"
  - "Table / sit-at-table — submitting — desktop 4038:228; narrow-iframe 4038:232"
  - "Display name / edit — default 4038:236/4038:245; validation-error 4038:254/4038:264; saving 4038:274/4038:282"
  - "Seated table (reuse) — see design/screens.md 4004:*–4010:*; hand off after Sit at Table"
  - "Loading (copy refreshed) — 4004:15 desktop / 4004:20 narrow-iframe"
  - "Embed / session error (copy refreshed) — 4005:210 desktop / 4005:215 narrow-iframe"
  - "a11y annotations — standalone + embed entry — 4038:290"
states:
  - "standalone-entry → auth-sign-in | auth-sign-up | anonymous path → unseated → sit-submitting → waiting-for-deal (reuse) → hand states (reuse)"
  - "embed: loading → unseated narrow → sit-submitting → waiting-for-deal narrow (reuse); embed-error on bad link"
  - "display-name-edit (default | validation-error | saving) on desktop and narrow-iframe"
a11y:
  - "Auth forms: visible labels on every field; errors associated with fields; keyboard complete"
  - "Anonymous CTA named Play without account — text-distinguishable from Sign in / Create account"
  - "Embed iframe title Riffle Poker table on host page (4038:290 annotation)"
  - "Sit at Table submitting: live region Taking your seat… (4038:228/4038:232)"
  - "Embed-error live-region intent preserved (4005:214/4005:219); attach failure not a login form"
  - "No Riffle login chrome inside embed iframe"
open_questions: []
---

Two product surfaces, one play felt.

**Flow.** Standalone: entry/auth gate (desktop only) → shared play URL → unseated felt (`4038:206`) → Sit at Table → existing waiting-for-deal (`4004:31`) and hand states. Embed: host `iframe.src` same URL → unseated narrow (`4038:217`) → Sit at Table → existing seated narrow frames. No production lobby.

**Copy refresh (2026-09-12).** Loading: "Loading table…" / "Opening play link · no actions yet". Embed error: "Couldn't open this table" / shared play-link invalid message.

**Viewport.** Standalone consumer surfaces desktop 960×640 Now. Narrow-iframe 360×640 for embed unseated, sit-submitting, and display-name only. Mobile-web standalone unscoped.

**Spike section.** Screens / Flows row starting y=11120; section label `4038:27`. Play-lab `4012:*` remains operator harness only.

Suggested next: `/forge.initiative-planning` for Designer re-check (signoffs still false until planning gate).
