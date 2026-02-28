---
name: code-review
description: Code review and quality gates. Use when reviewing code, creating merge gates, planning releases, or deciding between refactor and rebuild.
argument-hint: "[pr-number or file-path]"
---

# Code Review & Quality Gates

## When to Use

- Reviewing your own code before PR
- Reviewing someone else's PR
- Setting up merge gates and quality rails
- Planning releases
- Deciding refactor vs rebuild

## Code Review Process

### Step 1: Understand the Change

1. Read the PR description (what and why)
2. Check diff size (>400 lines = request split)
3. Identify the core change vs supporting changes

### Step 2: Review for Correctness

Priority order:
1. **Security:** Auth checks, input validation, secrets exposure
2. **Data integrity:** Race conditions, constraint violations, transaction boundaries
3. **Error handling:** Failures are caught, reported, and recoverable
4. **Edge cases:** Empty inputs, concurrent requests, network failures
5. **Readability:** Names make sense, logic is followable

### Step 3: Review for Quality

- [ ] No commented-out code
- [ ] No TODO without issue link
- [ ] Tests cover the new behavior
- [ ] Naming is consistent with codebase conventions
- [ ] No unnecessary abstraction (3 similar lines > premature helper)

### Step 4: Give Feedback

**Format:** Be specific about line numbers. Explain why, not just what.

```markdown
# Blocking
- Line 42: SQL injection risk — use parameterized query

# Suggestions (non-blocking)
- Line 87: Consider extracting to constant — used in 3 places

# Praise
- Clean separation of concerns in the handler
```

## Quality Rails

Minimum quality gates for any project:

| Rail | Why | Enforcement |
|------|-----|-------------|
| Type check | Catches bugs at compile time | `tsc --noEmit` in CI |
| Lint | Consistent style | ESLint in CI |
| Tests pass | No regressions | `npm test` in CI |
| No secrets | Prevent credential leaks | `.gitignore` + pre-commit hook |
| Build succeeds | Deployable | `npm run build` in CI |
| PR review | Second pair of eyes | GitHub required review |

### Merge Gate

6 checks maximum (more = nobody reads them):

1. `npm run typecheck` — Type safety
2. `npm run lint` — Code style
3. `npm test` — Tests pass
4. `npm run build` — Build succeeds
5. PR has description — Context for reviewers
6. At least 1 approval — Human verification

### Release Checklist

Before tagging a release:

1. - [ ] All merge gates pass on main branch
2. - [ ] Changelog updated
3. - [ ] Version bumped
4. - [ ] Smoke tests pass on staging
5. - [ ] Rollback plan documented
6. - [ ] Team notified

## Refactor vs Rebuild Decision

When considering rewriting a component:

| Criterion | Refactor | Rebuild |
|-----------|----------|---------|
| Test coverage | >60% — refactor safely | <20% — can't verify |
| Coupling | Low — change is local | High — everything breaks |
| Team familiarity | Team knows the code | Nobody understands it |
| Business risk | Low downtime tolerance | Can afford transition |
| Size | <500 lines | >2000 lines of tangled code |

**Default:** Refactor. Rebuild only when refactoring is more expensive.

## Diff Summary Template

For PR descriptions:

```markdown
## What changed
[One paragraph summarizing the change]

## Why
[Business reason or bug being fixed]

## How to test
1. [Step to verify the change works]
2. [Step to verify nothing broke]

## Risk
[Low/Medium/High — what could go wrong]
```

## Checklist

- [ ] Security issues checked first
- [ ] Error handling reviewed
- [ ] Tests cover new behavior
- [ ] No unnecessary complexity added
- [ ] PR description explains why, not just what

## Low-Energy Mode

Focus on security and correctness only. Skip style and optimization feedback.
