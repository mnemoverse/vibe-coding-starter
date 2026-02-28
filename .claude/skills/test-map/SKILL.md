---
name: test-map
description: Testing strategy and test map creation. Use when writing tests, designing test coverage, diagnosing flaky tests, or building test suites for specific domains (auth, payments, data).
argument-hint: "[feature-or-component-name]"
---

# Testing Strategy

## When to Use

- Starting test coverage for a feature
- Need a test map (must-never-break behaviors)
- Writing integration or property-based tests
- Diagnosing flaky tests
- Building domain-specific test suites (auth, payments, data)

## Process

### Phase 1: Test Map (Must-Never-Break)

List 10-12 behaviors that must never break. Each statement:
- Is testable (not vague)
- Is written from user or system promise perspective
- Survives refactoring (tests intent, not implementation)

**Example:**
```
1. Authenticated users can create rooms
2. Room names must be unique per organization
3. Deleted messages disappear for all participants within 2 seconds
4. Payment failure does not grant access
```

**Output:** `TEST-MAP.md`

### Phase 2: Test Pyramid

Decide coverage per layer:

| Layer | What to test | Tools |
|-------|-------------|-------|
| Unit | Pure functions, utils, transforms | Vitest/Jest |
| Integration | API routes, DB queries, webhooks | Vitest + test DB |
| E2E | Critical user flows (login → action → verify) | Playwright/Cypress |

**Rule:** Most tests at unit level. Integration for boundaries. E2E for critical paths only.

### Phase 3: Write Tests

For each test map item:

1. Write the test name (describes the promise)
2. Write the assertion first (what must be true)
3. Build the setup backward from the assertion
4. Include at least one negative case per feature

**Intent-based test pattern:**
```typescript
// Test name = promise
it('should not grant access when payment fails', async () => {
  // Given: user with failed payment
  // When: checking entitlements
  // Then: access denied
  expect(entitlements.hasAccess('premium')).toBe(false)
})
```

### Phase 4: Smoke Tests

Post-deploy checklist (5-7 items):
- Auth flow works (login → get token)
- Core CRUD operations succeed
- At least one integration point responds
- No console errors on main pages
- Health endpoint returns 200

### Phase 5: Domain-Specific Suites

**Auth tests (if applicable):**
- Login, logout, token refresh
- Session expiry and rotation
- Role-based access (at least 3 roles)
- Lockout after failed attempts

**Payment tests (if applicable):**
- Successful payment → access granted
- Failed payment → no access
- Duplicate webhook → idempotent
- Refund → access revoked
- Out-of-order events handled

**Data tests (if applicable):**
- Ingestion boundary: schema validation
- Transform boundary: expected output shape
- Truth surface: metrics match source data

## Diagnosing Flaky Tests

When a test is flaky:
1. **Identify nondeterminism source:** timing, shared state, network, randomness
2. **Common fixes:**
   - Replace `setTimeout` with explicit wait conditions
   - Isolate test data (no shared DB rows)
   - Mock external services deterministically
   - Use `requestId` pattern for concurrent requests
3. **Verify fix:** Run the test 10 times in a row

## Property-Based Testing

For functions with complex input spaces:
1. Define the property (invariant that must always hold)
2. Define input range (what to generate)
3. Let the framework find edge cases

**Example:**
```
Property: "sorting is idempotent"
Input: any array of objects with `createdAt`
Invariant: sort(sort(arr)) === sort(arr)
```

## Checklist

- [ ] Test map has 10+ must-never-break items
- [ ] Each item has at least one test
- [ ] Negative cases covered (what should NOT happen)
- [ ] Smoke test checklist exists for post-deploy
- [ ] No shared mutable state between tests
- [ ] Coverage threshold met (recommended: 80%)

## Low-Energy Mode

Write just the test map (Phase 1) and 3 smoke tests (Phase 4). That's enough to start.
