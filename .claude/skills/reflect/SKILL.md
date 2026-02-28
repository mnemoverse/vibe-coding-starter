---
name: reflect
description: Post-PR reflection and system improvement. Use after receiving code review comments, fixing a tricky bug, or after a production incident. Turns incidents into permanent improvements.
argument-hint: "[pr-number, bug description, or review comment]"
---

# Reflection & Self-Improvement

## When to Use

- After receiving PR review comments
- After fixing a bug that took >30 minutes
- After a production incident
- After catching yourself repeating an explanation to the agent
- Periodically (weekly/sprint) for system health check

## Process

### Phase 1: Extract

Collect all feedback signals from the trigger event.

**For PR review:**
1. List every reviewer comment (blocking and non-blocking)
2. For each comment: what was the issue? What file/line?
3. Categorize: security | correctness | style | architecture | testing | performance

**For bug fix:**
1. What was the root cause?
2. How long did it take to find?
3. At what development step should this have been caught?

**For incident:**
1. What broke?
2. What was the timeline?
3. What was the fix?

Output: A numbered list of concrete findings.

### Phase 2: Classify

For each finding, determine if it's generalizable:

```
Finding → Is this specific to this PR, or a pattern?
  ├── Specific (one-off typo, naming choice) → Skip
  ├── Code pattern (will recur in similar code) → Rule candidate
  ├── Workflow gap (missed step in process) → Skill update candidate
  ├── Behavioral issue (agent did something wrong) → Protocol candidate
  └── Context gap (agent didn't know something) → CLAUDE.md candidate
```

Output: Classified list with target location for each generalizable finding.

### Phase 3: Draft Updates

For each generalizable finding, draft the actual update:

**Rule (`.claude/rules/`):**
```markdown
### [Pattern Name]

**BAD:**
```[language]
// The problematic pattern from the review
```

**GOOD:**
```[language]
// The correct pattern
```
```

**Skill update (`.claude/skills/`):**
- Which skill needs a new phase, checklist item, or pattern?
- Write the specific addition

**Protocol update (`.claude/protocols/`):**
- What behavioral rule would have prevented this?
- Write as an imperative: "Always X before Y"

**CLAUDE.md update:**
- What project context was missing?
- Write the specific line to add

### Phase 4: Verify

For each drafted update, ask:

1. **Would this have caught the original issue?** → If no, rewrite
2. **Is this already covered by an existing rule?** → If yes, strengthen the existing rule instead
3. **Will this change agent behavior next time?** → If no, delete it
4. **Is this the simplest form of the rule?** → If no, simplify

### Phase 5: Apply & Commit

1. Apply all updates to the relevant files
2. Run a quick check: do any new rules contradict existing ones?
3. Commit with message: `chore: reflection — [summary of what was learned]`

## Checklist

- [ ] All review comments examined (not just blocking ones)
- [ ] Each finding classified as generalizable or specific
- [ ] Drafted updates pass the "would it have caught this?" test
- [ ] No contradictions with existing rules
- [ ] Updates committed to repo

## System Health Check (Quarterly)

Run this periodically to keep the system clean:

1. **Rules audit:** Read every rule in `.claude/rules/`. Delete any that:
   - Describe what the agent already does correctly
   - Haven't been relevant in 3+ months
   - Are too vague to change behavior

2. **Skills audit:** Read every skill. For each:
   - When was it last used?
   - Are the phases still accurate?
   - Should any phases be added or removed?

3. **CLAUDE.md audit:** Is the project overview still accurate?
   - Architecture diagram matches reality?
   - Commands still work?
   - Known Issues updated?

## Low-Energy Mode

After a PR review, just answer two questions:
1. **What's the one thing I'd change about my instructions?**
2. **Where does it go?** (rules / skills / CLAUDE.md / nowhere)

Write it down and commit. Done in 5 minutes.
