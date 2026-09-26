Feature: Join and play at /riffle/<table-guid> with no account
  As a player with a shared table URL
  I want to open play at galaxyclass.app/riffle/<table-guid>, sit with a display name, and finish NLHE hands in play chips
  So that I can play on the studio domain without an account, onramp, login, or Amplify session

  Background:
    Given the play SPA is deployed with basePath /riffle
    And exactly one table record exists in the database with a known table GUID
    And there is no lobby and no in-product way to create more tables

  Scenario: Player opens the seeded table at galaxyclass.app/riffle path
    When a player opens https://galaxyclass.app/riffle/<table-guid>
    Then the play surface loads at the galaxyclass.app/riffle subpath
    And the page joins the database-backed table for that GUID
    And the player is not prompted to create an account, sign in, or complete an onramp

  Scenario: Unknown table GUID does not join a table
    When a player opens https://galaxyclass.app/riffle/<unknown-guid>
    Then the runtime does not join them to a table
    And they do not sit or play at a table

  Scenario: Empty riffle path does not join a table
    When a player opens https://galaxyclass.app/riffle/ or https://galaxyclass.app/riffle
    Then the runtime does not join them to a table
    And they do not sit or play at a table

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

  Scenario: No lobby or multi-table discovery
    When a player uses the deployed play surface for this initiative
    Then they do not see a lobby or list of tables to choose from
    And they cannot create another table in-product

  Scenario: WebSocket client cannot create another table
    When a player connects to the deployed WebSocket endpoint from the public play surface
    Then create_table is rejected
    And no additional table is created

  Scenario: Play path does not use Cognito or Amplify
    When a player opens the table URL, sits, and completes a hand
    Then they do not use Cognito, login, or account onramp
    And the Riffle SPA does not read Galaxy Class Amplify session storage
