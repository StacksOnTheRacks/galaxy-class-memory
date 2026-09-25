---
doc: product.open_questions
schema_version: 1
updated: 2026-09-25
questions:
  - id: privacy-policy-extension-section
    question: "Does https://riffsync.tv/privacy need an extension-specific paragraph for Chrome Web Store disclosure (tabs permission, ephemeral JWT relay)?"
    blocking: false
    status: open
    owner: security
  - id: developer-account-custody
    question: "Named owner and 2FA backup access for the Chrome Web Store developer account used to publish RiffSync Host."
    blocking: false
    status: open
    owner: release
---

<!--
Authoring (not validated):
- questions: [{ id, question, blocking, status, owner }]
- status: open | answered | deferred
- Remove answered items; defer with status deferred rather than deleting if still relevant.
- Bump updated when any frontmatter field changes.
-->

Resolved at HLD design (2026-09-25): cta-surface-post-room-panel (how-to only; no in-room CTA), store-listing-readiness (env-gated CTAs), cta-target-store-vs-docs (how-to page owns store link when env set).

Resolved at #478 refinement (2026-09-25): store-zip-localhost-matches (store zip matches https://riffsync.tv/* only; source may keep localhost), extension-version-source-of-truth (manifest.json 0.2.0 is SoT; package.json reconciled), contributor-unpacked-fallback (Load unpacked developer-only in apps/host-extension/README.md; no how-to collapsed note).
