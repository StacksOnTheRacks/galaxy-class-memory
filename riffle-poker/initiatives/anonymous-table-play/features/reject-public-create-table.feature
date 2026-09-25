Feature: Reject public create_table
  As the Riffle platform
  I want the public WebSocket handler to reject create_table
  So that clients cannot mint tables beyond what is seeded out of band

  Scenario: Public WebSocket create_table is rejected
    Given a WebSocket client is connected to the public MatchRuntime $default handler
    When the client sends create_table
    Then the handler responds with type error and code unsupported_action
    And no additional table is created
    And the handler does not post table_created

  Scenario: Tests seed without public create_table success
    Given a unit or integration test needs a table
    When the test prepares that table
    Then it seeds via MatchStore helpers or asserts the create_table reject path
    And it does not rely on the public WebSocket create_table action succeeding
