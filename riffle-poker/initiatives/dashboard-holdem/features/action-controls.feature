Feature: Ship Fold/Check/Call/Raise controls with raise presets, slider, and phone action sheet
  As the acting player
  I want legal NLHE actions including all-in
  So that I can play from the dashboard or phone action sheet

  Scenario: Acting player uses presets and all-in
    Given it is my turn
    Then I can Fold, Check or Call, and Raise with presets, slider, and All-in when legal
