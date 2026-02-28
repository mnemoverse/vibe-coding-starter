---
name: tune
description: Audit and improve your agent configuration. Use when starting a new project (to customize the starter), periodically (to prune stale rules), or when the agent keeps making the same mistakes. Reads CLAUDE.md, rules, skills, and protocols — then proposes and applies improvements.
argument-hint: "[goal: customize | audit | add-rule | add-skill]"
---

# Tune — Agent Configuration Improvement

## When to Use

- **First setup:** Just cloned the starter, need to customize for your project
- **After onboarding:** Agent doesn't know your stack well enough
- **Periodic audit:** Rules accumulated, some might be stale
- **Pattern detected:** Agent keeps making the same mistake
- **New workflow:** Need a skill for a recurring multi-step process

## Process

### Phase 1: Read Current State

Read and inventory the entire agent configuration:

1. Read `CLAUDE.md` — extract project overview, tech stack, commands, NEVER rules
2. List all rules in `.claude/rules/` — name, what pattern they enforce
3. List all skills in `.claude/skills/` — name, when they trigger
4. List all protocols in `.claude/protocols/` — name, what they enforce
5. Read `.claude/settings.json` — current permissions

**Output:** Configuration inventory table:

```
| Layer     | File                  | Status    | Notes              |
|-----------|-----------------------|-----------|--------------------|
| Identity  | CLAUDE.md             | [status]  | [notes]            |
| Rule      | rules/typescript.md   | [status]  | [notes]            |
| Skill     | skills/spec/SKILL.md  | [status]  | [notes]            |
| Protocol  | protocols/truth.md    | [status]  | [notes]            |
| Permission| settings.json         | [status]  | [notes]            |
```

Status: `placeholder` | `customized` | `stale` | `active` | `missing`

### Phase 2: Diagnose

Based on the goal, identify gaps:

**If `customize` (first setup):**
- Which `[YOUR PROJECT]` placeholders remain in CLAUDE.md?
- Which rules don't match the actual tech stack?
- Which commands in CLAUDE.md don't work (`npm run dev`, etc.)?
- Ask the user: "What's your project? What stack? What are your absolute prohibitions?"

**If `audit` (periodic):**
- Are there rules that describe what the agent already does correctly? → Delete candidates
- Are there rules that haven't been relevant in months? → Delete candidates
- Are there contradictions between rules? → Resolution needed
- Is CLAUDE.md still accurate (architecture, commands, known issues)?
- Are there skills that are never used? → Archive candidates

**If `add-rule` (pattern detected):**
- What's the BAD pattern? Show concrete code example.
- What's the GOOD pattern? Show concrete code example.
- Which existing rule file does this belong to? Or new file needed?
- Would this rule have caught the original issue?

**If `add-skill` (new workflow):**
- What triggers this workflow?
- What are the phases (3-6 steps)?
- What's the output artifact?
- What's the low-energy version?

**Output:** Diagnosed gap list with priorities.

### Phase 3: Propose Changes

For each gap, draft the concrete change:

**CLAUDE.md updates:**
- Fill in project overview, tech stack, folder structure
- Update commands section with actual working commands
- Add/remove NEVER rules

**Rule changes:**
- New rule: write BAD/GOOD code example pair
- Rule update: add new pattern to existing file
- Rule deletion: explain why (doesn't change behavior)

**Skill changes:**
- New skill: write full SKILL.md with phases, checklist, low-energy mode
- Skill update: add/modify phases

**Permission changes:**
- New allow patterns for common project commands
- New deny patterns for dangerous operations

Present all proposed changes to the user before applying.

### Phase 4: Apply & Verify

1. Apply approved changes to files
2. Verify CLAUDE.md has no remaining `[YOUR PROJECT]` placeholders
3. Verify rules don't contradict each other
4. Verify all commands in CLAUDE.md actually work (run them)
5. Commit: `chore: tune agent configuration — [summary]`

## Checklist

- [ ] All `[YOUR PROJECT]` placeholders replaced
- [ ] Tech stack in CLAUDE.md matches actual dependencies
- [ ] Commands in CLAUDE.md actually work
- [ ] Rules match the actual tech stack (no React rules in a Python project)
- [ ] No contradicting rules
- [ ] No stale rules that don't change behavior
- [ ] NEVER section covers project-specific dangers
- [ ] Permissions match project needs

## Quick Reference: Where Things Go

```
"Agent keeps writing BAD code pattern"    → .claude/rules/    (BAD/GOOD example)
"I keep explaining the same workflow"     → .claude/skills/   (phased SKILL.md)
"Agent does something dangerous"          → .claude/protocols/ (behavioral rule)
"I repeat project context every session"  → CLAUDE.md          (identity layer)
"Agent runs commands it shouldn't"        → .claude/settings.json (permissions)
```

## Low-Energy Mode

Just answer three questions:

1. **What's broken?** (Agent keeps doing X wrong)
2. **What's the fix?** (It should do Y instead)
3. **Where does it go?** (rules / skills / CLAUDE.md / settings.json)

Write the one-line fix and commit. Done in 2 minutes.
