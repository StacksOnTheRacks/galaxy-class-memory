---
doc: design.themes
schema_version: 1
updated: 2026-10-04
themes:
  - app: scribble
    figma_url: ""
    figma_file_key: ""
    status: unbound
    last_audited: ""
---

No Figma file is bound. In-game themes are code data in `packages/scribble/src/themes/` (`default` "Study", `halloween`, `christmas`), each covering board accents (frame, squares, premiums, centre glyph), room backdrop (sky gradient, floor, decorations), and scored-word emphasis (highlight, glow, count text, premium flash, burst). The studio cabinet uses `--c-scribble*` tokens in `packages/www`.
