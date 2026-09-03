Feature: Playable no-limit Hold'em table
  As a seated player in a host room (RiffSync first)
  I want a Riffle NLHE play-chip table attached from that room
  So that we can complete a hand deal through showdown on Turnur without Riffle owning identity, chat, rooms, or media, and without Riffle becoming match authority

  # Out of this initiative (Now slice):
  # - Real money, rake, cashier, KYC
  # - Player or host identity, chat, rooms, presence, or media on Riffle
  # - Other poker variants, tournaments / sit-and-go, standalone lobby or matchmaking
  # - Spectator public-board polish (roadmap Next)
  # - Side pots, all-in runout, and disconnect/rejoin (roadmap Next) — first complete hand
  #   must finish via fold-to-one or showdown when no player is all-in; those polish paths
  #   are not required to call this initiative done
  # - Dedicated rules service; client-side rules execution; SDK key in the browser
  # - Signed result issuance/verification (deferred with Turnur)

  Background:
    Given a host room exists with identity, chat, rooms, and media owned by the host
    And Riffle Poker is the registered Turnur game
    And poker rules execute as an in-process library inside the Riffle runtime
    And the Riffle runtime holds the Turnur SDK key and uses @turnur/sdk
    And the browser never receives the Turnur SDK key

  Scenario: Host attaches the Riffle play surface via iframe
    When the host loads the Riffle play URL in an iframe for that room's match
    Then seated players see the Riffle table UI inside the host room
    And the host does not become Turnur match authority
    And identity, chat, rooms, and media remain on the host

  Scenario: Riffle runtime authenticates to Turnur with an SDK key
    Given the host has attached the Riffle play surface via iframe
    When the Riffle runtime authenticates to Turnur with a valid SDK key
    Then Turnur accepts the game as authenticated
    And subsequent match operations for that game use that authenticated session

  Scenario: Missing or invalid SDK key is rejected
    When the Riffle runtime attempts to authenticate to Turnur without a valid SDK key
    Then Turnur rejects the authentication
    And the table cannot create seats, designate turns, write hidden views, or append moves

  Scenario: Authenticated game seats a play-chip NLHE table on Turnur
    Given the Riffle runtime is authenticated to Turnur
    When the game creates seats for the table on the attached match
    Then Turnur owns those seats and returns distinct seatIds
    And seats do not include player identity
    And mapping seatIds to host-room participants remains the host's job

  Scenario: Hand deals hole cards as seat-scoped hidden views
    Given at least two seats are seated at the table
    When the Riffle runtime deals a no-limit Hold'em hand
    Then each seated player receives hole cards only for their own seat
    And those hole cards are stored as that seat's Turnur hidden view
    And Turnur owns the hidden views

  Scenario: Hole cards do not leak across seats
    Given a hand is in progress with hole cards dealt
    When one seat reads its hidden view or table state available to that seat
    Then that seat sees only its own hole cards
    And that seat does not see any other seat's hole cards

  Scenario: Public board advances through streets
    Given a hand is in progress past preflop with action complete for the street
    When the Riffle runtime deals the next street under NLHE rules
    Then the public board updates for flop, then turn, then river as applicable
    And every seated player can see the same public board
    And the public board is not stored as a seat hidden view

  Scenario: On-turn betting actions are applied under NLHE rules
    Given a hand is in progress and it is one seat's turn
    When that seat submits a legal NLHE action (fold, check, call, bet, or raise) through the Riffle table UI
    Then the Riffle runtime validates the action against in-process NLHE rules
    And the authenticated game submits the corresponding move to Turnur for that seat
    And Turnur accepts the on-turn move and appends it to the match move log
    And play-chip stacks and the pot update according to the accepted action

  Scenario: Off-turn or illegal action is rejected before authority advances
    Given a hand is in progress and it is one seat's turn
    When another seat attempts an action, or the turn seat submits an illegal NLHE action
    Then the Riffle runtime rejects the action under in-process NLHE rules
    And Turnur's current turn and move log are unchanged by that attempt

  Scenario: Hand completes by fold without showdown
    Given a hand is in progress with no player all-in
    When all but one seat fold under NLHE rules
    Then the remaining seat wins the pot in play chips
    And the hand is complete
    And Turnur's move log reflects the accepted actions for that hand

  Scenario: Hand completes at showdown without all-in or side pots
    Given a hand reaches river with at least two seats still in and no player all-in
    When betting completes and remaining seats show down
    Then the Riffle runtime ranks hands under NLHE rules
    And the pot is awarded in play chips to the winning seat or seats for that single pot
    And the hand is complete
    And hole cards required for shown hands are revealed only as allowed at showdown
    And Turnur remains authority for seats, turns, hidden views, and the move log

  Scenario: First complete hand does not require side pots, all-in runout, or disconnect recovery
    Given a seated table can finish a hand by fold-to-one or by non-all-in showdown
    Then side pots, all-in board runout, and disconnect/rejoin are out of scope for this initiative
    And spectator-only public-board polish is out of scope for this initiative
