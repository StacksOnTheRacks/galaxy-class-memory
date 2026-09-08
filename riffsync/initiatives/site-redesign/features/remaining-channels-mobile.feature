Feature: Remaining channels and mobile shell adaptations
  As a RiffSync fan
  I want Home, RiffTrax, Live Now, and Community under the new chrome on desktop and mobile
  So that browse IA matches Figma across the remaining destinations

  # Out of this ticket: MST3K pilot, TV Shows/Movies, Riff Material, catalog hub,
  # Load Media, host theater / Solo Live View, /live/{slug} player reskin.

  Background:
    Given the Figma file https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync is the visual source
    And AppShell and ChannelLayout patterns exist from prior tickets
    And product-metrics instrumentation (GA4 / CloudWatch) stays in place

  Scenario: Home matches the two Home frames
    When a visitor opens /
    Then the page renders inside AppShell
    And signed-out Home matches Home / Unauthenticated (3:185)
    And signed-in Home matches Home / Authenticated (1309:2385)
    And Home uses HomeHero plus card rows, not ChannelHero
    And Home has no Cards | List toggle

  Scenario: RiffTrax and Community match ChannelLayout with Cards and List
    When a visitor opens /catalog/rifftrax, /catalog/rifftrax/movies, /catalog/rifftrax/shorts, or /catalog/community
    Then each page matches ChannelHero plus Cards or List
    And they can toggle between Cards view and List view
    And Figma View=Table maps to Cards
    And Cards is the default and the choice is in-memory only
    And Community ChannelHero title is Community

  Scenario: Existing RiffTrax and Community filters still apply
    When a visitor uses those channel routes and the in-page title filter
    Then RiffTrax movies routes show playable rifftrax non-Short rows
    And /catalog/rifftrax/shorts shows Shorts only
    And Community shows playable community rows only
    And Home, Videos, and Live toolbar tabs are absent

  Scenario: Live Now channel links to official Live surfaces
    When a visitor opens Live Now
    Then they reach an AppShell hub at /live backed by GET /v1/live
    And each row links to /live/{slug}
    And Live Now is not implemented as a catalog enum browse page
    And /live/{slug} keeps today's Live player chrome

  Scenario: Indexable SEO is preserved
    When a visitor opens /, /catalog/rifftrax, or /catalog/community
    Then document title, canonical, and exactly one sr-only h1 are preserved
    And /live is not added to the static indexable set

  Scenario: Host starts a party from a remaining catalog card
    When a signed-in host chooses Start Party on a Home, RiffTrax, or Community row
    Then a public room is created with that title as catalogEpisodeId
    And signed-out Start Party uses Hosted UI plus pending-party resume

  Scenario: Redesign remains usable on mobile viewports
    When a visitor uses a viewport max-width 767px on Home, RiffTrax, Community, or Live Now
    Then the sidebar is an overlay drawer opened from the hamburger
    And the top bar keeps search and profile or sign-in
    And rows stack in a single column
    And primary actions stay reachable without horizontal scroll
