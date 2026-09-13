Feature: Integrate Turnur WebSockets — server-side notify for match orchestrators
  As the Riffle runtime orchestrating play-lab and hand flows
  I want to subscribe to Turnur match events over a server-side WebSocket
  So that I can reduce post-mutation HTTP polling without changing match authority

  # Out of this initiative:
  # - Browser or iframe WebSocket (play-lab page and /play iframes never open WS)
  # - Player-facing realtime push UI
  # - RiffSync host WebSocket integration
  # - Replacing the Turnur HTTP client or mutation paths
  # - Tournaments, multi-hand session, or host attach scope creep

  Background:
    Given the Riffle runtime holds the Turnur SDK key server-side
    And HTTP request and response remains the match authority
    And the play-lab browser and play iframes never receive the Turnur SDK key
    And TURNUR_WS_URL is optional and when unset the runtime keeps today's HTTP poll behavior

  Scenario: Lab session subscribes server-side after match attach
    Given a live Turnur is configured with TURNUR_WS_URL set
    When the operator starts a play-lab session
    Then the server-side orchestrator attaches a match via HTTP
    And the server-side orchestrator opens a WebSocket and subscribes to that matchId
    And the play-lab browser does not open a WebSocket

  Scenario: Two-seat play-lab hand issues fewer turn and move polls with WS
    Given a two-seat match is in play in the play lab
    And TURNUR_WS_URL is configured
    And the server-side orchestrator has subscribed to the match over WebSocket
    When the operator completes a seated two-player hand
    Then the runtime issues fewer HTTP polls for turn and move log than without the subscription

  Scenario: WebSocket client runs only on the server-side orchestrator
    Given a two-seat match is in play in the play lab
    When the lab uses a Turnur WebSocket subscription for the match
    Then the WebSocket client runs in the Riffle runtime process
    And the play-lab page and play iframes never receive TURNUR_WS_URL or the SDK key

  Scenario: HTTP remains authoritative when push is missed
    Given the server-side orchestrator has subscribed to a match over WebSocket
    And the runtime completes a Turnur mutation via HTTP
    When the runtime does not receive the expected push event
    Then the runtime can still read the current turn and move log via HTTP

  Scenario: move.accepted triggers a targeted move log fetch
    Given the server-side orchestrator has subscribed to a match over WebSocket
    When the runtime receives a move.accepted event for that match
    Then the runtime fetches the move log via HTTP when rules need the payload
    And the runtime does not expect move payload on the WebSocket event

  Scenario: turn.designated updates the current seat without a redundant turn poll
    Given the server-side orchestrator has subscribed to a match over WebSocket
    When the runtime receives a turn.designated event with a currentSeat
    Then the runtime uses the event currentSeat without an immediate turn.get poll

  Scenario: view.updated triggers a seat-scoped hidden view fetch
    Given the server-side orchestrator has subscribed to a match over WebSocket
    When the runtime receives a view.updated event for a seat
    Then the runtime fetches that seat's hidden view via HTTP only
    And the runtime does not read view JSON from the push event

  Scenario: Graceful degradation when WebSocket is unavailable
    Given TURNUR_WS_URL is unset or the WebSocket connect fails
    When the operator completes a play-lab hand
    Then the hand flow completes using the existing HTTP poll paths
    And CI against the fake Turnur is unchanged
