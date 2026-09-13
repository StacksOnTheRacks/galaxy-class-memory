Feature: Match subscription registry and waitForMatchEvent
  As the Riffle runtime orchestrator
  I want per-match WebSocket subscription and event await helpers
  So that hand flows can react to push events with HTTP poll fallback

  # Out of this ticket: WS client factory, lab wire-up, poll refactors.

  Background:
    Given the server-side Turnur WebSocket client is available
    And HTTP request and response remains the match authority

  Scenario: ensureSubscribed is idempotent for a match
    Given a match has been attached via HTTP
    When ensureTurnurWsSubscription is called twice for the same matchId
    Then the match is subscribed once without error

  Scenario: waitForMatchEvent resolves on matching push
    Given the runtime has subscribed to a match
    When a turn.designated event arrives for that match
    Then waitForMatchEvent resolves with the event within the timeout

  Scenario: waitForMatchEvent falls back on timeout
    Given the runtime has subscribed to a match
    When waitForMatchEvent times out without a matching push
    Then the caller can fall back to HTTP poll paths

  Scenario: Reconnect resubscribes active matches
    Given two matches are subscribed
    When the WebSocket disconnects and reconnects
    Then both matchIds are resubscribed
