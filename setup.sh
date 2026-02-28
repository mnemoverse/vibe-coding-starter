#!/bin/bash
# Vibe Coding Starter — Multi-tool setup
# Creates symlinks so CLAUDE.md serves as single source of truth
# for all AI coding assistants.

set -e

echo "Setting up agent configuration..."
echo ""

# ── Claude Code ──
# CLAUDE.md is already the native file — no symlink needed.
echo "  ✓ CLAUDE.md (Claude Code — native)"

# ── Cursor ──
if [ ! -L .cursorrules ]; then
  ln -sf CLAUDE.md .cursorrules
  echo "  ✓ .cursorrules → CLAUDE.md"
else
  echo "  · .cursorrules already linked"
fi

# ── GitHub Copilot ──
mkdir -p .github
if [ ! -L .github/copilot-instructions.md ]; then
  ln -sf ../CLAUDE.md .github/copilot-instructions.md
  echo "  ✓ .github/copilot-instructions.md → CLAUDE.md"
else
  echo "  · copilot-instructions.md already linked"
fi

# ── Windsurf (Codeium) ──
if [ ! -L .windsurfrules ]; then
  ln -sf CLAUDE.md .windsurfrules
  echo "  ✓ .windsurfrules → CLAUDE.md"
else
  echo "  · .windsurfrules already linked"
fi

# ── Cline ──
if [ ! -L .clinerules ]; then
  ln -sf CLAUDE.md .clinerules
  echo "  ✓ .clinerules → CLAUDE.md"
else
  echo "  · .clinerules already linked"
fi

# ── Gemini ──
if [ ! -L GEMINI.md ]; then
  ln -sf CLAUDE.md GEMINI.md
  echo "  ✓ GEMINI.md → CLAUDE.md"
else
  echo "  · GEMINI.md already linked"
fi

# ── Aider ──
if [ ! -L CONVENTIONS.md ]; then
  ln -sf CLAUDE.md CONVENTIONS.md
  echo "  ✓ CONVENTIONS.md → CLAUDE.md"
else
  echo "  · CONVENTIONS.md already linked"
fi

echo ""
echo "Done! Edit CLAUDE.md — all tools stay in sync."
echo ""
echo "Symlinked tools: Claude Code, Cursor, GitHub Copilot, Windsurf, Cline, Gemini, Aider"
echo "Also included: AGENTS.md (cross-tool standard), PROVIDERS.md (documentation links)"
echo ""
echo "Next steps:"
echo "  1. Open CLAUDE.md and fill in [YOUR PROJECT] sections"
echo "  2. Customize .claude/rules/ for your code patterns"
echo "  3. Try: /spec [your-project-name]"
echo ""
echo "For tool-specific features beyond CLAUDE.md, see PROVIDERS.md"
