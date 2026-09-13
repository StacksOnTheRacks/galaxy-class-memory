---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-11
summary: "Introduce a static asset pipeline and card→asset mapper; swap CSS/text poker visuals for exported clean-flat SVG/PNG from Figma; sync core CSS variables to Figma tokens; Canva kit is an out-of-repo deliverable. No Turnur, host API, or rules changes."
approach: "Add public/assets/ with organized exports (52 card faces as {rank}{suit}.svg, card back, chip denominations, optional felt). Extend the client build to copy assets into public/; add GET /assets/* on the Riffle runtime alongside existing /play.css serving. New client module (e.g. src/client/assets/cards.ts) maps rules notation (As, Kh) → asset URL; refactor board.ts, hole-cards.ts, and showdown surfaces to render img or background-image with fixed aspect while retaining aria-label and data-tag YOU|BOARD|SHOWN. Replace ad hoc --felt-green etc. in styles.css with names aligned to Figma token export (design/tokens.md populated in a follow-on audit). Update hole-cards-ui, public-board-ui, and hand-complete-ui tests to assert asset presence and a11y labels instead of textContent rank letters. Canva kit lives outside the runtime repo."
interfaces:
  - "GET /assets/* — static first-party artwork (cards, chips, felt) from Riffle origin"
  - "cardAssetUrl(card: Card): string — internal mapper from rules notation to asset URL"
  - "chipAssetUrl(denom: number): string — internal mapper for chip denomination artwork (LLD detail)"
structure:
  - "public/assets/cards/ — 52 face SVGs + back.svg"
  - "public/assets/chips/ — denomination SVGs (e.g. 1, 5, 25, 100, 500, 1000)"
  - "public/assets/felt/ — optional felt texture or swatch export"
  - "src/client/assets/ — card and chip URL mappers"
  - "Refactored render paths — board.ts, hole-cards.ts, hand-complete surfaces, optional chip component for pot/stacks"
  - "Build step — esbuild client build copies/hashes assets; CSP img-src 'self' data: unchanged"
  - "Canva kit — external deliverable; not served by runtime"
constraints:
  - "No Turnur SDK, host API, bootstrap, or seat-capability changes"
  - "SVG preferred for cards and chips; PNG fallback for felt texture only if needed"
  - "Iframe bundle size budget — review total asset weight before LLD sign-off"
  - "All runtime assets served from 'self'; no external hotlinked art in production bundle"
  - "Rules Card notation unchanged — mapper is presentation-only"
  - "Play lab inherits play-surface art via iframes; lab-styles.css reskin optional"
open_questions: []
---

<!--
Authoring (not validated):
- Architect-owned HLD technical spec under initiatives/<slug>/spec.md.
- Distinct from per-ticket <!-- forge-tech-spec --> comments posted at LLD refinement.
- Bump updated when any frontmatter field changes.
-->
