Feature: Create play-chip NLHE seats on the attached Turnur match
  As the authenticated Riffle runtime
  I want to create Turnur-owned seats for the table
  So that seatIds are the roster and the host maps them to room participants without putting identity on seats

  # Out of this ticket: hole cards, turns/moves, capability crypto schema,
  # host identity, stack/blinds defaults, signed result.

  Background:
    Given the Riffle runtime is authenticated to Turnur with an SDK key
    And a match has been attached for the table
    And identity, chat, rooms, and media stay on the host

  Scenario: Authenticated game creates seats with distinct seatIds
    When the authenticated runtime creates seats on the attached match
    Then Turnur owns those seats and returns distinct seatIds

  Scenario: Seats do not include player identity
    When the authenticated runtime creates a seat on the match
    Then the seat does not include a player identity

  Scenario: Host maps seatIds to room participants
    Given seats exist on the attached match
    Then mapping those seatIds to host-room participants remains the host's job

  Scenario: Invalid SDK key cannot create seats
    When a caller attempts to create seats without a valid SDK key
    Then Turnur rejects the request
