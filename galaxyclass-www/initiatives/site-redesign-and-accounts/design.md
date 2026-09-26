---
doc: product.initiative_design
schema_version: 1
updated: 2026-09-26
summary: "Code-first redesign on existing dark cinematic theme (void/nebula/gold/stellar/riffle Tailwind tokens). Studio brand distinct from Riffle product green. Auth screens are first-class surfaces matching studio craft. Figma unbound — code is source of truth for this initiative."
figma_file: ""
screens:
  - "Home / — hero, studio pillars, Riffle featured card, games teaser, footer (evolve existing page.tsx sections)"
  - "Nav — signed-out: Sign in + Sign up; signed-in: Account + Sign out"
  - "/sign-up — default, validation-error, submitting, check-email"
  - "/sign-in — default, not-authorized, unconfirmed-hint, submitting"
  - "/confirm — code entry, resend, error"
  - "/forgot-password — request, check-email"
  - "/reset-password — code + new password, validation-error, success"
  - "/account — profile summary (email), sign out; redirect when signed out"
states:
  - "Home — default with motion; reduced-motion static layout"
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

Code-first: no Figma file bound. Replace HostEmbedSection with external Play Riffle CTA. Retain Starfield/Hero glass aesthetic; tighten copy for functional/fun studio positioning over costly art. Auth pages share studio chrome (Nav, dark background, gold/stellar accents) but simplify motion for form clarity.
