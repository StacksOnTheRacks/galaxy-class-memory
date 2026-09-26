Feature: GitHub Actions OIDC deploy workflow
  As the galaxyclass-www maintainers
  I want production deploy from main via GitHub Actions and CDK
  So that the redesigned site and auth config ship without manual artifact upload

  Background:
    Given the workflow file is .github/workflows/deploy.yml
    And the workflow triggers on push to main and on workflow_dispatch
    And the job uses environment production with permissions id-token write and contents read
    And AWS credentials come from GitHub OIDC via aws-actions/configure-aws-credentials@v4
    And there are no long-lived AWS keys in the workflow
    And the CDK app lives under infra/cdk
    And the region is us-east-1
    And the canonical host is https://galaxyclass.app

  Scenario: Fail closed when the deploy role is missing
    Given vars.AWS_DEPLOY_ROLE_ARN is empty for environment production
    When the production deploy workflow starts
    Then the job fails before assuming a role or deploying

  Scenario: Production deploy assumes OIDC then deploys auth then builds then deploys site
    When the production deploy workflow runs on the main branch
    Then it assumes the OIDC deploy role using vars.AWS_DEPLOY_ROLE_ARN and vars.AWS_REGION defaulting to us-east-1
    And it runs npm ci in infra/cdk
    And it cdk deploys GalaxyClassAuth-prod with --require-approval never --toolkit-stack-name GalaxyClassToolkit and --context @aws-cdk/core:bootstrapQualifier=galcls
    And it captures auth stack outputs and maps UserPoolId to NEXT_PUBLIC_COGNITO_USER_POOL_ID UserPoolClientId to NEXT_PUBLIC_COGNITO_USER_POOL_CLIENT_ID and Region to NEXT_PUBLIC_COGNITO_REGION
    And it fails the job if any of those three values is empty
    And root npm ci and npm run build with Node 22 produce out/ using those public Cognito env values
    And it cdk deploys GalaxyClassSite-prod with the same approval toolkit and bootstrap flags so BucketDeployment publishes out/ and invalidates CloudFront

  Scenario: Offline contract test proves the workflow shape
    When an engineer runs node --test test/deploy-workflow.contract.test.mjs with no AWS credentials
    Then the test reads .github/workflows/deploy.yml and asserts triggers permissions environment fail-closed empty role OIDC action deploy order locked CDK flags the three env names empty-output failure Node 22 missing out/index.html failure bounded apex check and absence of long-lived AWS keys and pull_request

  Scenario: Successful production run proves the apex is reachable
    When deploy completes successfully on main after sibling stacks and OIDC wiring exist
    Then a post-deploy check in the workflow confirms https://galaxyclass.app is reachable with up to 12 retries 10 seconds apart
