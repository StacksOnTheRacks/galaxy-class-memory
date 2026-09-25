Feature: Anonymous table play
  As a player with a shared table URL
  I want to open the CloudFront play surface, sit at the one seeded table, and finish NLHE hands in play chips
  So that I can play without an account, onramp, login, or custom domain

  # Out of this initiative:
  # - Authentication, Cognito, user onramp, or login chrome
  # - Custom DNS / non-CloudFront hostname
  # - Marketing / public website
  # - Turnur as match backend
  # - Embed-mode / RiffSync / iframe host attach
  # - Multi-table discovery, lobby, or in-product table creation
  # - Felt-table artwork pipeline
  # - Real money, rake, cashier, or KYC
  # - Multi-Hand Session productization beyond completing hands at this table
  # - Re-specifying Dashboard Hold'em felt, HUD, or a second game/ruleset
  # - Historical client path /play/<matchId> or bootstrap-token identity as the join URL

  Background:
    Given the play surface is deployed as a static SPA on S3 behind CloudFront
    And match runtime is API Gateway WebSocket plus Lambda plus DynamoDB already used for Dashboard Hold'em
    And exactly one table record exists in the database with a known table GUID
    And there is no lobby and no in-product way to create more tables
    And the forward join URL path is /<table-guid> only

  Scenario: Player opens the seeded table on the CloudFront hostname
    When a player opens https://<distribution>.cloudfront.net/<table-guid>
    Then the play surface loads on the default CloudFront hostname
    And the page joins the database-backed table for that GUID
    And the player is not prompted to create an account, sign in, or complete an onramp

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

  Scenario: Unknown table GUID does not join a table
    When a player opens https://<distribution>.cloudfront.net/<unknown-guid>
    Then the runtime does not join them to a table
    And they do not sit or play at a table

  Scenario: Hostname with no GUID does not join a table
    When a player opens https://<distribution>.cloudfront.net/
    Then the runtime does not join them to a table
    And they do not sit or play at a table

  Scenario: No lobby or multi-table discovery
    When a player uses the deployed play surface for this initiative
    Then they do not see a lobby or list of tables to choose from
    And they cannot create another table in-product

  Scenario: WebSocket client cannot create another table
    When a player connects to the deployed WebSocket endpoint from the public play surface
    Then create_table is rejected
    And no additional table is created

  Scenario: Join URL is not the historical play path
    When a player joins the seeded table for play under this initiative
    Then the join path is /<table-guid> on the CloudFront hostname
    And /play/<matchId> is not the forward join URL
    And bootstrap-token identity is not required to open the table

  Scenario: Custom domain and marketing site are not required
    When the play surface is deployed for this initiative
    Then players reach it on the default CloudFront hostname
    And a custom DNS name is not required
    And a marketing site is not part of the play path

  Scenario: Auth, Turnur, embed, and felt art stay out
    When players open the table URL, sit, and complete a hand
    Then they do not use Cognito, login, or account onramp
    And Turnur is not match authority
    And the surface is not an embed or RiffSync attach
    And felt-table artwork is not required to play
