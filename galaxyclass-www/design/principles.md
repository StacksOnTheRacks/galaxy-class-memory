---
doc: design.principles
schema_version: 1
updated: 2026-09-14
principles:
  - "Figma is source of truth for tokens, screens, and components once a theme is bound; do not invent visual-system facts"
  - "This site is the Galaxy Class Gaming company surface — cinematic, craft-first marketing — not a game client"
  - "Galaxy Class Gaming is the studio brand; Riffle is the first featured product — do not collapse studio and product into one identity"
  - "Marketing introduces products and routes people to them; play, accounts, and money stay in the product"
a11y_rules:
  - "Do not rely on color alone for CTAs, featured-product emphasis, or status"
  - "Interactive controls need a visible label and a non-color focus indicator"
  - "Atmospheric motion and video must not be the only way to understand content; honor reduced-motion"
  - "Copy and CTAs stay readable against cinematic or dark backgrounds"
interaction_patterns:
  - "Keep primary paths named and obvious: company story and featured product (Riffle)"
  - "Leaving the marketing site into a product is an explicit destination, not a silent embed"
  - "Hover, parallax, and atmosphere are enhancement; navigation and CTAs work without them"
anti_patterns:
  - "Shipping marketing UI from unbound or stale Figma, or from invented tokens"
  - "Color-only or motion-only encoding of important states"
  - "Live gameplay, table UI, cashier, or account flows on this site"
  - "Treating Galaxy Class Gaming and Riffle as the same brand or the same product"
---

First-pass UX/a11y for an unbound marketing site. Not a design-system catalog. Revisit after theme bind.
