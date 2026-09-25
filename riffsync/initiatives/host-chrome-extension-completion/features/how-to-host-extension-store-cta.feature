Feature: Wire how-to Host extension section to Chrome Web Store URL
  As a signed-in host on Chrome desktop
  I want the how-to page to link to the Chrome Web Store when configured
  So that I can install the Host extension without developer-mode unpacked load

  # Out of this ticket: store zip packaging (#478); CWS dashboard submit (#480);
  # HostRoomConsole or in-room install CTA; new host-console behavior.

  Background:
    Given the how-to page section id is host-extension on /how-to-host-a-watchparty

  Scenario: How-to page directs hosts to the Chrome Web Store when listing URL is configured
    Given VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL is set for the environment
    When I open /how-to-host-a-watchparty#host-extension
    Then the Install the Host extension section describes installing from the Chrome Web Store
    And the primary Add to Chrome action links to the Chrome Web Store listing URL
    And the link opens in a new tab with rel=noopener noreferrer
    And the steps do not require Developer mode or Load unpacked as the primary path
    And the section does not state that there is no Chrome Web Store listing

  Scenario: How-to page shows preparatory copy before listing URL is configured
    Given VITE_PUBLIC_CHROME_WEB_STORE_EXTENSION_URL is not set for the environment
    When I open /how-to-host-a-watchparty#host-extension
    Then the Install the Host extension section does not link to a broken external store URL
    And the section does not instruct Developer mode or Load unpacked as the primary public install path
    And the section does not claim a Chrome Web Store listing is unavailable when one may be pending
