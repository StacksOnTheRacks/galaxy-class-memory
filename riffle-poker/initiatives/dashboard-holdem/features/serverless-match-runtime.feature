Feature: Host interactive match runtime on API Gateway WebSocket + Lambda + DynamoDB
  As the Riffle platform
  I want cheap serverless match hosting
  So that seated players can play interactively without an always-on server

  Scenario: CDK defines the serverless match stack
    Given the repo contains a CDK app for the match runtime
    When the stack is synthesized
    Then it defines an API Gateway WebSocket API
    And it defines one Lambda wired to $connect, $disconnect, and $default
    And it defines a DynamoDB table for match and connection state
    And it does not require an always-on application server

  Scenario: Client connects and is registered
    Given the WebSocket API and Lambda handler exist
    When a client connects
    Then Lambda records the connection in DynamoDB

  Scenario: Creator is bound and a second client joins by tableId
    Given two connected clients
    When the first client sends create_table
    Then Lambda persists a new table with an unguessable tableId
    And the creator connection is bound to that table
    When the second client sends join_table with that tableId
    Then that connection is bound to the table
    And Lambda conditional-writes a new table version
    And every open connection on that table receives a public table snapshot

  Scenario: Disconnect only drops the connection registry row
    Given a client is connected and bound to a table
    When the client disconnects
    Then Lambda removes that connectionId from the connection registry
    And the table record is left unchanged

  Scenario: CI can synth and ships an OIDC deploy workflow without long-lived AWS keys
    Given the GitHub Actions workflows for this stack
    When CI runs synth
    Then cdk synth succeeds for the match runtime stack
    And a deploy workflow assumes AWS via OIDC
    And the repo does not contain long-lived AWS access keys for deploy

  Scenario: New work does not extend the always-on server
    Given the historical Hono, Turnur, and MatchStore server paths
    When the serverless match runtime is implemented
    Then this ticket's interactive path is WebSocket plus Lambda plus DynamoDB
    And those always-on server paths are not extended
