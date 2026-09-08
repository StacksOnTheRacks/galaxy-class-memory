Feature: Site redesign
  As a RiffSync fan or signed-in host
  I want the site to match the Figma chrome and the listed hosting and browse changes
  So that I can browse channels (including TV Shows), find parties, and reuse watch parties through Load Media

  # Out of this initiative:
  # - Big-bang UI rewrite or downtime cutover (incremental surface adoption)
  # - Find/focus room tab + return-to-share as the primary hosting UX (Icebox)
  # - Extension capture / tabCapture / extension-supplied host_screen (ADR-001)
  # - Verified Premium, piracy vault, indexing ephemeral /room/*
  # - Friends/DM, admin, federated login, or new lawful-playback backends
  # - Board tickets (created later in LLD grooming)
  # - Rooms with no current catalogEpisodeId (create-without-title)

  Background:
    Given the Figma file https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync is the visual source
    And rooms have a mutable catalogEpisodeId seeded at create and changeable by the host
    And the catalog gains a tv_shows enum value and /catalog/tv-shows route
    And product-metrics instrumentation (GA4 / CloudWatch) stays in place

  Scenario: Left nav is fixed, vertical, and collapsible
    When a visitor uses the main navigation
    Then it is fixed on the left and vertical
    And a hamburger control collapses it to an icons-only rail
    And expanded and collapsed states remain keyboard reachable

  Scenario: Top bar search uses a custom dropdown
    When a visitor types in the top-bar search field
    Then matching catalog titles list in a custom dropdown combobox
    And selecting a result navigates to the title or channel destination
    And empty and error states are announced to assistive tech

  Scenario: Top bar profile menu opens Your Parties
    Given the visitor is signed in as a host
    When they open the top bar profile menu
    Then they can navigate to the Your Parties page

  Scenario: Your Parties lists rooms the signed-in host owns
    Given the host is signed in
    When they open Your Parties
    Then they see watch parties they host sorted by recent activity
    And they do not see rooms hosted by other fans
    And system Live rooms are not listed as owned parties

  Scenario: Host resumes an owned party from Your Parties
    Given the host has an existing room on Your Parties
    When they open that party
    Then they land in the room at /room/{roomId}
    And the room retains its current catalogEpisodeId until Load Media changes it

  Scenario: Channel pages include TV Shows with a cards and list toggle
    When a visitor opens a channel page for MST3K, RiffTrax, Live Now, Movies, TV Shows, or Community
    Then the page matches the Figma channel layout for that destination
    And they can toggle between Cards view and List view
    And TV Shows shows only catalog rows with catalog tv_shows

  Scenario: Movies channel uses movie_night catalog at /catalog/movies
    When a visitor opens the Movies channel
    Then they browse movie_night catalog rows at /catalog/movies
    And requests to /catalog/movie-night redirect to /catalog/movies

  Scenario: Live Now channel links to official Live surfaces
    When a visitor opens the Live Now channel
    Then they reach official Live hub content backed by GET /v1/live and /live/{slug}
    And Live Now is not implemented as a catalog enum browse page

  Scenario: Host starts a party from a movie card
    When a signed-in host starts a watch party from a catalog card
    Then a room is created or resumed with that title as the current catalogEpisodeId
    And Load Media default-selects that title when opened

  Scenario: Load Media replaces Open Media Source Tab for title selection
    Given the host is in their room with host authority
    When they choose Load Media from the host theater UI
    Then a media chooser modal opens with category sidebar and searchable title table
    And Open Media Source Tab is not the primary title-picker entry point

  Scenario: Load Media applies a title via host PATCH
    Given Load Media is open and the host selects a catalog title
    When they confirm Load Media
    Then the room catalogEpisodeId updates via authenticated host PATCH
    And guests see updated now-watching metadata on the next room refresh

  Scenario: Load Media opens media in the extension-owned tab when extension is present
    Given the host has the Chrome host extension installed and bound to the party tab
    When they confirm Load Media with the extension tab option
    Then the extension opens or navigates the host media tab to the resolved source URL
    And the party tab stays focused

  Scenario: Load Media opens media in a new browser tab without the extension path
    Given the host chooses the new-tab option in Load Media
    When they confirm Load Media
    Then the resolved source URL opens in a new browser tab
    And host PATCH still updates the room catalogEpisodeId

  Scenario: Host theater surfaces match Figma media mode variants
    When a host is in media mode in their room
    Then the slim top bar, chat panel, and host button bar match the Figma host theater frames
    And broadcast, TV cast, share, and camera/audio affordances remain host-authoritative as today

  Scenario: Redesign remains usable on mobile viewports
    When a visitor uses a mobile viewport
    Then the app shell adapts with a drawer or overlay sidebar pattern
    And channel content and host controls remain reachable without horizontal scroll on primary actions
