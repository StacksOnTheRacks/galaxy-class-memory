Feature: Host interactive match runtime on API Gateway WebSocket + Lambda + DynamoDB
  As the Riffle platform
  I want cheap serverless match hosting
  So that seated players can play interactively without an always-on server

  Scenario: Clients connect over WebSocket and receive table updates
    Given the match runtime is deployed via CDK
    When a client connects to the WebSocket API
    Then table updates are delivered over the connection

  Scenario: Match state persists in DynamoDB
    When a match mutation occurs
    Then Lambda persists state to DynamoDB
