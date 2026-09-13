Feature: WebSocket notify integrator documentation
  As a game pack developer
  I want integrator documentation for the WebSocket notify channel
  So that I can adopt push beside HTTP without guessing auth, events, or authority rules

  Background:
    Given WebSocket infrastructure and SDK client have already shipped

  Scenario: README documents WebSocket connect auth carve-out
    When an integrator reads infra/cdk/README.md
    Then the README documents WebSocketApiUrl and $connect ?token= usage
    And the README states HTTP routes remain Bearer-only

  Scenario: README documents event catalog and authority rules
    When an integrator reads infra/cdk/README.md
    Then the README lists seat.created, turn.designated, move.accepted, and view.updated
    And the README states move.accepted has no payload and view.updated is seatId only
    And the README states HTTP mutation response is authoritative and push is best-effort

  Scenario: README documents server-side key guidance
    When an integrator reads infra/cdk/README.md
    Then the README states production SDK keys stay server-side
    And the README warns not to log the connect token or query string
