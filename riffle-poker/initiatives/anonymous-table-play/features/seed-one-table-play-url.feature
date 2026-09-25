Feature: Seed one unguessable table and export PlayUrl
  As an operator
  I want exactly one seeded table with stable stack outputs for the play URL
  So that I can form and share https://<distribution>.cloudfront.net/<table-guid> without reminting on every deploy

  Background:
    Given MatchRuntimeStack includes the match DynamoDB table and a CloudFront distribution domain
    And table seeding is out-of-band at deploy time (CDK custom resource or equivalent)

  Scenario: First deploy mints exactly one unguessable table id
    When the stack is created or the seed resource first runs
    Then exactly one table record is written
    And its id is a UUID or equivalent cryptographically unguessable random id
    And the id is not sequential, short, or guessable

  Scenario: Stack update does not remint the seeded table id
    Given a seeded table id already exists from a prior deploy
    When the stack is updated
    Then the seed does not mint a new table id
    And it does not create an additional seeded table
    And SeededTableId remains the same value

  Scenario: Stack exports SeededTableId and PlayUrl
    Given the seeded table id and the stack CloudFront distribution domain
    When the stack synthesizes outputs
    Then SeededTableId equals the seeded table id
    And PlayUrl equals https://{distributionDomain}/{tableId}
    And PlayUrl uses the default CloudFront hostname only (no custom domain)

  Scenario: Seed is not a public-client create path
    When this ticket’s seed path runs
    Then it is deploy-time and out-of-band
    And it does not add a lobby, table list, or in-product create-table surface
