Feature: Join from table GUID path
  As a player with a shared table URL
  I want to open /<table-guid> on the CloudFront hostname
  So that I join that table or see a clear error without a lobby or login

  Background:
    Given the forward join URL path is /<table-guid> only

  Scenario: Player opens the seeded table on the CloudFront hostname
    When a player opens https://<distribution>.cloudfront.net/<table-guid>
    Then the page joins the database-backed table for that GUID
    And the player is not prompted to create an account, sign in, or complete an onramp

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

  Scenario: Join URL is not the historical play path
    When a player joins the seeded table for play under this initiative
    Then the join path is /<table-guid> on the CloudFront hostname
    And /play/<matchId> is not the forward join URL
    And bootstrap-token identity is not required to open the table
