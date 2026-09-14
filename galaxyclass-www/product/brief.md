---
doc: product.brief
schema_version: 2
updated: 2026-09-14
product_name: "Galaxy Class Gaming"
product_description: "Public marketing site for Galaxy Class Gaming — a highly design-focused company website, not a product app. First featured product is Riffle (standalone no-limit Texas Hold'em, play chips; embed-mode for hosts, RiffSync first). Repo: https://github.com/StacksOnTheRacks/galaxyclass-www. Later deployable with AWS CDK (not this init)."
problem: "Galaxy Class Gaming has no public face. People who find the company or Riffle have nowhere to land that communicates the brand, the first product, or how to play or embed. The need is a design-led marketing site, not another play surface."
audience:
  - "Prospective players discovering Galaxy Class Gaming and Riffle"
  - "Hosts evaluating embed-mode (RiffSync first)"
  - "Press, partners, and collaborators looking for brand and product story"
  - "Not for in-product play, real-money operators, or anyone expecting this site to be a game"
goals:
  - "A public, design-led marketing site that is the company face for Galaxy Class Gaming"
  - "Feature Riffle first, with accurate positioning (standalone NLHE play chips; embed-mode for hosts)"
  - "Brand-first visual identity (Figma unbound this run)"
  - "Keep the site structured so it can later deploy with AWS CDK — capability, not this init"
non_goals:
  - "A product app: playable table, accounts, match state, or embed runtime on this site"
  - "CI, live deploy, or an AWS CDK stack this run"
  - "Figma theme bind this run (unbound; no file yet)"
  - "Creating or joining a Forge group"
  - "Product-targeted implement, grooming, or refinement while kind is site"
  - "Real money, rake, cashier, or KYC"
  - "Featuring Turnur or mothballed platforms"
  - "A multi-product catalog, blog, or store as v1"
  - "Board tickets, epics, or role signoffs at init"
success_metrics:
  - metric: "Company landing"
    target: "A design-led public site that names Galaxy Class Gaming and presents Riffle as the first featured product"
  - metric: "Riffle story accuracy"
    target: "Riffle described as standalone NLHE (play chips) with embed-mode for hosts (RiffSync first); Turnur not featured"
  - metric: "Later CDK deployability"
    target: "Site can accept AWS CDK deploy later without a product rewrite — not built or deployed this init"
  - metric: "Quantified traffic"
    target: "TBD (greenfield; no instrumentation or live URL this run)"
current_focus: "Init kind: site — seed brief + design memory only. Figma unbound. No CI, CDK, or live deploy this run. Product-targeted implement/grooming/refinement stop while kind is site; later site-build either stays outside the ticket pipeline or kind flips to app."
---

Host repo [StacksOnTheRacks/galaxyclass-www](https://github.com/StacksOnTheRacks/galaxyclass-www) was empty at init; first featured product is [Riffle](https://github.com/StacksOnTheRacks/riffle-poker) (`riffle-poker`). Turnur is mothballed. Standalone product (no Forge group). While `kind: site`, product-targeted implement / grooming / refinement stop — later site-build stays outside the ticket pipeline or `kind` flips to `app`.
