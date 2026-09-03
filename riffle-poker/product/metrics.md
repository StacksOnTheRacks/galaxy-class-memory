---
doc: product.metrics
schema_version: 1
updated: 2026-09-02
primary:
  - "Completed Hold'em hands on Turnur (deal through showdown)"
  - "Successful game authentication to Turnur"
  - "Host-attached matches that seat at least two players"
  - "Hidden-view correctness (hole cards not leaked to other seats or spectators)"
supporting:
  - "Host-attach → seat-claim completions on the first host (RiffSync), when measurable"
  - "Invalid or missing SDK key rejections"
  - "Abandoned or incomplete hands"
targets:
  - metric: "Baseline instrumentation"
    target: "TBD after first metrics-review (no product yet; README-only repo, empty issue board)"
  - metric: "First playable slice"
    target: "A table can complete a no-limit Hold'em hand on Turnur from a host room"
  - metric: "Hidden information"
    target: "Hole cards appear only on the owning seat's Turnur hidden view"
current_read: "Repo is still README-only with an empty board and no instrumentation. Initiative playable-holdem-table is HLD→LLD (iframe embed, in-process rules, host-issued seat capability). First expected host: RiffSync. Match backend: Turnur."
---

Brief holds intent/targets in `success_metrics`; this file is the working metric list and current read.
