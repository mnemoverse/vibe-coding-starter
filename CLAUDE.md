# CLAUDE.md

This file is the **single source of truth** for all AI agent configuration. It provides project context to every AI coding assistant via symlinks (see `setup.sh`).

**Supported tools:** Claude Code (native) · Cursor · GitHub Copilot · Windsurf · Cline · Gemini · Aider · any tool that reads markdown.

**For tool-specific features:** See [PROVIDERS.md](./PROVIDERS.md) for documentation links to each tool's native configuration format.

---

## 🧠 Knowledge System

| Component | Contains | When to use | Works with |
|-----------|----------|-------------|------------|
| **CLAUDE.md** | Architecture, principles, navigation | Always — this is the hub | All tools (via symlinks) |
| **`.claude/skills/`** | Task workflows with checklists | When starting spec, building, testing, debugging, deploying | Claude Code native* |
| **`.claude/rules/`** | Code patterns with BAD/GOOD examples | When writing code | Claude Code native* |
| **`.claude/protocols/`** | Behavioral rules | Always — non-negotiable | Claude Code native* |

*\*Skills, rules, and protocols are Claude Code native features. The content (markdown) works in any tool — paste it as a prompt or adapt to your tool's format. See [PROVIDERS.md](./PROVIDERS.md) for how to create native rules in Cursor, Copilot, Windsurf, etc.*

### How to use

1. **Before starting work** — read relevant skill for the task
2. **While coding** — apply patterns from rules/ without asking
3. **Before committing** — run `/pr-prep` checklist (Claude Code) or review the checklist manually
4. **After finding bugs** — update rules if the pattern is generalizable

---

## Project Overview

<!-- CUSTOMIZE: Replace with your project description -->

**Project:** [YOUR PROJECT NAME]

**What it does:** [One paragraph describing your project]

**Tech stack:** [e.g., Next.js 15, TypeScript, Tailwind CSS, PostgreSQL]

## Architecture

<!-- CUSTOMIZE: Replace with your folder structure -->

```
/
├── src/               # Application source
├── tests/             # Test files
├── public/            # Static assets
└── docs/              # Documentation
```

## Commands

<!-- CUSTOMIZE: Replace with your project's commands -->

```bash
# Development
npm run dev            # Start development server
npm test               # Run tests
npm run build          # Production build
npm run lint           # Run linter

# Database (if applicable)
# npm run db:migrate   # Run migrations
# npm run db:seed      # Seed database
```

---

## Quick Checks (Before Committing)

**TypeScript:** `!` → use `??`, `as Type` → add runtime check, inline imports → top of file
**React:** static objects → outside component, useState in deps → functional update
**Async:** always await in handlers, never empty catch blocks
**Tests:** new logic → new test, changed logic → updated test

See [.claude/rules/](.claude/rules/) for detailed patterns with code examples.

---

## Decision Trees

### New feature: where to start?

```
Feature scope?
├── Need spec/requirements first    → /spec
├── Building feature/integration    → /build
├── Adding tests                    → /test-map
├── Debugging a bug                 → /debug
└── Ready for PR                    → /pr-prep
```

### Something broke?

```
What happened?
├── Bug in development              → /debug
├── Security concern                → /security-review
├── Production incident             → /incident
├── Need to ship fix                → /deploy
```

### Code review time?

```
Reviewing code?
├── My own code before PR           → /pr-prep
├── Reviewing someone else's PR     → /code-review
├── Post-release quality check      → /security-review
```

---

## Code Patterns

| Pattern    | File                               |
|------------|------------------------------------|
| TypeScript | [.claude/rules/typescript.md](.claude/rules/typescript.md) |
| React      | [.claude/rules/react.md](.claude/rules/react.md)           |
| API        | [.claude/rules/api.md](.claude/rules/api.md)               |
| Database   | [.claude/rules/database.md](.claude/rules/database.md)     |

## Skills (on-demand workflows)

| Skill | When to use | Command |
|-------|-------------|---------|
| [Specification](.claude/skills/spec/SKILL.md) | Starting new feature, need spec/domain/API design | `/spec` |
| [Build](.claude/skills/build/SKILL.md) | Implementing: save contracts, auth, integrations | `/build` |
| [Test Map](.claude/skills/test-map/SKILL.md) | Writing tests, coverage strategy | `/test-map` |
| [Debug](.claude/skills/debug/SKILL.md) | Stuck on bug, need systematic approach | `/debug` |
| [Security Review](.claude/skills/security-review/SKILL.md) | Pre-launch security audit | `/security-review` |
| [Deploy](.claude/skills/deploy/SKILL.md) | Deploying, writing runbooks, incident response | `/deploy` |
| [Code Review](.claude/skills/code-review/SKILL.md) | Reviewing code, quality gates | `/code-review` |
| [Incident](.claude/skills/incident/SKILL.md) | Production incident response | `/incident` |
| [PR Preparation](.claude/skills/pr-preparation/SKILL.md) | Before creating PR or commit | `/pr-prep` |
| [Reflect](.claude/skills/reflect/SKILL.md) | After PR review, bug fix, or incident — improve the system | `/reflect` |

---

## NEVER

<!-- CUSTOMIZE: Add your project-specific prohibitions -->

- Never return hardcoded data instead of real API/LLM calls
- Never claim code exists without reading it first (see [verification protocol](.claude/protocols/verification-first.md))
- Never skip tests for changed logic
- Never commit secrets, credentials, or API keys

## Known Issues

<!-- CUSTOMIZE: List current bugs, workarounds, tech debt -->

- None yet — this is a fresh project

---

## Continuous Improvement

After every PR review, bug fix, or incident — run the [reflection cycle](.claude/protocols/reflection.md):

1. **Extract:** What was the feedback/issue?
2. **Classify:** Is it generalizable? (code pattern → rule, workflow gap → skill, context gap → CLAUDE.md)
3. **Draft:** Write the update (BAD/GOOD example, checklist item, or context line)
4. **Verify:** Would this have caught the original issue? If no → rewrite or delete
5. **Apply:** Commit with `chore: reflection — [what was learned]`

Use `/reflect` to run this as a guided workflow.

**Criterion:** If a rule doesn't change agent behavior — delete it. If a workflow is rarely needed — keep it in skills, not in CLAUDE.md.
