---
doc: product.metrics
schema_version: 1
updated: 2026-08-23
primary:
  - "Successful guest joins to active hosted rooms (lobby or share URL)"
  - "Hosted rooms that start shared video (broadcast) at least once"
  - "Catalog → room create / solo watch conversion for signed-in hosts"
  - "Indexable public page usefulness (search/social unfurls on catalog, watch, Live) — qualitative until analytics wired"
supporting:
  - "Cast start / stop / failure rates among Cast-capable senders (when ops telemetry exists)"
  - "Friends invite accept rate and DM send success among signed-in fans"
  - "Stale-room sweep effectiveness (dead lobby rows)"
  - "SFU / chat reconnect recovery without full session teardown"
targets:
  - metric: "Baseline instrumentation"
    target: "TBD after first metrics-review (no baseline instrumentation contract in product memory yet)"
  - metric: "Directional product health"
    target: "Guests never blocked from join/watch/read by auth walls; hosts can create and share within one session"
current_read: "Stub: production site live at https://riffsync.tv. Open board is the host Chrome MV3 control-panel MVP (#426 tracking; Ready #428–#431). Scaffold #427 closed. No quantified product dashboard read captured."
---

Brief holds intent/targets in `success_metrics`; this file is the working metric list and current read.
