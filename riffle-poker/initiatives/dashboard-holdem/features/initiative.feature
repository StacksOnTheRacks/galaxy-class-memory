Feature: Dashboard Hold'em
  As a player at a Riffle dashboard table
  I want to sit, deal, and finish no-limit Hold'em hands with play chips
  So that the game is playable in the dashboard UI before embed or marketing work

  # Out of this initiative:
  # - Embed-mode, RiffSync, shared iframe host attach
  # - Felt-table artwork pipeline / Canva kit
  # - Live microphone or camera
  # - Chat, rooms, media, real money, variants, tournaments
  # - Multi-hand session productization beyond completing hands at a seated table
  # - Public marketing website

  Background:
    Given Riffle Poker is a standalone no-limit Hold'em product that uses play chips
    And the play surface is the dashboard UI from Figma "Table / Your Turn"
    And Riffle owns gameplay, rules, match state, and notify
    And interactive hosting is WebSocket API Gateway plus Lambda plus DynamoDB
    And player tiles show avatar or initials without live audio or video

  Scenario: Player sits at the dashboard table
    When a player sits at an open seat
    Then they appear in the player row with avatar or initials and a stack
    And the top bar shows table name, blinds, and seated players

  Scenario: A hand is dealt
    Given at least two players are seated
    When a hand starts
    Then blinds are posted
    And each seated player receives hole cards
    And the acting seat is prompted to act
    And the top bar shows the hand number and street

  Scenario: Player acts on their turn
    Given it is a seated player's turn
    When they fold, check, call, or raise using the action controls
    Then the action is recorded in the action log
    And other seated players see the last action on that seat
    And stacks and committed amounts update

  Scenario: Raise controls include presets and all-in
    Given it is a player's turn and a raise is legal
    When they use raise-to, the amount slider, or presets Min, half pot, three-quarter pot, pot, or All-in
    Then the chosen raise or all-in amount is submitted as their action

  Scenario: Phone uses an action sheet
    Given the player is on the phone breakpoint of Table / Your Turn
    When it is their turn
    Then Fold, Check or Call, and Raise controls are available from an action sheet

  Scenario: Streets advance through the board
    Given a hand is in progress
    When a betting round completes with more than one player still in
    Then the public board advances through flop, turn, and river slots as required
    And the Board surface shows the pot and players still in the hand

  Scenario: Hand ends by fold-out
    Given a hand is in progress
    When all but one player fold
    Then the remaining player wins the pot
    And stacks update
    And the hand completes without requiring a showdown

  Scenario: Hand ends by showdown
    Given two or more players reach showdown
    When the final board is complete
    Then hole cards needed for settlement are revealed per rules
    And the pot is awarded to the winning hand or hands
    And stacks update

  Scenario: All-in is a legal on-screen action
    Given it is a player's turn and they may go all-in
    When they choose All-in
    Then their remaining stack is committed
    And the hand continues to fold-out or to board runout and showdown as required

  Scenario: Side pots settle when all-in stacks require them
    Given more than one player is all-in for unequal amounts
    When the hand reaches settlement
    Then main and side pots are formed as required for correct NLHE settlement
    And each pot is awarded to the eligible winner or winners
    And stacks reflect those awards

  Scenario: My Hand shows the player's private and session context
    Given a player is seated in a hand
    Then My Hand shows their pocket cards, bank, session delta, committed amount,
      hand strength and outs, and the action log for that seat's view

  Scenario: Player row does not use live media
    When seated players are shown in the player row
    Then each seat uses an avatar or initials tile
    And live microphone and camera are not active
    And mic or camera controls are omitted

  Scenario: Stacks remain play chips only
    When players sit and complete hands
    Then stacks and pots are play chips only
