Feature: Submit and advance post-mutation polls use WS notify
  As the Riffle hand orchestrator
  I want submit and advance paths to use Turnur push events instead of blind polling
  So that seated play in the lab is faster on the hot action path

  # Out of this ticket: WS client, subscription registry, lab subscribe, remaining poll sites.

  Background:
    Given the server-side orchestrator has subscribed to the match over WebSocket
    And HTTP request and response remains the match authority

  Scenario: turn.designated skips redundant turn.get
    When submit or advance completes an HTTP mutation
    And a turn.designated event arrives within the timeout
    Then the runtime uses event currentSeat without an immediate turn.get poll

  Scenario: move.accepted triggers targeted moves.list
    When submit completes an HTTP move mutation
    And a move.accepted event arrives within the timeout
    Then the runtime fetches moves.list once when rules need the payload
    And the runtime does not expect move payload on the WebSocket event

  Scenario: Missed push falls back to HTTP poll
    When submit completes an HTTP mutation
    And no expected push arrives within the timeout
    Then the runtime reads turn and move log via HTTP as today
