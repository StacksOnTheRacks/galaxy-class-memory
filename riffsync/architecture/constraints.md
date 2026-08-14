# Hard constraints

- Lawful playback only: official YouTube iframe / IFrame Player API on the host; no re-hosting of third-party video files on RiffSync infra.
- Shared viewing for guests is host tab/window capture republished via WebRTC (SFU), not parallel embed clock sync.
- Hosting and authoritative room/playback mutation require signed-in Cognito fan identity (`JWT.sub === hostSub`); anonymous users cannot become room admin.
- Control plane and media plane stay split: API Gateway WebSocket is not SDP/ICE mesh relay; mediasoup signaling lives on `RiffSyncTurn` SFU WebSocket.
- DynamoDB is system of record for Catalog, Rooms, Connections; optional caches are never authoritative.
- Infrastructure-as-code is AWS CDK TypeScript; Lambda handlers are TypeScript on Node.js.
- Production public site canonical hostname is `https://riffsync.tv` (CORS/ACM/CloudFront aligned).
- Media stack is self-hosted mediasoup + coturn on `RiffSyncTurn`; no paid third-party RTC provider and no mesh fallback in current design.
- Host Chrome MV3 extension lives at `apps/host-extension`; must not capture or supply `host_screen` (no `tabCapture` / desktopCapture / offscreen capture); page `getDisplayMedia` is sole capture SoT (ADR-001).
- Host control panel UI surface is Chrome Side Panel API (`side_panel` + permission `"sidePanel"`); product term remains **host control panel**.
- MVP party-tab → `roomId`: parse `/room/:roomId` from the active tab on allowed origins; no PATCH without a resolvable `roomId`.

# Soft constraints

- Prefer managed serverless for BFF/control; add VPC-only pieces (e.g. ElastiCache) only when load or latency requires it.
- CloudWatch-first observability before introducing external APM.
- Catalog `GET` Scan is acceptable while library fits one Lambda scan; GSI/export/cache before scale pressure.
- Staff `/v1/admin/*` behind invite-only Cognito (MFA preferred).
- Local/CI media profiles must not mutate prod `RiffSyncTurn` or prod Secrets Manager.
- Premium vs free/ad-supported room labels are host-declared advisory only (not verified against YouTube subscription).
- Host Chrome MV3 extension (ADR-001): bind room via active tab `/room/:roomId` (C1); host control panel shows media-tab open/not + now playing + full public catalog library (B1) and title change via host PATCH + media navigate (A1); JWT via SPA↔extension bridge (JWT A); must not capture or supply `host_screen`.
- Scaffold #427 allow-list is `"permissions": ["sidePanel"]` only; #428 Ready `"permissions": ["sidePanel","tabs"]` with no `host_permissions` (inactive media-tab create/update + open/not via tracked `tabId`, not SPA `window.name`); #429 Ready adds `host_permissions` for the public HTTP API origin only (catalog GET / room GET / PATCH); #430 Ready JWT A is content-script + origin-checked `window.postMessage` (`riffsync-host-bridge` v1) — SPA origins via `content_scripts.matches`, not `host_permissions`; access token ephemeral in SW memory; SPA owns Cognito refresh; never capture permissions under ADR-001.

# Out of bounds

- Pirate CDN, scraped streams, or communal upload vault of copyrighted video.
- ECS/Fargate (or alternate WS stacks) as default for control plane; exception is only EC2 for SFU/coturn.
- Guest promotion / host reclaim token as MVP room-admin transfer (not in current server baseline).
- Embedding TURN credentials or secrets in the SPA bundle.
- Using seed (`data/catalog`) as ongoing prod migration for a curated live Catalog table.

# Assumptions

- Browsers grant display-media (and mic/camera when used); guests tolerate one Play gesture for incoming media.
- YouTube embed policy and availability remain usable for catalog rows; TMDB enrichment is best-effort and skippable on ambiguous matches.
- Single-account AWS prod footprint with singleton `RiffSyncTurn` capacity is enough for current scale.
- Stale rooms are eventually consistent via `lastActivityAt` + sweeper/TTL, not instant host-disconnect detection.
- Fan SPA may call prod API from localhost during development (CORS allowlist).
