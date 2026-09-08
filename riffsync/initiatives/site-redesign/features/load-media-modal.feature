Feature: Load Media modal replaces Open Media Source Tab
  As a signed-in host in my room
  I want a Load Media modal to pick and apply a catalog title
  So that title selection is consolidated without changing ADR-001 authority split

  # Out of this ticket: Your Parties page, channel browse surfaces, host theater visual reskin (except Load Media entry wiring).

  Background:
    Given the host is in their room with host authority
    And rooms have a mutable catalogEpisodeId changeable via host PATCH

  Scenario: Load Media replaces Open Media Source Tab for title selection
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
