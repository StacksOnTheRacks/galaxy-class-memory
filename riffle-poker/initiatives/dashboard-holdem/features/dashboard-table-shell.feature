Feature: Render dashboard table shell for Desktop, Tablet, and Phone
  As a player
  I want the dashboard play layout from Figma
  So that game surfaces mount in the correct regions

  Scenario: Dashboard regions exist at all breakpoints
    Given the Figma Table / Your Turn frames
    Then the play surface has top bar, player row, My Hand, Board, and Actions regions
