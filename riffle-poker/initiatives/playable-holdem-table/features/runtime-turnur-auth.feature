Feature: Riffle runtime authenticates to Turnur with a server-side SDK key
  As the Riffle runtime
  I want to authenticate to Turnur with a server-side SDK key
  So that later tickets can create seats, designate turns, write views, and append moves without exposing the key to the browser

  # Out of this ticket: mint/redeem bootstrap, seat capability, rules library,
  # seats/turns/views/moves, hosting/IaC, signed result.

  Background:
    Given Riffle Poker is the registered Turnur game
    And the Riffle runtime is the sole holder of the Turnur SDK key
    And the browser never receives the Turnur SDK key

  Scenario: Runtime authenticates to Turnur with a valid SDK key
    When the Riffle runtime authenticates to Turnur with a valid SDK key
    Then Turnur accepts the game as authenticated

  Scenario: Authenticated session is used for subsequent match operations
    Given the Riffle runtime is authenticated to Turnur
    When subsequent match operations for that game are performed
    Then those operations use that authenticated session

  Scenario: Missing or invalid SDK key is rejected
    When the Riffle runtime attempts to authenticate to Turnur without a valid SDK key
    Then Turnur rejects the authentication
    And the table cannot create seats, designate turns, write hidden views, or append moves

  Scenario: SDK key never appears in iframe, host client, or browser-accessible config
    When the runtime authenticates or fails to authenticate
    Then the iframe, host client, public env, and browser-accessible config never receive a production SDK key
