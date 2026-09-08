---
doc: design.structure
schema_version: 1
updated: 2026-09-07
structure_status: fail
structure_gaps:
  - "missing Tokens/Variables page"
  - "missing Components page"
  - "no spacing variables matching spacing/* or space-*"
  - "no radius variables matching radius/*"
  - "no typography variables matching font/*"
  - "missing Text input category"
last_checked: "2026-09-07"
required_pages_found:
  - Brand
  - Screens
required_variable_patterns_missing:
  - spacing
  - radius
  - font
required_component_categories_missing:
  - Text input
---

<!--
Authoring (not validated):
- Frontmatter is source of truth; body is expansion-only.
- Bump updated when any frontmatter field changes. Empty body OK at init.
- structure_status: unverified | pass | fail
- structure_gaps[]: human-readable structural misses (not content/value diffs)
- last_checked: YYYY-MM-DD or ""
- required_pages_found[]: page roles matched (e.g. Brand, Tokens, Components, Screens)
- required_variable_patterns_missing[]: pattern families still missing (e.g. color, spacing)
- required_component_categories_missing[]: categories still missing (e.g. Button, Link)
- Projection from design-structure-check via Figma MCP. Fail on missing structure;
  never fail because two apps use different brand colors.
-->

MCP check 2026-09-07 on bound file vQ6yHQyiGlOnRG7ngIOxR7. Pages present: Screens, Layouts, Brand, Cards, Carousels, Buttons/Links/Tabs/Pills, Icons, Navigation, Chat. Brand and Screens match required page roles. No page name contains Token/Tokens/Variable/Variables or Component/Components/Library. Color-ish variables exist (primary-color, Background, Text); spacing, radius, and font/* families missing. Button and Link categories present; Text input category missing (SearchBox and Chat Input frame do not count). Blocks user-facing ai-ready Ready promotion until remediated in Figma.
