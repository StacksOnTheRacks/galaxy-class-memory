Feature: Deploy GalaxyClassSite-prod static hosting stack
  As a visitor to galaxyclass.app
  I want the studio site served from apex with www redirect
  So that deep links and auth routes load reliably on the canonical host

  Background:
    Given the CDK stack name is GalaxyClassSite-prod
    And the public hostname is https://galaxyclass.app
    And Route53 hosted zone Z02927871LCJW2KMZGKOP exists
    And Riffle play is served under /riffle from a separate private origin
    And the Riffle origin bucket name comes from SSM /galaxyclass/riffle/play-origin-bucket

  Scenario: Apex host serves the static export
    When the site stack is deployed
    Then https://galaxyclass.app/ returns the SPA document
    And the origin is a private S3 bucket behind CloudFront OAC

  Scenario: www host redirects to apex preserving path and query
    When a visitor opens https://www.galaxyclass.app/sign-in?next=/account
    Then the browser receives HTTP 301 to https://galaxyclass.app/sign-in?next=/account

  Scenario: www host redirects Riffle paths to apex preserving path and query
    When a visitor opens https://www.galaxyclass.app/riffle/<guid>?x=1
    Then the browser receives HTTP 301 to https://galaxyclass.app/riffle/<guid>?x=1

  Scenario: CloudFront default hostname is not redirected
    When a visitor opens the distribution on a *.cloudfront.net hostname
    Then the request is not redirected to galaxyclass.app

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

  Scenario: /riffle paths route to the Riffle origin via SSM
    When the site stack is synthesized
    Then CloudFront behaviors for exact /riffle and /riffle/* use a private Riffle S3 origin
    And the origin bucket name is read from SSM parameter /galaxyclass/riffle/play-origin-bucket

  Scenario: Extensionless /riffle routes serve Riffle index not studio fallback
    When a visitor opens https://galaxyclass.app/riffle/<table-guid>
    Then the Riffle document /riffle/index.html is served
    And the response is not the studio /index.html fallback

  Scenario: /riffle and /riffle/ serve the Riffle SPA document
    When a visitor opens https://galaxyclass.app/riffle or https://galaxyclass.app/riffle/
    Then the Riffle document /riffle/index.html is served

  Scenario: Riffle assets with extensions pass through
    When a visitor opens https://galaxyclass.app/riffle/config.json or /riffle/assets/app.js
    Then the request passes through to the Riffle origin without rewrite to index.html

  Scenario: Riffle object key prefix is preserved
    When CloudFront fetches an object for a /riffle path
    Then the /riffle prefix is not stripped at the Riffle origin

  Scenario: Separate CSP for studio and /riffle
    When the site stack is deployed
    Then studio responses include a CSP that may allow Cognito connect-src
    And /riffle responses include a CSP that allows WebSocket connect-src and does not include Cognito hosts
