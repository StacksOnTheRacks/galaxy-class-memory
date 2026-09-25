Feature: Host dashboard play SPA on CloudFront
  As a player with a table URL
  I want the play SPA served from the default CloudFront hostname
  So that deep-link paths like /<table-guid> load the client without custom DNS

  Background:
    Given the play surface is deployed as a static SPA on S3 behind CloudFront
    And match runtime is API Gateway WebSocket plus Lambda plus DynamoDB already used for Dashboard Hold'em

  Scenario: Player opens the seeded table on the CloudFront hostname
    When a player opens https://<distribution>.cloudfront.net/<table-guid>
    Then the play surface loads on the default CloudFront hostname

  Scenario: Custom domain and marketing site are not required
    When the play surface is deployed for this initiative
    Then players reach it on the default CloudFront hostname
    And a custom DNS name is not required
    And a marketing site is not part of the play path
