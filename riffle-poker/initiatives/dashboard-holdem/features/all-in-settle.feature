Feature: Settle all-in with side pots when required, showdown or fold-out, and update stacks
  As seated players
  I want correct all-in and side-pot settlement
  So that stacks reflect NLHE outcomes

  # Product facts (locked):
  # - Play chips; blinds 1/2; start 2000; max 8; seat token; WS seat-scoped snapshots (#65)
  # - All-in = call/bet/raise that commits entire remaining stack
  # - Short all-in below a full raise does not change lastRaiseSize or re-queue prior actors
  # - Server auto-settles in the same success that makes the hand terminal; no client settle
  # - Auto-run remaining streets when further betting is impossible, then showdown
  # - Main then side pots; eligibility by commitment; folded ineligible; uncalled returned
  # - Odd chip clockwise from button among tied eligible winners, per pot
  # - Fold-out: complete/fold_to_one, no hole reveal; Showdown: complete/showdown, still-in holes revealed
  # - Stacks persist after complete; no auto next hand
  # - Historical MatchStore/Hono/Turnur stay reject-all-in; forward = serverless only
  # - All-in confirm UI = #64; single pot chrome = #63; multi-pot Main/Side labels = this ticket
  # Out: Multi-Hand Session, OIDC (#68), shell/chrome (#60–#62), felt/AV/embed/cashier

  Background:
    Given a hand is open on the serverless WebSocket match path after start_hand
    And blinds are 1 and 2
    And play chips are integers

  Scenario: All-in is legal when the action exhausts the stack
    Given it is my seat's turn on the serverless path
    And a legal call or bet or raise would commit my entire remaining stack
    When I send that action
    Then the action applies and my stack is zero
    And the rejection code all_in_or_side_pot_unsupported is not returned

  Scenario: Short all-in does not reopen a full raise
    Given it is my seat's turn facing a bet
    And a short all-in would add less than lastRaiseSize to the current bet
    When I send that short all-in
    Then lastRaiseSize is unchanged
    And seats that already matched the previous full bet are not re-queued for action

  Scenario: Further betting impossible auto-runs remaining streets then showdown
    Given every still-in seat is all-in
    Or all but one still-in seats are all-in and the other has matched the current bet
    And undealt streets remain
    When the successful action completes
    Then remaining streets are dealt in that same success with no betting
    And board lengths follow flop 3 then turn 4 then river 5 with one burn each street
    And burns and remaining deck never appear in any snapshot
    And showdown and settlement run before fan-out
    And phase is complete with reason showdown

  Scenario: Unequal all-in stacks form main and side pots
    Given two or more still-in seats are all-in for unequal total commitments
    When the hand reaches settlement
    Then a main pot and one or more side pots are formed with numeric amounts
    And each seat is eligible only for pots built from chips up to that seat's total commitment
    And folded seats are ineligible for every pot
    And eligible winners receive awards and stacks update

  Scenario: Uncalled chips return to the bettor
    Given a seat has put more chips into the current betting than any other still-in seat
    When pots are formed for settlement
    Then the uncalled excess returns to that bettor
    And those chips are not awarded from any pot

  Scenario: Odd chip on a split goes clockwise from the button
    Given two or more eligible seats tie for a pot whose chip total is not evenly divisible
    When that pot is awarded
    Then equal floor shares go to each tied winner
    And each remaining odd chip is given one at a time clockwise from the button among those tied winners

  Scenario: Fold-out awards without revealing holes
    Given folding leaves exactly one seat not folded
    When that fold succeeds
    Then every eligible pot is awarded to that seat in the same success
    And no hole cards are revealed in any seat's snapshot
    And phase is complete with reason fold_to_one
    And the current seat is cleared
    And stacks update

  Scenario: Showdown reveals still-in holes and awards
    Given two or more seats are still in at showdown on a five-card board
    When showdown runs in the terminal success
    Then each still-in seat is ranked by best five of seven
    And still-in hole faces appear in every seat's snapshot
    And folded seats' holes remain hidden
    And eligible pots are awarded and stacks update
    And phase is complete with reason showdown
    And the current seat is cleared

  Scenario: After complete stacks persist and next hand does not auto-start
    Given phase is complete after fold-out or showdown
    Then seated stacks remain on the seats
    And the server does not automatically start the next hand

  Scenario: No client settle and no client-supplied state
    When a client sends a settle message or an action that includes board or pot or holes or stacks or winners or street
    Then the message is rejected
    And for client-supplied board pot holes stacks winners or street the code is client_supplied_state
    And match state is unchanged

  Scenario: Historical paths keep rejecting all-in
    Given a match is on the historical MatchStore or Hono or Turnur path
    When a client sends an action that would all-in or create a side pot
    Then the action is rejected with code all_in_or_side_pot_unsupported
    And match state is unchanged

  Scenario: Multi-pot Board shows Main and Side labels
    Given a seat-scoped snapshot supplies more than one pot
    When Board renders at desktop or tablet or phone
    Then the pot area shows labeled Main and Side amounts
    Given a snapshot supplies exactly one pot
    Then Board shows the single pot total without Side labels

  Scenario: Winner result is text not color alone
    Given a seat has won chips at settlement
    When the dashboard renders at phone or tablet or desktop
    Then that seat shows a text winner result such as Won $X
    And the win is not communicated by color alone

  Scenario: Terminal success writes once then fans out
    Given a successful action makes the hand terminal including any auto-runout and settlement
    Then there is one conditional write of the post-settlement state
    And each open connection on that table receives a seat-scoped snapshot
    And burns remaining deck and seat tokens are absent from every snapshot and error body

  Scenario: Rejections do not fan out a new version
    Given an action is rejected for any reason
    Then the stored table version is unchanged
    And no new snapshot is fan out to connections
