---
doc: product.initiative
schema_version: 1
updated: 2026-09-24
slug: artwork
title: "Artwork (Figma + Canva)"
status: lld
user_facing: true
signoffs:
  po: true
  architect: true
  designer: true
  security: true
board_milestone: "[Artwork](https://github.com/StacksOnTheRacks/riffle-poker/milestone/5)"
board_tickets:
  - "[#53 Define Riffle Figma source components for cards, chips, and felt](https://github.com/StacksOnTheRacks/riffle-poker/issues/53)"
  - "[#54 Serve first-party artwork via GET /assets/* and cardAssetUrl](https://github.com/StacksOnTheRacks/riffle-poker/issues/54)"
  - "[#55 Render Riffle card faces on hole, board, and showdown](https://github.com/StacksOnTheRacks/riffle-poker/issues/55)"
  - "[#56 Apply Riffle felt and table chrome tokens](https://github.com/StacksOnTheRacks/riffle-poker/issues/56)"
  - "[#57 Show chip artwork at pot and seat stacks](https://github.com/StacksOnTheRacks/riffle-poker/issues/57)"
  - "[#58 Publish Canva kit from the same Riffle identity](https://github.com/StacksOnTheRacks/riffle-poker/issues/58)"
---

First-party visual identity and poker artwork for Riffle Poker before public site and embed-mode launch. Covers card faces, backs, chips, felt/table chrome, and exportable brand assets in the dedicated Riffle Poker Figma file and Canva. Playable table and play-lab UI already exist with Alto9-template placeholders; this initiative replaces placeholder art with a coherent Riffle look without changing gameplay rules or match architecture.

Locked for this initiative:
- **Scope:** artwork and visual identity assets — not new gameplay, not RiffSync attach, not a public marketing site (Web Site is a separate Next item)
- **Figma:** extend the bound [Riffle Poker Design](https://www.figma.com/design/NgpCBblDdJ7cw4TLrH9kUE/Riffle-Poker-Design) file; seated-table and play-lab frame structure stays; swap art/tokens where needed
- **Canva:** brand/marketing-ready exports (logo lockups, social templates, one-pagers) derived from the same identity
- **Out:** real-money cashier art, host-platform (RiffSync) reskin, additional poker variants, tournaments

Success bar: seated-table and play-lab surfaces render Riffle-owned card/chip/felt artwork (not Alto9 placeholders) in Figma and in the running app; Canva kit exists for non-product surfaces.

Suggested next: `/forge.refinement` (Designer attends user-facing tickets).
