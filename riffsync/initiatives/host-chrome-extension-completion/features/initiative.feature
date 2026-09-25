Feature: Host Chrome Extension Completion
  As a signed-in host on Chrome desktop
  I want to install the RiffSync Host extension from the Chrome Web Store
  So that I can use background media-tab helpers without developer-mode unpacked load

  # Out of this initiative:
  # - New host console behavior or new host control surfaces
  # - In-room Install Host Extension CTA (host-bar-room-control #473 removed Room panel)
  # - Extension media capture, tabCapture, desktopCapture, offscreen capture, or host_screen supply (ADR-001 unchanged)
  # - Firefox, Safari, mobile Chrome, or non-Chromium browsers
  # - Chrome Side Panel UI or sidePanel permission
  # - Discord app, Watch Party Game Mode, or other roadmap items
  # - Board tickets (created later in LLD grooming)
  # - Replacing page getDisplayMedia as the share / capture source of truth

  Background:
    Given the RiffSync Host Chrome MV3 extension MVP is shipped (GitHub #426-431)
    And the extension binds the party tab on /room/:roomId (C1)
    And the extension opens or navigates a background media tab without capture APIs
    And page getDisplayMedia remains the sole share / capture source of truth (ADR-001)

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

  Scenario: Public docs treat the Chrome Web Store as the default install path
    Given I read host extension install documentation
    When I follow the public install path from apps/host-extension/README.md
      | or the root README host-extension pointer |
      | or /how-to-host-a-watchparty#host-extension |
    Then the primary instructions point to the Chrome Web Store listing URL when the listing is live
    And Developer mode and Load unpacked are not the default public install flow
    And any remaining unpacked instructions are clearly labeled internal or developer-only if retained

  Scenario: Extension-present behavior is unchanged after store packaging
    Given I am the signed-in host of a room on /room/:roomId
    And I installed the Host extension from the Chrome Web Store listing URL
    When the party page loads and the bridge presence ping succeeds
    Then extensionPresent is true in the host UI
    And I can open or navigate the background media tab without leaving the party tab
    And media-tab open / not-open and play-pause controllability behave as in the shipped MVP
    And share / broadcast still starts from page getDisplayMedia, not from the extension
    And no new host-console controls or Side Panel surface appear because of store packaging

  Scenario: Store packaging and listing do not add capture permissions
    Given the extension package is prepared for Chrome Web Store submission
    When manifest.json permissions and host_permissions are reviewed
    Then permissions remain limited to the MVP set (tabs plus configured API host_permissions)
    And tabCapture, desktopCapture, offscreen, sidePanel, and other capture-related permissions are absent
    And the published listing description does not claim extension-based screen or tab capture
    And npm test --prefix apps/host-extension continues to pass on the packaged sources
