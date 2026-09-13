---
doc: design.principles
schema_version: 1
updated: 2026-09-12
principles:
  - "Figma is source of truth for tokens, screens, and components once a theme is bound; do not invent visual-system facts"
  - "Player-facing poker UI must make turn, legal actions, and public table state obvious at a glance"
  - "In embed-mode, the host owns chat, rooms, and media; Riffle owns gameplay on the felt. In standalone, Riffle owns first-party account and anonymous entry before seated play"
  - "Hole cards stay seat-private; the public board is shared with other seated players"
  - "The host integrator attaches a table pack; Riffle UI is the game surface, not a lobby, cashier, or matchmaking product"
a11y_rules:
  - "Do not rely on color alone to convey suit, status, or win/lose"
  - "Interactive controls need a visible label and a non-color focus indicator"
  - "Seat-private hole cards and the public board must be distinguishable without color alone"
  - "Auth forms need visible labels; anonymous entry CTA must be named and distinguishable by text"
interaction_patterns:
  - "Confirm irreversible chip or table-exit actions before they commit"
  - "Keep table actions on the felt; account sign-in/sign-up and anonymous entry live in standalone chrome only — not in embed, not mid-hand"
anti_patterns:
  - "Shipping player UI from unbound or stale Figma, or from invented tokens"
  - "Color-only encoding of card suits or action states"
  - "Shipping identity UI inside the embed iframe, or treating host login as Riffle seat authority"
  - "Cashier, rake, or KYC UI"
  - "Study, HUD, or solver overlays on the table"
---

Theme bound to dedicated Riffle Poker Design file (`NgpCBblDdJ7cw4TLrH9kUE`). Principles updated after standalone-play-and-embed design-spike (2026-09-12) to allow Riffle-owned standalone entry/auth while preserving embed anti-patterns.
