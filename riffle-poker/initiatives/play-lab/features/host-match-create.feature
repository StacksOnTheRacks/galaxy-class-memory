Feature: Host-facing POST /v1/matches wraps Turnur match.create
  As the Riffle runtime
  I want an authenticated host to create a Turnur match via POST /v1/matches
  So that the lab orchestrator can attach a match without the browser holding host or SDK keys

  # Out of this ticket: lab page, lab orchestrator, capability postMessage,
  # seat create, bootstrap mint, capability mint, deal/open betting,
  # live Turnur manual verification, RiffSync, runtime hosting.

  Background:
    Given Riffle Poker is the registered Turnur game
    And the Riffle runtime holds the Turnur SDK key server-side
    And an in-repo fixture host credential is enough for host authentication
    And the browser and lab page must not call POST /v1/matches

  Scenario: Authenticated host creates a Turnur match
    When an authenticated host calls POST /v1/matches
    Then the runtime returns 201 with a matchId
    And Turnur match.create was invoked server-side

  Scenario: Unauthenticated host cannot create a match
    When an unauthenticated caller attempts POST /v1/matches
    Then the runtime rejects the request
    And Turnur match.create is not called

  Scenario: Unauthenticated Turnur session blocks match create
    Given the runtime is not game-authenticated to Turnur
    When an authenticated host calls POST /v1/matches
    Then the runtime rejects with turnur_unauthenticated or equivalent
    And no matchId is returned

  Scenario: Fake Turnur implements match.create for CI
    Given tests use an in-memory fake Turnur
    When the orchestrator or host route creates a match in vitest
    Then match.create succeeds without live network
