Feature: TV Shows and Movies channel pages
  As a RiffSync fan
  I want TV Shows and Movies channel pages under the Figma channel layout
  So that I can browse those catalogs with Cards and List views

  # Out of this ticket: catalog backend enum/routes (#447), AppShell rebuild (#445),
  # remaining channels (#451), Your Parties (#449), Load Media (#450), host theater (#452).

  Background:
    Given the Figma file https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync is the visual source
    And Channel / Movies (1433:5811) and Channel / TV Shows (1433:6129) are the channel references
    And /catalog/tv-shows and /catalog/movies already exist from the catalog IA ticket
    And the MST3K ChannelLayout pilot pattern exists
    And product-metrics instrumentation (GA4 / CloudWatch) stays in place

  Scenario: TV Shows channel matches Figma inside AppShell
    When a visitor opens /catalog/tv-shows
    Then the page renders inside AppShell
    And the page body matches ChannelHero plus Cards or List, not leftover subcategory chrome
    And only playable catalog rows with catalog tv_shows are shown
    And MST3K, RiffTrax, Community, Riff Material, hub, home, and Live routes are unchanged

  Scenario: Movies channel matches Figma inside AppShell
    When a visitor opens /catalog/movies
    Then the page renders inside AppShell
    And the page body matches ChannelHero plus Cards or List
    And only playable catalog rows with catalog movie_night are shown
    And /catalog/rifftrax/movies remains the RiffTrax Movies split

  Scenario: Cards is the default view
    When a visitor first opens /catalog/tv-shows or /catalog/movies
    Then Cards view is selected
    And the view choice is component state only

  Scenario: Visitor toggles Cards and List
    When a visitor uses the Cards | List control
    Then the selected button exposes aria-pressed
    And Cards shows one wrapping card grid of the filtered set
    And List shows the same ids as list or table rows
    And Figma View=Table maps to Cards

  Scenario: Movie-night path replace-navigates to Movies
    When a visitor opens /catalog/movie-night
    Then the SPA replace-navigates to the fixed path /catalog/movies
    And that destination is the Figma Movies channel page
    And the target is not query-driven (no next, returnTo, or url)

  Scenario: Indexable SEO is preserved
    When a visitor opens /catalog/tv-shows or /catalog/movies
    Then document title, canonical, description, and exactly one sr-only h1 are preserved
    And /catalog/movie-night is not an indexable page

  Scenario: Existing title filter still applies
    When a visitor uses the in-page title filter on either channel
    Then rows stay limited to that route's playable catalog value
    And no-match copy still explains clearing search
    And Home, Videos, and Live toolbar tabs are absent
    And Movies genre tabs (ACTION / COMEDY / HORROR / DRAMA / INDIE) are absent
    And there is no Subscribe button and no Subscribers metric

  Scenario: Cards and list rows are keyboard reachable
    When a visitor tabs through Cards or List
    Then each row and its Start Party / Watch Solo actions are reachable
    And focus rings are visible

  Scenario: Host starts a party from a Movies or TV Shows card
    When a signed-in host chooses Start Party on a playable row
    Then createRoom is called with that title as catalogEpisodeId, playbackExpectation, and visibility public
    And they land on /room/{roomId}

  Scenario: Signed-out Start Party uses pending-party
    When a signed-out visitor chooses Start Party
    Then the existing Hosted UI sign-in plus pending-party resume runs
    And this is not Your Parties or Load Media reuse

  Scenario: Channel rows stack on narrow viewports
    When the viewport is max-width 767px
    Then channel rows stack in a single column
