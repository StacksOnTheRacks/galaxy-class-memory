---
doc: design.principles
schema_version: 1
updated: 2026-09-26
principles:
  - "Figma is source of truth for tokens, screens, and components once a theme is bound; do not invent visual-system facts"
  - "Functional, usable, and fun over high-cost graphic art production"
  - "Impressive modern craft with tasteful motion — atmosphere is enhancement, not the product"
  - "Galaxy Class Gaming is the studio brand; Riffle and future games are featured products — do not collapse studio and product into one identity"
  - "Auth screens (sign up, sign in, account) are first-class designed surfaces, not bolt-on forms"
  - "Marketing introduces products and routes people to them; gameplay stays in the game apps"
a11y_rules:
  - "Do not rely on color alone for CTAs, featured-product emphasis, or status"
  - "Interactive controls need a visible label and a non-color focus indicator"
  - "Atmospheric motion and animation must not be the only way to understand content; honor reduced-motion"
  - "Copy and CTAs stay readable against cinematic or dark backgrounds"
interaction_patterns:
  - "Keep primary paths named and obvious: studio story, featured games (Riffle first), Galaxy Class account"
  - "Leaving the studio site into a game is an explicit destination, not a silent embed"
  - "Hover, parallax, and atmosphere are enhancement; navigation, auth, and CTAs work without them"
anti_patterns:
  - "Shipping UI from unbound or stale Figma, or from invented tokens"
  - "Color-only or motion-only encoding of important states"
  - "Live gameplay or table UI on the studio site"
  - "Treating Galaxy Class Gaming and Riffle as the same brand or the same product"
  - "Cognito Hosted UI as the player-facing auth experience"
---

Studio UX/a11y guardrails. Revisit after theme bind and initiative-design.
