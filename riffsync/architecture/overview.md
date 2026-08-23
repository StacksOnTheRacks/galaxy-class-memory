---
doc: architecture.overview
schema_version: 1
updated: 2026-08-23
system: "RiffSync is a fan watch-party product: curated YouTube episode catalog, signed-in hosts driving lawful iframe playback, and WebRTC redistribution of the host capture so guests share one picture. Control plane is AWS serverless (CDK TypeScript, Lambda Node/TS, API Gateway HTTP + WebSocket, DynamoDB). Media plane is self-hosted mediasoup SFU + coturn on EC2 stack RiffSyncTurn. Production hostname is https://riffsync.tv."
context: "Browsers run the SPA. Anonymous guests may browse, join, chat, and consume media. Hosting, room mutation, and publisher paths require Cognito fan JWT (hostSub = Cognito sub). Staff Cognito guards operator admin APIs. Catalog rows are Dynamo-backed; data/catalog seeds bootstrap; TMDB reconcile enriches artwork/metadata on a schedule. No pirate CDN: RiffSync does not re-host YouTube video files."
data_flow: "1. Client loads SPA from CloudFront; reads catalog/rooms/lobby over HTTPS HTTP API. 2. Host elevates via Cognito; POST /v1/rooms / PATCH mutate Rooms. 3. Clients open room WebSocket for chat/presence/share_state. 4. Host plays YouTube iframe locally; getDisplayMedia captures tab; client mints SFU JWT, signals mediasoup, publishes host_screen. 5. Guests consume RTP from SFU. 6. EventBridge schedules sweeper and TMDB reconcile."
deployment_shape: "IaC: AWS CDK TypeScript under infra/cdk; prod context only. Stacks: fan/staff auth, API+Dynamo (RiffSyncApi-prod), static site, observability, SES inbound as needed; singleton media RiffSyncTurn. Compute: Lambda for BFF/control; two EC2 roles in RiffSyncTurn (SFU + coturn). Local media: disposable SFU + coturn under infra/local-media. Secrets: Secrets Manager; never baked into SPA."
current_focus: "Host Chrome MV3 extension (ADR-001) at apps/host-extension is a tabs/media helper only. The party Room tab is the host control panel (detects extension via page-initiated ping; Next Up host-local; catalog add; open/broadcast; play/pause when party-capture controllable). Side Panel retired. No capture / no host_screen from extension."
major_components:
  - "SPA (apps/web) — catalog, lobby, room UI; RoomMediaEngine owns chat WS, SFU session, theater playback"
  - "Host Chrome MV3 extension (apps/host-extension) — media-tab helper; host control panel UI is the SPA Room tab; no capture"
  - "HTTP API (API Gateway HTTP + Lambda) — catalog, rooms, lobby, ICE, SFU join token, health, admin"
  - "WebSocket API (API Gateway + Lambda) — control plane: connect/disconnect, ping, presence, chat, share_state, leave"
  - "DynamoDB — Catalog, Rooms, Connections (plus optional profiles/lists/events as shipped)"
  - "Cognito — fan pool (host JWT); staff pool (invite-only /v1/admin/*)"
  - "RiffSyncTurn — mediasoup SFU + coturn on shared VPC/EC2"
  - "EventBridge + Lambdas — stale-room sweeper; TMDB catalog reconcile"
  - "Optional ElastiCache — read-through cache only; Dynamo remains SoT"
  - "CloudWatch — metrics, dashboards, alarms, Logs Insights (ops home)"
  - "Static site — S3 + CloudFront for SPA at riffsync.tv"
---

See also `architecture/interfaces.md` and ADR-001 in `architecture/decisions.md`.
