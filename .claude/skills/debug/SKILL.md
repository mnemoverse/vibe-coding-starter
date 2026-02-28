---
name: debug
description: Evidence-first debugging workflow. Use when stuck on a bug, investigating errors, slow requests, or unexpected behavior. Systematic approach from symptom to fix.
argument-hint: "[bug-description or error-message]"
---

# Evidence-First Debugging

## When to Use

- Bug report with unclear cause
- Error that resists quick fixes
- Slow request or performance issue
- Production incident investigation
- Debugging after 2-3 failed attempts (stop guessing, start methodically)

## Process

### Phase 1: Symptom to Facts

Convert panic into structure:

1. **Symptom** (one sentence): What's actually happening?
2. **Expected behavior** (one sentence): What should happen?
3. **Minimal repro steps** (5 lines max): How to reproduce?
4. **Unknowns** (3 max): What don't we know?
5. **One next evidence step**: What single action reduces the most uncertainty?

**Rule:** Keep it calm and specific. No speculation yet.

### Phase 2: Hypotheses with Disproof Tests

Generate exactly 3 hypotheses. For each:
- **Hypothesis:** What might be causing this
- **Disproof test:** One fast check that would ELIMINATE this hypothesis
- **Where to check:** Exact file, line, log, or endpoint

**Rule:** Do NOT suggest fixes yet. Only narrow the search space.

### Phase 3: Binary Search

Identify the boundaries of the bug:
1. Pick 3 checkpoints that cut the search space in half
2. For each: what "good" looks like, what "bad" implies, where to check next
3. Execute checkpoints in order until you locate the fault

**Think:** "Is the data correct at point A? At point B? The bug is between the last good and first bad."

### Phase 4: Minimal Reproduction

Reduce to the smallest case that reproduces the bug:
1. Freeze variables: data, timing, environment
2. Remove components one at a time
3. Stop when removing anything makes the bug disappear

**Output:** A recipe someone else can follow to reproduce.

### Phase 5: Fix Strategy

Choose ONE strategy based on risk context:

| Strategy | When to use |
|----------|-------------|
| **Patch** | Root cause clear, fix is small, low risk |
| **Guard** | Root cause unclear, need safety net now |
| **Refactor** | Root cause is structural, fix requires redesign |
| **Revert** | Recent change caused it, fastest path to stability |

Explain choice in 3 bullets, then propose the smallest change that addresses the root cause.

### Phase 6: Regression Lock

After fixing:
1. Write the smallest reliable test that catches this bug
2. Define what it asserts (the invariant)
3. Identify what could make it flaky (timing, state, randomness)

### Phase 7: Ship Safety

Before deploying the fix:
1. **Scope:** Who/what is affected?
2. **Signals:** 3 things to watch post-deploy
3. **Rollback trigger:** What would make you revert?
4. **Observation window:** How long to watch before declaring success?

## Production Debugging (No Local Repro)

When you can't reproduce locally:
1. **Metrics** for scope (how many users, which endpoints)
2. **Logs** for story (sequence of events leading to failure)
3. **Traces** for timing (if available: where time is spent)
4. **Safe probes:** read-only queries, health checks, debug headers

For each step: what evidence would confirm or deny your hypothesis?

## Structured Logging Guidance

When adding logs for debugging:
- **Log at boundaries:** request in, response out, external call, DB query
- **Never log:** passwords, tokens, PII, credit cards, session IDs
- **Include:** timestamp, trace/request ID, level, event name, duration
- **Keep it minimal:** 5 boundary events > 50 scattered console.logs

## Checklist

- [ ] Bug converted to structured facts (Phase 1)
- [ ] 3 hypotheses with disproof tests (Phase 2)
- [ ] Root cause identified with evidence
- [ ] Fix strategy chosen with rationale
- [ ] Regression test written
- [ ] Ship safety plan reviewed

## Low-Energy Mode

Do Phase 1 only. Write down the symptom, expected behavior, and one next step. That's enough to unblock yourself or hand off to someone else.
