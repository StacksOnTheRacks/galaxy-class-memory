Feature: Load Media modal replaces Open Media Source Tab
  As a signed-in host in my room
  I want a Load Media modal to pick and apply a catalog title
  So that title selection is consolidated without changing ADR-001 authority split

  # Out of this ticket: Your Parties (#449), channel browse, AppShell,
  # host theater visual reskin (#452) except Load Media entry wiring,
  # Next Up URL paste, PartyCaptureMediaPicker on party-capture watch,
  # PATCH contract changes (except derived displayTitle on episode change),
  # extension capture / find-focus.

  Background:
    Given the host is in their room with host authority
    And rooms have a mutable catalogEpisodeId changeable via host PATCH
    And Watch Party Host / Select Media Option (1387:3764) is the visual source

  Scenario: Load Media replaces Open Media Source Tab for title selection
    When they choose Load Media from the host theater UI
    Then a media chooser modal opens with category sidebar and searchable title table
    And Open Media Source Tab is not the primary title-picker entry point
    And Load Media is available with or without the host extension

  Scenario: Load Media dialog is accessible
    When Load Media is open
    Then the chooser is a dialog with role dialog and aria-modal
    And focus is trapped in the dialog
    And Escape dismisses it
    And the dialog is labelled by its title

  Scenario: Load Media applies a title via host PATCH
    Given Load Media is open and the host selects a catalog title
    When they confirm Load Media via the row LOAD MEDIA control
    Then the room catalogEpisodeId updates via authenticated host PATCH with body { catalogEpisodeId }
    And when displayTitle is omitted the server derives displayTitle from the catalog row
    And guests see updated now-watching metadata on the next room refresh

  Scenario: Non-host cannot apply Load Media
    When a guest or other fan PATCHes catalogEpisodeId on that room
    Then the response is 403
    And the media tab is not navigated as success

  Scenario: Load Media opens media in the extension-owned tab when extension is present
    Given the host has the Chrome host extension installed and bound to the party tab
    When they confirm Load Media on a catalog row
    Then the SPA PATCHes first and on success calls openHostMediaTab(resolveHostSourceTabUrl(...))
    And the party tab stays focused
    And C1 bind is unchanged

  Scenario: Load Media opens media in a new browser tab without the extension path
    Given the host has no bound extension
    When they confirm Load Media on a catalog row
    Then the resolved source URL opens in a new browser tab via the existing host source-tab window.open helper
    And host PATCH still updates the room catalogEpisodeId

  Scenario: Card-start default-selects the title when Load Media opens
    Given the host started the party from a catalog card
    And the room current catalogEpisodeId is that card's title
    When they open Load Media
    Then that catalogEpisodeId is selected in the chooser

  Scenario: Load Media default-selects the current room title on resume
    Given the host resumed a room that already has a catalogEpisodeId
    When they open Load Media
    Then that catalogEpisodeId is selected in the chooser

  Scenario: Load Media is catalog-only
    When Load Media is open
    Then the host can select only catalog titles from the cached catalog list
    And there is no URL paste field in the modal
    And playable movie_night titles remain selectable
