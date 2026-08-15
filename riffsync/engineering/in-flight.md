# Active

- Host control panel: change room title (PATCH + media navigate)
  - https://github.com/StacksOnTheRacks/riffsync/issues/430
  - PR: https://github.com/StacksOnTheRacks/riffsync/pull/435
  - CI web-app: annotate hostJwtBridge test mocks as `() => string | null`

# Approach

- `createDeps()` infers token getters as `() => string`. `mockReturnValue(null)` fails `tsc -b` because `tsconfig.app.json` includes all of `src`.
- Annotate both mocks: `vi.fn<() => string | null>(...)`. No production change.

# Open questions

# Blockers

# Review state
