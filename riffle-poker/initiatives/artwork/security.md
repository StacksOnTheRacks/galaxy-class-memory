---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-11
summary: "Artwork is static, first-party, served from the Riffle origin. No new secrets, auth surfaces, or Turnur trust-boundary changes. Primary risks are asset supply chain (malicious SVG), licensing (Canva/fonts), CSP compatibility, and iframe load from oversized assets."
threats:
  - "Malicious SVG/script injection via unreviewed Figma or Canva exports committed to the repo"
  - "Third-party font or image license violation from Canva templates or stock assets"
  - "Oversized card/chip/felt assets degrading iframe load time or bundle weight"
  - "Accidental embedding of secrets, PII, or environment hints in exported asset metadata"
  - "External hotlinked artwork introducing supply-chain or tracking risk if used in production"
mitigations:
  - "Review all SVGs before commit — reject script tags, foreignObject, and event handlers"
  - "Strip export metadata from SVG/PNG before commit"
  - "Prefer self-hosted fonts already in the stack; document Canva font choices and licenses"
  - "Size budget per asset class (cards, chips, felt) — LLD enforces max bytes"
  - "Canva kit stored outside the runtime repo; not served by GET /assets/*"
  - "Keep CSP img-src 'self' data:; no user-upload path for artwork"
  - "No external CDN hotlinks for production play-surface art"
requirements:
  - "All runtime artwork MUST be served from the Riffle origin ('self')"
  - "SVG assets committed to the repo MUST be reviewed for script injection before merge"
  - "Production play bundles MUST NOT hotlink external image URLs"
  - "Canva template licenses MUST be documented when the kit is published (initiative OQ or body note)"
  - "Artwork changes MUST NOT alter Turnur SDK handling, bootstrap tokens, seat capabilities, or hidden-view delivery"
  - "No secrets, API keys, or tokens in asset files or export metadata"
open_questions: []
---

<!--
Authoring (not validated):
- Security-owned HLD notes. Required sign-off before HLD → LLD.
- Bump updated when any frontmatter field changes.
-->
