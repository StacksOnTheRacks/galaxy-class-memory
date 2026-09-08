Feature: Pilot MST3K channel layout with Cards | List toggle
  As a RiffSync fan
  I want the MST3K channel page under the new AppShell with a cards and list view toggle
  So that we validate ChannelLayout on one surface before rolling out other channels

  # Out of this ticket: other channel routes, tv_shows backend, Your Parties, Load Media, host theater.

  Background:
    Given the Figma AppShell is available for adopted routes
    And the MST3K catalog channel has public browse rows

  Scenario: MST3K channel matches Figma with Cards and List views
    When a visitor opens the MST3K channel page
    Then the page matches the Figma channel layout for MST3K
    And they can toggle between Cards view and List view

  Scenario: Host starts a party from an MST3K catalog card
    When a signed-in host starts a watch party from an MST3K catalog card
    Then a room is created or resumed with that title as the current catalogEpisodeId
