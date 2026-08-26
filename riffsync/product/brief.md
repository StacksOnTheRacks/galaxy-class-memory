---
doc: product.brief
schema_version: 2
updated: 2026-08-26
product_name: "RiffSync"
product_description: "Open-source fan catalog and watch-party app at https://riffsync.tv. Fans browse a curated catalog of riff-style MST episodes on YouTube, and signed-in hosts create shareable rooms that drive lawful YouTube (or staff-configured Custom) embeds and optionally broadcast one shared picture to guests via WebRTC/SFU."
problem: "Riff fans want to watch together with matched ads, chat, and presence, without each person fighting separate embeds or relying on piracy vaults. Discovery of titles and active parties is fragmented; hosting must be accountable while guests should stay anonymous-first."
audience:
  - "Fans browsing and joining watch parties without mandatory signup"
  - "Signed-in hosts who create rooms, drive playback, and optionally share video to the room"
  - "Staff/operators who curate catalog, Live sources, and admin surfaces"
  - "Not for people seeking rehosted or pirated video libraries"
goals:
  - "Lawful playback only: official embeds / staff-approved Custom HTTPS pages; no communal upload vault"
  - "Anonymous-first guests: browse, join, watch, and read chat without accounts"
  - "Host login required for room create, admin authority, and WebRTC publish"
  - "Shared-picture watch parties (host capture + SFU) with room chat and presence"
  - "Honest disclaimers and advisory Premium vs ad-supported room labels (not verified entitlements)"
  - "Discoverable public catalog / watch / Live surfaces where product policy allows indexing"
  - "Durable social layer for signed-in fans (friends + 1:1 DMs) beside public room chat"
non_goals:
  - "Verified YouTube Premium detection"
  - "Server-side video hosting, rehosting, or transcoding of third-party content"
  - "Indexing ephemeral /room/* or lobby party state for search engines"
  - "Room-wide host-controlled Cast for all participants (Cast is viewer-local)"
  - "Group DMs, public social profiles/feeds, or staff reading of DM bodies"
  - "Mesh WebRTC fallback (SFU required in all environments)"
success_metrics:
  - metric: "Guest room join without signup"
    target: "Guests join via lobby or /room/<id> and watch the shared picture without signing up"
  - metric: "Host room control"
    target: "Signed-in hosts create rooms, switch catalog titles in-room, and broadcast when they choose"
  - metric: "Public catalog shareability"
    target: "Catalog and eligible watch/Live URLs are shareable with useful previews where SEO packaging applies"
  - metric: "Viewer-local Cast"
    target: "Cast (when configured) stays viewer-local and does not break room authority or chat"
  - metric: "Honest fan/unofficial positioning"
    target: "Product stays clearly fan/unofficial with honest playback and affiliation disclaimers"
current_focus: "Figma redesign program — theme bound, design memory seeded; schedule /forge.design-system-audit; incremental surface rollout after per-surface sign-off (pilot: catalog/home). Product metrics baseline shipped (#437–#440); preserve GA4/CloudWatch instrumentation during redesign."
---

Live site: [riffsync.tv](https://riffsync.tv).

Host extension work lives under `apps/host-extension`. Epic **#426** and slices **#427–#431** are closed Done. Metrics baseline **#437–#440** closed Done (2026-08-25). **Now**: Figma-driven UI redesign (Designer-gated).
