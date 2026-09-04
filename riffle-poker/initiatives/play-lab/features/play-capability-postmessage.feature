Feature: Play iframe accepts host seat capability via postMessage
  As a /play iframe embedded by the lab parent
  I want to receive a seat capability via targeted postMessage
  So that seat-scoped fetches include X-Riffle-Seat-Capability without postMessage being seat authority

  # Out of this ticket: lab page, lab orchestrator, POST /v1/matches,
  # deal/open betting, capability mint encoding changes, live Turnur manual verification.
  # Iframe isolation between two sibling frames is sibling #23 (lab-parent-origin), not this ticket.
  # No full table or action fetch client — header-attach helper only.

  Background:
    Given the play surface is attached via bootstrap mint redeem
    And postMessage bootstrap attempts are rejected
    And requireSeatCapability remains the runtime gate for seat-scoped writes
    And the /play client does not yet call seat-scoped table or action APIs

  Scenario: Parent delivers capability via postMessage
    Given a bound play session in an iframe
    When the parent sends a valid capability postMessage from an allowlisted origin
    And the closed schema uses type riffle.seatCapability and capability only
    And the message does not include token, bootstrapToken, or bt keys
    Then the iframe stores the token in per-iframe memory
    And the seat-scoped fetch helper includes X-Riffle-Seat-Capability on mocked seat-scoped requests

  Scenario: postMessage bootstrap remains rejected
    When the parent sends a postMessage shaped like bootstrap with token or bt fields
    Then the iframe ignores it
    And bootstrap remains hash-fragment redeem only

  Scenario: Wrong origin or non-closed schema is ignored
    When the parent sends a postMessage from a non-allowlisted origin
    Or the payload is not the closed capability schema
    Then the iframe stores nothing
    And the fetch helper does not attach X-Riffle-Seat-Capability

  Scenario: Wrong-seat capability cannot act as another seat
    Given seat A's iframe received seat A's capability via the fetch helper
    When seat-scoped operations use seat B's capability token
    Then requireSeatCapability on the runtime rejects the operation

  Scenario: Capability delivery does not bypass runtime verification
    Given a capability was delivered via postMessage into per-iframe memory
    When a seat-scoped Turnur operation runs
    Then the fetch helper presents X-Riffle-Seat-Capability
    And requireSeatCapability verifies the header token first
