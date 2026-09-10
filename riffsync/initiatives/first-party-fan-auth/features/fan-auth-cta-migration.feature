Feature: Migrate in-app fan auth CTAs off Hosted UI
  As a RiffSync fan
  I want every in-app Sign in entry to open first-party auth routes
  So that routine auth never redirects me to *.amazoncognito.com

  # Out of this ticket: building auth page UI (#461–#464 except navigation helpers),
  # removing fanHostedUiPkce.ts or /auth/callback, staff auth.

  Background:
    Given first-party fan auth pages are shipped (#461–#464)
    And fanAuthNavigation provides navigateToFanAuth and buildFanAuthUrl
    And /auth/callback remains for legacy Hosted UI OAuth returns

  Scenario: In-app Sign in CTA opens first-party sign-in with returnTo
    Given a visitor is on a fan route such as /catalog/movies
    When they choose Sign in from the site header, catalog tile, or account gate
    Then the browser navigates to /auth/sign-in with returnTo set to the current path and query
    And the visitor is not redirected to Cognito Hosted UI

  Scenario: Soft Hosted UI fallback does not replace in-app CTAs
    Given Hosted UI remains reachable for legacy links and bookmarks
    When a visitor uses any in-app Sign in, Sign up, or Forgot password entry point updated by this initiative
    Then that entry point targets a first-party /auth/* route
    And it does not deep-link to *.amazoncognito.com

  Scenario: Legacy Hosted UI callback still completes fan OAuth at /auth/callback
    Given a visitor arrives from a bookmarked or emailed *.amazoncognito.com authorize URL
    When Cognito redirects to /auth/callback with an authorization code
    Then the SPA completes PKCE exchange using existing fan callback handling
    And the visitor lands on the stored returnTo or a safe default
    And fan tokens match the same riffsync.fan* storage shape as first-party sign-in
