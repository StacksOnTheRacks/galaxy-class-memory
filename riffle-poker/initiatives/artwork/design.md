---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-11
summary: "Replace Alto9 placeholder identity with Riffle clean-flat artwork in the bound Figma file. Reskin existing seated-table and play-lab frames without changing layout structure. Produce a Canva marketing kit derived from the same identity. Art direction: clean flat vector — bold suits, minimal texture, modern app feel."
figma_file: "https://www.figma.com/design/NgpCBblDdJ7cw4TLrH9kUE/Riffle-Poker-Design"
screens:
  - "Brand & Foundations — logo mark, wordmark, primary/secondary palette (replace Alto9 brand/500), typography pairing"
  - "Assets / Components — 52 card face component set, card back, chip denominations (1/5/25/100/500/1000 play-chip styling), felt swatch, dealer button (optional)"
  - "Seated table / my-turn — desktop + narrow iframe (reskin; reference design/screens.md names)"
  - "Seated table / hand-in-progress — desktop + narrow iframe"
  - "Seated table / showdown — desktop + narrow iframe"
  - "Seated table / hand-complete — desktop + narrow iframe"
  - "Play lab — no structural change; embedded /play iframes show reskinned play surface"
states:
  - "loading"
  - "waiting-for-deal"
  - "hand-in-progress (not my turn)"
  - "my-turn (actionable)"
  - "showdown"
  - "hand-complete"
  - "embed-error (invalid session / host attach failure)"
  - "lab-idle / lab-ready / lab-two-seats / lab-harness-error (iframe content inherits play art)"
a11y:
  - "Suits readable at narrow iframe width; rank and suit not encoded by color alone"
  - "Chip stacks distinguishable by visible label/value, not color alone"
  - "Card images use decorative img with parent aria-label, or img alt with rank+suit"
  - "Contrast on felt for action controls unchanged or improved vs placeholder"
  - "Reduced-motion: no mandatory deal or chip animations this initiative"
  - "Do not ship identity, chat, rooms, cashier, rake, KYC, HUD, or solver UI as Riffle surfaces"
open_questions:
  - "Figma MCP read Cover-only Alto9 template (2026-09-11); Designer must confirm whether Screens/Flows pages from design/screens.md need rebuild or access is stale"
---

<!--
Authoring (not validated):
- Designer-owned HLD notes. Leave empty / N/A sign-off when initiative is not user-facing.
- Pre-build Figma screens during HLD before LLD grooming.
- Bump updated when any frontmatter field changes.
-->

Frame node ids are not listed here — they are assigned when asset components and reskin frames are built in Figma. Reference existing seated-table and play-lab frame names in design/screens.md; do not invent node ids. Designer HLD sign-off flips in /forge.initiative-planning after frames exist and are inventoried.
