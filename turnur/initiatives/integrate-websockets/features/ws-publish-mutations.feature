Feature: Remaining WebSocket mutation publishers
  As a game pack developer authenticated with an SDK key
  I want turn, move, and view HTTP mutations to push public events
  So that subscribers stay in sync without polling after every mutation

  # Out of this ticket: SDK, integrator docs.

  Background:
    Given a match has already been attached
    And the game is authenticated to Turnur with an SDK key
    And the game has subscribed to the match over WebSocket
    And publish-match-event and seat.created fanout have already shipped

  Scenario: Turn designation pushes current seat
    Given the authenticated game has created two seats on the match
    When the authenticated game designates the first seat as the current turn via HTTP
    Then the subscriber receives a turn.designated event
    And the event reports the current turn as that seat

  Scenario: Accepted move pushes public HTTP 201 fields
    Given the authenticated game has created two seats on the match
    And the current turn is the first seat
    When the authenticated game submits a move for the first seat via HTTP
    Then the subscriber receives a move.accepted event
    And the event includes seq, seatId, createdAt, and currentSeat
    And the event does not include the move payload

  Scenario: View update pushes seatId only
    Given the authenticated game has created a seat on the match
    When the authenticated game writes a hidden view for that seat via HTTP
    Then the subscriber receives a view.updated event
    And the event includes the seatId
    And the event does not include the view body

  Scenario: Push events do not leak another seat's hidden view
    Given the authenticated game has created two seats on the match
    And the first seat has a hidden view
    And the second seat has a different hidden view
    When the authenticated game writes a hidden view for the first seat via HTTP
    Then any push event for that match does not include the second seat's hidden view
