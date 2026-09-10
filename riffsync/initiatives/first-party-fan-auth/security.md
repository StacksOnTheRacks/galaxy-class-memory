---
doc: product.initiative_security
schema_version: 1
updated: 2026-09-11
summary: "HLD security for first-party fan auth on riffsync.tv. Primary new risk: credential entry on SPA origin (XSS). No new server trust boundary; same fan pool, public client, JWT.sub === hostSub, extension access-only bridge."
threats:
  - "Credential theft via SPA XSS — passwords, reset codes, and change-password inputs on riffsync.tv readable by injected script; complements existing localStorage JWT theft (riffsync.fan* keys)"
  - "Password-over-the-wire if SRP skipped — ALLOW_USER_PASSWORD_AUTH enabled on fan client; cleartext password posts increase interception vs SRP"
  - "Client secret or AWS creds in bundle — violates build_packaging.md; enables offline pool abuse"
  - "Credential stuffing / enumeration on first-party forms — browser-direct InitiateAuth/SignUp/ForgotPassword bypass RiffSync API throttling"
  - "OAuth CSRF / session fixation on fallback and callback — soft Hosted UI keeps /auth/callback PKCE; weak state handling could allow code injection"
  - "Open redirect via returnTo / post-auth navigation — sign-in resume paths could become phishing vectors if not same-origin relative paths only"
  - "Email verification link abuse — Cognito verification URLs replayed, shared, or crafted with wrong redirect targets"
  - "Password-reset code leakage — reset codes in URL query strings leak via Referer, history, analytics, server logs"
  - "Soft fallback attack surface — dual entry (first-party + *.amazoncognito.com) expands phishing templates and OAuth redirect_uri confusion"
  - "Extension bridge token exfiltration — hostJwtBridge relays access JWT via postMessage; first-party auth must not expose refresh to bridge"
  - "Account lifecycle edge cases — unverified signup, expired reset codes, concurrent sessions leave stale tokens in localStorage"
mitigations:
  - "Prefer Cognito SRP (USER_SRP_AUTH) in SPA via official SDK; do not add BFF that accepts passwords; do not use USER_PASSWORD_AUTH for new first-party flows"
  - "Public client only in bundle — VITE_COGNITO_CLIENT_ID + pool/region metadata; no client secret, no IAM keys"
  - "Treat auth pages as high-trust UI — no innerHTML/eval on auth surfaces; bind errors via textContent; CSP-aligned script/style origins"
  - "Preserve token storage contract — access + refresh in fanTokens.ts; extension and bridge access-only; refresh stays out of extension"
  - "Harden post-auth redirect — allowlist relative paths for returnTo; reject //, javascript:, off-origin URLs; clear PKCE verifier and OAuth state after exchange"
  - "PKCE + state on Hosted UI fallback only — keep completeFanAuthCallback state checks; code-only callback is fallback/password-reset only"
  - "Reset and verify UX: prefer code entry on first-party pages; strip codes from URL after read (history.replaceState)"
  - "Rely on Cognito pool lockout + monitoring; emit auth-failure product metrics without logging credentials, codes, or tokens"
  - "Soft fallback containment — primary CTAs route to first-party routes only; same client_id and redirect allowlist"
  - "No change to API authorizers — fan JWT verification on HTTP/WS unchanged; staff pool isolation unchanged"
requirements:
  - "First-party fan auth MUST use the existing public fan Cognito app client (no client secret) and MUST NOT embed AWS credentials or pool admin keys in the SPA bundle"
  - "Sign-in MUST use USER_SRP_AUTH (SRP); MUST NOT send cleartext passwords to RiffSync HTTP APIs or new Lambdas for fan login"
  - "Sign-up, confirm sign-up, forgot password, confirm forgot password, and change password MUST call Cognito user-pool APIs directly from the browser (or equivalent client SDK)"
  - "Token issuance shape MUST remain unchanged: same access JWT claims (sub for hostSub), same refresh token handling in riffsync.fan* localStorage keys"
  - "Refresh tokens MUST NOT be exposed via hostJwtBridge, extension messages, GA4, console logs, or error reporting"
  - "Post-auth redirect / resume paths MUST be same-origin relative paths only; MUST reject external URLs and protocol-relative paths"
  - "OAuth Hosted UI fallback MUST retain PKCE (S256) + state for authorization-code sign-in"
  - "Email verification and password-reset flows MUST NOT log or persist verification/reset codes; MUST minimize code presence in URL query strings"
  - "Auth UI MUST render untrusted strings via safe DOM APIs (textContent / React text nodes)"
  - "Soft Hosted UI fallback MUST use the same allowlisted redirect/sign-out URLs as today; MUST NOT add wildcard redirect targets"
  - "Staff auth (/admin/*, staff pool, staff Hosted UI) MUST remain untouched; fan and staff token namespaces MUST stay separate"
  - "Implementation MUST NOT weaken existing checklist release gates: extension C1 bind, room PATCH authority, ADR-001 no-capture"
  - "LLD tickets MUST slice forge-tech-spec AC from this doc at refinement"
open_questions:
  - "srp-only-enforcement"
  - "verification-email-template-urls"
  - "cognito-advanced-security"
  - "reset-code-in-url"
---

<!--
Authoring (not validated):
- Security-owned HLD notes. Required sign-off before HLD → LLD.
- Bump updated when any frontmatter field changes.
-->

HLD security for first-party-fan-auth. Residual: compromised fan JWT still mutates only that fan's hosted rooms (accepted MVP model). LLD tickets must carry sliced security AC from this doc in forge-tech-spec comments at refinement.
