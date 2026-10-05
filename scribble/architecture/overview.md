---
doc: architecture.overview
schema_version: 1
updated: 2026-10-04
system: "Scribble is a server-authoritative crossword-board word game at galaxyclass.app/scribble. A Phaser 3 static SPA talks to its own API Gateway WebSocket API; one Lambda applies the rules in-process against the ENABLE word list and persists to its own DynamoDB table; seat-scoped snapshots fan out via PostToConnection."
context: "Built in the galaxyclass monorepo next to Riffle. Reuses the Galaxy Class account verifier (@galaxyclass/accounts/player-verifier) and copies Riffle's session shape, but shares no poker rules, UI, or runtime resources."
data_flow: "1. Browser loads /scribble from the GalaxyClassSite-prod CloudFront distribution (Scribble S3 play origin, prefix scribble/). 2. Client reads /scribble/config.json (webSocketUrl, seeded tables, Cognito ids) and opens the WebSocket. 3. join_table binds the connection; sit verifies an optional Cognito access token and returns a seat token, which the client keeps in localStorage; after a reconnect, resume (or signing in) takes the held seat back. 4. While drafting, the client previews words and score locally and asks check_words for validity. 5. play/pass/exchange/start_game/set_theme carry the seat token; Lambda validates, scores, and commits with a version-conditioned TransactWriteItems. 6. Each connection gets its own snapshot; only the owning seat's snapshot carries its rack. 7. A dropped connection mid-game leaves the seat held (away) and the game running."
deployment_shape: "CDK ScribbleRuntimeStack (DynamoDB table + byTable GSI, NodejsFunction runtime with enable1.txt copied beside the bundle and DICTIONARY_PATH, WebSocket API prod stage, seed custom resources Custom::SeededScribbleTable ×3, play-origin bucket + BucketDeployment prefix scribble). GalaxyClassSite-prod adds /scribble and /scribble/* behaviors, SCRIBBLE_CSP, and the origin-read bucket policy. Deployed by the manual Deploy Galaxy Class workflow (OIDC)."
current_focus: "v1 merged to galaxyclass main. Playtest fixes on scribble/durable-seats-and-preview: held seats with resume and 24 h removal, gameNumber-keyed count, score preview."
major_components:
  - "Rules engine — packages/scribble/src/rules (bag, premium board, placement, word finding, scoring beats, game end and adjustment); pure, no I/O except the dictionary loader"
  - "Runtime — packages/scribble/src/runtime (handler, actions, seat tokens, Dynamo/memory stores, seat-scoped snapshots)"
  - "Client — packages/scribble/src/client (TableModel, pure TableController, Room/Board/Hud Phaser scenes, DOM overlay, score timeline)"
  - "Themes — packages/scribble/src/themes (data-only Default, Halloween, Christmas)"
  - "Dev harness — packages/scribble/src/dev (local ws server, RSA-signed dev tokens, scripted table) for Playwright e2e"
  - "Infra — packages/infra/lib/scribble-runtime-stack.ts, scribble-seed-table-handler.ts, site stack /scribble behaviors"
---
