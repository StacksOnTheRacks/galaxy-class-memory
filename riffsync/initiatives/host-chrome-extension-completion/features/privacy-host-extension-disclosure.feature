Feature: Disclose Host Chrome extension on the privacy policy page
  As a visitor and as a Chrome Web Store reviewer
  I want the RiffSync privacy policy to describe the Host extension
  So that the store listing can truthfully link to https://riffsync.tv/privacy

  # Out of this ticket: CWS dashboard (#480); store zip (#478); how-to CTA (#479);
  # extension runtime / manifest / bridge changes.

  Background:
    Given the privacy policy is served at /privacy from PrivacyPolicyPage

  Scenario: Privacy policy discloses Host extension purpose and permissions
    When I open /privacy
    Then I see a Host Chrome extension disclosure
    And it states the single purpose is a host media-tab helper for riffsync.tv parties
    And it states the tabs permission is used for active tab URL/title for party-tab bind and one media tab
    And it states host_permissions are used for HTTPS API calls
    And it states the content script runs on the SPA origin only
    And it states the access JWT is ephemeral and in-memory from the page bridge
    And it states the extension does not hold a refresh token
    And it states the extension does not persist tokens or URLs in chrome.storage
    And the policy does not claim sale of personal information

  Scenario: Privacy disclosure does not claim capture
    When I open /privacy
    Then the Host extension disclosure does not claim the extension captures media
    And capture remains described as a separate browser/page choice where already documented
