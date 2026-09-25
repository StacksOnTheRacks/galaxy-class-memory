Feature: Host dashboard play SPA on CloudFront
  As a player with a table URL
  I want the play SPA served from the default CloudFront hostname
  So that deep-link paths like /<table-guid> load the client without custom DNS

  Background:
    Given the play surface is deployed as a static SPA on S3 behind CloudFront
    And match runtime is API Gateway WebSocket plus Lambda plus DynamoDB already used for Dashboard Hold'em
    And hosting is added on the same MatchRuntimeStack (not a sibling stack)

  Scenario: Player opens a deep-link path on the CloudFront hostname
    When a player opens https://<distribution>.cloudfront.net/<table-guid>
    Then the play surface loads on the default CloudFront hostname
    And the response for that path is the SPA document (not an S3 missing-object error page)

  Scenario: Root path also serves the SPA
    When a player opens https://<distribution>.cloudfront.net/
    Then the SPA document is served

  Scenario: Private S3 origin with CloudFront OAC
    Given the SPA origin is a private S3 bucket
    When the stack defines the public read path
    Then CloudFront reaches the bucket via origin access control
    And the bucket is not publicly listable or writable

  Scenario: SPA fallback uses custom error responses only
    Given a client requests a path that has no matching object at the origin
    When CloudFront receives origin 403 or 404
    Then it returns /index.html with HTTP 200
    And no CloudFront Function is required for that fallback

  Scenario: Dashboard play SPA is the hosted artifact
    When the deploy publishes the origin contents
    Then the artifact includes an index.html entry and the built dashboard play client
    And historical play.html, lab, and identity surfaces are not the play path artifact

  Scenario: Public non-secret runtime config is published
    When the origin is published
    Then GET /config.json is publicly readable
    And the JSON includes webSocketUrl from the existing WebSocket stage
    And the client bundle does not contain AWS credentials

  Scenario: Custom domain and marketing site are not required
    When the play surface is deployed for this initiative
    Then the distribution uses the default CloudFront hostname
    And a custom DNS name is not required
    And a marketing site is not part of the play path

  Scenario: Deploy workflow builds the artifact before cdk deploy
    Given the SPA artifact must exist before CloudFormation syncs the origin
    When the production deploy workflow runs
    Then it builds the dashboard play artifact before cdk deploy
    And it still deploys MatchRuntimeStack with bootstrap qualifier rifflepk and toolkit stack RifflePokerMatchToolkit
    And it does not change the OIDC role, add GitHub secrets, or leave us-east-1
