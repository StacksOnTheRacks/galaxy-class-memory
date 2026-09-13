Feature: Browser WebSocket notify-only for public table updates
  As a seated player in standalone or embed
  I want public table refresh over Riffle WebSocket
  So that the felt updates without treating push as write authority

  # Out of this ticket: identity UI, MatchStore creation, shared play URL,
  # Sit at Table, display name, HTTP mutations, hole-card delivery on WS,
  # hand complete, Turnur WS.

  Background:
    Given Riffle exposes a browser-facing WebSocket in ws/
    And HTTP mutations remain authoritative
    And WS frames are notify-only public table cursor / refresh

  Scenario: Browser subscribes by matchId with bearer auth
    When a browser connects to Riffle WS for a match
    Then subscribe proves the same bearer as HTTP in the handshake or first control frame
    And the token never appears in query strings

  Scenario: Public WS frames omit hidden views
    When a public WS frame is emitted
    Then it does not carry hidden-view bodies or other-seat hole cards

  Scenario: Topic ACL separates public notify from seat-scoped channels
    Given a client is subscribed to public table notify
    Then push is not mutation success
    And seat-scoped hidden views stay on HTTP

  Scenario: Table updates when action is accepted or board advances
    Given at least two players are seated
    When one seat's action is accepted or the public board advances
    Then seated players' tables update via WS notify

  Scenario: Does not wrap Turnur WS
    When new WS work is implemented
    Then it does not wrap or depend on Turnur WS
