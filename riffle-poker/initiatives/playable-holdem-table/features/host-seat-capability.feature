Feature: Verify host-issued seat capability before seat-scoped Turnur ops
  As the Riffle runtime
  I want to verify a host-issued short-lived seat capability before seat-scoped Turnur reads or writes
  So that a client cannot act as another seat and postMessage is not seat authority

  # Out of this ticket: bootstrap mint/redeem, seat.create, hidden-view reads,
  # turn submits, rules library, deal/actions/showdown, signed result,
  # concrete encoding (JWT vs opaque, crypto, TTL, routes — tech spec),
  # production console, any new player-visible screen.

  Background:
    Given a host room exists with identity owned by the host
    And an in-repo fixture host credential is enough for host→runtime authentication
    And seat capability is issued on an authenticated host→runtime channel
    And bootstrap is separate from seat authority
    And this ticket installs the verify-before-op gate only

  Scenario: Host issues a seat capability separate from bootstrap
    When an authenticated host issues a short-lived seat capability binding player subject ↔ matchId ↔ seatId
    Then the runtime accepts that capability as seat authority for that binding
    And that capability is not a bootstrap token and does not attach the play surface

  Scenario: Unauthenticated host cannot issue a seat capability
    When an unauthenticated caller attempts to issue a seat capability
    Then the runtime rejects the issue

  Scenario: Runtime verifies capability before a seat-scoped Turnur read or write
    Given a host-issued seat capability for a player subject, matchId, and seatId
    When the runtime is about to perform a seat-scoped Turnur read or write for that seat
    Then the runtime verifies the capability first
    And stub or probe helpers are enough to prove the gate
    And this ticket does not implement hidden-view reads, turn submits, or seat.create

  Scenario: Missing, expired, or mismatched capability is rejected
    When a seat-scoped Turnur operation is attempted with a missing, expired, wrong-seat, or wrong-match capability
    Then the runtime rejects the operation

  Scenario: Bootstrap and play session are not seat authority
    Given a bound play session without a seat capability
    When a seat-scoped Turnur operation is attempted
    Then the runtime rejects the operation

  Scenario: postMessage is not seat authority
    When a postMessage arrives from the host or another frame claiming a seat
    Then the runtime does not treat postMessage as seat authority
    And postMessage remains not seat authority even if used as a delivery pipe

  Scenario: Capability failure after attach may reuse embed-error
    Given the play surface is already attached
    When seat capability verification fails
    Then the failure may reuse the embed-error surface
    And no new Riffle screen is required
