# System

RiffSync is a fan watch-party product: curated YouTube episode catalog, signed-in hosts driving lawful iframe playback, and WebRTC redistribution of the host capture so guests share one picture. Control plane is AWS serverless (CDK TypeScript, Lambda Node/TS, API Gateway HTTP + WebSocket, DynamoDB). Media plane is self-hosted mediasoup SFU + coturn on EC2 stack `RiffSyncTurn`. Production hostname is `https://riffsync.tv`.

# Context

Browsers run the SPA. Anonymous guests may browse, join, chat, and consume media. Hosting, room mutation, and publisher paths require Cognito fan JWT (`hostSub` = Cognito `sub`). Staff Cognito guards operator admin APIs. Catalog rows are Dynamo-backed; `data/catalog` seeds bootstrap; TMDB reconcile enriches artwork/metadata on a schedule. No pirate CDN: RiffSync does not re-host YouTube video files.

# Major components

- **SPA** (`apps/web`) - catalog, lobby, room UI; RoomMediaEngine owns chat WS, SFU session, theater playback.
- **Host Chrome MV3 extension** (`apps/host-extension`) - media-tab helper (background open/navigate + play/pause); host control panel UI is the SPA Room tab; no capture / no `host_screen` from the extension.
- **HTTP API** (API Gateway HTTP + Lambda) - catalog, rooms, lobby, ICE, SFU join token, health, admin.
- **WebSocket API** (API Gateway + Lambda) - control plane: connect/disconnect, ping, presence, chat, share_state, leave. Not media signaling.
- **DynamoDB** - Catalog, Rooms, Connections (plus optional profiles/lists/events as shipped).
- **Cognito** - fan pool (host JWT); staff pool (invite-only `/v1/admin/*`).
- **RiffSyncTurn** - mediasoup SFU + coturn on shared VPC/EC2; SFU WebSocket for produce/consume; TURN for ICE.
- **EventBridge + Lambdas** - stale-room sweeper; TMDB catalog reconcile.
- **Optional ElastiCache** - read-through cache only; Dynamo remains SoT.
- **CloudWatch** - metrics, dashboards, alarms, Logs Insights (ops home).
- **Static site** - S3 + CloudFront for SPA at `riffsync.tv`.

# Data flow

1. Client loads SPA from CloudFront; reads catalog/rooms/lobby over HTTPS HTTP API.
2. Host elevates via Cognito; `POST /v1/rooms` / `PATCH` mutate Rooms (`catalogEpisodeId`, visibility, `hostSub`, activity).
3. Clients open room WebSocket for chat/presence/share_state; Connections map `connectionId` to room for fan-out.
4. Host plays YouTube iframe locally; `getDisplayMedia` captures tab; client mints SFU JWT via `POST /v1/webrtc/sfu-token`, fetches ICE via `GET /v1/webrtc/ice`, signals mediasoup on SFU WS, publishes `host_screen` (and optional `participant_av`).
5. Guests consume RTP from SFU; control metadata stays on API Gateway WS/HTTP.
6. EventBridge schedules sweeper (stale rooms) and TMDB reconcile (Catalog enrichment). Seed/migrate scripts operate Catalog from `data/catalog` for bootstrap only.

# Deployment shape

- **IaC:** AWS CDK TypeScript under `infra/cdk`; synth to CloudFormation; prod context only (no billable staging stack in current app).
- **Stacks (prod):** fan/staff auth, API+Dynamo (`RiffSyncApi-prod`), static site, observability, SES inbound as needed; singleton media `RiffSyncTurn`.
- **Compute:** Lambda for BFF/control; two EC2 roles in `RiffSyncTurn` (SFU + coturn).
- **Local media:** disposable SFU + coturn under `infra/local-media` / CI conformance without touching prod `RiffSyncTurn`.
- **Secrets:** Secrets Manager (TMDB, TURN static-auth, SFU join HMAC, Giphy, etc.); never baked into SPA.

# Current focus

Host Chrome MV3 extension (ADR-001) at `apps/host-extension` is a **tabs/media helper** only. The party **Room** tab is the host control panel (detects extension via page-initiated ping; Next Up host-local; catalog add; open/broadcast; play/pause when party-capture controllable). Side Panel retired. No capture / no `host_screen` from extension.
