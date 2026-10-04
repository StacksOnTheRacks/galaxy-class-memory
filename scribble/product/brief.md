---
doc: product.brief
schema_version: 2
updated: 2026-10-04
product_name: "Scribble"
product_description: "Galaxy Class browser word game on a 15×15 crossword board, at galaxyclass.app/scribble. Standard crossword-board rules (100-tile English set, racks of 7, premium squares, 50-point all-seven bonus) with an original look. Server-authoritative over its own API Gateway WebSocket + Lambda + DynamoDB runtime; Phaser 3 static SPA. Lives in the galaxyclass monorepo as packages/scribble. Repo: https://github.com/StacksOnTheRacks/galaxyclass"
problem: "Friends want to sit down at a shared word-game table in the browser, signed in or as a guest, without installing anything and without anyone being able to see another player's rack."
audience:
  - "Galaxy Class players who want a 2–4 player word game in the browser"
  - "Signed-in Galaxy Class accounts (name and avatar from the account) and guests"
  - "Not for competitive word-list play (no NASPA/Collins lists, no challenges)"
goals:
  - "A full legal game from first play to end-game rack adjustment, 2–4 seats"
  - "Hidden racks: an opponent cannot read another rack from the wire"
  - "Same table session shape as Riffle (join_table, sit, leave, seat token, seat-scoped snapshots)"
  - "Readable scoring: every scored tile highlighted, then face values, premiums, +50, total"
  - "Themes as data, shared per table: Default, Halloween, Christmas"
non_goals:
  - "Poker rules or poker UI"
  - "The Scrabble name, logo, or board art"
  - "Copyrighted word lists (NASPA, Collins); the shipped list is ENABLE (public domain)"
  - "Public create-table in v1 (seeded public tables only; records are ready for private invite-only tables)"
  - "Challenges, turn timers, or seat resume after disconnect in v1"
  - "Native, Godot, or Unity builds"
success_metrics:
  - metric: "Two-browser game"
    target: "One signed-in and one guest browser finish a legal game, see the highlight and count, change themes, and leave and rejoin"
  - metric: "Hidden information"
    target: "No opponent rack tile ids, bag contents, seat token hashes, or player subs appear in any other seat's frames"
current_focus: "v1 shipped as stacked PRs 1–5 on galaxyclass (accounts verifier move, rules + ENABLE, runtime, Phaser client, infra + studio cabinet). Next: operator applies the Scribble cfn-exec policy and runs Deploy Galaxy Class."
---
