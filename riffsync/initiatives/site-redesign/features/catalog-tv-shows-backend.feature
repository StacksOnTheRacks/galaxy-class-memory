Feature: tv_shows catalog enum and Movies route canonical
  As a RiffSync operator and public browse client
  I want tv_shows catalog data and canonical Movies routes
  So that TV Shows and Movies channel pages can ship without schema blockers

  # Out of this ticket: channel page UI, AppShell, Your Parties, Load Media, host theater.

  Scenario: tv_shows enum and public route are available
    Given staff can tag catalog rows with catalog tv_shows
    When a client requests GET /v1/catalog or browses /catalog/tv-shows
    Then tv_shows rows are available to public browse policy
    And /catalog/tv-shows serves only tv_shows rows

  Scenario: Movies channel uses movie_night catalog at /catalog/movies
    When a visitor opens /catalog/movies
    Then they receive movie_night catalog rows
    And requests to /catalog/movie-night redirect to /catalog/movies
