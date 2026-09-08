Feature: Remaining channels and mobile shell adaptations
  As a RiffSync fan
  I want Home, RiffTrax, Live Now, and Community under the new chrome on desktop and mobile
  So that browse IA matches Figma across the remaining destinations

  # Out of this ticket: MST3K pilot, TV Shows/Movies channels (separate tickets), Load Media, host theater reskin.

  Background:
    Given the Figma AppShell and ChannelLayout patterns are proven on prior surfaces

  Scenario: Remaining catalog channels match Figma with Cards and List toggle
    When a visitor opens Home, RiffTrax, or Community channel pages
    Then each page matches the Figma channel layout for that destination
    And they can toggle between Cards view and List view

  Scenario: Live Now channel links to official Live surfaces
    When a visitor opens the Live Now channel
    Then they reach official Live hub content backed by GET /v1/live and /live/{slug}
    And Live Now is not implemented as a catalog enum browse page

  Scenario: Redesign remains usable on mobile viewports
    When a visitor uses a mobile viewport on these destinations
    Then the app shell adapts with a drawer or overlay sidebar pattern
    And channel content remains reachable without horizontal scroll on primary actions
