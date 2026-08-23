---
doc: product.spec
schema_version: 1
updated: 2026-08-23
feature: "Product metrics baseline"
problem: "Maintainers cannot read primary product funnels (guest join, host broadcast, catalog conversion, Live entry) beyond GA4 page views and ops EMF namespaces; #438–#440 need one normative contract."
users:
  - "Maintainers and engineers implementing metrics tickets"
  - "Not for end-user-facing product changes"
requirements:
  - "Canonical contract at docs/operations/product-metrics.md (board #437 deliverable)"
  - "GA4 events: room_join, host_broadcast_start, host_room_create, solo_watch_start, live_channel_view"
  - "CloudWatch RiffSync/Product Routes: GuestRoomJoin, BroadcastStarted, RoomCreate, LiveChannelView"
  - "Low-cardinality params/dimensions only; no roomId/sessionId/hostSub/fanSub"
  - "Ops namespaces RiffSync/Realtime, RiffSync/Media, RiffSync/Api stay drawer/ops-only"
acceptance_criteria:
  - "Contract doc lands per Ready issue #437"
  - "#438 and #439 implement strings verbatim from contract"
out_of_scope:
  - "Cast, friends/DM, stale-room supporting metrics in v1 contract"
  - "New analytics vendors"
  - "Privacy Policy rewrite unless gap found during #437"
constraints:
  - "Board issue #437 + tech spec comment are SoT until doc merges"
  - "GA4 no-op when VITE_GA_MEASUREMENT_ID unset"
verification: "Doc review; trace primary metrics in product/metrics.md to contract table"
open_questions: []
success_metrics:
  - metric: "Contract completeness"
    target: "Every primary metric maps to GA4 event and/or CW Route with no TBD strings"
---

Ready ticket #437 is the execution contract; this spec is a memory projection updated after the doc ships.
