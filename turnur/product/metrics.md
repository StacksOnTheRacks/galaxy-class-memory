---
doc: product.metrics
schema_version: 1
updated: 2026-08-23
primary:
  - "Control plane health: GET /v1/health succeeds (synth locally; deployed URL when operators deploy)"
  - "Game authentication success (valid SDK key; game can talk to Turnur) — after auth slice"
  - "Authentication rejection (missing or invalid SDK key) — after auth slice"
  - "After auth exists: matches that an authenticated game can run to seats / turns / hidden views / move log"
  - "Signed-result issuance for finished matches (later; capability only)"
supporting:
  - "cdk synth green on the default branch"
  - "Unauthenticated calls rejected (player or host treated as a game) — after auth slice"
  - "Host-attach → user-join → game-auth completions on the first host (RiffSync), when measurable"
targets:
  - metric: "Baseline instrumentation"
    target: "TBD after first metrics-review (no product yet; README-only repo, empty issue board)"
  - metric: "Control plane slice"
    target: "Health returns ok; synth passes"
  - metric: "Game auth slice"
    target: "A game with an SDK key can authenticate; games without one cannot; Turnur does not authenticate players"
current_read: "Stub: https://github.com/StacksOnTheRacks/turnur is public, created 2026-08-14, default branch main. Scaffold #1 Done (PR #5). Ready #2–#4 on board. Labels ai-ready / human-ready exist; repo on shared GitHub Project. No instrumentation. First expected host: RiffSync. Stack intent: TypeScript, Node 22, AWS CDK, RiffSync-like serverless control plane."
---

Brief holds intent/targets in `success_metrics`; this file is the working metric list and current read.
