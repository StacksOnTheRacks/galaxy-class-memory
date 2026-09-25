Feature: Reject public create_table
  As the Riffle platform
  I want the public WebSocket handler to reject create_table
  So that exactly one seeded table remains and clients cannot mint more

  Scenario: WebSocket client cannot create another table
    When a player connects to the deployed WebSocket endpoint from the public play surface
    Then create_table is rejected
    And no additional table is created

  Scenario: No lobby or multi-table discovery
    When a player uses the deployed play surface for this initiative
    Then they do not see a lobby or list of tables to choose from
    And they cannot create another table in-product
