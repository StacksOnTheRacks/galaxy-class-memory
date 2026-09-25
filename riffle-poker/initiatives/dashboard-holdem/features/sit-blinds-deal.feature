Feature: Sit at table, post blinds, deal hole cards, and open betting
  As a player at a dashboard table
  I want to sit, start a hand, and receive my hole cards
  So that preflop betting can open on the correct seat

  # Product facts (locked):
  # - Max seats 8; blinds 1/2; starting stack 2000 play chips
  # - Explicit start_hand; no auto-start on second sit
  # - Anonymous display name + server-issued seat token
  # Out of this ticket: street advance (#66), settlement (#67), UI chrome (#60–#64), OIDC (#68)

  Background:
    Given a table exists on the serverless WebSocket match path
    And play chips use blinds 1 and 2
    And the table allows at most 8 seats
    And sitting grants starting stack 2000 play chips

  Scenario: Player sits an open seat
    Given I am a table member and seat 3 is open
    When I sit seat 3 with display name "Maya R."
    Then I receive a server-issued seat token for that table and seat
    And seat 3 is occupied with stack 2000
    And public snapshots show players count including my seat over 8

  Scenario: Sit is rejected when illegal
    Given seat 3 is occupied
    When another player tries to sit seat 3
    Then the sit is rejected and match state is unchanged
    And sitting with an empty display name is rejected
    And sitting when already seated is rejected
    And sitting when 8 seats are occupied is rejected

  Scenario: Leave between hands frees the seat
    Given I am seated and no hand is in progress
    When I leave
    Then my seat is open and my seat token no longer authorizes that seat

  Scenario: Leave during a hand is rejected
    Given a hand is in progress and I am seated
    When I leave
    Then the leave is rejected and I remain seated

  Scenario: Start hand requires two seated players and is explicit
    Given only one player is seated
    When that player sends start_hand
    Then start_hand is rejected and no hand begins
    Given two players are seated and no hand is in progress
    When either seated player sends start_hand
    Then a hand begins
    And the server does not auto-start merely because the second player sat

  Scenario: Heads-up blinds and first to act
    Given seats 1 and 2 are seated and no hand is in progress
    When start_hand succeeds
    Then the button is also the small blind
    And the other seat is the big blind
    And blinds 1 and 2 are posted from those stacks into the pot
    And preflop first to act is the button
    And street is preflop and hand number is 1

  Scenario: Three or more blinds and first to act
    Given three or more players are seated and no hand is in progress
    When start_hand succeeds
    Then the small blind is left of the button
    And the big blind is left of the small blind
    And preflop first to act is left of the big blind
    And street is preflop

  Scenario: Hole cards are seat-scoped
    Given a hand has just started
    Then each seated player's snapshot includes exactly two hole faces for their seat
    And no other connection's snapshot includes another seat's hole ranks or suits
    And seat tokens never appear in public snapshots

  Scenario: Top bar meta after deal
    Given a hand has just started
    Then public meta includes hand number and street preflop
    And blinds display as $1 / $2
    And desktop and tablet players meta is n / 8

  Scenario: Illegal start_hand is rejected
    Given a hand is already in progress
    When any player sends start_hand
    Then start_hand is rejected and match state is unchanged
    Given I am connected but not seated
    When I send start_hand
    Then start_hand is rejected

  Scenario: Client cannot supply stacks or deals
    When a client includes stack, blinds, pot, or hole cards on sit or start_hand
    Then server-assigned values are used and client-supplied game values are not applied

  Scenario: Button assignment across hands
    Given the first hand uses the lowest seated seat index as button
    When a later start_hand runs after no hand is in progress
    Then the button moves left to the next still-seated player from the previous button
    And hand number increments by 1
