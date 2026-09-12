---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-11
summary: "Reskin watch-party NavigationSlim to match Figma NavigationSlim (910:9936): logo left, profile menu right; remove leave-first layout; no new APIs."
approach: "Refactor NavigationSlim layout (flex: logo start, menu end); embed or adapt ProfileMenu for room context; swap leave-left pattern for logo; relocate episode title per design OQ room-title-placement; CSS updates under .riffsync-navigation-slim*."
interfaces:
  - "NavigationSlimProps — simplify; title/subtitle/leaveHref may move or retire per OQs"
  - "ProfileMenu / fan auth — navigateToFanAuth, useFanSession, startFanHostedUiSignOut; room-appropriate returnTo"
  - "RoomChromeProvider — nowPlayingLabel if episode title moves out of header strip"
structure:
  - "apps/web/src/room/NavigationSlim.tsx"
  - "apps/web/src/room/NavigationSlim.test.tsx"
  - "apps/web/src/styles/riffsync-app.css (.riffsync-navigation-slim*)"
  - "apps/web/src/pages/RoomPage.tsx — header props/wiring"
  - "Optional shared primitive under components/app-shell/ or components/site/ if ProfileMenu extraction needed"
constraints:
  - "No friends icon on room header (presentation.md)"
  - "No new backend APIs or Lambdas"
  - "Preserve --riffsync-room-chrome-height and expanded-view chrome hide behavior"
  - "Guest and host header layout parity; host authority unchanged"
  - "GA4 unchanged unless existing header events are already wired"
  - "SiteHeader compact dead path on /room routes out of scope unless LLD consolidates"
open_questions:
  - "room-title-placement"
  - "leave-party-affordance"
---

<!--
Authoring (not validated):
- Architect-owned HLD technical spec under initiatives/<slug>/spec.md.
- Distinct from per-ticket <!-- forge-tech-spec --> comments posted at LLD refinement.
- Bump updated when any frontmatter field changes.
-->

Primary implementation target is NavigationSlim on RoomPage, not SiteHeader compact (SiteLayout hides SiteHeader on /room routes). Reuse app-shell logo SVG and ProfileMenu auth patterns from the shipped AppShell.
