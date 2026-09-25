Feature: Submit and publish Host extension on Chrome Web Store
  As a release operator
  I want the Host extension published on the Chrome Web Store
  So that hosts can install from the public listing and how-to CTAs resolve in production

  # Out of this ticket: zip script and manifest icons (#478); SPA how-to wiring (#479);
  # automated CWS CI publish; new extension runtime behavior.

  Background:
    Given a Chrome Web Store-ready zip artifact exists from #478
    And the privacy policy URL https://riffsync.tv/privacy is live with Host extension disclosure

  Scenario: Privacy page Host-extension disclosure is live before store submit
    Given the sibling privacy disclosure for the Host extension is deployed (#481)
    And https://riffsync.tv/privacy states single purpose, tabs, host_permissions, SPA-only content script, and ephemeral in-memory access JWT
    When the operator prepares Chrome Web Store submission
    Then the listing Privacy policy field may be set to https://riffsync.tv/privacy
    And submit does not proceed until that disclosure is live

  Scenario: Published listing is installable and extension-present behavior is unchanged
    Given the Host extension is published on the Chrome Web Store
    And I am the signed-in host of a room on /room/:roomId
    When I install the Host extension from the Chrome Web Store listing URL
    And the party page loads and the bridge presence ping succeeds
    Then extensionPresent is true in the host UI
    And I can open or navigate the background media tab without leaving the party tab
    And media-tab open / not-open and play-pause controllability behave as in the shipped MVP
    And share / broadcast still starts from page getDisplayMedia, not from the extension
    And no new host-console controls or Side Panel surface appear because of store packaging

  Scenario: Production how-to CTA resolves after publish
    Given the Chrome Web Store listing is published
    And PROD_CHROME_WEB_STORE_EXTENSION_URL is set in GitHub repo variables
    When the SPA is redeployed to production
    Then /how-to-host-a-watchparty#host-extension shows the Add to Chrome link to the listing
