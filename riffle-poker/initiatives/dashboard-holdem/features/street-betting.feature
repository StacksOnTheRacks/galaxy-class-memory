Feature: Advance legal betting through flop, turn, and river
  As seated players
  I want full-street NLHE betting
  So that hands can reach fold-out or showdown-ready without awarding yet

  # Product facts (locked by #65 / this ticket):
  # - Blinds 1/2; starting stack 2000; max 8 seats; seat token; explicit start_hand
  # - WebSocket seat-scoped snapshot fan-out (not Turnur notify)
  # - Auto-deal next street inside the successful act when betting round completes
  # - All-in / side-pot actions rejected with no mutation; settlement is #67
  # Out of this ticket: pot award / hole reveal (#67), UI chrome (#60–#64), OIDC (#68)

  Background:
    Given a hand is open on the serverless WebSocket match path after start_hand
    And blinds are 1 and 2
    And play chips are integers

  Scenario: Legal actions advance turn order
    Given it is my seat's turn during betting
    When I send a legal fold or check or call or bet or raise
    Then the action applies
    And when the street continues the current seat advances to the next still-in player
    And every open connection receives a seat-scoped snapshot

  Scenario: Completing a round auto-deals the next street
    Given a betting round is about to complete with two or more players still in
    And the street is preflop or flop or turn
    When the closing legal action succeeds
    Then the next street is dealt inside that same act without a second client message
    And street commitments and current bet reset for the new street
    And postflop first to act is the next clockwise still-in seat from the button
    And seat-scoped snapshots include the updated street and board

  Scenario: Preflop through river board lengths
    Given betting completes on preflop
    Then the board has three community cards after one burn and street is flop
    Given betting then completes on flop
    Then the board has four community cards after one burn and street is turn
    Given betting then completes on turn
    Then the board has five community cards after one burn and street is river

  Scenario: Minimum bet and raise sizes
    Given it is my turn and there is no bet to face
    When I bet below the big blind
    Then the bet is rejected and match state is unchanged
    Given it is my turn and I am facing a bet
    When I raise to less than currentBet plus lastRaiseSize
    Then the raise is rejected and match state is unchanged

  Scenario: Bet versus raise shape
    Given I am facing a bet
    When I send bet
    Then the action is rejected and match state is unchanged
    Given there is nothing to raise
    When I send raise
    Then the action is rejected and match state is unchanged
    Given I am facing a bet
    When I check
    Then the check is rejected and match state is unchanged
    Given there is nothing to call
    When I send call
    Then the call is rejected and match state is unchanged

  Scenario: Off-turn and all-in paths are rejected
    Given it is not my seat's turn
    When I send any action
    Then the action is rejected and match state is unchanged
    Given an action that would all-in or create a side pot
    When I send that action
    Then the action is rejected with code all_in_or_side_pot_unsupported
    And match state is unchanged

  Scenario: Client-supplied state is rejected
    When I send an action that includes board or pot or holes or stacks or winners or street
    Then the action is rejected with code client_supplied_state
    And match state is unchanged

  Scenario: River close reaches showdown-ready without awarding
    Given river betting completes with two or more players still in
    Then phase is showdown_ready and current seat is cleared
    And pots are not awarded
    And hole cards are not revealed to other seats
    And stacks are not settled for winners

  Scenario: Fold to one reaches fold-to-one without awarding
    Given folding leaves exactly one player still in
    Then phase is fold_to_one and current seat is cleared
    And the pot is not awarded
    And stacks are not settled

  Scenario: Actions while terminal phases are rejected
    Given phase is fold_to_one or showdown_ready
    When I send any action
    Then the action is rejected and match state is unchanged

  Scenario: Hole cards stay seat-scoped on street fan-out
    Given a street advance or legal action just succeeded
    Then each seat's snapshot may include only that seat's hole faces
    And foreign snapshots omit other seats' hole ranks and suits
    And seat tokens never appear in public or foreign snapshots
    And burns and remaining deck never appear in any snapshot

  Scenario: Rejections do not fan out a new version
    Given an action is rejected for any reason
    Then the stored table version is unchanged
    And no new snapshot is fan out to connections
