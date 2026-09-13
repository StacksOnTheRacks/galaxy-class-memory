---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-12
summary: "HLD adds Riffle-owned standalone chrome (account sign-up/sign-in and anonymous play entry) plus embed-mode of the SAME seated play surface via a shared play URL. Existing Screens / Flows seated-table and embed-error frames (desktop 960×640 + narrow-iframe 360×640) are reusable and must not be redesigned this HLD. Auth, anonymous entry, display-name edit, Sit at Table chrome, and standalone app shell are missing from Figma — blocking Designer HLD exit until /forge.design-spike. Play-lab frames are an operator harness, not consumer standalone. Host (RiffSync first) keeps chat, rooms, and media."
figma_file: "https://www.figma.com/design/NgpCBblDdJ7cw4TLrH9kUE/Riffle-Poker-Design"
screens:
  - "Seated table (reuse; desktop + narrow-iframe) — see design/screens.md; do not redesign"
  - "Embed / session error (reuse) — 4005:210 desktop / 4005:215 narrow-iframe; do not redesign"
  - "MISSING — Standalone entry (account vs anonymous CTA)"
  - "MISSING — Account sign-in"
  - "MISSING — Account sign-up"
  - "MISSING — Auth form error / validation / submitting states"
  - "MISSING — Display-name edit (anonymous and account)"
  - "MISSING — Sit at Table affordance on felt if not already present"
  - "MISSING — Minimal standalone app chrome (header / account affordance)"
  - "Play lab (existing 4012:*; operator harness only — not consumer standalone)"
states:
  - "standalone-entry (choose account or anonymous)"
  - "auth-sign-in / auth-sign-up (default)"
  - "auth-validation-error / auth-failure / auth-submitting"
  - "anonymous-session-ready (after Sit at Table)"
  - "display-name-edit"
  - "iframe felt states unchanged: loading | waiting-for-deal | hand-in-progress | my-turn | showdown | hand-complete | embed-error"
  - "embed-error remains host-attach / shared-link failure — not a Riffle login"
a11y:
  - "Auth forms: visible labels on every field (not placeholder-only); errors associated with fields and announced to AT; non-color focus; keyboard complete without pointer"
  - "Anonymous CTA must be a named control, distinguishable from Sign in / Sign up by text (not color or position alone)"
  - "Auth failure vs validation vs network/session expiry must be plain language, not color-only"
  - "Embed iframe needs a visible programmatic title (e.g. Riffle Poker table) so the host page and AT can name the frame"
  - "Embed-error already has live-region intent (4005:214 / 4005:219); keep attach failure in text; do not morph it into a login form"
  - "Standalone chrome vs embed: do not put Riffle login/identity chrome inside the embed iframe"
  - "Desktop (960×640) vs narrow-iframe (360×640): auth/entry are standalone desktop-first; embed stays narrow-iframe"
  - "Do not rely on color alone for auth status or anonymous vs account"
  - "Respect reduced-motion on any entry/auth transition"
open_questions:
  - "BLOCKING — No Figma frames for sign-up, sign-in, anonymous entry, display-name edit, or standalone chrome. Pre-build on Screens / Flows via /forge.design-spike before Designer HLD sign-off."
  - "BLOCKING — missing-auth-frames tracked in initiative open-questions.md"
  - "Does standalone table use desktop frames only, with narrow-iframe reserved for embed?"
  - "Embed-error copy still says host session mint/redeem — refresh to shared-URL language when embed ships"
  - "design/principles.md still forbids Riffle-owned identity — update principles after the spike, not this HLD"
---

This HLD is two product surfaces, one play felt.

**Reuse (MCP-verified on Screens / Flows `3:4`, 2026-09-12).** All `design/screens.md` seated-table and embed-error node ids still resolve with the same names. Desktop 960×640 and narrow-iframe 360×640 pairs are intact. Felt composition stays one table after attach. Do not redesign these frames here.

**Embed.** Host (RiffSync first) iframes the same `/play` surface via the shared play URL. Existing loading copy references host-session redeem; embed-error copy says "Couldn't attach to this table" / host session invalid — "This is not a Riffle login." Narrow-iframe is the embed viewport. No Riffle login chrome inside the iframe. Iframe title is a host-page a11y requirement.

**Standalone (missing).** Account sign-up/sign-in, anonymous play entry, display-name edit, and Sit at Table chrome have no frames. Components page `3:3` has Button, Input, Link, Card, Checkbox — primitives for a spike, not pre-built auth screens. Play lab `4012:*` is an operator harness; not a consumer lobby.

**Spike path.** Same file `NgpCBblDdJ7cw4TLrH9kUE`. Add a new Screens / Flows row below play-lab (y > 11000). Designer sign-off stays false until planning re-check after frames exist.

**Artwork OQ note.** MCP page listing shows Cover-only, but pages exist by id (Screens / Flows `3:4`). Inventoried frames do not need rebuild.
