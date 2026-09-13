---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-12
summary: "Replace HostTheaterButtonBar Share with Settings that opens Watch Party Settings (Figma 1433:8139). Consolidate party name, party URL copy, visibility, and share quality. Add toast-like confirmations on name save and visibility change. Remove the chat Room button, Room panel, playlist UI, and Room-panel Install Host Extension / Hosting Guide / Leave Party. No new capture, extension, or SFU work."
approach: "Replace PopupKind 'share' and HostTheaterDialog title Share Watch Party with Settings / Watch Party Settings in HostTheaterButtonBar. Inline Party Name + Save by reusing RoomPage.saveRenameFromModal + patchRoom({ displayTitle }) (retire RoomRenameModal as the primary path). Keep Copy via existing copyShare (getPublicOrigin()/room/{roomId} + shareHint). Keep visibility via patchRoomVisibility + RoomVisibilityControl (map Figma Private/Public to existing public|private). Move TheaterShareQualityControls into the Settings dialog; theaterShareQuality stays RoomPage useState default balanced, applied by useHostScreenCapture on the next getDisplayMedia. Add a visible toast-like confirmation for successful displayTitle save and visibility PATCH (today visibility only announces via #riffsync-a11y-announcer; there is no toast library). Remove riffsync-room-page__aux-tabs Room button, RoomPageSidebar room panel (RoomHostIconRow, HostRoomConsole, guest Leave Party). Hide Next Up / catalog-add UI (HostRoomConsole playlist); keep hostNextUpQueue localStorage module. Do not add shareQuality to PATCH."
interfaces:
  - "PATCH /v1/rooms/{roomId} (infra/cdk/lambda/room-patch.ts, apps/web/src/api/roomsApi.ts patchRoom) — reuse displayTitle (normalizeRoomDisplayTitle, max 120) and visibility public|private; JWT.sub === hostSub or 403"
  - "No new PATCH field for share quality — TheaterShareQualityPreset smooth|balanced|sharp is client session state only"
  - "copyShare — clipboard write of {origin}/room/{roomId}; shareHint 'Link copied' already exists"
  - "HostTheaterButtonBar HostTheaterDialog — Settings opener replaces aria-label Share watch party; Close stays"
  - "RoomVisibilityControl + visibilityAnnounceCopy — keep host-only radiogroup; Figma Private/Public labels replace Show on Live Now / Link only copy"
  - "Toast-like confirm — new visible role=status (no existing toast/snackbar primitive; do not reuse Cast/chat/video-relay banners or invent GA4 events)"
  - "GA4 unchanged — room_join / host_broadcast_start / host_room_create names stay; share_link / share_url remain funnel enums only"
structure:
  - "apps/web/src/room/HostTheaterButtonBar.tsx (+ HostTheaterButtonBar.test.tsx)"
  - "apps/web/src/pages/RoomPage.tsx — saveRenameFromModal, patchRoomVisibility, copyShare, theaterShareQuality, rename modal wiring"
  - "apps/web/src/room/RoomVisibilityControl.tsx"
  - "apps/web/src/room/TheaterShareQualityControls.tsx + theaterShareQuality.ts"
  - "apps/web/src/room/useHostScreenCapture.ts — getDisplayMedia constraints from qualityPresetRef"
  - "apps/web/src/room/RoomPageSidebar.tsx — remove aux Room button and room panel"
  - "apps/web/src/room/RoomHostIconRow.tsx — retire with Room panel"
  - "apps/web/src/room/HostRoomConsole.tsx — hide/unmount from sidebar; playlist UI off, module stays"
  - "apps/web/src/room/RoomRenameModal.tsx — fold into Settings or keep only as leftover until Settings lands"
  - "apps/web/src/room/hostRoomControls.ts — visibilityAnnounceCopy / mergeRoomPatchResult"
  - "apps/web/src/api/roomsApi.ts patchRoom"
  - "infra/cdk/lambda/room-patch.ts + room-shared.ts"
  - "apps/web/src/styles/riffsync-app.css — host-theater dialog + new toast/status"
constraints:
  - "JWT.sub === hostSub for all room-admin PATCHes; guests never see Settings (HostTheaterButtonBar is host-only)"
  - "No new capture, extension, or SFU work; ADR-001 no-capture / no Side Panel / C1 bind unchanged"
  - "Removing Install Host Extension from HostRoomConsole does not change ADR-001 packaging or apps/host-extension"
  - "Playlist removal is UI hide now; do not add/remove a playlist API; hostNextUpQueue (riffsync.hostNextUp.v1:{roomId}) may remain"
  - "Reuse existing PATCH displayTitle and visibility; do not add shareQuality / share_quality to Rooms or room-patch"
  - "Figma redesign must not rename GA4 event names or CloudWatch RiffSync/Product routes without a metrics contract revision"
  - "Host theater Help popup (chat rail toggle, title Host settings) is not the Watch Party Settings dialog"
  - "Sibling host-header-layout-fix owns NavigationSlim / leave-party-affordance; do not invent a guest Leave Party replacement here"
open_questions:
  - "leave-party-remaining-surface"
  - "guest-copy-link"
  - "toast-confirm-pattern"
---

Primary surface is `HostTheaterButtonBar` on `RoomPage`, Figma Watch Party Settings `1433:8139`. Room-admin functions today are split across the Share popup (copy, rename modal, visibility), `RoomPageSidebar` Room panel (`RoomHostIconRow`, `TheaterShareQualityControls`, `HostRoomConsole`), and `RoomRenameModal`. This initiative is a relocate/hide, not a new control plane.

**Share quality is client-only.** `RoomPage` holds `useState<TheaterShareQualityPreset>('balanced')`. `useHostScreenCapture` applies `theaterShareVideoConstraints` on the next `getDisplayMedia`. Hint already says it applies the next time Share Source Tab starts. Not on `RoomSnapshot`, not in `patchRoom`, not in Dynamo, not in localStorage (unlike Next Up).

**Name and visibility already exist on host PATCH.** `displayTitle` (max 120) and `visibility: public | private`. Create-time default remains public. No new Lambda.

**No toast primitive today.** Copy uses inline `shareHint`. Visibility success is sr-only via `announceRoomA11y(visibilityAnnounceCopy(...))`. Admin uses `.riffsync-admin-catalog-saved-banner`. Add a visible toast-like `role="status"` for name save and visibility change. Do not fire new GA4 events.

LLD must revise submodule contracts that still place share quality, visibility, and Leave Party on the Room tab: `riffsync/.ai/interface/presentation.md`, `input_handling.md`. Those are not memory-repo files.
