---
doc: product.initiative
schema_version: 1
updated: 2026-09-25
slug: dashboard-holdem
title: "Dashboard Hold'em"
status: lld
user_facing: true
signoffs:
  po: false
  architect: false
  designer: false
  security: false
board_milestone: "[Dashboard Hold'em](https://github.com/StacksOnTheRacks/riffle-poker/milestone/6)"
board_tickets:
  - "[#59 Host interactive match runtime on API Gateway WebSocket + Lambda + DynamoDB](https://github.com/StacksOnTheRacks/riffle-poker/issues/59)"
  - "[#60 Render dashboard table shell for Desktop, Tablet, and Phone](https://github.com/StacksOnTheRacks/riffle-poker/issues/60)"
  - "[#61 Show player row tiles with stack, cards, action, positions, and turn timer](https://github.com/StacksOnTheRacks/riffle-poker/issues/61)"
  - "[#62 Show My Hand pocket, bank, session delta, committed, strength, outs, and action log](https://github.com/StacksOnTheRacks/riffle-poker/issues/62)"
  - "[#63 Show Board slots, pot, and players in hand](https://github.com/StacksOnTheRacks/riffle-poker/issues/63)"
  - "[#64 Ship Fold/Check/Call/Raise controls with raise presets, slider, and phone action sheet](https://github.com/StacksOnTheRacks/riffle-poker/issues/64)"
  - "[#65 Sit at table, post blinds, deal hole cards, and open betting](https://github.com/StacksOnTheRacks/riffle-poker/issues/65)"
  - "[#66 Advance legal betting through flop, turn, and river](https://github.com/StacksOnTheRacks/riffle-poker/issues/66)"
  - "[#67 Settle all-in with side pots when required, showdown or fold-out, and update stacks](https://github.com/StacksOnTheRacks/riffle-poker/issues/67)"
  - "[#68 Configure AWS OIDC deploy role and GitHub environment for serverless match runtime](https://github.com/StacksOnTheRacks/riffle-poker/issues/68)"
---

**Outcome:** Players sit at a Riffle dashboard table and complete no-limit Hold'em hands in play chips: deal → act → streets → fold-out or showdown (including all-in), with stacks settling correctly.

**UI (locked):** Dashboard composition per Figma file [NgpCBblDdJ7cw4TLrH9kUE](https://www.figma.com/design/NgpCBblDdJ7cw4TLrH9kUE/Riffle-Poker-Design?node-id=4132-44) — node `4132:44` Table / Your Turn (Desktop `4132:45`, Tablet `4132:795`, Phone `4132:796`). Surfaces: top bar; player row; My Hand; Board; Actions (phone = action sheet). Tiles are avatar or initials — no live mic/camera. Mic/camera controls omitted (not disabled chrome).

**Hosting (product constraint):** API Gateway WebSocket + Lambda + DynamoDB; static SPA on S3 + CloudFront; CDK via GitHub Actions (OIDC). Interactive, cheap; no always-on server.

**In scope:** sit, deal, legal betting, street advance, all-in, side pots when unequal stacks require them, fold-out or showdown, stack updates, dashboard surfaces above.

**Out:** embed-mode / RiffSync / iframe host attach; felt-table artwork pipeline; live AV; chat/rooms/media; real money; variants; tournaments; Multi-Hand Session polish as a separate outcome; public marketing site.

Operator skipped HLD sign-off; status is `lld` so Refinement tickets were cut immediately. Signoffs remain false until `/forge.initiative-planning`.

Suggested next: `/forge.refinement` (Designer attends user-facing tickets).
