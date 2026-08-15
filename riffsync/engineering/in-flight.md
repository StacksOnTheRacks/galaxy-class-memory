# Active

- Host control panel: change room title (PATCH + media navigate)
  - https://github.com/StacksOnTheRacks/riffsync/issues/430

# Approach

- Consume #428 C1 bind + media-tab helpers and #429 library selection
- Add SPA↔extension JWT bridge (content script + `apps/web` listener)
- PATCH `{ catalogEpisodeId }` then navigate media tab with `active: false`

# Open questions

# Blockers

# Review state
