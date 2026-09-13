Feature: TURNUR_WS_URL env gate and Turnur WS client factory
  As the Riffle runtime
  I want an optional server-side Turnur WebSocket client beside the HTTP session
  So that WS is available when TURNUR_WS_URL is configured and CI is unchanged when it is not

  # Out of this ticket: match subscription registry, lab subscribe, poll refactors.

  Background:
    Given the Riffle runtime holds the Turnur SDK key server-side
    And HTTP request and response remains the match authority

  Scenario: WS client is not created when TURNUR_WS_URL is unset
    Given TURNUR_WS_URL is unset
    When the runtime authenticates to Turnur via HTTP
    Then no WebSocket connection is attempted
    And existing HTTP poll behavior is unchanged

  Scenario: WS client connects when TURNUR_WS_URL is set
    Given TURNUR_WS_URL is configured
    And Turnur HTTP authentication succeeds
    When the runtime initializes the Turnur session
    Then a server-side WebSocket client is created via createTurnurWsClient
    And the client is not imported by the lab page or play iframe bundle

  Scenario: Connect logs omit key material
    Given TURNUR_WS_URL is configured
    When the WebSocket client connects
    Then structured logs do not contain the SDK key or full connect URL with query token
