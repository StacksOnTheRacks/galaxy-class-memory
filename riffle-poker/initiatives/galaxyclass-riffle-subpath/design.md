---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-26
summary: "Anonymous play at galaxyclass.app/riffle/<table-guid>: open URL → load/join one table → pick seat + display name (no account) → dashboard Your Turn. Reuses anonymous-table-play Figma frames; copy references galaxyclass.app/riffle path instead of CloudFront hostname. No studio chrome or Sign in on play path."
figma_file: "https://www.figma.com/design/NgpCBblDdJ7cw4TLrH9kUE/Riffle-Poker-Design"
screens:
  - "Loading (open /riffle/<guid>) — 4004:15 desktop / 4004:20 narrow-iframe"
  - "Table / open — unseated (pick seat + Sit at Table) — 4038:206 desktop / 4038:217 narrow-iframe"
  - "Table / sit-at-table — submitting — 4038:228 / 4038:232"
  - "Display name / edit — default 4038:236/4038:245; validation-error 4038:254/4038:264; saving 4038:274/4038:282"
  - "Table not found / invalid GUID — 4005:210 / 4005:215 (adapt body: invalid link / no table list; not host-room language)"
  - "Play — Table / Your Turn canvas 4132:44+ (owned by dashboard-holdem)"
  - "OUT — Standalone entry / choose-path 4038:35 and Auth 4038:56+ (no login on play path)"
states:
  - "loading: open /riffle/<table-guid> while resolving table"
  - "unseated: choose open seat + Sit at Table (no Cognito)"
  - "sit-submitting: Taking your seat…"
  - "display-name: enter/edit seat label (default | validation-error | saving)"
  - "table-not-found: unknown/invalid GUID or empty /riffle"
  - "seated play: dashboard your-turn"
a11y:
  - "Display name: visible label; validation text not color-only (4038:254)"
  - "Table not found: headline + body text; live-region intent (4005:214/4005:219)"
  - "No auth form on this path; do not present Sign in / Create account chrome"
  - "Sit submitting: live region Taking your seat…"
  - "Table play: inherit a11y from dashboard-holdem/design.md"
open_questions: []
---

Reuse anonymous-table-play Figma inventory. Flow: open `https://galaxyclass.app/riffle/<table-guid>` → loading → unseated join → display name as seat label → dashboard Your Turn. No studio Nav, Cognito, onramp, or iframe embed. Error copy adapted from embed-oriented frames to anonymous subpath (invalid link, no table list).
