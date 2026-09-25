Feature: Extend OIDC deploy role for SPA hosting
  As the Riffle platform
  I want GitHub Actions OIDC to deploy S3 and CloudFront for the play SPA
  So that the anonymous table play surface ships without long-lived AWS keys

  Scenario: Production OIDC execution policy covers S3 and CloudFront deploy
    Given the existing production GitHub OIDC deploy role for the match runtime stack
    When the CloudFormation execution policy is extended for this initiative's S3 and CloudFront resources
    Then CI can deploy the SPA hosting surface via OIDC
    And the role remains least-privilege for this initiative's S3 and CloudFront scope

  Scenario: Long-lived AWS keys are not introduced
    Given the production deploy path uses GitHub Actions OIDC
    When the deploy role is extended for S3 and CloudFront
    Then no long-lived AWS access keys are introduced in CI or the client
    And Environment production does not gain AWS access-key secrets

  Scenario: Runtime deploy scope and least privilege are preserved
    Given the production OIDC role already deploys MatchRuntimeStack runtime resources
    When S3 and CloudFront permissions are added for SPA hosting
    Then existing Lambda DynamoDB logs and API Gateway deploy permissions remain
    And the role is not an account admin role
    And the role still cannot assume the account default CDK bootstrap roles
