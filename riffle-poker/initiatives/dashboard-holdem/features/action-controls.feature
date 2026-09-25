Feature: Ship Fold/Check/Call/Raise controls with raise presets, slider, and phone action sheet
  As the acting player
  I want legal NLHE actions including all-in
  So that I can play from the dashboard or phone action sheet

  Scenario: Acting player facing a bet uses presets and all-in
    Given it is my turn and toCall is greater than zero
    Then Fold is enabled
    And Check is named Check and disabled
    And Call is labeled with the toCall amount and enabled
    And Raise shows raise-to with presets Min, half pot, three-quarter pot, Pot, and All-in on desktop and tablet
    And the slider ranges from minRaiseTo to allInTo
    And committing All-in shows a confirm dialog before submit

  Scenario: Acting player with nothing to call checks or bets
    Given it is my turn and toCall is zero
    Then Check is enabled
    And Call is named Call and disabled
    And Raise is available when minRaiseTo is less than or equal to allInTo

  Scenario: Phone presents an action sheet without Min preset
    Given it is my turn on phone breakpoint
    Then actions render in the Action Sheet with Your turn and optional timer
    And presets are half pot, three-quarter pot, Pot, and All-in with labels only
    And Min preset is not shown

  Scenario: Not your turn leaves actions region empty
    Given it is not my turn
    Then the actions region has no buttons and no action sheet

  Scenario: Disabled control does not submit
    Given a disabled Check or Call or Raise control
    When the player activates it
    Then onSubmit is not called
