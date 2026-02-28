---
name: security-review
description: Security & auth review workflow. Use before launch, when adding auth, handling payments, reviewing dependencies, or doing a security audit.
argument-hint: "[app-name or feature-name]"
---

# Security & Auth Review

## When to Use

- Pre-launch security audit
- Adding or changing authentication
- Integrating payments or handling sensitive data
- Reviewing third-party dependencies
- After a security incident

## Process

### Phase 1: Threat Model

Create a lightweight threat model table:

| Asset | Entry Point | Threat | Minimum Control |
|-------|-------------|--------|-----------------|
| User credentials | Login form | Brute force | Rate limiting + lockout |
| Session tokens | Cookies/headers | Theft/fixation | HttpOnly, Secure, rotation |
| User data | API endpoints | Unauthorized access | Auth middleware + RBAC |
| Payment info | Checkout flow | Interception | HTTPS + provider tokenization |

Keep it to 8-10 rows. Controls must be small-team-friendly (achievable, not theoretical).

**Output:** `THREAT-MODEL.md`

### Phase 2: OWASP Practical Checklist

Map your app to practical OWASP-aligned risks:

1. **Injection** — Parameterized queries, no string concatenation in SQL
2. **Broken Auth** — Session expiry, rotation, no credentials in URLs
3. **Sensitive Data** — HTTPS everywhere, encrypted at rest, minimal collection
4. **XXE/Parsing** — Validate and sanitize all inputs
5. **Access Control** — Deny by default, check at every endpoint
6. **Misconfig** — No debug mode in prod, no default credentials
7. **XSS** — Escape output, CSP headers, no innerHTML with user data
8. **Insecure Deserialization** — Validate shapes (Zod/JSON Schema)
9. **Vulnerable Dependencies** — `npm audit`, pin versions, review before adding
10. **Logging** — Log access attempts, never log secrets

**Output:** Security checklist for your app

### Phase 3: Secrets & Logging Policy

Define what must never be logged:
- Passwords, tokens, API keys
- Credit card numbers, SSNs
- Session IDs, refresh tokens
- Full request bodies with PII

Define secrets management:
- Where secrets are stored (env vars, vault)
- Rotation schedule
- Emergency revocation steps

**Output:** `SECRETS-POLICY.md`

### Phase 4: Auth Rules Extraction

For each endpoint, define authorization:

| Subject | Action | Object | Rule |
|---------|--------|--------|------|
| Authenticated user | create | room | Must be org member |
| Room admin | delete | room | Must be room owner |
| Any user | read | public profile | No auth needed |

Keep it to 12 rules max. Each rule must be testable.

### Phase 5: Dependency Verification

Before adding any dependency (especially AI-suggested):

1. Does the package exist on npm/pypi? (check URL, not just name)
2. Last publish date (>1 year = warning)
3. Weekly downloads (< 1000 = warning)
4. Open issues and maintenance signals
5. License compatibility
6. Are there lighter alternatives?

### Phase 6: Supply Chain Baseline

Minimum supply chain security:
1. Pin dependency versions (no `^` for critical deps)
2. Run `npm audit` in CI
3. Review lockfile changes in PRs
4. Never run `curl | bash` or `npx -y unknown-package`
5. Keep SBOM updated

## Session Security Checklist

- [ ] Sessions expire after inactivity (e.g., 30 min idle)
- [ ] Sessions rotate on privilege change
- [ ] Cookies: HttpOnly, Secure, SameSite=Lax/Strict
- [ ] No session data in URLs
- [ ] Bulk revocation possible (for incident response)
- [ ] Device list shows active sessions

## No Foot Guns Contract

Invariants that must always be true:

1. Unauthenticated requests cannot access protected resources
2. Users cannot access other users' data
3. Role changes take effect immediately
4. Deleted sessions cannot be reused
5. Failed auth attempts are rate-limited
6. Password reset invalidates existing sessions
7. API errors never leak internal details to clients
8. No admin endpoints accessible without admin role

## Checklist

- [ ] Threat model covers top assets and entry points
- [ ] OWASP checklist applied to this app
- [ ] Secrets policy defined (what to log, what never to log)
- [ ] Auth rules extracted and testable
- [ ] Dependencies audited
- [ ] Session security reviewed

## Low-Energy Mode

Do Phase 1 (threat model) only. 8 rows. That's enough to identify the biggest risks.
