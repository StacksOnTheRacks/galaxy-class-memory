Feature: Wire how-to Host extension section to Chrome Web Store URL
  As a signed-in host on Chrome desktop
  I want the how-to page to link to the Chrome Web Store when configured
  So that I can install the Host extension without developer-mode unpacked load

  # Out of this ticket: store zip packaging (#478); CWS dashboard submit and setting
  # PROD_CHROME_WEB_STORE_EXTENSION_URL (#480); HostRoomConsole or in-room install CTA;
  # extension runtime/manifest/bridge; new Figma frames.

  Background:
    Given the how-to page section id is host-extension on /how-to-host-a-watchparty

  Scenario: How-to page directs hosts to the Chrome Web Store when listing URL is configured
    Given VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL is set to a valid https Chrome Web Store listing URL
    When I open /how-to-host-a-watchparty#host-extension
    Then the Install the Host extension section describes installing from the Chrome Web Store
    And the primary Add to Chrome action is a real anchor with class gen-button
    And the anchor href equals the configured listing URL
    And the link opens in a new tab with rel=noopener noreferrer
    And the steps do not require Developer mode, Load unpacked, chrome://extensions, or the repo folder as the primary path
    And the section does not state that there is no Chrome Web Store listing
    And the section keeps an accurate PWA note that host UI lives in the page, not a Chrome side panel
    And the section does not conflate extension install with Share Source Tab or getDisplayMedia capture

  Scenario: How-to page shows preparatory copy when listing URL is unset
    Given VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL is not set for the environment
    When I open /how-to-host-a-watchparty#host-extension
    Then the Install the Host extension section does not expose an external store href
    And the section uses neutral preparatory copy that store install is coming
    And the section does not instruct Developer mode or Load unpacked as the primary public install path
    And the section does not claim a Chrome Web Store listing is unavailable

  Scenario: Blank or whitespace listing URL is treated as unset
    Given VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL is blank or whitespace only
    When I open /how-to-host-a-watchparty#host-extension
    Then the Install the Host extension section behaves as when the env is unset
    And no external store href is rendered

  Scenario: Non-Chrome-Web-Store URL is treated as unset
    Given VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL is set to a URL that is not an https host on chromewebstore.google.com or chrome.google.com
    When I open /how-to-host-a-watchparty#host-extension
    Then the Install the Host extension section behaves as when the env is unset
    And no external store href is rendered

  Scenario: host-extension section id is preserved for deep links
    Given I open /how-to-host-a-watchparty#host-extension
    Then an h2 with id host-extension is present
    And deep links to #host-extension still resolve to Install the Host extension

  Scenario: deploy-prod optionally exports the public store URL
    Given the deploy-prod workflow has workflow-level env PROD_CHROME_WEB_STORE_EXTENSION_URL from the GitHub repo variable
    When the SPA build step runs and that variable is non-empty
    Then VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL is exported for the build
    And when the variable is unset or empty the SPA build still succeeds without failing the job
