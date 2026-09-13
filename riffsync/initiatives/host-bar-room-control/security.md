---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-12
summary: "HLD security for Watch Party Settings. Reuses host PATCH displayTitle and visibility (JWT.sub === hostSub) and host-local share quality. No new APIs, tokens, or trust boundaries."
threats:
  - "IDOR / host authority — signed-in non-host or anonymous caller PATCHes displayTitle or visibility"
  - "Visibility listing — public room stays on GET /v1/lobby after intended private, or private room is advertised beyond link-only SoT"
  - "XSS via party name — displayTitle interpolated into toast, settings, or aria-live with innerHTML / string HTML"
  - "Copy URL leak — clipboard writes location.href, query, hash, or tokens instead of origin + /room/:roomId"
  - "Share quality scope creep — preset PATCHed to the room, applied to guest cameras, or used to drive extension/tabCapture"
mitigations:
  - "Keep server SoT: PATCH requires fan JWT; 401 without sub; 403 unless JWT.sub === room.hostSub; ConditionExpression host + version; 409 on conflict"
  - "Settings mutators host-only in UI (isPublisher / cognitoSub === hostSub). HostTheaterButtonBar remains publisher-gated. Guests must not see name/visibility/quality editors"
  - "Name save PATCH body { displayTitle } only. Visibility PATCH body { visibility } only. Do not add share quality, catalogEpisodeId, customPlaybackUrl, or hostSub to Settings requests"
  - "Honor existing visibility SoT: public SET lobbyPk=PUBLIC + lobbySk; private REMOVE lobby keys. Do not invent GET /v1/rooms/{id} auth, guest kick, or a second listing index"
  - "Toast and a11y announce only after PATCH 200; rollback local state on 401/403/409. Render displayTitle via React text nodes / textContent (same as announceRoomA11y)"
  - "Copy URL = getPublicOrigin() + /room/ + encodeURIComponent(roomId). Never clipboard location.href, search, hash, Authorization, or fan tokens"
  - "Share quality stays host-local React state applied on the next page getDisplayMedia. Not PATCHed, not fanned out, not guest-editable. ADR-001 unchanged"
  - "Removing Install host extension / Hosting guide / playlist URL paste does not add extension capture, chrome-extension CORS, or a new hostJwtBridge surface"
requirements:
  - "Party name and visibility mutations MUST use existing authenticated PATCH /v1/rooms/{roomId} with JWT.sub === hostSub as sole admin gate"
  - "Non-host PATCH MUST return 403 and MUST NOT toast success or persist optimistic name/visibility"
  - "Settings name save MUST send { displayTitle } only; visibility MUST send { visibility: public|private } only"
  - "Share quality MUST NOT be added to PATCH, room snapshot, or WebSocket envelopes"
  - "Watch Party Settings editors (name, visibility, share quality) MUST render only when the viewer is the room host"
  - "Toasts and settings labels MUST render untrusted displayTitle via React text nodes or textContent; MUST NOT use innerHTML or string-built HTML"
  - "Copy party URL MUST write a constructed same-origin path /room/:roomId with no query string, hash, or credentials"
  - "Share quality MUST remain a host-only getDisplayMedia constraint for the next Share Source Tab; MUST NOT retarget guest A/V or extension capture"
  - "This initiative MUST NOT add tabCapture, desktopCapture, offscreen capture, externally_connectable, or chrome-extension:// CORS"
  - "This initiative MUST NOT change GET /v1/rooms/{roomId} anonymity or link-join for private rooms (existing link-only SoT)"
  - "Visibility private MUST continue to REMOVE lobby GSI keys in the same host PATCH; public MUST SET them. Do not invent a second listing write path"
  - "LLD tickets MUST slice forge-tech-spec AC from this doc at refinement"
open_questions: []
---

Watch Party Settings consolidates controls that already exist on the Room tab and host Share dialog. Server already gates `displayTitle` and `visibility` with `JWT.sub === hostSub`, trims/caps title at 120 chars, and updates `PublicLobbyIndex` in the same `UpdateCommand` (`public` SET `lobbyPk`/`lobbySk`; `private` REMOVE). `GET /v1/lobby` is the public listing. Direct `/room/:roomId` join stays available for both values. Visibility is not WebSocket-fanned out today; lobby readers pick up the next poll. Do not add a new envelope unless Architect opens that separately.

`GET /v1/rooms/{roomId}` is already unauthenticated and returns `displayTitle`, `visibility`, and `hostSub` to anyone who knows `roomId`. That is existing link-only SoT, not a new leak from Settings. Do not invent GET auth or guest eviction on private.

Share quality is host React state (`smooth` / `balanced` / `sharp`) applied as `getDisplayMedia` constraints on the next Share Source Tab. It is not durable room state.

Copy link already uses `getPublicOrigin() + /room/${encodeURIComponent(roomId)}` on RoomPage and Your Parties. Settings must keep that constructor.

Room-tab Leave Party (`Link` to `/` for guests and hosts) is removed with the Room panel. Remaining in-room leave is **NavigationSlim** (`leaveHref="/live"`) until sibling `host-header-layout-fix` decides via `leave-party-affordance`. This initiative does not invent a replacement leave control. Removing Install host extension / Hosting guide is not a security-control loss (page `getDisplayMedia` remains capture SoT; how-to-host can stay as a first-party page). Removing playlist URL paste shrinks the in-room arbitrary-URL surface; do not reintroduce URL paste in Settings.

Residual: a stolen host fan JWT can still rename or relist that host's rooms (accepted MVP model). LLD tickets must carry sliced security AC in `forge-tech-spec` comments.
