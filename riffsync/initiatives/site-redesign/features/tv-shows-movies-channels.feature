Feature: TV Shows and Movies channel pages
  As a RiffSync fan
  I want TV Shows and Movies channel pages under the Figma channel layout
  So that I can browse those catalogs with Cards and List views

  # Out of this ticket: catalog backend enum/routes, remaining channels, Your Parties, Load Media, host theater.

  Background:
    Given tv_shows catalog data and /catalog/movies routes are live
    And the Figma AppShell and ChannelLayout pilot pattern exist

  Scenario: TV Shows channel shows only tv_shows rows
    When a visitor opens the TV Shows channel at /catalog/tv-shows
    Then the page matches the Figma channel layout
    And only catalog rows with catalog tv_shows are shown
    And they can toggle between Cards view and List view

  Scenario: Movies channel shows movie_night rows at /catalog/movies
    When a visitor opens the Movies channel
    Then they browse movie_night catalog rows at /catalog/movies
    And they can toggle between Cards view and List view

  Scenario: Host starts a party from a Movies or TV Shows card
    When a signed-in host starts a watch party from a catalog card on these channels
    Then a room is created or resumed with that title as the current catalogEpisodeId
