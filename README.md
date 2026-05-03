<p align="center">
  <strong>Vibe Coding Starter</strong><br>
  <em>Agent configuration template for AI-assisted development</em>
</p>

<p align="center">
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <a href="#works-with"><img alt="Tools: 11+" src="https://img.shields.io/badge/tools-11%2B-green.svg"></a>
  <a href=".claude/skills"><img alt="Skills: 11" src="https://img.shields.io/badge/skills-11-orange.svg"></a>
  <a href="https://github.com/mnemoverse/vibe-coding-starter/generate"><img alt="Use this template" src="https://img.shields.io/badge/use_this-template-blueviolet.svg"></a>
</p>

---

Turn copy-paste prompts into a living system. One `CLAUDE.md` file configures every AI coding tool. Eleven structured skills replace ad-hoc prompting with repeatable workflows. A self-tuning skill keeps the system evolving with your project.

## Quick Start

### New project

```bash
# 1. Create from template
gh repo create my-project --template mnemoverse/vibe-coding-starter --clone
cd my-project

# 2. Set up symlinks (one command, all tools)
chmod +x setup.sh && ./setup.sh

# 3. Customize with AI assistance
#    Open Claude Code (or any AI tool) and run:
/tune customize

# That's it. The agent reads your project, asks what you're building,
# and fills in CLAUDE.md, adapts rules to your stack, and sets permissions.
```

### Existing project

```bash
# Option A: run the adopt script (safe — never overwrites existing files)
curl -fsSL https://raw.githubusercontent.com/mnemoverse/vibe-coding-starter/main/adopt.sh | bash

# Option B: manual
# Copy .claude/ directory, CLAUDE.md, AGENTS.md, PROVIDERS.md, setup.sh
# Then run: ./setup.sh && /tune customize
```

`adopt.sh` downloads the starter files and adds them to your repo. Files that already exist are skipped. Run it multiple times safely.

### What happens after setup

```
You: /spec my-feature
AI:  Reads CLAUDE.md → knows your stack, conventions, constraints
     Runs the spec skill → produces SPEC.md, DOMAIN.md, DATA-SHAPE.md
     Follows your rules → code patterns match your project
     Checks protocols → no stubs, no lies, verification-first

You: /tune
AI:  Reads your entire .claude/ config
     Finds stale rules, missing patterns, placeholder text
     Proposes fixes → you approve → config improves
```

---

## What's Inside

```
CLAUDE.md                    # Single source of truth (edit this)
AGENTS.md                    # Cross-tool universal standard
PROVIDERS.md                 # Provider docs & adaptation guide
setup.sh                     # Multi-tool symlink setup
adopt.sh                     # Add to existing project
│
.claude/
├── skills/                  # 11 phased workflows
│   ├── spec/                #   /spec — specification & planning
│   ├── build/               #   /build — feature implementation
│   ├── test-map/            #   /test-map — testing strategy
│   ├── debug/               #   /debug — evidence-first debugging
│   ├── security-review/     #   /security-review — security audit
│   ├── deploy/              #   /deploy — deployment & operations
│   ├── code-review/         #   /code-review — review & quality
│   ├── incident/            #   /incident — incident response
│   ├── pr-preparation/      #   /pr-prep — pre-PR checklist
│   ├── reflect/             #   /reflect — post-PR improvement
│   └── tune/                #   /tune — agent self-improvement ★
├── rules/                   # Code patterns (BAD → GOOD)
│   ├── typescript.md
│   ├── react.md
│   ├── api.md
│   └── database.md
├── protocols/               # Behavioral rules
│   ├── verification-first.md
│   ├── truth-rules.md
│   ├── reflection.md
│   └── algorithmic-fidelity.md
└── settings.json            # Permissions (allow/deny)
```

## Three Layers

| Layer | Purpose | Files | Works with |
|-------|---------|-------|------------|
| **Identity** | What the agent knows about your project | `CLAUDE.md` | All tools (via symlinks) |
| **Workflow** | How the agent approaches tasks | `.claude/skills/`, `.claude/rules/`, `.claude/protocols/` | Claude Code native* |
| **Permission** | What the agent is allowed to do | `.claude/settings.json` | Claude Code native |

*\*Skills are markdown — paste them as prompts in any tool. See [PROVIDERS.md](./PROVIDERS.md).*

## Skills

Every skill follows a phased approach with checklists and a **low-energy mode** for when you're tired.

| Skill | Command | When to use |
|-------|---------|-------------|
| Specification | `/spec` | Starting a new project or feature |
| Build | `/build` | Implementing features & integrations |
| Test Map | `/test-map` | Writing tests, coverage strategy |
| Debug | `/debug` | Stuck on a bug |
| Security Review | `/security-review` | Before launch or after security concern |
| Deploy | `/deploy` | Deploying to production |
| Code Review | `/code-review` | Reviewing PRs and code quality |
| Incident | `/incident` | Production incidents |
| PR Preparation | `/pr-prep` | Before every PR or commit |
| Reflect | `/reflect` | After PR review, bug fix, or incident |
| **Tune** | **`/tune`** | **Audit & improve agent configuration** |

---

## The Tune Skill

`/tune` is the meta-skill — it improves everything else. Four modes:

| Mode | Command | What it does |
|------|---------|-------------|
| **Customize** | `/tune customize` | First setup. Fills in CLAUDE.md, adapts rules to your stack |
| **Audit** | `/tune audit` | Finds stale rules, contradictions, missing patterns |
| **Add rule** | `/tune add-rule` | Turns a recurring mistake into a BAD/GOOD rule |
| **Add skill** | `/tune add-skill` | Creates a new phased workflow for a recurring process |

### How it works

```
/tune audit

Phase 1: READ — inventories CLAUDE.md, all rules, skills, protocols
Phase 2: DIAGNOSE — finds gaps, stale rules, contradictions
Phase 3: PROPOSE — drafts concrete changes for your approval
Phase 4: APPLY — writes changes, verifies, commits
```

### The growth loop

```
You write code
  → Agent follows rules & skills
    → Something goes wrong (PR review, bug, incident)
      → /reflect extracts the lesson
        → /tune applies it to the system
          → Agent is better next time
```

This is how the starter **evolves with your project** instead of staying static.

---

## Adding to an Existing Project

Three options depending on your situation:

### Option 1: adopt.sh (recommended)

```bash
cd your-existing-project
curl -fsSL https://raw.githubusercontent.com/mnemoverse/vibe-coding-starter/main/adopt.sh | bash
```

What it does:
- Downloads starter files (CLAUDE.md, skills, rules, protocols, setup.sh)
- **Never overwrites** existing files — skips anything that already exists
- Safe to run multiple times
- Reports what was added and what was skipped

Then:
```bash
./setup.sh            # Create multi-tool symlinks
# Open Claude Code:
/tune customize       # Agent helps you fill in project details
```

### Option 2: Cherry-pick what you need

Already have a CLAUDE.md? Just grab specific parts:

```bash
# Get just the skills
cp -r /path/to/vibe-coding-starter/.claude/skills/ .claude/skills/

# Get just the tune skill
mkdir -p .claude/skills/tune
curl -fsSL https://raw.githubusercontent.com/mnemoverse/vibe-coding-starter/main/.claude/skills/tune/SKILL.md \
  -o .claude/skills/tune/SKILL.md
```

### Option 3: Manual setup

1. Copy `.claude/` directory to your project
2. Copy `CLAUDE.md`, `AGENTS.md`, `PROVIDERS.md`
3. Edit `CLAUDE.md` — fill in your project details
4. Remove rules that don't match your stack
5. Run `setup.sh` to create symlinks

---

## Works With

`CLAUDE.md` is your source of truth. `setup.sh` creates symlinks so every tool reads the same configuration:

| Tool | Instruction file | Native features |
|------|-----------------|-----------------|
| **Claude Code** | `CLAUDE.md` (native) | Skills, rules, protocols, permissions |
| **Cursor** | `.cursorrules` → symlink | `.cursor/rules/` for additional rules |
| **GitHub Copilot** | `.github/copilot-instructions.md` → symlink | `*.instructions.md` files |
| **Windsurf** | `.windsurfrules` → symlink | `.windsurf/rules/` |
| **Cline** | `.clinerules` → symlink | `.clinerules/*.md` |
| **Gemini CLI** | `GEMINI.md` → symlink | — |
| **Aider** | `CONVENTIONS.md` → symlink | `--read` flag |
| **Continue** | — | `.continue/rules/*.md` |
| **Amazon Q** | — | `.amazonq/rules/*.md` |
| **JetBrains AI** | — | `.aiassistant/rules/*.md` |
| **Tabnine** | — | `.tabnine/guidelines/*.md` |

See [PROVIDERS.md](./PROVIDERS.md) for the complete adaptation guide with documentation links.

---

## Customization

### 1. Fill in CLAUDE.md

Replace all `[YOUR PROJECT]` placeholders — or just run `/tune customize` and let the agent do it.

### 2. Adapt rules for your stack

The rules in `.claude/rules/` ship with TypeScript/React patterns. Different stack? Replace them:

- Different language? Replace `typescript.md`
- No React? Remove `react.md`, add your framework
- Different DB? Adapt `database.md` to your ORM

Or run `/tune customize` — it detects your stack and proposes adapted rules.

### 3. Create your own skills

```
.claude/skills/[name]/SKILL.md
```

Each skill needs: trigger conditions, phased process, quality checklist, and a low-energy mode. Or run `/tune add-skill` and the agent scaffolds it for you.

### 4. Grow the system

| What you learned | Where it goes |
|------------------|---------------|
| Repeatable code pattern | `.claude/rules/` (BAD/GOOD example) |
| Multi-step workflow | `.claude/skills/` |
| Behavioral rule | `.claude/protocols/` |
| Project context | `CLAUDE.md` |
| Dangerous command | `.claude/settings.json` (deny list) |

**The test:** "Will this change the agent's behavior?" If no — don't add it.

## Related

- **[Vibe Coding Companion Pack](https://github.com/mnemoverse/vibe-coding-companion-pack)** — 103 free resources: checklists, prompts, decision trees, templates. [Browse online](https://mnemoverse.github.io/vibe-coding-companion-pack/).
- **[Mnemoverse](https://mnemoverse.com)** — Spatial AI memory system. Navigable knowledge environments instead of flat text retrieval.
- **[Mnemoverse Docs](https://mnemoverse.com/docs)** — Architecture documentation for L1-L8 cognitive layers, MCP integration, and research library.
- **[Eduard Izgorodin on Amazon](https://www.amazon.com/stores/Eduard-Izgorodin/author/B0F58BB7QJ)** — Author of the Vibe Coding Bible and other books on AI-assisted development.

## License

[MIT](LICENSE)
