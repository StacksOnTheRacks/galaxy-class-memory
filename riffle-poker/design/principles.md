---
doc: design.principles
schema_version: 1
updated: 2026-08-30
principles:
  - "Figma is source of truth for tokens, screens, and components once a theme is bound; do not invent visual-system facts"
  - "Player-facing poker UI must make turn, legal actions, and public table state obvious at a glance"
a11y_rules:
  - "Do not rely on color alone to convey suit, status, or win/lose"
  - "Interactive controls need a visible label and a non-color focus indicator"
interaction_patterns:
  - "Confirm irreversible chip or table-exit actions before they commit"
anti_patterns:
  - "Shipping player UI from unbound or stale Figma, or from invented tokens"
  - "Color-only encoding of card suits or action states"
---

Stubs pending brief/personas and a bound theme. Expand in /forge.design-system-audit or /forge.insights-review.
