---
name: build
description: Building & integration patterns. Use when implementing features that involve save contracts, auth patterns, external integrations, webhooks, RBAC, or payment flows.
argument-hint: "[feature-or-integration-name]"
---

# Building & Integration

## When to Use

- Implementing create/edit flows with save contracts
- Choosing auth patterns (session, token, passwordless)
- Integrating external APIs or webhooks
- Building RBAC, entitlements, or payment flows

## Patterns

### Pattern 1: Save Contract

Before building any create/edit flow, define the save contract:

1. **UI States:** idle → saving → saved → error
2. **Server validations:** what gets checked before persisting
3. **Truth rules:** UI never claims success before server confirmation
4. **Optimistic updates:** only for low-risk, reversible actions

**Output:** Save contract section in feature spec or `SAVE-CONTRACT.md`

### Pattern 2: Auth Pattern Decision

Compare approaches for your use case:

| Approach | Best for | Complexity |
|----------|----------|------------|
| Session-based | Traditional web apps | Low |
| JWT tokens | API-first, microservices | Medium |
| Passwordless (magic link) | Consumer apps, low friction | Medium |
| OAuth + session | Apps with social login | High |

Write a decision record (ADR) explaining your choice.

**Output:** `docs/decisions/auth-pattern.md`

### Pattern 3: Protected Routes

For multi-user apps:
- List public vs protected routes
- Centralize auth checks (middleware, not per-route)
- Handle redirects (unauthenticated → login → original destination)
- Never leak resource existence to unauthorized users (404, not 403)

### Pattern 4: Integration Map

For any external integration:

| System | Objects Exchanged | Direction | Owner | Failure Surface |
|--------|-------------------|-----------|-------|-----------------|
| [Provider] | [Data type] | In/Out/Both | Us/Them | [What breaks] |

**Output:** `INTEGRATION-MAP.md`

### Pattern 5: Webhook Receiver

Safe webhook handling:
1. Verify signature (header extraction, timestamp, replay window)
2. Persist before acknowledging (inbox table)
3. Return 200 quickly, process async
4. Handle retries idempotently (idempotency key)
5. Log everything, alert on anomalies

### Pattern 6: Idempotent Handler

For any event/webhook handler:
```
1. Extract idempotency key
2. Check effect record (already processed?)
3. If yes → return cached result
4. If no → process, write effect record, return
5. On failure → mark as retriable or poison
```

### Pattern 7: Session Lifecycle

Define before building auth:
- Expiry duration
- Idle timeout
- Rotation triggers (privilege change, password change)
- Revocation rules
- Device list fields

### Pattern 8: RBAC Model

For multi-user apps:
- 3-5 roles with clear hierarchy
- Permission vocabulary: `action:resource` (e.g., `write:messages`, `admin:rooms`)
- Default role for new users
- Role assignment rules

### Pattern 9: Entitlement Mapping

For SaaS with plans:
- Map provider plan IDs → internal feature flags
- States: active, trial, grace period, revoked
- Upgrade/downgrade rules
- What happens when payment fails

## Checklist

- [ ] Save contract defines all UI states
- [ ] Auth pattern has a decision record
- [ ] Integration map covers failure surfaces
- [ ] Webhook receivers verify signatures
- [ ] Handlers are idempotent
- [ ] RBAC permissions are testable

## Low-Energy Mode

Pick the ONE pattern you need right now. Skip the rest.
