Feature: Deploy GalaxyClassSite-prod static hosting stack
  As a visitor to galaxyclass.app
  I want the studio site served from apex with www redirect
  So that deep links and auth routes load reliably on the canonical host

  Background:
    Given the CDK stack name is GalaxyClassSite-prod
    And the public hostname is https://galaxyclass.app
    And Route53 hosted zone Z02927871LCJW2KMZGKOP exists

  Scenario: Apex host serves the static export
    When the site stack is deployed
    Then https://galaxyclass.app/ returns the SPA document
    And the origin is a private S3 bucket behind CloudFront OAC

  Scenario: www host redirects to apex preserving path and query
    When a visitor opens https://www.galaxyclass.app/sign-in?next=/account
    Then the browser receives HTTP 301 to https://galaxyclass.app/sign-in?next=/account

  Scenario: Extensionless export routes resolve to path.html
    When a visitor opens https://galaxyclass.app/sign-in
    Then CloudFront serves the exported sign-in.html object for that route

  Scenario: SPA fallback when no exported object exists
    When a client requests a path with no matching origin object
    Then CloudFront returns /index.html for SPA routing

  Scenario: SPA fallback and security headers are configured
    When the site stack is deployed
    Then baseline security headers include HSTS and CSP for static plus Cognito endpoints

  Scenario: ACM certificate covers apex and www
    When the site stack is deployed
    Then an ACM certificate in us-east-1 covers galaxyclass.app and www.galaxyclass.app
    And Route53 alias records point apex and www to CloudFront
