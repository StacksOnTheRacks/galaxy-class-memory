Feature: Pilot MST3K channel layout with Cards | List toggle
  As a RiffSync fan
  I want the MST3K channel page under the new AppShell with a cards and list view toggle
  So that we validate ChannelLayout on one surface before rolling out other channels

  # Out of this ticket: other channel routes (#448, #451), tv_shows backend (#447),
  # Your Parties (#449), Load Media (#450), host theater (#452), AppShell rebuild (#445).

  Background:
    Given the Figma file https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync is the visual source
    And Channel / MST3K (15:913) is the channel reference
    And existing MST3K public browse routes already use CatalogSubcategoryPage
    And product-metrics instrumentation (GA4 / CloudWatch) stays in place

  Scenario: MST3K channel matches Figma inside AppShell
    When a visitor opens /catalog/mst3k or an existing nested MST3K season, era, or shorts path
    Then the page renders inside AppShell
    And the page body matches ChannelHero plus Cards or List, not today's red-html subcategory chrome
    And other catalog subcategory pages are unchanged

  Scenario: Cards is the default view
    When a visitor first opens an MST3K channel route
    Then Cards view is selected
    And the view choice is component or session state only

  Scenario: Visitor toggles Cards and List
    When a visitor uses the Cards | List control
    Then the selected button exposes aria-pressed
    And Cards shows a DesktopCardRow grid
    And List shows list or table rows
    And Figma View=Table maps to Cards

  Scenario: Existing MST3K filters still apply
    When a visitor uses route filters, Era/Season tag pills on /catalog/mst3k, or the in-page title filter
    Then rows stay limited to playable MST3K catalog entries
    And Community, RiffTrax, and Riff Material rows do not appear
    And there is no Subscribe button and no Subscribers metric
    And Home, Videos, and Live toolbar tabs are absent

  Scenario: Cards and list rows are keyboard reachable
    When a visitor tabs through Cards or List
    Then each row and its Start Party / Watch Solo actions are reachable
    And focus rings are visible

  Scenario: Host starts a party from an MST3K catalog card
    When a signed-in host chooses Start Party on an MST3K row
    Then createRoom is called with that title as catalogEpisodeId, playbackExpectation, and visibility public
    And they land on /room/{roomId}

  Scenario: Signed-out Start Party uses pending-party
    When a signed-out visitor chooses Start Party
    Then the existing Hosted UI sign-in plus pending-party resume runs
    And this is not Your Parties or Load Media reuse

  Scenario: Indexable MST3K SEO is preserved
    When a visitor opens /catalog/mst3k
    Then document title, canonical, and exactly one sr-only h1 with text MST3K are preserved

  Scenario: MST3K rows stack on narrow viewports
    When the viewport is max-width 767px
    Then channel rows stack in a single column
