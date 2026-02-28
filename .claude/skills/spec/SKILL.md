---
name: spec
description: Specification & planning workflow. Use when starting a new feature, project, or need to define requirements, domain model, data shape, or API design.
argument-hint: "[project-or-feature-name]"
---

# Specification & Planning

## When to Use

- Starting a new project or feature
- Need domain model or data shape
- Designing API or UX skeleton
- Defining success criteria and non-goals

## Process

### Phase 1: One-Page Product Spec

Write a one-page spec for the project/feature. Include:
- Core user stories (who does what, why)
- Non-goals (explicitly out of scope)
- Domain definitions (key terms)
- Success criteria (measurable)

Keep it tool-agnostic. One page maximum.

**Output:** `SPEC.md`

### Phase 2: Domain Rules & Truth Rules

Define the domain model:
- List entities and their relationships
- 10 domain rules in plain English
- Truth Rules section: what counts as "saved", how the UI represents failure

**Output:** `DOMAIN.md`

### Phase 3: Data Shape

For each entity, define:
- Fields (name, type)
- Required vs optional
- Constraints (min/max, format, uniqueness)
- Top queries that need indexes

**Output:** `DATA-SHAPE.md`

### Phase 4: Edge Cases

List top 10 edge cases:
- What could go wrong
- Expected behavior for each
- Priority (must-handle vs nice-to-handle)

### Phase 5: API Slice (if building an API)

Minimal API surface for MVP:
- Endpoints with methods (GET, POST, etc.)
- Auth requirements per endpoint
- Request/response shapes
- Error codes and their meanings

**Output:** `API-SLICE.md`

### Phase 6: UX Skeleton (if building UI)

For each screen (5 max):
- User goal on this screen
- States: loading, empty, error, success, edge
- One interaction that matters most

**Output:** `UX-SKELETON.md`

## Checklist

- [ ] Spec has clear non-goals
- [ ] Domain rules are testable (not vague)
- [ ] Data shape has constraints and indexes
- [ ] Edge cases cover auth, empty states, concurrent access
- [ ] API slice is minimal (MVP only, no speculative endpoints)
- [ ] All outputs committed to repo

## Low-Energy Mode

Skip phases 4-6. Deliver only:
1. One-page spec
2. Domain rules
3. Data shape

That's enough to start building.
