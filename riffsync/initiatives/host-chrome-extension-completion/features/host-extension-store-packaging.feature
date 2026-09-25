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

  Scenario: Store zip content_scripts matches are production-only
    Given the store zip is built from current extension sources
    When I inspect the packaged manifest.json inside the zip
    Then content_scripts matches are exactly https://riffsync.tv/*
    And http://localhost:5173/* is not present in the packaged manifest
    And the unpacked source manifest may still include localhost for local dev

  Scenario: Manifest version is source of truth for store package
    Given manifest.json version is 0.2.0
    When the store zip is built
    Then the zip filename is riffsync-host-0.2.0.zip
    And apps/host-extension/package.json version is 0.2.0

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
    Then the primary instructions point to the Chrome Web Store as the default install path
    And Developer mode and Load unpacked are not the default public install flow
    And any remaining unpacked instructions are clearly labeled developer or contributor-only in apps/host-extension/README.md
    And the how-to page is out of scope for this ticket (#479)

  Scenario: Extension tests pass on source tree
    Given the store packaging script and icons are added to apps/host-extension
    When npm test runs under apps/host-extension on the source tree
    Then all extension unit tests pass
