Feature: Host private play-origin S3, deploy /riffle SPA, publish SSM and PlayUrl
  As an operator
  I want MatchRuntimeStack to publish a private S3 play-origin and galaxyclass routing metadata
  So that galaxyclass.app can serve the /riffle SPA from riffle-poker without a riffle-owned prod CloudFront distribution

  Background:
    Given MatchRuntimeStack already includes the match runtime and an existing seeded table id
    And galaxyclass-www GalaxyClassSite-prod will add a /riffle/* behavior reading SSM /galaxyclass/riffle/play-origin-bucket

  Scenario: Private play-origin bucket is OAC-ready and not publicly writable
    When the stack defines the play-origin S3 bucket
    Then the bucket blocks public access
    And the bucket is not publicly listable or writable
    And no new riffle-owned prod CloudFront distribution is created for play

  Scenario: Deploy publishes the dashboard SPA with basePath /riffle
    When riffle-poker production deploy completes successfully
    Then BucketDeployment publishes the dashboard play SPA built with basePath /riffle
    And GET /riffle/config.json includes public webSocketUrl only
    And the production bundle does not import Amplify

  Scenario: Deploy publishes SSM play-origin bucket for galaxyclass routing
    When riffle-poker production deploy completes successfully
    Then SSM parameter /galaxyclass/riffle/play-origin-bucket contains the play-origin S3 bucket name
    And stack output PlayOriginBucketName equals that bucket name

  Scenario: Stack exports galaxyclass PlayUrl without reminting the seeded table
    Given a seeded table id already exists from a prior deploy
    When the stack synthesizes outputs after deploy or update
    Then SeededTableId remains the same value
    And stack output PlayUrl equals https://galaxyclass.app/riffle/<SeededTableId>

  Scenario: Existing Dashboard distribution and root SPA remain
    Given MatchRuntimeStack already hosts the Dashboard CloudFront distribution and root SPA from prior work
    When the stack defines the play-origin bucket and /riffle BucketDeployment
    Then the existing Dashboard CloudFront distribution remains
    And the root SPA deployment and DashboardUrl stay available for the deferred cloudfront.net URL
    And no new Origin Access Control is created in the riffle stack for play

  Scenario: Play-origin object keys keep the riffle prefix
    When BucketDeployment publishes the dashboard play SPA built with basePath /riffle
    Then object keys include riffle/index.html, riffle/config.json, and the main play script under riffle/
    And HTML asset URLs in that artifact are /riffle/... paths
    And root-absolute asset URLs such as /dashboard-play.js are not used in that artifact
