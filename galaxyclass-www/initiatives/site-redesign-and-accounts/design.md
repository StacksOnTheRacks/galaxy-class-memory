---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-26
summary: "Figma SoT for studio screens on dark cinematic theme (void/nebula/gold/stellar). Studio brand distinct from Riffle product green. Auth screens are first-class surfaces matching studio craft. Play Riffle CTA navigates to /riffle on galaxyclass.app (same domain, separate deploy)."
figma_file: "https://www.figma.com/design/0ByUrA0pS5qXyzcUsDstby/Galaxy-Class-Web"
screens:
  - "Home / — figma node 4:81 (default 4:81, reduced-motion 4:396)"
  - "Nav — figma node 4:97 (signed-out 4:97, signed-in 4:105)"
  - "/sign-up — figma node 4:112 (default, validation-error 4:133, submitting 4:156, check-email 4:177)"
  - "/sign-in — figma node 4:190 (default, not-authorized 4:212, unconfirmed-hint 4:234, submitting 4:255)"
  - "/confirm — figma node 4:276 (default, error 4:293)"
  - "/forgot-password — figma node 4:310 (request, check-email 4:326)"
  - "/reset-password — figma node 4:336 (default, validation-error 4:355, success 4:372)"
  - "/account — figma node 4:384 (authenticated profile)"
states:
  - "Home — default with motion; reduced-motion static layout (4:396)"
  - "Auth routes — loading, default, validation-error, submitting, success, error per step"
  - "Nav — signed-out vs signed-in session states"
  - "Account — authenticated profile vs redirect-to-sign-in"
a11y:
  - "Visible focus rings on all interactive controls"
  - "Explicit labels on every form field; errors linked via aria-describedby"
  - "Do not rely on color alone for errors or CTAs"
  - "Keyboard-complete sign-up, sign-in, confirm, and reset flows"
  - "Honor prefers-reduced-motion; navigation and auth work without animation"
open_questions: []
---

Bound to Galaxy-Class-Web (`0ByUrA0pS5qXyzcUsDstby`). Replace HostEmbedSection with Play Riffle CTA linking to /riffle (same-domain navigation, not external hostname or iframe). Riffle table UI is riffle-poker owned at /riffle/* — studio home does not embed gameplay. Retain Starfield/Hero glass aesthetic; tighten copy for functional/fun studio positioning over costly art. Auth pages share studio chrome (Nav, dark background, gold/stellar accents) but simplify motion for form clarity.
