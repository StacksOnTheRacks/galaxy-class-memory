Feature: WebSocket ConnectionRegistry and connect/disconnect
  As a game pack developer authenticated with an SDK key
  I want Turnur to provision WebSocket connect/disconnect with ConnectionRegistry
  So that later tickets can subscribe and receive push events

  # Out of this ticket: subscribe handler, publish/fanout, SDK, integrator docs.

  Background:
    Given match authority primitives have already shipped
    And the game is authenticated to Turnur with an SDK key

  Scenario: Valid connect persists ConnectionRegistry row
    When the game opens a WebSocket with a valid SDK key on the connect query string
    Then Turnur accepts the handshake
    And ConnectionRegistry stores connectionId and gameId
    And matchId is not set until a later subscribe ticket

  Scenario: Invalid connect token is rejected at handshake
    When the game opens a WebSocket with a missing or invalid SDK key on the connect query string
    Then Turnur rejects the connection with handshake 401
    And no ConnectionRegistry row is created

  Scenario: Disconnect removes the connection row
    Given the game has opened a WebSocket with a valid SDK key on the connect query string
    When the WebSocket disconnects
    Then the ConnectionRegistry row for that connectionId is deleted
