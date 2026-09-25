Feature: Show My Hand pocket, bank, session delta, committed, strength, outs, and action log
  As the local player
  I want private and session context in My Hand
  So that I can decide my actions

  Scenario: My Hand mounts in the dashboard region
    Given the dashboard table shell is rendered
    Then My Hand content renders inside data-region="my-hand"

  Scenario: Pocket faces are local seat only
    Given I am seated with two hole cards supplied
    Then My Hand shows two pocket faces for my seat
    And My Hand never shows another seat's ranks or suits

  Scenario: Your bank shows a play-chip amount
    Given a bank amount is supplied for my seat
    Then My Hand shows Your bank with a grouped amount and a leading $

  Scenario: Desktop and tablet show session delta and committed
    Given the dashboard breakpoint is desktop or tablet
    And session delta and committed amounts are supplied
    Then My Hand shows a signed session amount with this session
    And My Hand shows an amount with committed this hand

  Scenario: Phone omits session delta, committed, and action log
    Given the dashboard breakpoint is phone
    Then My Hand shows pocket faces, Your bank, made-hand name, meter, tier, and outs phrase
    And My Hand has no session delta, no committed amount, and no action log

  Scenario: Hand strength text is primary and meter is supplementary
    Given hand strength and outs are supplied
    Then My Hand shows the made-hand name and a strength-tier word or badge
    And Desktop and Tablet also show a Hand strength label
    And a 10-segment meter from High card to Royal flush is present as a supplementary visual
    And an outs phrase including N outs is shown

  Scenario: Desktop and tablet action log is current street only
    Given the dashboard breakpoint is desktop or tablet
    And the current street is Turn with public action rows supplied
    Then My Hand shows an action log headed Turn action
    And each row shows display name and public action text
    And the log does not include earlier streets

  Scenario: Names and action text are escaped
    Given a display name or action text containing HTML markup
    Then My Hand shows that text as escaped text, not injected markup
