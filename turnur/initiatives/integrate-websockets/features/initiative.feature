Feature: Integrate WebSockets — match-event push
  As a game pack developer authenticated with an SDK key
  I want Turnur to push match events over a WebSocket when match state changes
  So that the game can react without polling HTTP after every mutation

  # Out of this initiative: signed result; player or host authentication;
  # realtime or action gameplay; hidden-view bodies on push; replacing HTTP routes.

  Background:
    Given a match has already been attached
    And the game is authenticated to Turnur with an SDK key
    And HTTP request and response remains the match authority
    And identity, chat, rooms, and media stay on the host

  Scenario: Game opens a WebSocket and subscribes to its match
    When the game opens a WebSocket with a valid SDK key on the connect query string
    And the game sends a subscribe message for the match it owns
    Then Turnur accepts the subscription

  Scenario: Invalid connect token is rejected
    When the game opens a WebSocket with a missing or invalid SDK key on the connect query string
    Then Turnur rejects the connection for subscription

  Scenario: Game cannot subscribe to another game's match
    Given a second game has attached its own match
    When the first game opens a WebSocket with a valid SDK key
    And the first game sends a subscribe message for the second game's match
    Then Turnur rejects the subscription

  Scenario: Seat creation pushes a public event
    Given the game has subscribed to the match over WebSocket
    When the authenticated game creates a seat on the match via HTTP
    Then the subscriber receives a seat.created event
    And the event includes the new seatId
    And the event does not include any hidden view

  Scenario: Turn designation pushes current seat
    Given the game has subscribed to the match over WebSocket
    And the authenticated game has created two seats on the match
    When the authenticated game designates the first seat as the current turn via HTTP
    Then the subscriber receives a turn.designated event
    And the event reports the current turn as that seat

  Scenario: Accepted move pushes public move fields
    Given the game has subscribed to the match over WebSocket
    And the authenticated game has created two seats on the match
    And the current turn is the first seat
    When the authenticated game submits a move for the first seat via HTTP
    Then the subscriber receives a move.accepted event
    And the event includes the move sequence, seatId, and public payload fields
    And the event does not include hidden state

  Scenario: View update pushes seatId only
    Given the game has subscribed to the match over WebSocket
    And the authenticated game has created a seat on the match
    When the authenticated game writes a hidden view for that seat via HTTP
    Then the subscriber receives a view.updated event
    And the event includes the seatId
    And the event does not include the view body

  Scenario: Push events do not leak another seat's hidden view
    Given the game has subscribed to the match over WebSocket
    And the authenticated game has created two seats on the match
    And the first seat has a hidden view
    And the second seat has a different hidden view
    When the authenticated game writes a hidden view for the first seat via HTTP
    Then any push event for that match does not include the second seat's hidden view

  Scenario: HTTP remains authoritative when push is missed
    Given the game has subscribed to the match over WebSocket
    And the authenticated game has created a seat on the match
    When the authenticated game designates that seat as the current turn via HTTP
    And the game does not receive the push event
    Then the game can still read the current turn via HTTP

  Scenario: Play lab needs fewer turn and move polls
    Given a two-seat match is in play in the play lab
    And the game has subscribed to the match over WebSocket
    When the authenticated game completes a seated two-player hand
    Then the game issues fewer HTTP polls for turn and move log than without the subscription
