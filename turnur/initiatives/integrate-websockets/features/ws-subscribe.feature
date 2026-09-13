Feature: WebSocket subscribe with match ownership gate
  As a game pack developer authenticated with an SDK key
  I want to subscribe my WebSocket connection to a match I own
  So that later tickets can push match events to that connection

  # Out of this ticket: publish/fanout, SDK, integrator docs.

  Background:
    Given a match has already been attached
    And the game is authenticated to Turnur with an SDK key
    And WebSocket connect/disconnect has already shipped

  Scenario: Game subscribes to its own match
    Given the game has opened a WebSocket with a valid SDK key on the connect query string
    When the game sends a subscribe message for the match it owns
    Then Turnur accepts the subscription

  Scenario: Game cannot subscribe to another game's match
    Given a second game has attached its own match
    And the first game has opened a WebSocket with a valid SDK key on the connect query string
    When the first game sends a subscribe message for the second game's match
    Then Turnur rejects the subscription

  Scenario: Subscribe to an unknown match is rejected
    Given the game has opened a WebSocket with a valid SDK key on the connect query string
    When the game sends a subscribe message for a match that does not exist
    Then Turnur rejects the subscription with match_not_found
