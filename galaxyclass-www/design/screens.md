---
doc: design.screens
schema_version: 1
updated: 2026-09-26
screens:
  - name: Home /
    figma_node_id: "4:81"
    app: galaxyclass-www
    states:
      - default
      - reduced-motion
    responsive:
      - desktop
  - name: Nav
    figma_node_id: "4:97"
    app: galaxyclass-www
    states:
      - signed-out
      - signed-in
    responsive:
      - desktop
  - name: SignUp /sign-up
    figma_node_id: "4:112"
    app: galaxyclass-www
    states:
      - default
      - validation-error
      - submitting
      - check-email
    responsive:
      - desktop
  - name: SignIn /sign-in
    figma_node_id: "4:190"
    app: galaxyclass-www
    states:
      - default
      - not-authorized
      - unconfirmed-hint
      - submitting
    responsive:
      - desktop
  - name: Confirm /confirm
    figma_node_id: "4:276"
    app: galaxyclass-www
    states:
      - default
      - error
    responsive:
      - desktop
  - name: ForgotPassword /forgot-password
    figma_node_id: "4:310"
    app: galaxyclass-www
    states:
      - request
      - check-email
    responsive:
      - desktop
  - name: ResetPassword /reset-password
    figma_node_id: "4:336"
    app: galaxyclass-www
    states:
      - default
      - validation-error
      - success
    responsive:
      - desktop
  - name: Account /account
    figma_node_id: "4:384"
    app: galaxyclass-www
    states:
      - authenticated
    responsive:
      - desktop
---
