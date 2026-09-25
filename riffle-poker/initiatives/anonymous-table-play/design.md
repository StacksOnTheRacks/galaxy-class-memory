---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-25
summary: "Anonymous CloudFront GUID play: open URL → load/join one table → pick seat + display name (no account) → dashboard Your Turn. Reuse standalone entry frames for sit/name/error; reuse dashboard-holdem Your Turn for play. No lobby, auth, felt artwork, or mic/camera. Empty path and embed-oriented error copy are non-blocking adaptations."
figma_file: "https://www.figma.com/design/NgpCBblDdJ7cw4TLrH9kUE/Riffle-Poker-Design"
screens:
  - "Loading (open GUID) — 4004:15 desktop / 4004:20 narrow-iframe"
  - "Table / open — unseated (pick seat + Sit at Table) — 4038:206 desktop / 4038:217 narrow-iframe — interaction SoT; felt backdrop out of ship"
  - "Table / sit-at-table — submitting — 4038:228 / 4038:232"
  - "Display name / edit — default 4038:236/4038:245; validation-error 4038:254/4038:264; saving 4038:274/4038:282"
  - "Table not found / invalid GUID — reuse Embed / session error 4005:210 / 4005:215 (adapt body copy; keep title)"
  - "Play — Table / Your Turn canvas 4132:44; Desktop 4132:45; Tablet 4132:795; Phone 4132:796 (owned by dashboard-holdem; do not redesign)"
  - "OUT — Standalone entry / choose-path 4038:35 and Auth 4038:56+ (no login / no lobby)"
states:
  - "EXIST — loading: open /<table-guid> while resolving table"
  - "EXIST — unseated: choose open seat + Sit at Table (no Cognito)"
  - "EXIST — sit-submitting: Taking your seat…"
  - "EXIST — display-name: enter/edit seat label (default | validation-error | saving); not an account"
  - "EXIST — table-not-found: unknown/invalid GUID; text error panel; no other-tables list"
  - "COMPOSE — empty path (/) → same error panel as table-not-found (no dedicated frame)"
  - "EXIST — seated play: dashboard your-turn (and related dashboard composition)"
  - "OUT — choose-path / sign-in / sign-up"
  - "OWNED ELSEWHERE — dashboard waiting / not-your-turn / showdown / empty-seat gaps stay with dashboard-holdem"
a11y:
  - "Display name: visible label on the field (panel title Edit display name or an explicit Display name label associated with the input); validation text not color-only (see 4038:254)"
  - "Table not found: headline + body text (4005:210); not color-only; live-region intent on 4005:214/4005:219"
  - "No auth form on this path; do not present Sign in / Create account chrome"
  - "Sit submitting: live region Taking your seat… (4038:228/4038:232)"
  - "Table itself: inherit a11y from initiatives/dashboard-holdem/design.md (omit Mic/Camera; no live media)"
open_questions:
  - "NON-BLOCKING — Adapt 4005:210/4005:215 body from embed host-room language to CloudFront anonymous (table not found / invalid link; no host room; no table list). Keep title Couldn't open this table."
  - "NON-BLOCKING — Unseated/sit/display-name frames are felt-backed. Compose pick-seat + Sit + display-name panel onto the dashboard shell at implement; do not ship felt artwork. No new dashboard-unseated frame required for HLD."
  - "NON-BLOCKING — No dedicated empty-path frame. Treat / (and missing GUID) as the same table-not-found error surface as invalid GUID."
  - "NON-BLOCKING — Figma separates unseated Sit at Table from Display name / edit. Either sit-then-name or name-with-sit is fine if both frames' behaviors ship; name is a seat label only."
---

Anonymous GUID play on the default CloudFront host. Flow: open `https://<distribution>.cloudfront.net/<table-guid>` → loading → unseated join (pick seat, Sit at Table) → display name as seat label → dashboard Your Turn. No custom domain, lobby, Cognito, onramp, felt art, or live mic/camera.

**Reuse.** Entry interactions from standalone spike frames (`4038:*`, `4004:15`/`20`, `4005:210`/`215`). Play composition from dashboard-holdem Your Turn (`4132:44`+). Do not reopen dashboard waiting / not-your-turn / showdown / empty-seat as blockers here.

**Out.** Choose-path and auth frames. Any UI that lists other tables or implies login.
