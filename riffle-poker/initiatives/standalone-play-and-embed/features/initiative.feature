Feature: Standalone play and embed
  As a player at a Riffle table
  I want to sit and play no-limit Hold'em from the standalone app or from a host embed
  So that Riffle owns the game while hosts keep chat, rooms, and media

  # Out of this initiative:
  # - Chat, rooms, presence, or media/playback on Riffle (host owns those in embed-mode)
  # - Real money, rake, cashier, or KYC
  # - Turnur as match backend or developer platform GTM
  # - Additional poker variants, tournaments / sit-and-go
  # - Side pots, all-in runout, disconnect/rejoin, spectator public-board polish
  # - Production lobby or matchmaking
  # - Anonymous session becoming a Riffle account without leaving the table (open question; not required)

  Background:
    Given Riffle Poker is a standalone no-limit Hold'em app that uses play chips
    And Riffle owns gameplay, rules, match state, and notify
    And match state includes seats, turns, hidden hole cards, and the move log
    And new work does not depend on Turnur as match backend
    And a host in embed-mode keeps chat, rooms, and media

  Scenario: Player creates a Riffle account and sits
    When a player signs up for a Riffle account and signs in
    And they click Sit at Table
    Then they are seated as that Riffle account
    And they can take a turn when it is their seat's turn

  Scenario: Player signs in with an existing Riffle account and sits
    Given a player has a Riffle account
    When they sign in
    And they click Sit at Table
    Then they are seated as that Riffle account
    And they can take a turn when it is their seat's turn

  Scenario: Player sits with an anonymous session
    When a player chooses to play without a Riffle account
    And they click Sit at Table
    Then they receive an anonymous session that binds that seat
    And they can take a turn when it is that seat's turn
    And they are not required to create a Riffle account to play

  Scenario: Anonymous player can change in-game name
    Given a player is seated with an anonymous session
    When they change their in-game display name
    Then seated players see the new display name for that seat
    And the seat binding does not require a Riffle account

  Scenario: Account and anonymous players can share a table
    Given one seated player is signed in with a Riffle account
    And another seated player is bound by an anonymous session
    When they play at the same table
    Then both seats participate in the same hand

  Scenario: Host attaches embed-mode via a shared play URL
    Given a host room exists (RiffSync first) with chat, rooms, and media owned by the host
    When the host loads the Riffle play surface in an iframe using the shared play URL
    Then guests in that room see the same Riffle play surface as standalone
    And chat, rooms, and media remain on the host
    And the host does not own match state or evaluate poker rules

  Scenario: Unauthenticated host guests can sit
    Given a host has loaded the play surface via the shared play URL for everyone in the room
    And a guest has no Riffle account and no host account
    When that guest clicks Sit at Table
    Then they are seated with an anonymous Riffle session
    And there is no Riffle login chrome in the iframe
    And host identity is not used as seat authority

  Scenario: Hole cards stay seat-scoped
    Given at least two players are seated and a hand is dealt
    When one seat views its cards
    Then that seat sees only its own hole cards

  Scenario: Public board is shared
    Given a hand is in progress past preflop
    When the public board advances
    Then every seated player sees the same public board

  Scenario: The table updates for seated players
    Given at least two players are seated
    When one seat's action is accepted or the public board advances
    Then the table updates for seated players

  Scenario: Seated standalone players complete a play-chip hand
    Given at least two players are seated at the same standalone table
    When they play a no-limit Hold'em hand through deal to fold-to-one or non-all-in showdown
    Then the hand completes in play chips
    And Riffle owns seats, turns, hidden hole cards, and the move log

  Scenario: Embed-mode table can complete a hand
    Given a host has loaded the play surface via the shared play URL
    And at least two guests have clicked Sit at Table
    When they play a no-limit Hold'em hand through deal to fold-to-one or non-all-in showdown
    Then the hand completes in play chips
    And chat, rooms, and media remain on the host

  Scenario: Riffle does not provide chat, rooms, or media
    When players sit at a standalone or embedded table
    Then they do not use Riffle chat, Riffle rooms, or Riffle media playback

  Scenario: Riffle does not take real money
    When players sit and play
    Then stacks and pots are play chips only

  Scenario: New play does not use Turnur as match backend
    When players sit and complete a hand on this path
    Then Riffle owns match state and notify
    And Turnur is not match authority for that hand

  Scenario: Side pots, all-in runout, and disconnect recovery are not required
    Given a seated table can finish a hand by fold-to-one or by non-all-in showdown
    Then side pots, all-in board runout, and disconnect/rejoin are out of scope
