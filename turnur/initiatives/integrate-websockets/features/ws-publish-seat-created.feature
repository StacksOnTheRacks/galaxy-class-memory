Feature: publish-match-event and seat.created fanout
  As a game pack developer authenticated with an SDK key
  I want seat creation to push a public seat.created event
  So that subscribers can react without polling HTTP after creating a seat

  # Out of this ticket: turn/move/view publishers, SDK, integrator docs.

  Background:
    Given a match has already been attached
    And the game is authenticated to Turnur with an SDK key
    And the game has subscribed to the match over WebSocket

  Scenario: Seat creation pushes a public event
    When the authenticated game creates a seat on the match via HTTP
    Then the subscriber receives a seat.created event
    And the event includes the new seatId
    And the event does not include any hidden view

  Scenario: HTTP seat create still succeeds when fanout fails
    Given no WebSocket subscribers exist for the match
    When the authenticated game creates a seat on the match via HTTP
    Then Turnur returns HTTP 201 with the new seatId
