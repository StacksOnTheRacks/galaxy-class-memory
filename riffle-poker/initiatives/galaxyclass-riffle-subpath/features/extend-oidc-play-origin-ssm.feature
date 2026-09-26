Feature: Extend OIDC deploy role for play-origin S3 and SSM
  As the Riffle platform
  I want GitHub Actions OIDC to deploy the play-origin bucket and publish the galaxyclass routing SSM parameter
  So that the /riffle SPA ships without long-lived AWS keys or over-broad SSM write

  Scenario: Production OIDC execution policy covers play-origin S3 deploy
    Given the existing production GitHub OIDC deploy role for MatchRuntimeStack
    When the execution policy is extended for the play-origin S3 bucket used by the /riffle SPA
    Then CI can deploy objects to that bucket via OIDC
    And the role is not an account admin role

  Scenario: OIDC can write only the galaxyclass play-origin SSM parameter
    Given the production deploy path uses GitHub Actions OIDC
    When SSM permissions are added for this initiative
    Then ssm:PutParameter is allowed only for /galaxyclass/riffle/play-origin-bucket
    And no long-lived AWS access keys are introduced

  Scenario: OIDC is not granted a new prod CloudFront distribution for play
    Given prod play is served at galaxyclass.app/riffle via galaxyclass CloudFront
    When the deploy role is extended for play-origin S3 and scoped SSM
    Then the role is not granted creation of a new riffle-owned prod CloudFront distribution for this initiative
