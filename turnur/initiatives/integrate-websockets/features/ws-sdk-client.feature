Feature: TypeScript SDK WebSocket client
  As a game pack developer
  I want a TypeScript WebSocket client in @turnur/sdk
  So that my server-side integrator can connect, subscribe, and receive push events

  # Out of this ticket: integrator README docs.

  Background:
    Given WebSocket connect, subscribe, and publish have already shipped
    And the game is authenticated to Turnur with an SDK key

  Scenario: SDK connects with query token and subscribes
    When the integrator creates a WebSocket client with wsUrl and apiKey
    And the integrator subscribes to a match it owns
    Then the subscription is accepted

  Scenario: SDK delivers push events via callback
    Given the integrator has subscribed to a match over the WebSocket client
    When a seat is created on that match via HTTP
    Then the integrator onEvent callback receives a seat.created event

  Scenario: HTTP SDK client is unchanged
    When the integrator uses createTurnurClient for HTTP calls
    Then the existing HTTP match authority methods still work
