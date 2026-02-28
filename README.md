<p align="center">
  <strong>Vibe Coding Starter</strong><br>
  <em>Agent configuration template for AI-assisted development</em>
</p>

<p align="center">
  <a href="LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-blue.svg"></a>
  <a href="#works-with"><img alt="Tools: 11+" src="https://img.shields.io/badge/tools-11%2B-green.svg"></a>
  <a href=".claude/skills"><img alt="Skills: 10" src="https://img.shields.io/badge/skills-10-orange.svg"></a>
  <a href="https://github.com/mnemoverse/vibe-coding-starter/generate"><img alt="Use this template" src="https://img.shields.io/badge/use_this-template-blueviolet.svg"></a>
</p>

---

Turn copy-paste prompts into a living system. One `CLAUDE.md` file configures every AI coding tool. Ten structured skills replace ad-hoc prompting with repeatable workflows.

## Quick Start

```bash
# Use as GitHub template (recommended)
# Click "Use this template" above, or:
gh repo create my-project --template mnemoverse/vibe-coding-starter --clone
cd my-project

# Set up multi-tool symlinks
chmod +x setup.sh && ./setup.sh

# Customize CLAUDE.md — fill in your project details
# Then start building:
#   /spec my-project
```

## What's Inside

```
CLAUDE.md                    # Single source of truth (edit this)
AGENTS.md                    # Cross-tool universal standard
PROVIDERS.md                 # Provider docs & adaptation guide
setup.sh                     # One-command multi-tool setup
LICENSE                      # MIT
│
.claude/
├── skills/                  # 10 phased workflows
│   ├── spec/SKILL.md        #   /spec — specification & planning
│   ├── build/SKILL.md       #   /build — feature implementation
│   ├── test-map/SKILL.md    #   /test-map — testing strategy
│   ├── debug/SKILL.md       #   /debug — evidence-first debugging
│   ├── security-review/     #   /security-review — security audit
│   ├── deploy/SKILL.md      #   /deploy — deployment & operations
│   ├── code-review/SKILL.md #   /code-review — review & quality
│   ├── incident/SKILL.md    #   /incident — incident response
│   ├── pr-preparation/      #   /pr-prep — pre-PR checklist
│   └── reflect/SKILL.md     #   /reflect — post-PR improvement
├── rules/                   # Code patterns (BAD → GOOD)
│   ├── typescript.md
│   ├── react.md
│   ├── api.md
│   └── database.md
├── protocols/               # Behavioral rules
│   ├── verification-first.md
│   ├── truth-rules.md
│   └── reflection.md
└── settings.json            # Permissions (allow/deny)
```

## Three Layers

The starter organizes agent configuration into three layers:

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

## Customization

### 1. Fill in CLAUDE.md

Replace all `[YOUR PROJECT]` placeholders with your project details — description, tech stack, folder structure, development commands, and absolute prohibitions.

### 2. Adapt rules for your stack

The rules in `.claude/rules/` ship with TypeScript/React patterns. Swap them for your stack:

- Different language? Replace `typescript.md`
- No React? Remove `react.md`, add your framework
- Different DB? Adapt `database.md` to your ORM

### 3. Create your own skills

```
.claude/skills/[name]/SKILL.md
```

Each skill needs: trigger conditions, phased process, quality checklist, and a low-energy mode.

### 4. Grow the system

After every PR review or discovered pattern:

| What you learned | Where it goes |
|------------------|---------------|
| Repeatable code pattern | `.claude/rules/` (BAD/GOOD example) |
| Multi-step workflow | `.claude/skills/` |
| Behavioral rule | `.claude/protocols/` |
| Project context | `CLAUDE.md` |

**The test:** "Will this change the agent's behavior?" If no — don't add it.

## Related

- **[Vibe Coding Companion Pack](https://github.com/mnemoverse/vibe-coding-companion-pack)** — Checklists, prompts, decision trees, and templates for AI-assisted development. Free reference materials.

## License

[MIT](LICENSE)
