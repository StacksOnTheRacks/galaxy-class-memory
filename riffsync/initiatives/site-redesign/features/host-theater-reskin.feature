Feature: Host theater reskin to Figma media mode
  As a signed-in host in media mode
  I want the in-room host UI to match Figma host theater frames
  So that hosting feels consistent with the redesigned browse chrome while preserving ADR-001 behavior

  # Out of this ticket: Load Media modal behavior (depends on that ticket), browse/AppShell surfaces, Your Parties.

  Background:
    Given Load Media modal behavior is available from the host theater entry point
    And ADR-001 extension bind and host PATCH contracts are unchanged

  Scenario: Host theater surfaces match Figma media mode variants
    When a host is in media mode in their room
    Then the slim top bar, chat panel, and host button bar match the Figma host theater frames
    And broadcast, TV cast, share, and camera/audio affordances remain host-authoritative as today

  Scenario: Host with extension sees extension-aligned theater chrome
    Given the host has the Chrome host extension installed and bound to the party tab
    When they are in media mode
    Then the host theater layout matches the Figma extension variant frame
