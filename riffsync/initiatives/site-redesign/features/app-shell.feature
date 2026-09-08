Feature: Figma AppShell with nav, search, and profile menu
  As a RiffSync visitor or signed-in fan
  I want the shared app shell with collapsible sidebar, global search, and profile menu
  So that browse surfaces can adopt Figma chrome incrementally without a big-bang cutover

  # Out of this ticket: channel page reskins, Your Parties page content (#449),
  # GET /v1/rooms/mine, Load Media, host theater reskin, catalog IA backend
  # (tv_shows, /catalog/movies), search API, and chrome on room/live/watch/admin/cast/tv.

  Background:
    Given the Figma file https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync is the visual source
    And product-metrics instrumentation (GA4 / CloudWatch) stays in place on adopted surfaces
    And old SiteLayout plus SiteHeader remains the chrome for non-adopted routes

  Scenario: Left nav is fixed, vertical, and collapsible
    When a visitor uses the main navigation on an adopted browse surface
    Then it is fixed on the left and vertical
    And a hamburger control collapses it to an icons-only rail
    And the hamburger exposes aria-expanded
    And expanded and collapsed states remain keyboard reachable
    And collapsed icons keep accessible names

  Scenario: Top bar search lists catalog titles only
    Given the client has a cached GET /v1/catalog list
    When a visitor types in the top-bar search field
    Then matching results are catalog titles filtered client-side
    And only rows that pass catalogEntriesVisibleInPublicBrowse appear
    And there are no channel-name shortcut rows
    And selecting a result navigates to /watch/{catalogEpisodeId}
    And empty, loading, and error states are announced to assistive tech

  Scenario: Search uses a WAI-ARIA combobox
    When the top-bar search dropdown is open
    Then it is a combobox with a listbox
    And ArrowUp, ArrowDown, and Enter move and confirm the active option
    And Escape closes the dropdown

  Scenario: Top bar profile menu links to Your Parties
    Given the visitor is signed in
    When they open the top bar profile menu
    Then they can navigate to /your-parties
    And /your-parties may be a stub placeholder
    And GET /v1/rooms/mine is not called

  Scenario: Signed-out chrome has Sign In and no Your Parties item
    Given the visitor is signed out
    When they use the AppShell
    Then they can start the existing fan Sign In flow
    And the profile menu does not offer Your Parties

  Scenario: App shell adopts public browse only
    When a visitor opens / or an existing /catalog or /catalog/* route
    Then those pages render inside the AppShell
    And /room/:roomId, /live/:slug, party-capture watch, admin, cast, and tv keep their current chrome

  Scenario: App shell adapts on mobile viewports
    When a visitor uses a viewport below about 768px on an adopted surface
    Then the sidebar uses an overlay drawer opened from the hamburger
    And primary shell actions remain reachable without horizontal scroll
