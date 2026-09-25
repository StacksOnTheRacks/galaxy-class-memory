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

  Scenario: Loading copy while resolving a UUID path
    When a player opens a single UUID path segment on the play surface
    Then the page shows title "Loading table…"
    And the page shows message "Opening play link · no actions yet"
    And the player cannot sit or play until join completes

  Scenario: Optional trailing slash on a UUID still joins
    When a player opens /<table-guid>/
    Then the page joins the database-backed table for that GUID

  Scenario: Non-UUID path fails closed
    When a player opens a non-UUID path segment
    Then the runtime does not send join_table
    And the page shows title "Couldn't open this table"
    And the page shows body "This table link is invalid or unavailable. There is no list of other tables."
    And the player cannot sit or play

  Scenario: Extra path segments fail closed
    When a player opens a path with more than one segment
    Then the runtime does not send join_table
    And the page shows title "Couldn't open this table"
    And the player cannot sit or play

  Scenario: Historical play path is not the forward join URL
    When a player opens /play/<anything> on this play surface
    Then the runtime does not send join_table
    And the page shows title "Couldn't open this table"

  Scenario: Table-not-found copy for unknown GUID and bare root
    When a player opens an unknown UUID path or bare /
    Then the runtime does not join them to a table
    And the page shows title "Couldn't open this table"
    And the page shows body "This table link is invalid or unavailable. There is no list of other tables."
    And there is no dedicated empty-path frame

  Scenario: Known UUID joins via existing join_table on the dashboard shell
    When a player opens a known seeded UUID path
    Then the client sends join_table for that id over the existing WebSocket
    And the play surface is the dashboard shell
    And bootstrap-token identity is not required
    And the client does not redeem a bootstrap token
    And the client does not send create_table
