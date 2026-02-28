---
name: pr-preparation
description: Pre-PR checklist to validate code quality before creating PR. Use AUTOMATICALLY before any git commit or PR creation.
---

# PR Preparation Checklist

Before creating a commit or PR, validate against this checklist.

## Mandatory Checks

### 1. Error Handling & UX
- [ ] All user-facing operations have error feedback
- [ ] Loading states exist for async operations
- [ ] Error messages are helpful (not "Something went wrong")
- [ ] Async operations are awaited (no fire-and-forget)

### 2. Security
- [ ] No secrets in code (API keys, tokens, passwords)
- [ ] User input validated at API boundary
- [ ] SQL queries parameterized (no string concatenation)
- [ ] Error messages don't leak internal details
- [ ] Auth checks present on protected endpoints

### 3. Data Integrity
- [ ] No check-then-act race conditions (use try-catch + unique constraints)
- [ ] Concurrent request scenarios considered
- [ ] Nullable fields handled (`??` not `||` when empty string is valid)

### 4. Tests
- [ ] New logic has new tests
- [ ] Changed logic has updated tests
- [ ] Tests pass locally (`npm test`)
- [ ] No flaky tests introduced (no timing dependencies)

### 5. Code Quality
- [ ] No commented-out code
- [ ] No `console.log` left in production code
- [ ] Unused imports removed
- [ ] No `any` types (TypeScript)
- [ ] Names are clear and consistent with codebase

### 6. Build & Lint
- [ ] `npm run build` succeeds
- [ ] `npm run lint` passes
- [ ] Type check passes (`tsc --noEmit` or equivalent)

## Quick Validation Commands

```bash
npm run lint         # Style issues
npm run build        # Build succeeds
npm test             # Tests pass
git diff --stat      # Review scope of changes
```

## PR Description Template

```markdown
## What changed
[One paragraph]

## Why
[Business reason or bug being fixed]

## How to test
1. [Step 1]
2. [Step 2]

## Checklist
- [ ] Tests added/updated
- [ ] No secrets committed
- [ ] Build passes
```

## If Any Check Fails

Fix the issue BEFORE committing. Don't create "fix later" PRs — they never get fixed.
