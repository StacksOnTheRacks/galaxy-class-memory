Feature: Play iframe accepts host seat capability via postMessage
  As a /play iframe embedded by the lab parent
  I want to receive a seat capability via targeted postMessage
  So that seat-scoped fetches include X-Riffle-Seat-Capability without postMessage being seat authority

  # Out of this ticket: lab page, lab orchestrator, POST /v1/matches,
  # deal/open betting, iframe isolation mechanism (lab-parent-origin),
  # capability mint encoding changes, live Turnur manual verification.

  Background:
    Given the play surface is attached via bootstrap mint redeem
    And postMessage bootstrap attempts are rejected
    And requireSeatCapability remains the runtime gate for seat-scoped writes

  Scenario: Parent delivers capability via postMessage
    Given a bound play session in an iframe
    When the parent sends a valid capability postMessage from an allowlisted origin
    Then the iframe stores the token in per-iframe memory
    And subsequent seat-scoped fetches include X-Riffle-Seat-Capability

  Scenario: postMessage bootstrap remains rejected
    When the parent sends a postMessage shaped like bootstrap with token or bt fields
    Then the iframe ignores it
    And bootstrap remains hash-fragment redeem only

  Scenario: Wrong-seat capability cannot act as another seat
    Given seat A's iframe received seat A's capability
    When seat-scoped operations use seat B's capability token
    Then the runtime rejects the operation

  Scenario: Capability delivery does not bypass runtime verification
    Given a capability was delivered via postMessage
    When a seat-scoped Turnur operation runs
    Then requireSeatCapability verifies the header token first
