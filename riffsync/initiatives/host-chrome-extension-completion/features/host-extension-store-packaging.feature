Feature: Package Host extension for Chrome Web Store submission
  As a release operator
  I want a deterministic Chrome Web Store zip and manifest store assets
  So that the existing MV3 Host extension can be uploaded without runtime behavior changes

  # Out of this ticket: how-to page CTA wiring (#479); CWS dashboard submit (#480);
  # new host-console behavior; capture APIs (ADR-001 unchanged).

  Background:
    Given the RiffSync Host Chrome MV3 extension MVP is shipped (GitHub #426-431)
    And ADR-001 forbids tabCapture, desktopCapture, offscreen capture, and Side Panel

  Scenario: Store zip packages production-ready extension files
    When I run the store packaging script under apps/host-extension
    Then a zip artifact is emitted with manifest version in the filename
    And the zip includes manifest, service worker, content script, popup, icons, and config.js
    And test harness files and node_modules are excluded

  Scenario: Manifest includes required store icons and MVP permissions only
    Given the extension package is prepared for Chrome Web Store submission
    When manifest.json permissions and host_permissions are reviewed
    Then icons include 16, 48, and 128 pixel sizes and action.default_icon is set
    And permissions remain limited to tabs plus configured API host_permissions
    And tabCapture, desktopCapture, offscreen, and sidePanel permissions are absent

  Scenario: Public docs treat the Chrome Web Store as the default install path
    Given I read host extension install documentation
    When I follow the public install path from apps/host-extension/README.md
      | or the root README host-extension pointer |
    Then the primary instructions point to the Chrome Web Store listing URL when the listing is live
    And Developer mode and Load unpacked are not the default public install flow
    And any remaining unpacked instructions are clearly labeled internal or developer-only if retained

  Scenario: Extension tests pass on packaged sources
    Given the store zip is built from current extension sources
    When npm test runs under apps/host-extension
    Then all extension unit tests pass
