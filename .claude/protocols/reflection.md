# Reflection Protocol

> After every PR review, bug fix, or code review comment — run the reflection cycle before moving on.

## Why

Code reviews reveal patterns. Bugs expose blind spots. If you fix the symptom without updating the system, you'll make the same mistake next sprint. Reflection turns incidents into infrastructure.

## The Cycle

```
Trigger (PR review, bug, code comment)
  │
  ▼
1. WHAT happened?
  │  → Concrete fact: what was the comment/bug/issue?
  │
  ▼
2. WHY did it happen?
  │  → Root cause: at what step was this introduced?
  │  → Was it a knowledge gap, a rush, or a missing check?
  │
  ▼
3. IS IT GENERALIZABLE?
  │  ├── Yes, code pattern → add to .claude/rules/ (BAD/GOOD example)
  │  ├── Yes, workflow gap → update skill or create new one
  │  ├── Yes, behavioral → add to .claude/protocols/
  │  ├── No, one-off → fix and move on
  │  └── Just rushing → don't add anything (docs don't fix behavior)
  │
  ▼
4. VERIFY the update
     → Would this rule/skill have caught the issue last time?
     → If no → rewrite until the answer is yes
     → If still no → it's not generalizable, delete it
```

## When to Run

- After receiving PR review comments (every PR, no exceptions)
- After fixing a bug that took >30 minutes to find
- After a production incident postmortem
- After catching yourself repeating an explanation to the agent

## What to Update (Decision Tree)

| Signal | Where to add |
|--------|-------------|
| "Agent keeps writing this BAD pattern" | `.claude/rules/` with BAD/GOOD example |
| "I keep explaining the same workflow" | `.claude/skills/` — create or expand a skill |
| "Agent does something dangerous/wrong" | `.claude/protocols/` — behavioral rule |
| "I repeat project context every session" | `CLAUDE.md` — identity layer |
| "This one-line check would have caught it" | Quick Checks section in CLAUDE.md |

## What NOT to Add

- Rules that describe what the agent already does correctly
- Documentation of obvious language features
- Rules born from a single incident that won't recur
- Aspirational rules ("always write perfect code")

**The test:** If adding this rule won't change the agent's behavior next time — don't add it.

## Anti-Patterns

- **Hoarding rules:** 50 rules nobody reads. Prune quarterly — delete what doesn't change behavior.
- **Blaming the tool:** If the same issue happens with different agents, the gap is in your instructions, not the model.
- **Skipping the cycle:** "I'll do it later" = never. Run reflection immediately while context is fresh.

## Core Principle

Your agent configuration is a living system. It evolves through deliberate reflection, not random accumulation. Every PR review is a training signal — use it.
