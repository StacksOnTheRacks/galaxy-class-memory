---
doc: product.brief
schema_version: 2
updated: 2026-09-12
product_name: "Turnur"
product_description: "Authoritative turn-based match engine (mothballed). Shipped: control plane, game SDK-key auth, host attach, and match authority primitives (seats, turns, hidden views, move log). Operator mothballed Turnur 2026-09-12 — not a developer platform GTM. Riffle Poker absorbs match state for new work. Repo: https://github.com/StacksOnTheRacks/turnur"
problem: "Historical: host platforms wanted turn-based match state without building in-house. Operator decided Riffle owns match state; Turnur is dormant."
audience:
  - "Historical — turn-based game developers (no active GTM)"
  - "Not for new integrators — Riffle is the product"
goals:
  - "Shipped: TypeScript, Node 22, AWS CDK, API Gateway HTTP + Lambda control plane"
  - "Shipped: game SDK-key authentication"
  - "Shipped: match authority primitives (#29–#35)"
non_goals:
  - "Third-party developer platform GTM (mothballed)"
  - "WebSocket notify slice (abandoned #44–#49)"
  - "Riffle as an active Turnur consumer for new work"
  - "Player or host identity on Turnur"
  - "Chat, rooms, presence, or media/playback"
success_metrics:
  - metric: "Product status"
    target: "Mothballed — no new delivery unless operator unmothballs"
  - metric: "Shipped baseline"
    target: "Control plane, game auth, host attach, match primitives remain in repo"
current_focus: "Mothballed (2026-09-12). No new delivery. Shipped code remains in repo. Unmothball only if operator adds a second game or external integrator."
---

Repo: [github.com/StacksOnTheRacks/turnur](https://github.com/StacksOnTheRacks/turnur). Sister product Riffle Poker owns match state for new work.
