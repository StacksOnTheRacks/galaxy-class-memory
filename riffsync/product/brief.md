# Product

RiffSync is an open-source fan catalog and watch-party app at https://riffsync.tv. Fans browse a curated catalog of riff-style MST episodes on YouTube, and signed-in hosts create shareable rooms that drive lawful YouTube (or staff-configured Custom) embeds and optionally broadcast one shared picture to guests via WebRTC/SFU.

# Problem

Riff fans want to watch together with matched ads, chat, and presence, without each person fighting separate embeds or relying on piracy vaults. Discovery of titles and active parties is fragmented; hosting must be accountable while guests should stay anonymous-first.

# Who it's for

- Fans browsing and joining watch parties without mandatory signup
- Signed-in hosts who create rooms, drive playback, and optionally share video to the room
- Staff/operators who curate catalog, Live sources, and admin surfaces
- Not for people seeking rehosted or pirated video libraries

# Goals

- Lawful playback only: official embeds / staff-approved Custom HTTPS pages; no communal upload vault
- Anonymous-first guests: browse, join, watch, and read chat without accounts
- Host login required for room create, admin authority, and WebRTC publish
- Shared-picture watch parties (host capture + SFU) with room chat and presence
- Honest disclaimers and advisory Premium vs ad-supported room labels (not verified entitlements)
- Discoverable public catalog / watch / Live surfaces where product policy allows indexing
- Durable social layer for signed-in fans (friends + 1:1 DMs) beside public room chat

# Non-goals

- Verified YouTube Premium detection
- Server-side video hosting, rehosting, or transcoding of third-party content
- Indexing ephemeral `/room/*` or lobby party state for search engines
- Room-wide host-controlled Cast for all participants (Cast is viewer-local)
- Group DMs, public social profiles/feeds, or staff reading of DM bodies
- Mesh WebRTC fallback (SFU required in all environments)

# Success metrics

- Guests can join a hosted room via lobby or `/room/<id>` and watch the shared picture without signing up
- Signed-in hosts can create rooms, switch catalog titles in-room, and broadcast when they choose
- Public catalog and eligible watch/Live URLs are shareable with useful previews where SEO packaging applies
- Cast (when configured) stays viewer-local and does not break room authority or chat
- Product stays clearly fan/unofficial with honest playback and affiliation disclaimers

# Current focus

Build a host Chrome MV3 **host control panel** so hosts bind the active `/room/:roomId` tab (C1), see media-tab open/not and now playing, and change room title from the full public catalog library without leaving the party tab. JWT via SPA↔extension bridge. No extension capture. Scaffold shipped (#427 closed; `apps/host-extension`). Ready (`ai-ready`): #428 media-tab, #429 catalog library, #430 PATCH/JWT + now-playing + JWT A bridge, #431 docs. Tracking: epic #426 (not implement-ready).
