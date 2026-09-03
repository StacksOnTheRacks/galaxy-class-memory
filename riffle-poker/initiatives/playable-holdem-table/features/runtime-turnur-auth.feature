Feature: Riffle runtime authenticates to Turnur with a server-side SDK key
  As the Riffle runtime
  I want to authenticate to Turnur with a server-side SDK key
  So that later tickets can create seats, designate turns, write views, and append moves without exposing the key to the browser

  # Out of this ticket: mint/redeem bootstrap, seat capability, rules library,
  # seats/turns/views/moves, hosting/IaC, signed result, production console,
  # npm publish, stack/blinds defaults, any player-visible UI.

  Background:
    Given Riffle Poker is the registered Turnur game
    And the Riffle runtime is the sole holder of the Turnur SDK key
    And an in-repo fixture SDK key is enough for authentication
    And a mocked or stubbed Turnur is enough
    And the browser never receives the Turnur SDK key

  Scenario: Runtime authenticates to Turnur with a valid fixture SDK key
    When the Riffle runtime authenticates as the registered game with a valid fixture SDK key
    Then authentication succeeds via the shipped Turnur SDK client contract
    And Turnur accepts the game as authenticated

  Scenario: Authenticated session is used for subsequent match operations
    Given the Riffle runtime is authenticated to Turnur
    When a subsequent match-operation attempt for that game is made through the runtime
    Then that attempt uses the authenticated session
    And this ticket does not create seats, designate turns, write hidden views, or append moves

  Scenario: Missing or invalid SDK key is rejected
    When the Riffle runtime attempts to authenticate to Turnur without a valid SDK key
    Then authentication is rejected
    And the runtime is not treated as an authenticated game

  Scenario: Unauthenticated runtime cannot perform match operations
    Given the Riffle runtime is not authenticated to Turnur
    When the runtime is asked to create seats, designate turns, write hidden views, or append moves
    Then those operations are refused

  Scenario: SDK key never appears in iframe, host client, or browser-accessible config
    When the runtime authenticates or fails to authenticate
    Then the iframe, host client, public env, and browser-accessible config never receive an SDK key
    And logs and error bodies do not echo the SDK key
