---
doc: design.principles
schema_version: 1
updated: 2026-09-02
principles:
  - "Figma is source of truth for tokens, screens, and components once a theme is bound; do not invent visual-system facts"
  - "Player-facing poker UI must make turn, legal actions, and public table state obvious at a glance"
  - "Design for a seated player at a host-attached table (play chips); identity, chat, rooms, and media stay on the host"
  - "Hole cards stay seat-private; the public board is shared with other seated players"
  - "The host integrator attaches a table pack; Riffle UI is the game surface, not a lobby, cashier, or matchmaking product"
a11y_rules:
  - "Do not rely on color alone to convey suit, status, or win/lose"
  - "Interactive controls need a visible label and a non-color focus indicator"
  - "Seat-private hole cards and the public board must be distinguishable without color alone"
interaction_patterns:
  - "Confirm irreversible chip or table-exit actions before they commit"
  - "Keep table actions on the felt; do not send the player into a Riffle-owned identity, chat, room, or cashier flow"
anti_patterns:
  - "Shipping player UI from unbound or stale Figma, or from invented tokens"
  - "Color-only encoding of card suits or action states"
  - "Shipping identity, chat, rooms, presence, or media UI as Riffle surfaces"
  - "Cashier, rake, or KYC UI"
  - "Study, HUD, or solver overlays on the table"
---

Hypothesis personas (brief audience plus sister Turnur/RiffSync contracts; not interview-validated). Theme still unbound. Principles encode seated-player table UX and host-owned social surfaces.
