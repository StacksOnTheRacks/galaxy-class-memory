---
doc: product.open_questions
schema_version: 1
updated: 2026-09-25
questions:
  - id: store-zip-localhost-matches
    question: "Should the store zip strip localhost:5173 from content_scripts matches, leaving only https://riffsync.tv/* for the published package?"
    blocking: false
    status: open
    owner: architect
  - id: extension-version-source-of-truth
    question: "Reconcile manifest version 0.2.0 vs package.json 0.1.0 — which is SoT for store releases and zip filenames?"
    blocking: false
    status: open
    owner: architect
  - id: contributor-unpacked-fallback
    question: "Keep Load unpacked instructions only in apps/host-extension/README.md, or add a collapsed for-developers note on the how-to page?"
    blocking: false
    status: open
    owner: product
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
