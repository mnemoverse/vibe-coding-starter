# Agent Provider Documentation

Where to find official instructions for configuring each AI coding tool. Use these docs when adapting the starter kit to your preferred tool or when building tool-specific rules beyond the universal CLAUDE.md.

> **Tip for AI agents:** If you're reading this file, your provider documentation below explains how to create and manage project-level instructions for your tool. Follow the link for your tool to learn the native format.

---

## Instruction Files by Tool

| Tool | Instruction File | Format | Docs |
|------|-----------------|--------|------|
| **Claude Code** | `CLAUDE.md`, `.claude/rules/*.md` | Markdown | [code.claude.com/docs/en/memory](https://code.claude.com/docs/en/memory) |
| **Cursor** | `.cursor/rules/` (`.mdc` or `RULE.md`) | Markdown + YAML frontmatter | [docs.cursor.com/context/rules](https://docs.cursor.com/context/rules) |
| **GitHub Copilot** | `.github/copilot-instructions.md` | Markdown | [docs.github.com/copilot/customizing-copilot](https://docs.github.com/copilot/customizing-copilot/adding-custom-instructions-for-github-copilot) |
| **Windsurf** | `.windsurfrules`, `.windsurf/rules/` | Markdown | [docs.windsurf.com/windsurf/cascade/memories](https://docs.windsurf.com/windsurf/cascade/memories) |
| **Cline** | `.clinerules` or `.clinerules/*.md` | Markdown | [docs.cline.bot/features/cline-rules](https://docs.cline.bot/features/cline-rules) |
| **Continue** | `.continue/rules/*.md` | Markdown + YAML frontmatter | [docs.continue.dev/customize/deep-dives/rules](https://docs.continue.dev/customize/deep-dives/rules) |
| **Aider** | `CONVENTIONS.md` (via `--read`) | Markdown | [aider.chat/docs/usage/conventions.html](https://aider.chat/docs/usage/conventions.html) |
| **Amazon Q** | `.amazonq/rules/*.md` | Markdown | [docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/context-project-rules.html](https://docs.aws.amazon.com/amazonq/latest/qdeveloper-ug/context-project-rules.html) |
| **JetBrains AI** | `.aiassistant/rules/*.md` | Markdown | [jetbrains.com/help/ai-assistant/configure-project-rules.html](https://www.jetbrains.com/help/ai-assistant/configure-project-rules.html) |
| **Tabnine** | `.tabnine/guidelines/*.md` | Markdown | [docs.tabnine.com/main/getting-started/tabnine-agent/guidelines](https://docs.tabnine.com/main/getting-started/tabnine-agent/guidelines) |
| **Gemini** | `GEMINI.md` | Markdown | [geminicli.com/docs/cli/gemini-md/](https://geminicli.com/docs/cli/gemini-md/) |
| **AGENTS.md** | `AGENTS.md` (cross-tool) | Markdown | [github.com/agentsmd/agents.md](https://github.com/agentsmd/agents.md) |

---

## What's Universal vs. Tool-Specific

### Universal (works everywhere via CLAUDE.md)

Every AI tool reads markdown. These sections of CLAUDE.md work with any tool:

- **Project Overview** — what the project does, tech stack
- **Architecture** — folder structure, key components
- **Commands** — dev, test, build, deploy
- **Quick Checks** — coding conventions and patterns
- **NEVER** — absolute prohibitions

This is why `setup.sh` creates symlinks from CLAUDE.md to each tool's instruction file. Edit one file, all tools stay in sync.

### Tool-Specific (requires native SDK)

These features are Claude Code native. Other tools have their own equivalents:

| Feature | Claude Code | Cursor | Copilot | Windsurf |
|---------|-------------|--------|---------|----------|
| **Phased workflows** | `.claude/skills/` | Not natively supported | Not natively supported | Workflows |
| **Code pattern rules** | `.claude/rules/` | `.cursor/rules/` | `*.instructions.md` | `.windsurf/rules/` |
| **Behavioral protocols** | `.claude/protocols/` | Global rules | Not natively supported | Global rules |
| **Permission control** | `.claude/settings.json` | Not natively supported | Not natively supported | Not natively supported |
| **Auto-memory** | `~/.claude/projects/*/memory/` | Not natively supported | Not natively supported | Cascade Memories |
| **Path-scoped rules** | YAML frontmatter `paths:` | YAML frontmatter `globs:` | YAML `applyTo:` | By description |

### Adapting Skills to Other Tools

The 9 starter skills in `.claude/skills/` are markdown files describing phased workflows. While the `/command` invocation is Claude Code native, the content works anywhere:

1. **In Cursor** — paste the skill content as a prompt in Composer, or create `.cursor/rules/` entries
2. **In Copilot** — reference the skill file with `@workspace` or paste into chat
3. **In any tool** — copy the relevant phases from the SKILL.md file as your prompt

For building tool-specific configurations from scratch, consult the provider docs linked in the table above.

---

## How This Starter Uses Symlinks

```
CLAUDE.md (source of truth — edit this)
  ├── .cursorrules         → symlink
  ├── .github/copilot-instructions.md → symlink
  ├── .windsurfrules       → symlink
  ├── .clinerules          → symlink
  ├── GEMINI.md            → symlink
  └── AGENTS.md            → standalone (points to CLAUDE.md)
```

`setup.sh` creates all symlinks automatically. Tools that don't support symlinks will still read the file content.
