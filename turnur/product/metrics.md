---
doc: product.metrics
schema_version: 1
updated: 2026-09-12
primary:
  - "Product status: mothballed"
  - "Shipped baseline preserved: control plane health, game auth, match primitives"
supporting:
  - "cdk synth green on default branch (maintenance only)"
targets:
  - metric: "Delivery"
    target: "No new features unless operator unmothballs"
  - metric: "Shipped baseline"
    target: "Existing HTTP match authority API remains in repo"
current_read: "Mothballed 2026-09-12. No active delivery. integrate-websockets abandoned."
---

Brief holds intent/targets in `success_metrics`; this file is the working metric list and current read.
