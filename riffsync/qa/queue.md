# Ready for QA

# In verification

# Passed back

# Approved

- Open/navigate host media tab without leaving the party tab
  - https://github.com/StacksOnTheRacks/riffsync/issues/428
  - PR: https://github.com/StacksOnTheRacks/riffsync/pull/433
  - `apps/host-extension`
  - QA approved: unit 15/15; #428 static greps clean; ACs met on code/unit evidence. Manual unpacked Chrome not executed (residual, not a blocker).

- Host control panel: load RiffSync catalog library
  - https://github.com/StacksOnTheRacks/riffsync/issues/429
  - PR: https://github.com/StacksOnTheRacks/riffsync/pull/434
  - `apps/host-extension`
  - QA approved: unit 24/24 (0 fail); #429 static greps clean; ACs 1-8 met on code/unit evidence. Manual unpacked Chrome not executed (residual, not a blocker; issue text marks it required for Done).

- Host control panel: change room title (PATCH + media navigate)
  - https://github.com/StacksOnTheRacks/riffsync/issues/430
  - PR: https://github.com/StacksOnTheRacks/riffsync/pull/435
  - `apps/host-extension` + SPA `apps/web/src/hostBridge`
  - QA approved: unit host-extension 45/45; SPA bridge 5/5; #430 static greps clean; ACs met on code/unit evidence. CI web-app + infra-cdk success. Manual unpacked Chrome not executed (residual, not a blocker; issue text marks it required for Done).
