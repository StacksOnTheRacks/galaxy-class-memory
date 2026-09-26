Feature: Configure GitHub OIDC deploy role for galaxyclass-www
  As the Galaxy Class studio platform
  I want GitHub Actions OIDC to deploy CDK stacks and static assets
  So that production deploys without long-lived AWS keys

  Scenario: Production OIDC trust covers galaxyclass-www repository
    Given the GitHub repository is StacksOnTheRacks/galaxyclass-www
    When the OIDC deploy role is configured for Environment production
    Then GitHub Actions can assume the role via OIDC
    And AWS_DEPLOY_ROLE_ARN is available as an Environment variable

  Scenario: Least-privilege policy covers CDK and static deploy
    Given the role must deploy GalaxyClassAuth-prod and GalaxyClassSite-prod
    When IAM permissions are applied
    Then CloudFormation can manage Cognito S3 CloudFront Route53 and ACM for this app
    And the role is not an account admin role

  Scenario: Long-lived AWS keys are not introduced
    Given the production deploy path uses GitHub Actions OIDC
    When the deploy role is configured
    Then no long-lived AWS access keys are introduced in CI or the client
    And Environment production does not gain AWS access-key secrets
