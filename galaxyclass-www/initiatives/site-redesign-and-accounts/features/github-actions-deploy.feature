Feature: GitHub Actions OIDC deploy workflow
  As the galaxyclass-www maintainers
  I want production deploy from main via GitHub Actions and CDK
  So that the redesigned site and auth config ship without manual artifact upload

  Background:
    Given the workflow file is .github/workflows/deploy.yml
    And deploy uses GitHub OIDC with AWS_DEPLOY_ROLE_ARN
    And Node 22 builds the Next.js static export

  Scenario: Production deploy assumes OIDC role and deploys both stacks
    When the production deploy workflow runs on the main branch
    Then GitHub Actions assumes the OIDC deploy role
    And CDK deploys GalaxyClassAuth-prod and GalaxyClassSite-prod

  Scenario: Build injects Cognito config before static export
    When the workflow builds the site
    Then NEXT_PUBLIC_COGNITO_* are set from stack outputs
    And npm ci and npm run build produce the out/ artifact

  Scenario: Static export is published to CloudFront origin
    When deploy completes successfully
    Then BucketDeployment publishes out/ to the CloudFront origin
    And the site is reachable at https://galaxyclass.app
