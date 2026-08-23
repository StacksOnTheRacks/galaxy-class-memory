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
    target: "Contract doc + GA4 custom events + CloudWatch RiffSync/Product counters for primary metrics; first dashboard/read within one sprint of ship"
  - metric: "Directional product health"
    target: "Guests never blocked from join/watch/read by auth walls; hosts can create and share within one session"
current_read: "Production at https://riffsync.tv. GA4 page views exist (VITE_GA_MEASUREMENT_ID); ops EMF namespaces exist (RiffSync/Realtime, RiffSync/Media, RiffSync/Api). Product funnel events and business counters not yet wired."
---

Brief holds intent/targets in `success_metrics`; this file is the working metric list and current read.
