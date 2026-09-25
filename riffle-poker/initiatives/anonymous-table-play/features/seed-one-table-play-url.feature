Feature: Seed one unguessable table and export PlayUrl
  As an operator
  I want exactly one seeded table with stack outputs for the play URL
  So that players join the known table via https://<distribution>.cloudfront.net/<table-guid>

  Background:
    Given exactly one table record exists in the database with a known table GUID
    And there is no lobby and no in-product way to create more tables

  Scenario: Player opens the seeded table on the CloudFront hostname
    When a player opens https://<distribution>.cloudfront.net/<table-guid>
    Then the page joins the database-backed table for that GUID
