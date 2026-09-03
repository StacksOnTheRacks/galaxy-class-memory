Feature: Lab deal orchestrator deals and opens betting for two seats
  As a Riffle operator using the play lab
  I want POST /v1/lab/deal to deal and open betting for the lab match
  So that both iframes can play a hand using the existing table UI

  # Out of this ticket: lab page UI, session start, live Turnur manual verification,
  # player actions in iframe, side pots, all-in runout, next-hand loop.

  Background:
    Given a lab session exists with two seats on a matchId
    And the lab browser never receives RIFFLE_HOST_API_KEY or TURNUR_SDK_KEY
    And fixed two-seat play-chip defaults apply for the lab

  Scenario: Lab deal deals hole cards and opens betting
    When an authorized client calls POST /v1/lab/deal with the matchId
    Then hole cards are dealt as seat-scoped hidden views
    And betting is open with a designated first actor
    And public table facts include pot and per-seat stacks

  Scenario: Deal without prior session is rejected
    When POST /v1/lab/deal is called for an unknown or unprepared matchId
    Then the request is rejected
    And deal and open paths are not partially applied

  Scenario: Iframe clients do not deal or open betting
    Given POST /v1/lab/deal succeeds
    Then the deal and open operations ran only in the server orchestrator
    And iframe bundles did not invoke host-key deal routes directly
