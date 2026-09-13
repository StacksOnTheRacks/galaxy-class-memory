Feature: Remaining orchestration poll sites and poll reduction verification
  As the Riffle hand orchestrator
  I want all hand and table modules to use WS notify with HTTP fallback
  So that a full play-lab hand completes with fewer HTTP polls when WS is configured

  # Out of this ticket: WS client, subscription registry, lab subscribe, submit/advance refactors.

  Background:
    Given the server-side orchestrator has subscribed to the match over WebSocket
    And HTTP request and response remains the match authority

  Scenario: view.updated triggers seat-scoped HTTP GET only
    When a view.updated event arrives for a seat
    Then the runtime fetches that seat hidden view via HTTP only
    And the runtime does not read view JSON from the push event

  Scenario: Remaining modules use subscription helper
    When complete, open, table public, or table seat paths mutate Turnur state
    Then they use the subscription helper instead of unconditional moves.list and turn.get pairs

  Scenario: Play-lab hand completes with fewer polls when WS configured
    Given TURNUR_WS_URL is configured
    And a two-seat match is in play in the play lab
    When the operator completes a seated two-player hand
    Then the runtime issues fewer HTTP polls for turn and move log than without the subscription

  Scenario: Graceful degradation when WS unavailable
    Given TURNUR_WS_URL is unset
    When the operator completes a play-lab hand
    Then the hand flow completes using existing HTTP poll paths
