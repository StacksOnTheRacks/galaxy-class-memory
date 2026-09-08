Feature: Figma AppShell with nav, search, and profile menu
  As a RiffSync visitor or signed-in host
  I want the shared app shell with collapsible sidebar, global search, and profile menu
  So that browse surfaces can adopt Figma chrome incrementally without a big-bang cutover

  # Out of this ticket: channel pages, Your Parties page content, Load Media, host theater reskin, catalog IA backend.

  Background:
    Given the Figma file https://www.figma.com/design/vQ6yHQyiGlOnRG7ngIOxR7/RiffSync is the visual source
    And product-metrics instrumentation (GA4 / CloudWatch) stays in place

  Scenario: Left nav is fixed, vertical, and collapsible
    When a visitor uses the main navigation
    Then it is fixed on the left and vertical
    And a hamburger control collapses it to an icons-only rail
    And expanded and collapsed states remain keyboard reachable

  Scenario: Top bar search uses a custom dropdown
    When a visitor types in the top-bar search field
    Then matching catalog titles list in a custom dropdown combobox
    And selecting a result navigates to the title or channel destination
    And empty and error states are announced to assistive tech

  Scenario: Top bar profile menu opens Your Parties
    Given the visitor is signed in as a host
    When they open the top bar profile menu
    Then they can navigate to the Your Parties page

  Scenario: App shell adapts on mobile viewports
    When a visitor uses a mobile viewport
    Then the sidebar uses a drawer or overlay pattern
    And primary shell actions remain reachable without horizontal scroll
