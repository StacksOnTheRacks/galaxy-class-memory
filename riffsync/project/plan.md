---
doc: project.plan
schema_version: 1
updated: 2026-09-10
objective: "Deliver site-redesign initiative via strangler surface rollout (AppShell → channels → Your Parties → Load Media → mobile → host theater reskin); preserve shipped baseline including GA4/CloudWatch metrics and ADR-001 host flows. Parallel track: first-party fan auth (milestone #39) replaces fan Hosted UI CTAs with SRP lifecycle pages on riffsync.tv."
in_scope:
  - "Now — site-redesign initiative (executing): milestone Site redesign (#38) + tickets #445–#452"
  - "Now — first-party-fan-auth initiative (lld): milestone First-party fan auth (#39) + 5 Refinement tickets #461–#465; SRP pages + CTA migration; soft Hosted UI fallback for legacy links"
  - "Shipped baseline preserved: catalog, rooms, host broadcast, lobby, chat, friends/DM, SEO, Cast/TV, MV3 host extension (#426–#431), Official Live, product metrics (#437–#440)"
  - "Next after site-redesign — Extension & TV distribution polish; Live maturity follow-ons (Cast on Live, multi-channel hub) demand-gated after first metrics read"
sequence:
  - "Host extension MVP #427–#431 — Done"
  - "Epic #426 — Done (closed 2026-08-20)"
  - "Product metrics baseline #437–#440 — Done (closed 2026-08-25; PR #441–#444)"
  - "Site redesign — milestone #38; Refinement tickets in spec LLD order:"
  - "  #445 AppShell + design tokens — Sidebar, TopBar, global search combobox, profile menu, main outlet"
  - "  #446 Pilot MST3K channel — ChannelLayout + Cards | List toggle"
  - "  #447 tv_shows catalog backend + /catalog/movies canonical + movie-night redirect"
  - "  #448 TV Shows and Movies channel pages"
  - "  #449 GET /v1/rooms/mine + Your Parties page"
  - "  #450 Load Media modal — PATCH catalogEpisodeId; extension or new-tab open"
  - "  #451 Remaining channels (Home, RiffTrax, Live Now, Community) + mobile shell"
  - "  #452 Host theater reskin — Figma media mode; Load Media entry"
  - "First-party fan auth — milestone #39; Refinement tickets in LLD order:"
  - "  #461 Fan auth SRP foundation — fanCognitoConfig, fanSrpAuth, fanAuthNavigation, FanAuthLayout, routes, returnTo, env/CI"
  - "  #463 Sign-in, sign-up, verify-email pages (parallel with #462, #464 after #461)"
  - "  #462 Forgot-password and reset-password pages"
  - "  #464 Change-password page"
  - "  #465 Migrate in-app CTAs off Hosted UI (after auth pages)"
  - "Refinement → Ready → implement per ticket; initiative status → executing when last ticket Ready"
  - "Incremental surface rollout (strangler); metrics events unchanged per surface"
dependencies:
  - "Initiative sign-offs complete; Figma vQ6yHQyiGlOnRG7ngIOxR7 bound; design memory seeded"
  - "tv_shows catalog schema migration + staff tagging before /catalog/tv-shows goes live (#447 before #448)"
  - "HostSubRoomsIndex GSI + backfill before Your Parties (#449)"
  - "Load Media reuses PATCH + navigate contract (ADR-001); #452 depends on #450 patterns"
  - "Metrics baseline (#437–#440) Done; redesign preserves docs/operations/product-metrics.md"
  - "ADR-001-adjacent tickets (#450, #452) require Architect+Security refinement at LLD"
handoffs:
  - "PO/PM → /forge.refinement per ticket (compile .feature → Ready; Designer on user-facing tickets)"
  - "Architect+Security → tech spec comment on ADR-001-adjacent tickets at refinement"
  - "Engineer+QA → per-surface strangler ship + metrics regression + ADR-001 host flows unchanged"
  - "Product → first GA4/CloudWatch metrics read informs demand-gated Live follow-ons"
---

Site-redesign groomed 2026-09-07: eight tickets under milestone #38 (executing). First-party fan auth groomed 2026-09-10: five Refinement tickets under milestone #39. Next refinement target: #461 (fan-auth-foundation).
