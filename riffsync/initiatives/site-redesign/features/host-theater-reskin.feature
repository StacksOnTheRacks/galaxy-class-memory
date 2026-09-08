Feature: Host theater reskin to Figma media mode
  As a signed-in host in media mode
  I want the in-room host UI to match Figma host theater frames
  So that hosting feels consistent with the redesigned browse chrome while preserving ADR-001 behavior

  # Out of this ticket: Load Media modal apply behavior (#450), browse/AppShell,
  # Your Parties, channel IA, Solo Live / Solo Watch, Next Up / transport contracts,
  # find/focus, extension capture.

  Background:
    Given Load Media modal behavior is available from the host theater entry point
    And ADR-001 extension bind and host PATCH contracts are unchanged
    And Watch Party Host / Media Mode (19:1900) is the closed visual source

  Scenario: Host theater surfaces match Figma media mode variants
    When a host is in media mode in their room
    Then NavigationSlim, Chatbox, and HostTheaterButtonBar match Watch Party Host / Media Mode (19:1900)
    And broadcast start/stop and Load Media apply remain host-only as today
    And Cast, share copy, and camera/mic keep today's signed-in authority

  Scenario: Load Media sits in the reskinned host button bar
    When a host is in media mode
    Then the reskinned HostTheaterButtonBar includes a Load Media entry
    And choosing it opens the Load Media modal from ticket 450
    And this ticket does not change PATCH, open-path, or catalog-picker behavior

  Scenario: Host option frames stay authority-preserving
    When a host opens broadcast, TV cast, share, or camera/audio from the reskinned bar
    Then those surfaces match the Figma option frames
    And guests cannot apply Load Media or start/stop broadcast

  Scenario: Host with extension sees extension-aligned theater chrome
    Given the host has the Chrome host extension installed and bound to the party tab
    When they are in media mode
    Then the host theater layout matches Watch Party Host with Extension (1053:3252)

  Scenario: Host theater chat adapts on narrow viewports
    When a host uses a viewport below about 768px
    Then chat may collapse to a tab or bottom sheet
    And NavigationSlim and host bar actions stay reachable without horizontal scroll

  Scenario: Reskin does not bypass host security gates
    When the host theater chrome is reskinned
    Then host bridge bind, room PATCH host-gate, and SFU token gates still apply
    And the reskin does not add extension capture

  Scenario: Product metric names stay unchanged
    When the host theater is reskinned
    Then existing GA4 event names and CloudWatch RiffSync/Product route names are unchanged
