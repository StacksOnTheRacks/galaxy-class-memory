Feature: Verify host-issued seat capability before seat-scoped Turnur ops
  As the Riffle runtime
  I want to verify a host-issued short-lived seat capability before seat-scoped Turnur reads or writes
  So that a client cannot act as another seat and postMessage is not seat authority

  # Out of this ticket: bootstrap mint/redeem, seat.create roster, deal/actions/
  # showdown, inventing the concrete token schema, signed result.

  Background:
    Given a host room exists with identity owned by the host
    And the Riffle runtime can receive host-issued seat capabilities
    And bootstrap is separate from seat authority

  Scenario: Host issues a seat capability separate from bootstrap
    When the host issues a short-lived seat capability binding player subject ↔ matchId ↔ seatId
    Then that capability is separate from the bootstrap token

  Scenario: Runtime verifies capability before a seat-scoped Turnur read or write
    Given a host-issued seat capability for a matchId and seatId
    When the runtime is about to perform a hidden-view read or turn submit for that seat
    Then the runtime verifies the capability first

  Scenario: Missing, expired, or wrong-seat capability is rejected
    When a seat-scoped Turnur operation is attempted with a missing, expired, or wrong-seat capability
    Then the runtime rejects the operation

  Scenario: postMessage is not seat authority
    When a postMessage arrives from the host or another frame
    Then the runtime does not treat postMessage as seat authority

  Scenario: Capability failure after attach may reuse embed-error
    Given the play surface is already attached
    When seat capability verification fails
    Then the failure may reuse the embed-error surface
    And no new Riffle screen is required
