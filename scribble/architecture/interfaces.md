---
doc: architecture.interfaces
schema_version: 1
updated: 2026-10-04
external_interfaces:
  - "Browser ↔ galaxyclass.app CloudFront /scribble, /scribble/* → Scribble S3 play origin (key prefix scribble/); extensionless paths rewrite to /scribble/index.html in the viewer-request function"
  - "Browser ← GET /scribble/config.json — { webSocketUrl, tables: [{ id, name, blurb }], auth?: { userPoolId, userPoolClientId } }; table ids come from the seed custom resources"
  - "Browser ↔ API Gateway WebSocket (prod stage) — JSON frames { action, ... } in; typed frames out"
  - "Client → server actions: ping; list_tables { tableIds[] } (max set, listed tables only); join_table { tableId }; sit { seatId?, accessToken? }; leave { seatToken }; start_game { seatToken }; play { seatToken, placements: [{ tileId, row, col, letter? }] } (letter only for blanks); pass { seatToken }; exchange { seatToken, tileIds[] }; set_theme { seatToken, themeId }; create_table → unsupported_action in v1"
  - "Server → client frames: table_snapshot (seat-scoped; `you: { seatId, rack }` only on the owner's connection); sat { seatId, seatToken }; left { seatId }; table_list { tables: [{ tableId, seatedCount, maxSeats, status }] }; error { code, reason?, words? }"
  - "Error codes: client_supplied_state, table_not_found, not_table_member, unsupported_action, invalid_access_token, invalid_seat_token, not_seated, already_seated, account_already_seated, table_full, invalid_seat, seat_occupied, game_in_progress, insufficient_players, game_not_in_progress, off_turn, invalid_placement (reason), invalid_word (words), invalid_exchange, exchange_unavailable, invalid_theme, version_conflict"
  - "Rejected on every action (client_supplied_state): board, rack, racks, score, scores, bag, bagCount, tiles, players, seats, turnOrder, currentSeatId, game"
  - "GitHub Actions OIDC → cdk deploy ScribbleRuntimeStack (after MatchRuntimeStack, before GalaxyClassSite-prod); smoke test /scribble/ and config.json"
internal_boundaries:
  - "Phaser scenes and DOM overlay are presentation; TableController is pure and testable without Phaser; Lambda is the trust boundary"
  - "Rules library is pure; the runtime owns persistence, seat tokens, and fan-out"
  - "Racks live on seat items; snapshots build per connection and strip other racks, bag contents, token hashes, player subs, and connection ids"
  - "Seeded table META rows are written by the seed handler with newTableRecord/tableMetaItem from @galaxyclass/scribble/table-record so the runtime reads them unchanged"
contracts_in_flight: []
ownership:
  - "packages/scribble owns rules, runtime, client, themes, dictionary, and dev harness"
  - "packages/infra owns ScribbleRuntimeStack and the site's /scribble behaviors, CSP, and bucket policy"
  - "packages/accounts owns the Cognito access-token verifier and resolveSitIdentity shared with Riffle"
  - "packages/www owns the studio library cabinet linking to /scribble"
---
