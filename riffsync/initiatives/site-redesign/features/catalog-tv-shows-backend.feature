Feature: tv_shows catalog enum and Movies route canonical
  As a RiffSync operator and public browse client
  I want tv_shows catalog data and canonical Movies routes
  So that TV Shows and Movies channel pages can ship without schema blockers

  # Out of this ticket: Figma channel page UI, AppShell rebuild,
  # Your Parties, Load Media, host theater, production Dynamo retag.

  Scenario: staff can tag tv_shows in schema, seed, and admin
    Given catalog schema, in-repo seed or fixtures, and the staff catalog form accept catalog tv_shows
    When staff create or edit a row with catalog tv_shows
    Then GET /v1/catalog includes that row
    And the stored enum value is tv_shows
    And production Dynamo tagging is not required to finish this ticket

  Scenario: /catalog/tv-shows serves only tv_shows rows
    When a visitor opens /catalog/tv-shows
    Then they see only playable rows whose catalog is tv_shows
    And the route is a public SEO canonical
    And tv_shows is included in PUBLIC_CATALOG_CATEGORIES
    And hub mixed grid, category chips, and catalogEntriesVisibleInPublicBrowse still omit other, live, and movie_night

  Scenario: Movies channel uses movie_night catalog at /catalog/movies
    When a visitor opens /catalog/movies
    Then they receive playable movie_night catalog rows
    And requests to /catalog/movie-night redirect to /catalog/movies
    And the Dynamo catalog value remains movie_night
    And movie_night stays withheld from hub mixed grid, category chips, and catalogEntriesVisibleInPublicBrowse

  Scenario: Live APIs and exclusion rules stay put
    When this ticket ships
    Then GET /v1/live and /live/:slug are unchanged
    And live rows are not treated as a catalog subcategory
