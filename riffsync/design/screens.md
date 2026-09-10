---
doc: design.screens
schema_version: 1
updated: 2026-09-10
screens:
  - name: Home / Unauthenticated
    figma_node_id: "3:185"
    app: riffsync
    states:
      - default
    responsive:
      - desktop
  - name: Home / Authenticated
    figma_node_id: "1309:2385"
    app: riffsync
    states:
      - default
    responsive:
      - desktop
  - name: Home / Your Parties
    figma_node_id: "1450:10247"
    app: riffsync
    states:
      - default
    responsive:
      - desktop
  - name: Channel / MST3K
    figma_node_id: "15:913"
    app: riffsync
    states:
      - cards
      - list
    responsive:
      - desktop
  - name: Channel / RiffTrax
    figma_node_id: "1135:4101"
    app: riffsync
    states:
      - cards
      - list
    responsive:
      - desktop
  - name: Channel / Live Now
    figma_node_id: "1429:3399"
    app: riffsync
    states:
      - cards
      - list
    responsive:
      - desktop
  - name: Channel / Movies
    figma_node_id: "1433:5811"
    app: riffsync
    states:
      - cards
      - list
    responsive:
      - desktop
  - name: Channel / TV Shows
    figma_node_id: "1433:6129"
    app: riffsync
    states:
      - cards
      - list
    responsive:
      - desktop
  - name: Channel / Community
    figma_node_id: "1434:8290"
    app: riffsync
    states:
      - cards
      - list
    responsive:
      - desktop
  - name: Watch Party Host / Media Mode
    figma_node_id: "19:1900"
    app: riffsync
    states:
      - default
    responsive:
      - desktop
  - name: Watch Party Host / Select Media Option
    figma_node_id: "1387:3764"
    app: riffsync
    states:
      - load-media-open
    responsive:
      - desktop
  - name: Watch Party Host / Broadcast Option
    figma_node_id: "1433:7834"
    app: riffsync
    states:
      - broadcast-picker
    responsive:
      - desktop
  - name: Watch Party Host / TV Option
    figma_node_id: "1433:7985"
    app: riffsync
    states:
      - cast-popup
    responsive:
      - desktop
  - name: Watch Party Host / Share Option
    figma_node_id: "1433:8139"
    app: riffsync
    states:
      - share-popup
    responsive:
      - desktop
  - name: Watch Party Host / Camera and Audio On
    figma_node_id: "1441:9139"
    app: riffsync
    states:
      - av-rail
    responsive:
      - desktop
  - name: Watch Party Host with Extension
    figma_node_id: "1053:3252"
    app: riffsync
    states:
      - extension-bar
    responsive:
      - desktop
  - name: Solo Live View (Authenticated)
    figma_node_id: "1433:7256"
    app: riffsync
    states:
      - default
    responsive:
      - desktop
  - name: Solo Live View (Unauthenticated)
    figma_node_id: "1433:7407"
    app: riffsync
    states:
      - default
    responsive:
      - desktop
  - name: Solo Watch Page
    figma_node_id: "966:1065"
    app: riffsync
    states:
      - default
    responsive:
      - desktop
  - name: Auth / Sign In
    figma_node_id: "1617:6584"
    app: riffsync
    states:
      - default
      - auth-layout-standalone
    responsive:
      - desktop
  - name: Auth / Sign Up
    figma_node_id: "1617:6621"
    app: riffsync
    states:
      - default
      - auth-layout-standalone
    responsive:
      - desktop
  - name: Auth / Verify Email
    figma_node_id: "1617:6660"
    app: riffsync
    states:
      - default
      - auth-layout-standalone
    responsive:
      - desktop
  - name: Auth / Forgot Password
    figma_node_id: "1617:6693"
    app: riffsync
    states:
      - default
      - auth-layout-standalone
    responsive:
      - desktop
  - name: Auth / Reset Password
    figma_node_id: "1617:6724"
    app: riffsync
    states:
      - default
      - auth-layout-standalone
    responsive:
      - desktop
  - name: Auth / Change Password
    figma_node_id: "1617:6763"
    app: riffsync
    states:
      - default
      - auth-layout-standalone
    responsive:
      - desktop
---

Figma file: https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync (Screens page `0:1`; Auth page `1617:6583` with six default desktop frames). All catalog/watch frames 1440×1024 desktop. Auth error/submitting/mobile 390 companions are LLD follow-ons, not in Figma yet. Mobile HLD defaults live in initiatives/site-redesign/design.md (drawer nav, stacked channels) — no Figma mobile frames yet. Missing from redesign scope: Lobby, admin, friends/DM panels. Sidebar collapsed, global search dropdown, and list-view row component are HLD defaults not drawn as separate frames.
