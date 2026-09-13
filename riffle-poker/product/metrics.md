---
doc: product.metrics
schema_version: 1
updated: 2026-09-12
primary:
  - "Completed Hold'em hands (deal through showdown) — standalone or embed"
  - "Account sign-up/sign-in and anonymous session starts"
  - "Embed-mode tables seated with at least two players"
  - "Hidden-view correctness (hole cards not leaked to other seats or spectators)"
supporting:
  - "WebSocket notify delivery vs HTTP poll fallback (when instrumented)"
  - "Embed attach → hand-complete completions on first host (RiffSync), when measurable"
  - "Abandoned or incomplete hands"
targets:
  - metric: "Baseline instrumentation"
    target: "TBD after first metrics-review (no product instrumentation yet)"
  - metric: "First standalone slice"
    target: "A table completes a no-limit Hold'em hand with account or anonymous auth"
  - metric: "First embed slice"
    target: "A host room loads Riffle embed iframe; two players complete a hand"
  - metric: "Hidden information"
    target: "Hole cards appear only on the owning seat's view"
current_read: "Operator pivot to standalone + embed. Shipped Turnur-backed table and play-lab are historical. Now: standalone-play-and-embed HLD. No product instrumentation yet."
---

Brief holds intent/targets in `success_metrics`; this file is the working metric list and current read.
