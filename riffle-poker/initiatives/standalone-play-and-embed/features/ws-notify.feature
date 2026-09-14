Feature: Browser WebSocket notify-only for public table updates
  As a seated player in standalone or embed
  I want public table refresh over Riffle WebSocket
  So that the felt updates without treating push as write authority

  # Out of this ticket: identity UI, MatchStore creation, shared play URL,
  # Sit at Table, display name, HTTP mutations as product work (#42),
  # hole-card delivery on WS (#43), hand complete (#44), Turnur WS.

  Background:
    Given Riffle exposes a browser-facing WebSocket in ws/
    And HTTP mutations remain authoritative
    And WS frames are notify-only public table cursor / refresh
    And the public topic is table:{matchId}

  Scenario: Browser subscribes by matchId with first-control-frame bearer
    When a browser connects to Riffle WS for a match
    Then subscribe proves the same IdentityStore bearer as HTTP in the first control frame
    And that bearer is sessionStorage key riffle.identity.session sent as Authorization Bearer
    And the token never appears in URL query, hash, or ?token=

  Scenario: Non-browser may prove bearer on the handshake
    When a non-browser client sends Authorization on the WS handshake
    Then the server accepts that same IdentityStore bearer
    And subscribe to table:{matchId} succeeds

  Scenario: Public WS frames are cursor refresh only
    When a public WS frame is emitted
    Then it carries matchId and a cursor
    And it does not carry hidden-view bodies, hole cards, or other-seat private fields

  Scenario: Topic ACL rejects hidden, seat-scoped, and write topics
    Given a client holds a valid Riffle bearer
    When they subscribe to a hidden, seat-scoped, or write topic
    Then subscribe is rejected
    And seat-scoped hidden views stay on HTTP

  Scenario: Push is not mutation success
    Given a client is subscribed to public table notify
    Then a notify frame is not mutation success
    And HTTP 2xx on the action remains authority

  Scenario: Table updates when notifyPublicTable fires
    Given at least one client is subscribed to table:{matchId}
    When notifyPublicTable runs after a simulated accepted action or board advance
    Then subscribed clients receive a public refresh
    And seated tables update
    And this ticket does not require action HTTP (#42) to be implemented

  Scenario: Foreign credentials cannot subscribe
    When a caller presents only host JWT, postMessage, shared play URL, riffle_play cookie, RIFFLE_HOST_API_KEY, or X-Riffle-Seat-Capability
    Then they cannot subscribe to the match

  Scenario: Does not wrap Turnur WS
    When new WS work is implemented
    Then it does not wrap Turnur WS
    And it does not import @turnur/sdk
