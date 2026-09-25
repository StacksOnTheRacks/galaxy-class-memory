Feature: Anonymous sit and play on dashboard surface
  As a player who opened the table URL
  I want to sit with a display name and play on the dashboard surface
  So that I can finish NLHE hands in play chips without an account

  Scenario: Player sits with a display name and no account
    Given a player has opened the seeded table URL and joined that table
    When they sit at an open seat with a non-empty display name
    Then they are seated with that display name as the seat label
    And they receive a play-chip stack
    And sitting does not create or require a Riffle account

  Scenario: Seated players complete a play-chip NLHE hand on the dashboard table
    Given at least two players are seated at the seeded table
    When they play a no-limit Hold'em hand through deal, betting actions, and streets to fold-out or showdown
    Then the hand completes on the Dashboard Hold'em play surface
    And stacks and pots are play chips only
    And Riffle owns seats, turns, hidden hole cards, and match notify on the existing runtime

  Scenario: Auth, Turnur, embed, and felt art stay out
    When players open the table URL, sit, and complete a hand
    Then they do not use Cognito, login, or account onramp
    And Turnur is not match authority
    And the surface is not an embed or RiffSync attach
    And felt-table artwork is not required to play
