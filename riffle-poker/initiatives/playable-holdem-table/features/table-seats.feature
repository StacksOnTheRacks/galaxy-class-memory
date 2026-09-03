Feature: Create play-chip NLHE seats on the attached Turnur match
  As the authenticated Riffle runtime
  I want to create Turnur-owned seats for the table
  So that seatIds are the roster and the host maps them to room participants without putting identity on seats

  # Out of this ticket: hole cards, turns/moves, capability crypto schema,
  # host identity, stack/blinds defaults, signed result, bootstrap,
  # rules library, table-size product decisions.

  Background:
    Given the Riffle runtime is authenticated to Turnur with an SDK key
    And a match has been attached for the table
    And identity, chat, rooms, and media stay on the host
    And seat.create is game-trusted (SDK key), not gated by seat capability

  Scenario: Authenticated game creates seats with distinct seatIds
    When the authenticated runtime creates two seats on the attached match
    Then Turnur owns those seats and returns a distinct seatId for each
    And two seats are enough to prove the roster

  Scenario: Seats do not include player identity
    When the authenticated runtime creates a seat on the match
    Then the seat does not include a player identity

  Scenario: Host maps seatIds to room participants
    Given seats exist on the attached match
    Then mapping those seatIds to host-room participants remains the host's job
    And this ticket does not bind a host player to a seat

  Scenario: Seat capability does not replace game-trusted seat.create
    When the authenticated runtime creates seats
    Then it uses the game-authenticated Turnur session
    And a host-issued seat capability is not required to create seats
    And seat capability binds a host player to an existing seat only

  Scenario: Creating seats does not designate a turn
    When the authenticated runtime creates one or more seats on the attached match
    Then currentSeat remains null
    And this ticket does not designate a turn

  Scenario: Missing or invalid SDK key cannot create seats
    When a caller attempts to create seats without a valid SDK key
    Then the request is rejected
    And no seats are created
