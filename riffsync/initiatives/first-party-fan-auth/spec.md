---
doc: product.initiative_spec
schema_version: 1
updated: 2026-09-10
summary: "First-party fan auth on riffsync.tv via Cognito USER_SRP_AUTH (@aws-amplify/auth v6 auth-only recommended); no new Lambdas; tokens and JWT.sub === hostSub unchanged; legacy Hosted UI + /auth/callback retained for soft fallback."
approach: "Primary path: SRP sign-in/sign-up/lifecycle via SDK → setFanTokenBundle() → navigate(returnTo). Legacy path: fanHostedUiPkce.ts + AuthCallbackPage unchanged for bookmarks. Extract refresh + authorization-code exchange from fanHostedUiPkce.ts into fanOAuthToken.ts. Sign-out: clearFanTokens() + optional GlobalSignOut (LLD fork). Migrate in-app CTAs from startFanHostedUiSignIn to navigateToFanAuth()."
interfaces:
  - "Cognito User Pool (fan) — browser → cognito-idp.{region}.amazonaws.com: SignUp, ConfirmSignUp, ResendConfirmationCode, InitiateAuth (USER_SRP_AUTH), RespondToAuthChallenge, ForgotPassword, ConfirmForgotPassword, ChangePassword, optional GlobalSignOut"
  - "Cognito OAuth domain (fan) — https://{prefix}.auth.{region}.amazoncognito.com/oauth2/token refresh_token grant (existing); legacy /oauth2/authorize + /auth/callback PKCE"
  - "fanTokens.ts — setFanTokenBundle / getFanAccessToken / getFanRefreshToken / clearFanTokens; all auth paths must use this boundary"
  - "fanSrpAuth.ts (new) — SDK facade returning normalized { accessToken, expiresIn, refreshToken? } or typed Cognito errors"
  - "fanAuthNavigation.ts (new) — buildFanAuthUrl(route, returnTo), navigateToFanAuth(), popReturnTo() via sessionStorage riffsync.returnTo"
  - "fanCognitoConfig.ts (new) — VITE_COGNITO_USER_POOL_ID, VITE_COGNITO_CLIENT_ID, VITE_COGNITO_REGION"
  - "API Gateway fan JWT authorizer — unchanged; same access token audience/issuer"
  - "Staff auth — /admin/*, staffHostedUiPkce.ts, riffsync.staff* untouched"
structure:
  - "Routes: /auth/sign-in, /auth/sign-up, /auth/verify-email, /auth/forgot-password, /auth/reset-password, /auth/change-password (?returnTo=); /auth/callback legacy only"
  - "Pages: apps/web/src/pages/auth/ — FanSignInPage, FanSignUpPage, FanVerifyEmailPage, FanForgotPasswordPage, FanResetPasswordPage, FanChangePasswordPage; shared FanAuthLayout + field primitives"
  - "Auth modules: apps/web/src/auth/ — fanCognitoConfig.ts, fanSrpAuth.ts, fanAuthNavigation.ts, fanOAuthToken.ts (extract), fanHostedUiPkce.ts (keep legacy), fanTokens.ts, useFanSession.ts, FanSessionKeepAlive.tsx"
  - "CTA migration: ProfileMenu, SiteHeader, AccountPage, YourPartiesPage, RoomPageSidebar, EpisodeTileActions, CatalogSubcategoryPage → navigateToFanAuth()"
  - "Env: VITE_COGNITO_USER_POOL_ID + VITE_COGNITO_REGION (new from FanUserPoolId CFN output); VITE_COGNITO_CLIENT_ID + VITE_COGNITO_HOSTED_UI_DOMAIN (existing)"
  - "CI: deploy-prod.yml + scripts/dev/write-web-env-from-prod.sh emit new Vite vars"
constraints:
  - "No new backend Lambdas for fan auth; browser-only Cognito IdP calls"
  - "Token issuance unchanged — same pool, client, JWT.sub for hostSub"
  - "API Gateway fan authorizers unchanged"
  - "Staff stays on Hosted UI; no fan auth routes under /admin/*"
  - "Not Facebook / federated IdP — COGNITO-only on fan client"
  - "Soft Hosted UI cutover — zero in-app links to *.amazoncognito.com; /auth/callback + OAuth callback URLs remain for legacy"
  - "Single token store — SRP + legacy PKCE both call setFanTokenBundle"
  - "Public SPA client — no client secret; SRP + refresh_token grant only"
  - "New first-party flows MUST use USER_SRP_AUTH; do not use USER_PASSWORD_AUTH for new UI even though pool allows it"
open_questions:
  - "fan-sign-out-revocation"
  - "new-password-required-ux"
---

<!--
Authoring (not validated):
- Architect-owned HLD technical spec under initiatives/<slug>/spec.md.
- Distinct from per-ticket <!-- forge-tech-spec --> comments posted at LLD refinement.
- Bump updated when any frontmatter field changes.
-->

SDK choice: @aws-amplify/auth (v6, auth-only import) recommended; amazon-cognito-identity-js acceptable fallback; raw InitiateAuth SRP rejected. Trust boundary unchanged: Cognito fan JWT for host mutations; anonymous catalog/lobby reads; extension bridge C1 bind on /room/:roomId.
